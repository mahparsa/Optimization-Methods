% % function Min_Number_of_Channel= Centeralized_ICA_MinChannel(AlgorithmParams,ProblemParams,ClusterParams)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %//for minimizing the number of allocated channel, we define features or %characteristics of country as province  and the number of resources that

global ProblemParams;
global AlgorithmParams;
simulation_run=20
for S=1:simulation_run
ProblemParams=SAMPLE(S).ProblemParams;
ProblemParams.SINR.Threshold=10;
ProblemParams.Path_Loss_Exponents=2;
ProblemParams.Maximum_No_Cluster=round(ProblemParams.NODE.Number/10);
distance=ProblemParams.Distance;
Rang=ProblemParams.NODE.TrRange;
INTRang=ProblemParams.NODE.InrRange;
SINR_TH=ProblemParams.SINR.Threshold;
for k=1:ProblemParams.NODE.Number
ProblemParams.NODE.Neighbors{k}=find(distance(k,:)<= Rang);
end
Neighbor=ProblemParams.NODE.Neighbors; 
MAX_CLUSTER= ProblemParams.Maximum_No_Cluster;
N=ProblemParams.NODE.Number;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AlgorithmParams.NumOfCountries = round(ProblemParams.NODE.Number/4);               % Number of initial countries.number of population
AlgorithmParams.NumOfInitialImperialists =5%round(AlgorithmParams.NumOfCountries/5);      % Number of Initial Imperialists.
AlgorithmParams.NumOfDecades =100; %%%Number of itteration
AlgorithmParams.StopIfJustOneEmpire = false;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%EMOTIONAL_BASED_REVOLUTION 
%in ICA, the revolution is choosen based on the costant rate, but we can  choose the rate based on emotional factor ??
%%
% AlgorithmParams.RevolutionRate1 = 0.3;               % HOW WE CAN IMPROVE THE REVELOTION RATE?????????????Revolution is the process in which the socio-political characteristics of a country change suddenly.
% %//we have two RevolutionRate.
% AlgorithmParams.RevolutionRate2=0.1
AlgorithmParams.Assimilation_NR_Coefficient = 0.15;  % It determine the number of resoueces that must be the same. 
AlgorithmParams.Assimilation_NC_Coefficient = 0.15;  % It deremine the number of colony that must change in each Empires. 
AlgorithmParams.Zeta = 0.02;                        % Total Cost of Empire = Cost of Imperialist + Zeta * mean(Cost of All Colonies);
AlgorithmParams.DampRatio = 0.2;
AlgorithmParams.StopIfJustOneEmpire = false;         % Use "true" to stop the algorithm when just one empire is remaining. Use "false" to continue the algorithm.
AlgorithmParams.UnitingThreshold = 0.02;            % The percent of Search Space Size, which enables the uniting process of two Empires.
AlgorithmParams.RevolutionRate1=0;
AlgorithmParams.RevolutionRate2=0;                 %%%%%the defulat value of RevolutionRate2 is 0.1 but it dependes on mean of cost. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Country = Generat_Country_Clustering;
global Country;
%%========================COST=================================== 
COST_Country_for_Clustering_V3;
%%========================COST===================================Single_objective
%%%%%%%we need to minimze the objective function, Thus the powerfull
%%%%%%%country are the country that has minimum  cost function 
Initial=[];
Initial=Country;
Val=[];SortInd=[];
[Val,SortInd] = unique([Initial(:).Cost]);               % Sort the cost in assending order. The best countries will be in higher places.
%////we minimize the cost function and order them in the way that the country with minimum of cost has maximum index. 
Country=[];
Country=Initial(SortInd);

Empires=[];
Empires_for_Clustering=[];
Empires_for_Clustering= CreateInitialEmpires_for_Clustering;
Empires=Empires_for_Clustering;

MinimumCost=[];  
Best_country=[];
for Decade = 1:AlgorithmParams.NumOfDecades

    if Decade>1
    Empires = ImperialisticCompetition(Empires);
    end

    Remained = AlgorithmParams.NumOfDecades - Decade;
    EmpiresCosts=[];  Other_Cost=[];   
