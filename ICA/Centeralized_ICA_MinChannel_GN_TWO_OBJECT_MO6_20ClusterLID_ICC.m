%%%%NOTE:::::::::
%%%%MULTI_objective Function is : COST(p)= exp(-abs(f3(p)+f2(p)-f1(p)));

% % function Min_Number_of_Channel= Centeralized_ICA_MinChannel(AlgorithmParams,ProblemParams,ClusterParams)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %//for minimizing the number of allocated channel, we define features or %characteristics of country as province  and the number of resources that
% %must allocated to provience. 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % clc; % clear;
  close all
% % %% Problem Statement
% % 
% % % first, we take assumption that the cluster are determined. the second assumption is that clustring is done to minimize the interfernce. 
% % % The number of channel that must assined to eacg cluster is same as the number of link in the cluster. 
% % % The chromosom is divided into n, which is the number of clusters. 
% % % Each cluster can  reuse the channels because they sepeated physically. there is no co-channel interference, but adjecent channel interference. 
% % % first we considere the ch-channel interfernce. 
% % % foe each part, we must assing channel in order to decrese interfrence and increse the numcber of avaialble channel. 
% % 
% %  
% % prompt = {'Enter number of nodes:','Enter the geographical length of network :', 'Enter the communication range  :' , 'Enter the interfence range   :','Enter the max available channel   :' ,'Enter the min available channel   :'};
% % dlg_title = 'Input for ad hoc network ';
% % num_lines = 1;
% % % def = {'100','1000','250','500'};
% % answer = inputdlg(prompt,dlg_title,num_lines);
% % ProblemParams.NODE.Number =str2num(answer{1,1});
% % rand('state', 0);
% % figure(1);
% % clf;
% % hold on;
% % ProblemParams.NODE.GeographicalRange = str2num(answer{2,1});
% % ProblemParams.NODE.TrRange= str2num(answer{3,1}); % maximum range;
% % ProblemParams.NODE.InrRange=str2num(answer{4,1});
% % ProblemParams.MaxNumber_of_Channel=str2num(answer{5,1});
% % ProblemParams.MinNumber_of_Channel=str2num(answer{6,1})
simulation_run=1

simulation_run=20;
BEST_Solution=zeros(simulation_run,40);

 for S=1:simulation_run
     
%     load('100_IT_1.mat');

ProblemParams.Path_Loss_Exponents=2.7;

% % ProblemParams.Distance=[];
% 
% ProblemParams.InrRange =ProblemParams.NODE.InrRange;
% [ProblemParams.Distance,ProblemParams.Adjacecy,ProblemParams.Point]=Creat_Ad_Hoc_Network(ProblemParams);
% % 
% % %%%%%%%%%%%%%%%%%%%%%%%%%%clustring%%%%%%%%%%%%
%  tic;
%  [ClusterParams]=Cluster_Ad_Hoc_Network_ACO_V3_ONEobject_1(ProblemParams);
% %  [ClusterParams,intP]=Cluster_Ad_Hoc_Network_ACO_V3_11(ProblemParams);
%   toc;
%  Cluster_NO(S)=ClusterParams.Number_of_Cluster;                       
%  INT_P_ACO(S)=intP;
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AlgorithmParams.NumOfCountries = 40;               % Number of initial countries.number of population
AlgorithmParams.NumOfInitialImperialists =10;      % Number of Initial Imperialists.
AlgorithmParams.NumOfAllColonies = AlgorithmParams.NumOfCountries - AlgorithmParams.NumOfInitialImperialists;
AlgorithmParams.NumOfDecades =100; %%%Number of itteration
AlgorithmParams.StopIfJustOneEmpire = false;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%EMOTIONAL_BASED_REVOLUTION 
%in ICA, the revolution is choosen based on the costant rate, but we can  choose the rate based on emotional factor ??
%%
% AlgorithmParams.RevolutionRate1 = 0.3;               % HOW WE CAN IMPROVE THE REVELOTION RATE?????????????Revolution is the process in which the socio-political characteristics of a country change suddenly.
% %//we have two RevolutionRate.
% AlgorithmParams.RevolutionRate2=0.1

