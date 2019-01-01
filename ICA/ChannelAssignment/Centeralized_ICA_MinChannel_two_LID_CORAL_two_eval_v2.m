% % function Min_Number_of_Channel= Centeralized_ICA_MinChannel(AlgorithmParams,ProblemParams,ClusterParams)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %//for minimizing the number of allocated channel, we define features or %characteristics of country as province  and the number of resources that

global ClusterParams;
global ProblemParams;
global AlgorithmParams;
simulation_run=20
 for S=1:simulation_run
     
      ClusterParams=SAMPLE(S).ClusterParams;
     ProblemParams=SAMPLE(S).ProblemParams;
    
%     load('100_IT_1.mat');

% load('100_IT_2.mat');
ProblemParams.Path_Loss_Exponents=2;
% % ProblemParams.Distance=[];
% 
% ProblemParams.InrRange =ProblemParams.NODE.InrRange;
% [ProblemParams.Distance,ProblemParams.Adjacecy,ProblemParams.Point]=Creat_Ad_Hoc_Network(ProblemParams);
% % 
% % %%%%%%%%%%%%%%%%%%%%%%%%%%clustring%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AlgorithmParams.NumOfCountries = 60;               % Number of initial countries.number of population
AlgorithmParams.NumOfInitialImperialists =8;      % Number of Initial Imperialists.
AlgorithmParams.NumOfAllColonies = AlgorithmParams.NumOfCountries - AlgorithmParams.NumOfInitialImperialists;
AlgorithmParams.NumOfDecades =200; %%%Number of itteration
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
AlgorithmParams.RevolutionRate1=0.05

AlgorithmParams.RevolutionRate2=0.05                  %%%%%the defulat value of RevolutionRate2 is 0.1 but it dependes on mean of cost. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Country_for_MinChannel = Generat_Country_MinChannel_G_Adjacency;
Initial.Countries=Country_for_MinChannel.Status ;
Initial.Resources= Country_for_MinChannel.Resources;
Initial.OrderResources= Country_for_MinChannel.OrderResources;
%%========================COST=================================== 
COSTFUNCTION_for_MinChannel=COST_New_Country_for_MinChannel_MO(Initial);
%%========================COST===================================Single_objective
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
Empires_for_MinChannel= CreateInitialEmpires_for_MinChannel(Initial);
Empires=Empires_for_MinChannel;
 
 MinimumCost=[];  
 Best_country=[];
  for Decade = 1:AlgorithmParams.NumOfDecades
%      if mod(Decade,100)==0 
%        if  mean(MinimumCost(Decade-:Decade-1))==mean(MinimumCost(1:Decade-1))
%        AlgorithmParams.RevolutionRate1 = Decade*AlgorithmParams.DampRatio * AlgorithmParams.RevolutionRate1  ;
%        AlgorithmParams.Assimilation_NC_Coefficient=AlgorithmParams.Assimilation_NC_Coefficient-Decade*0.1;
% %        AlgorithmParams.New_Country=(0.01*Decade/AlgorithmParams.NumOfDecad);%AlgorithmParams.Pc-(0.01*kkk/AlgorithmParams.MaxGeneration);
% 
% 
%        end
%        
%        if Decade>100 && MinimumCost(Decade-1) > MinimumCost(Decade-10)
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

          TheEmpire = Sort_Cost(Empires(ii));
         
%          
          Empires(ii)=AssimilateColonies_for_MinChannel_GN1(Empires(ii));
          %%========================COST=================================== 
          Empires(ii).Colonies.Cost=COST_Country_for_MinChannel_MO(Empires(ii));
          Empires(ii).Imperialist.Cost=COST_Imperialist_for_MinChannel_MO(Empires(ii));
          %%========================COST=================================== 
          TheEmpire = Sort_Cost(Empires(ii));
   
            
        %% Revolution;  A Sudden Change in the Socio-Political Characteristics
        if AlgorithmParams.RevolutionRate1>0
         Empires(ii)=RevolveColonies_GN(Empires(ii));
         
         %%========================COST=================================== 
         Empires(ii).Colonies.Cost=COST_Country_for_MinChannel_MO(Empires(ii));
         Empires(ii).Imperialist.Cost=COST_Imperialist_for_MinChannel_MO(Empires(ii));
         %%========================COST=================================== 

         TheEmpire = Sort_Cost(Empires(ii));
        end 
      %% Empire Possession  (****** Power Possession, Empire Possession)
         Empires(ii) = PossesEmpire(Empires(ii));
         TheEmpire = Sort_Cost(Empires(ii));

         Empires(ii).TotalCost = Empires(ii).Imperialist.Cost 
         EmpiresCosts(ii)=Empires(ii).TotalCost;
%          Other_COST(:,ii)=OThers_Objective_Functions2_COST(Empires(ii));
%       Mean_Other_FUN(:,kkk)=mean(Other_Functions,2);
     
   
     end
%     
%     %% Uniting Similiar Empires
%      Empires = UniteSimilarEmpires(Empires,AlgorithmParams,ProblemParams);
% 
%     %% Imperialistic Competition
     


  MinimumCost(Decade) = min(EmpiresCosts); %%%%change to  maximium
     V=[];
     I=[];
     [V,I]=min(EmpiresCosts);
    
     Best_country(Decade,:)=Empires(I).Imperialist.Position;
     BestCosts_for_MinChannel(Decade) = Empires(I).Imperialist.Cost;
     
%      Min_Other_FUN(Decade,:)=Other_COST(:,I);%%%it means that it is the value of other cost function  when the cost function is minimum. 
     
     MeanCost(Decade) = mean(EmpiresCosts);
     
%     MinimumOtherCost1(Decade) = mean(Other_COST(1,:));
%     MinimumOtherCost2(Decade) = mean(Other_COST(2,:));
%     MinimumOtherCost3(Decade)= mean(Other_COST(3,:));
%      Mean_Other_FUN(Decade,:)=mean(Other_COST,2)



Empires = ImperialisticCompetition(Empires);

if numel(Empires) == 1 && AlgorithmParams.StopIfJustOneEmpire
      iteration_number=Decade 
      MinimumCost(Decade+1:AlgorithmParams.NumOfDecades)=MinimumCost(Decade);
      break
elseif Decade==AlgorithmParams.NumOfDecades
      iteration_number=Decade 
     
end
   

N=ClusterParams.Number_of_Cluster;
NUM_AS_CH(Decade)=numel(unique(Best_country(Decade,1:N)));
Other_COST_BEST1(Decade) =OThers_Objective_Functions1(Best_country(Decade,1:N));
Other_COST_BEST2(Decade) =OThers_Objective_Functions2(Best_country(Decade,1:N));
end 
% 
%
%  MINIMUM_COST(S,:)= MinimumCost;
%  MEAN_COST(S,:)=MeanCost;
%  MEAN_OtherCost(S,:,:)=Mean_Other_FUN;
%  MINIMUM_OtherCOST(S,:)=Min_Other_FUN(iteration_number,3);

BEST_Solution{S}=Best_country(Decade,1:N);
%  NUM_IT(S)=iteration_number;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Here we gather the results of simulation 
MINIMUM_COST(S,:)= MinimumCost;
MEAN_COST(S,:)= MeanCost;
NO_CHANNEL(S,:)=NUM_AS_CH;
INT_POWER_SOLUTION(S,:)=Other_COST_BEST1;
INT_POWER(S,:)=Other_COST_BEST2;
% MEAN_OtherCost(S,:,:)=MEAN_OtherCost_ANTS
% MINIMUM_OtherCOST(S,:,:)=Other_COST_OF_BEST_ANT;
 

 end