for ii = 1:numel(Empires)
         
         Val=[];
         SortInd=[];
         [Val,SortInd] = sort([Empires(ii).Colonies(:).Cost]);               % Sort the cost in assending order. The best countries will be in higher places.
         Empires(ii).Colonies(:)=Empires(ii).Colonies(SortInd);
         Empires(ii)=AssimilateColonies_for_Clustering(Empires(ii));
          %%========================COST=================================== 
         Empires(ii)=COST_Empires_for_Clustering_V3(Empires(ii));
          %%========================COST=================================== 
         Val=[];
         SortInd=[];
         [Val,SortInd] = unique([Empires(ii).Colonies(:).Cost]);  
         Empires(ii).Colonies(1:numel(SortInd))=Empires(ii).Colonies(SortInd);
         Empires(ii).Colonies(numel(SortInd)+1:end)=[]
         Empires(ii).TotalCost = Empires(ii).Imperialist.Cost + AlgorithmParams.Zeta * mean([Empires(ii).Colonies(:).Cost]);
       
end

EmpiresCosts=[];ONLYImperialist=[];
ONLYImperialist=[Empires(:).Imperialist];
EmpiresCosts=[ONLYImperialist(:).Cost];

% if Decade>30 & rem(Decade-1,30)==0 & MinimumCost(Decade-1)==mean(MinimumCost(Decade-29:Decade-1))
% 
% 
%     AlgorithmParams.RevolutionRate2=0.1
% else
     AlgorithmParams.RevolutionRate2=0;
% end    
% if AlgorithmParams.RevolutionRate2==0& Decade> 5 & rem(Decade-1,5)==0 & MinTotalCost(Decade-1)==mean(MinTotalCost(Decade-4:Decade-1))
% 
%     AlgorithmParams.RevolutionRate1=0.2
% else
     AlgorithmParams.RevolutionRate1=0.1;
% end    
%% Revolution;  A Sudden Change in the Socio-Political Characteristics
EMPIRES_Revolution=[];
if AlgorithmParams.RevolutionRate2>0.2       
         Val=0;Index=0;
         [Val,Index]=min(EmpiresCosts);
         
         Empires(Index)=RevolveColonies_for_Clustering_level2(Empires(Index));
     
         %%========================COST=================================== 
         Empires(Index)=COST_Empires_for_Clustering_V3(Empires(Index));
          Empires(Index)=COST_Imperialist_for_Clustering_V3(Empires(Index));
         %%========================COST=================================== 
         Empires(Index).TotalCost = Empires(Index).Imperialist.Cost + AlgorithmParams.Zeta * mean([Empires(Index).Colonies(:).Cost]);

         Val=[];
         SortInd=[];
         [Val,SortInd] = unique([Empires(Index).Colonies(:).Cost]);  
         Empires(Index).Colonies(1:numel(SortInd))=Empires(Index).Colonies(SortInd);
         Empires(Index).Colonies(numel(SortInd)+1:end)=[]
        
          EMPIRES_Revolution=[EMPIRES_Revolution,Index];
          

elseif AlgorithmParams.RevolutionRate1>0
         No_Imperialist_For_revolotion=round(AlgorithmParams.NumOfInitialImperialists* AlgorithmParams.RevolutionRate1);    
         Val=[];Index=[];
         [Val,Index]=sort(EmpiresCosts);
         for kk=1:No_Imperialist_For_revolotion
              New_Index=Index(end-kk+1);
              if numel(Empires(New_Index).Imperialist.Sequence) >7
              Empires(New_Index)=RevolveColonies_for_Clustering_Level1(Empires(New_Index));
         %%========================COST=================================== 
         Empires(New_Index)=COST_Empires_for_Clustering_V3(Empires(New_Index));
          Empires(New_Index)=COST_Imperialist_for_Clustering_V3(Empires(New_Index));
         %%========================COST=================================== 
         Empires(New_Index).TotalCost = Empires(New_Index).Imperialist.Cost + AlgorithmParams.Zeta * mean([Empires(New_Index).Colonies(:).Cost]);

         Val=[];
         SortInd=[];
         [Val,SortInd] = unique([Empires(New_Index).Colonies(:).Cost]);  
         Empires(New_Index).Colonies(1:numel(SortInd))=Empires(New_Index).Colonies(SortInd);
         Empires(New_Index).Colonies(numel(SortInd)+1:end)=[]
        
         
         EMPIRES_Revolution=[EMPIRES_Revolution,New_Index];
              end
         end
  
 for jj=1:numel(EMPIRES_Revolution)
     Index=EMPIRES_Revolution(jj);
     Empires(Index) = PossesEmpire(Empires(Index));
     Val=[];
     SortInd=[];
     [Val,SortInd] = unique([Empires(Index).Colonies(:).Cost]);  
     Empires(Index).Colonies(1:numel(SortInd))=Empires(Index).Colonies(SortInd);
     Empires(Index).Colonies(numel(SortInd)+1:end)=[]
 end    
 
                  