AlgorithmParams.Assimilation_NR_Coefficient = 0.07;  % It determine the number of resoueces that must be the same. 
AlgorithmParams.Assimilation_NC_Coefficient = 0.09;   % It deremine the number of colony that must change in each Empires. 
AlgorithmParams.Zeta = 0.02;                        % Total Cost of Empire = Cost of Imperialist + Zeta * mean(Cost of All Colonies);
AlgorithmParams.DampRatio = 0.09;
AlgorithmParams.StopIfJustOneEmpire = false;         % Use "true" to stop the algorithm when just one empire is remaining. Use "false" to continue the algorithm.
AlgorithmParams.UnitingThreshold = 0.02;            % The percent of Search Space Size, which enables the uniting process of two Empires.
AlgorithmParams.RevolutionRate1=0.1
AlgorithmParams.RevolutionRate2=0.01                  %%%%%the defulat value of RevolutionRate2 is 0.1 but it dependes on mean of cost. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Country_for_MinChannel = Generat_Country_MinChannel_G_Adjacency(AlgorithmParams,ProblemParams,ClusterParams);
Initial.Countries=Country_for_MinChannel.Status ;
Initial.Resources= Country_for_MinChannel.Resources;
Initial.OrderResources= Country_for_MinChannel.OrderResources;
%%========================COST=================================== COST(p)=exp(-abs(f3(p)+f2(p)-f1(p)));
COSTFUNCTION_for_MinChannel=COST_New_Country_for_MinChMinInt6(Initial,AlgorithmParams,ProblemParams,ClusterParams);
%%========================COST===================================

Initial.Cost=COSTFUNCTION_for_MinChannel;
%%%%%%%we need to minimze the objective function, Thus the powerfull
%%%%%%%country are the country that has minimum  cost function 
[Initial.Cost,SortInd] = sort(Initial.Cost,'descend');                % Sort the cost in assending order. The best countries will be in higher places.
%////we minimize the cost function and order them in the way that the country with minimum of cost has maximum index. 
Initial.Countries = Initial.Countries(SortInd,:);                     % Sort the population with respect to their cost.
Initial.Resources= Initial.Resources(SortInd);
Initial.OrderResources= Initial.OrderResources(SortInd);
Initial.Cost=Initial.Cost(SortInd);
Empires=[];
Empires_for_MinChannel=[];
Empires_for_MinChannel= CreateInitialEmpires_for_MinChannel(Initial,AlgorithmParams,ProblemParams,ClusterParams);
Empires=Empires_for_MinChannel;
MinimumCost=[]; 
Best_country=[];

for Decade = 1:AlgorithmParams.NumOfDecades
     
%      if mod(Decade,10)==0 
%        if  mean(MinimumCost(Decade-0+1:Decade-1))==mean(MinimumCost(1:Decade-1))
%        AlgorithmParams.RevolutionRate1 = Decade*AlgorithmParams.DampRatio * AlgorithmParams.RevolutionRate1  ;
%        AlgorithmParams.Assimilation_NC_Coefficient=AlgorithmParams.Assimilation_NC_Coefficient-Decade*0.1;
% %        AlgorithmParams.New_Country=(0.01*Decade/AlgorithmParams.NumOfDecad);%AlgorithmParams.Pc-(0.01*kkk/AlgorithmParams.MaxGeneration);
% 
% 
%        end
%        
%        if Decade>10 && MinimumCost(Decade-1) > MinimumCost(Decade-10)
%           
%            AlgorithmParams.RevolutionRate1=(AlgorithmParams.RevolutionRate1)/2;
%            AlgorithmParams.Assimilation_NC_Coefficient=AlgorithmParams.Assimilation_NC_Coefficient/2
%         end 
%  
%     end  
    