end %%%% RevolveColonies_for_Clustering_Level1 and Level2 
  



              
            
         
       
 for jj=1: numel(Empires)
          Empires(jj)=COST_Empires_for_Clustering_V3(Empires(jj));
          Empires(jj)=COST_Imperialist_for_Clustering_V3(Empires(jj));
          Empires(jj).TotalCost = Empires(jj).Imperialist.Cost + AlgorithmParams.Zeta * mean([Empires(jj).Colonies(:).Cost]);
 end
    
  
     V=[];
     I=[];
     EmpiresCosts=[];ONLYImperialist=[];
     ONLYImperialist=[Empires(:).Imperialist];
     EmpiresCosts=[ONLYImperialist(:).Cost];
     [V,I]=min(EmpiresCosts);
    
     MinimumCost(Decade)=Empires(I).Imperialist.Cost;
     Best_country{Decade}=Empires(I).Imperialist.Sequence;
     BestCosts_for_MinChannel(Decade) = Empires(I).Imperialist.Cost;
 
%      Min_Other_FUN(Decade,:)=Other_COST(:,I);%%%it means that it is the value of other cost function  when the cost function is minimum. 
   MinTotalCost(Decade) = min([Empires(:).TotalCost]);
   MeanCost(Decade) = mean([Empires(:).TotalCost]);
     
%     MinimumOtherCost1(Decade) = mean(Other_COST(1,:));
%     MinimumOtherCost2(Decade) = mean(Other_COST(2,:));
%     MinimumOtherCost3(Decade)= mean(Other_COST(3,:));
%      Mean_Other_FUN(Decade,:)=mean(Other_COST,2)
if numel(Empires) == 1 && AlgorithmParams.StopIfJustOneEmpire
      iteration_number=Decade 
      MinimumCost(Decade+1:AlgorithmParams.NumOfDecades)=MinimumCost(Decade);
      break
elseif Decade==AlgorithmParams.NumOfDecades
      iteration_number=Decade 
     
end




plot(  MinTotalCost ,'r','linewidth',1)
% %      text(AlgorithmParams.MaxGeneration,MinimumCostM(AlgorithmParams.MaxGeneration),' \leftarrow MinimumInterference ','FontSize',18)
      hold on
%      plot(MeanCostM,'b','linewidth',2)
% %      text(MeanCostM(AlgorithmParams.MaxGeneration/2),AlgorithmParams.MaxGeneration/2,' \leftarrow MinimumInterference ','FontSize',18)
%      hold on
%      plot(Mean_Other_FUN(1,:),'k','linewidth',3);  
% 
%      hold on
%      plot(Mean_Other_FUN(2,:),'g','linewidth',4);  
      hold off
      xlim([1 AlgorithmParams.NumOfDecades ]);
     pause(.05)

end %%%Decade = 1:AlgorithmParams.NumOfDecades
   
BEST_SOLUTION{S}.Position=Best_country{Decade};
BEST_SOLUTION{S}.Cost= BestCosts_for_MinChannel(Decade);
% Other_COST_BEST1(Decade) =OThers_Objective_Functions1(Best_country(Decade,1:N));
% Other_COST_BEST2(Decade) =OThers_Objective_Functions2(Best_country(Decade,1:N));
end 


 
 
 
 



%     