Remained = AlgorithmParams.NumOfDecades - Decade;
EmpiresCosts=[];  Other_Cost=[];   

for ii = 1:numel(Empires)
%        %%%%%%%%%after eaxh operation we need to sort the cost function    

          TheEmpire = Sort_Cost(Empires(ii),AlgorithmParams,ProblemParams,ClusterParams);
         
%          
          Empires(ii)=AssimilateColonies_for_MinChannel_GN(Empires(ii),AlgorithmParams,ProblemParams,ClusterParams);
          %%========================COST=================================== COST(p)=exp(-abs(f3(p)+f2(p)-f1(p)));
          Empires(ii).Colonies.Cost=COST_Country_for_MinChMinInt6(Empires(ii),AlgorithmParams,ProblemParams,ClusterParams);
          Empires(ii).Imperialist.Cost=COST_Imperialist_for_MinChMinInt6(Empires(ii),AlgorithmParams,ProblemParams,ClusterParams);
          %%========================COST===================================

          
          TheEmpire = Sort_Cost(Empires(ii),AlgorithmParams,ProblemParams,ClusterParams);
   
            
        %% Revolution;  A Sudden Change in the Socio-Political Characteristics
        if AlgorithmParams.RevolutionRate1>0
         Empires(ii)=RevolveColonies_GN(Empires(ii),AlgorithmParams,ProblemParams,ClusterParams);

         %%========================COST=================================== COST(p)=exp(-abs(f3(p)+f2(p)-f1(p)));
         Empires(ii).Colonies.Cost=COST_Country_for_MinChMinInt6(Empires(ii),AlgorithmParams,ProblemParams,ClusterParams);
         Empires(ii).Imperialist.Cost=COST_Imperialist_for_MinChMinInt6(Empires(ii),AlgorithmParams,ProblemParams,ClusterParams);
         %%========================COST===================================

         TheEmpire = Sort_Cost(Empires(ii),AlgorithmParams,ProblemParams,ClusterParams);
        end 
      %% Empire Possession  (****** Power Possession, Empire Possession)
         Empires(ii) = PossesEmpire(Empires(ii));
         TheEmpire = Sort_Cost(Empires(ii),AlgorithmParams,ProblemParams,ClusterParams);
 
%         %% Computation of Total Cost for Empires
        
%          Empires(ii).TotalCost = Empires(ii).Imperialist.Cost + AlgorithmParams.Zeta * mean(Empires(ii).Colonies.Cost);
         Empires(ii).TotalCost = Empires(ii).Imperialist.Cost 

         EmpiresCosts(ii)=Empires(ii).TotalCost;

         Other_COST(:,ii)=OThers_Objective_Functions2_COST(Empires(ii),AlgorithmParams,ProblemParams,ClusterParams);
%       Mean_Other_FUN(:,kkk)=mean(Other_Functions,2);
     
   
     end
 
%     %% Uniting Similiar Empires
%      Empires = UniteSimilarEmpires(Empires,AlgorithmParams,ProblemParams);
% 
%     %% Imperialistic Competition
     



%   
%      ImerialistCosts = [Empires.Imperialist.Cost];
%      ImerialistCosts =[EmpiresCosts];
   
     MinimumCost(Decade) = min(EmpiresCosts); %%%%change to  maximium
     V=[];
     I=[];
     [V,I]=min(EmpiresCosts);
    
     Best_country(Decade,:)=Empires(I).Imperialist.Position;
     BestCosts_for_MinChannel(Decade) = Empires(I).Imperialist.Cost;
     
     Min_Other_FUN(Decade,:)=Other_COST(:,I);
     
     MeanCost(Decade) = mean(EmpiresCosts);
     
%     MinimumOtherCost1(Decade) = mean(Other_COST(1,:));
%     MinimumOtherCost2(Decade) = mean(Other_COST(2,:));
%     MinimumOtherCost3(Decade)= mean(Other_COST(3,:));
     Mean_Other_FUN(Decade,:)=mean(Other_COST,2)



 
% 


     figure(2);
%      title('Plot of Minimim number of Channel to Assined to Cluster')
      xlabel('Decade');
      ylabel('Objective Function');
%      
      hold on 
      plot(MinimumCost,'r','linewidth',3)
%       text(AlgorithmParams.MaxGeneration,MinimumCostM(AlgorithmParams.MaxGeneration),' \leftarrow MinimumInterference ','FontSize',18)
      hold on
      plot(MeanCost,'b','linewidth',2)
%       text(MeanCostM(AlgorithmParams.MaxGeneration/2),AlgorithmParams.MaxGeneration/2,' \leftarrow MinimumInterference ','FontSize',18)
    figure(3)
    plot(   Min_Other_FUN(:,3),'r')
    
%     hold on 
%      plot(MinimumOtherCost1,'k','linewidth',4)
%      hold on 
%      plot(MinimumOtherCost2,'g','linewidth',4)
%     
    hold off
           xlim([1 AlgorithmParams.NumOfDecades]);
% xlim([1]);
     pause(.01)

%      legend('MinCostICA','MeanCostICA', 'MeanCoChannelInterfrenceICA','MeanPowerInterfrenceICA');   
%  
Empires = ImperialisticCompetition1(Empires);
 
 %%%%Termination condition::::::::::
 %%%%1.
 if numel(Empires) == 1 && AlgorithmParams.StopIfJustOneEmpire
      iteration_number=Decade 
      MinimumCost(Decade+1:AlgorithmParams.NumOfDecades)=MinimumCost(Decade);
      break
 elseif Decade==AlgorithmParams.NumOfDecades
      iteration_number=Decade 
     
 end
 
%  if Decade>10 && MinimumCost(Decade) > MinimumCost(Decade-10)
%      
%      iteration_number=Decade-1
%      break
%  
%  end 
%  
 
 end

% MINIMUM_COST(S,:)= MinimumCost;
% MEAN_COST(S,:)=MeanCost;
% MEAN_OtherCost(S,:,:)=Mean_Other_FUN;
% MINIMUM_OtherCOST(S,:,:)=Min_Other_FUN;
% BEST_Solution(S,:,:)=Best_country;
% NUM_IT(S)=iteration_number;


MINIMUM_OtherCOST(S,:)=Min_Other_FUN(iteration_number,3);
BEST_Solution(S,1:size(Best_country,2))=Best_country(iteration_number,:);

%  NUM_IT(S)=iteration_number;

% MinimumCost(kkk) = min(COSTFUNCTION_for_MinChannel); 
% [MINV,MINI]=min(EmpiresCosts);
%  BestSolutions_for_MinChannel(it,:) = Empires(MINI).Imperialist.Position;
%  BestCosts_for_MinChannel(it) = Empires(MINI).Imperialist.Cost;
%  COST(it)=BestCosts_for_MinChannel(it);
%  IND(it)=MINI;
%  BEST(it,:)=BestSolutions_for_MinChannel(it,:); 
%  OTHER_OBJ(it,:)=[ min(MinimumOtherCost1), min(MinimumOtherCost2),min(MinimumOtherCost3)];
%  MINIMUM_COST(it)= MINV;
%  MEAN_COST_DECADE(it,:)= MeanCost;
%  MINIMUM_COST_DECADE(it,:)=MinimumCost;
end
%     
% Results_Min_Number_of_Channel= Centeralized_ICA_Results(AlgorithmParams,ProblemParams,ClusterParams)

    %% Displaying the Results
%     DisplayEmpires(Empires,AlgorithmParams,ProblemParams,DisplayParams);
    
    

 

% 
% % %     
% end
% 
%  BestSolution_for_MinChannel = Population_for_MinChannel(AlgorithmParams.PopSize,:);
%  BestCost_for_MinChannel = COSTFUNCTION_for_MinChannel(AlgorithmParams.PopSize);
