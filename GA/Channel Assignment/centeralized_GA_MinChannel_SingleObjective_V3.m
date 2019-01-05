%    function Min_Number_of_Channel= centeralized_GA_MinChannel(AlgorithmParams,ProblemParams,ClusterParams)

% clc;
% clear;
% close all
% 
% prompt = {'Enter number of nodes:','Enter the geographical length of network :', 'Enter the communication range  :' , 'Enter the interfence range   :','Enter the max available channel   :' ,'Enter the min available channel   :'};
% dlg_title = 'Input for ad hoc network ';
% num_lines = 1;
% def = {'100','1000','250','500'};
% answer = inputdlg(prompt,dlg_title,num_lines);
% 
% 
% 
% ProblemParams.NODE.Number =str2num(answer{1,1});
% rand('state', 0);
% figure(1);
% clf;
% hold on;
% ProblemParams.NODE.GeographicalRange = str2num(answer{2,1});
% ProblemParams.NODE.TrRange= str2num(answer{3,1}); % maximum range;
% ProblemParams.NODE.InrRange=str2num(answer{4,1});
% ProblemParams.MaxNumber_of_Channel=str2num(answer{5,1});
% ProblemParams.MinNumber_of_Channel=str2num(answer{6,1})
% ProblemParams.Distance=[];
% Distance=[];
%   [ProblemParams.Distance,ProblemParams.Adjacecy,ProblemParams.Point]=Creat_Ad_Hoc_Network(ProblemParams);
%  
% %%%%%%%%%%%%%%%%%%%%%%%%%%clustring%%%%%%%%%%%%
%  ClusterParams=Cluster_5_Ad_Hoc_Network(ProblemParams);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  ProblemParams   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ProblemParams.Chromosom_Start_Index_for_clustring=[];
% ProblemParams.Chromosom_End_Index_for_clustring=[];
% ProblemParams.Number_of_Channel=randint(1,1,[5 ProblemParams.MaxNumber_of_Channel]);
% ProblemParams.Number_of_Channel=0;
% ProblemParams.Assined_Channel=cell(ClusterParams.Number_of_Cluster,1);
% ProblemParams.Cluster_Avaiable_Channel=[];
% ProblemParams.InrRange=ProblemParams.NODE.InrRange;
% 
% ProblemParams.Path_Loss_Exponents=2;
% ProblemParams.NPar = ProblemParams.NODE.Number*(ProblemParams.NODE.Number-1)/2; % Number of optimization variables of your objective function. "NPar" is the dimention of the optimization problem.
% ProblemParams.VarMin = 1;                        %we consider the number of channel % Lower limit of the optimization parameters. You can state the limit in two ways. 1)   2)
% ProblemParams.VarMax = 20;  

% Lower limit of the optimization parameters. You can state the limit in two ways. 1)   2)
global ClusterParams;
global ProblemParams;
global AlgorithmParams;
simulation_run=20
 for S=1:simulation_run
     
     ClusterParams=SAMPLE(S).ClusterParams;
     ProblemParams=SAMPLE(S).ProblemParams;
    
%     load('100_IT_1.mat');

% load('100_IT_2.mat');

AlgorithmParams.PopSize = 30; 
AlgorithmParams.MaxGeneration =200;


AlgorithmParams.Pc=0.15%8/(ClusterParams.Number_of_Cluster+min(ClusterParams.Number_of_Cluster,ProblemParams.MinNumber_of_Channel));

AlgorithmParams.Pm=0.15%4/(ClusterParams.Number_of_Cluster+min(ClusterParams.Number_of_Cluster,ProblemParams.MinNumber_of_Channel));

AlgorithmParams.Pi=0.1%3/(ClusterParams.Number_of_Cluster+min(ClusterParams.Number_of_Cluster,ProblemParams.MinNumber_of_Channel));

AlgorithmParams.Pg=0.1,;
%for inversion operation
 AlgorithmParams.Pr = 1 - AlgorithmParams.Pc - AlgorithmParams.Pm-AlgorithmParams.Pi;
AlgorithmParams.NumberofCrossOver = floor(AlgorithmParams.Pc*AlgorithmParams.PopSize);
AlgorithmParams.NumberofMutation = floor(AlgorithmParams.Pm*AlgorithmParams.PopSize);
AlgorithmParams.NumberofInversion=floor(AlgorithmParams.Pi*AlgorithmParams.PopSize);
AlgorithmParams.NumberofNewGeneartion=0;

AlgorithmParams.NumberofRecomb = AlgorithmParams.PopSize - AlgorithmParams.NumberofCrossOver - AlgorithmParams.NumberofMutation-AlgorithmParams.NumberofInversion;

Population_for_MinChannel =  GeneratPopulation_MinChannel_Neighbor_Adjacency1;
% %    Population_for_MinChannel= Population_for_MinChannel2; %%%%%%for comparison
% COSTFUNCTION_for_MinChannel=COST_Chromosom_for_MinChannel(Population_for_MinChannel,AlgorithmParams,ProblemParams,ClusterParams);
COSTFUNCTION_for_MinChannel= COST_Chromosom_for_MinChannel_V3(Population_for_MinChannel);
indx=[];
[COSTFUNCTION_for_MinChannel,indx] = sort(COSTFUNCTION_for_MinChannel,'ascend');
 

Population_for_MinChannel  = Population_for_MinChannel (indx,:);
MinimumCostM=[];
MeanCostM=[];
MinimumCostM(1) = min(COSTFUNCTION_for_MinChannel); % For drawing purposes we keep trak of minimum and maximum costs of population.
MeanCostM(1) = mean(COSTFUNCTION_for_MinChannel);
 

 
 kkk=1;
 %% %%%%%%%%%%%%%%%%%%%%% MAIN LOOP (Evolution) %%%%%%%%%%%%%%%%%%%%%%%%
for kkk=1:AlgorithmParams.MaxGeneration
% 


    
          

if mod(kkk,10)==0 
    
        
        AlgorithmParams.Pg=(0.1*kkk/AlgorithmParams.MaxGeneration);%AlgorithmParams.Pc-(0.01*kkk/AlgorithmParams.MaxGeneration);
%        AlgorithmParams.Pc=AlgorithmParams.Pc+(0.01*kkk/AlgorithmParams.MaxGeneration);
% 
%        AlgorithmParams.Pm=AlgorithmParams.Pm+(0.002*kkk/AlgorithmParams.MaxGeneration);;
% 
%        AlgorithmParams.Pr=1 - AlgorithmParams.Pc - AlgorithmParams.Pm-AlgorithmParams.Pi-AlgorithmParams.Pg;
       if mean(MeanCostM(kkk-10+1:kkk-1))> mean(MeanCostM(1:kkk-1))
       AlgorithmParams.Pg=0.1%08*kkk/AlgorithmParams.MaxGeneration);%AlgorithmParams.Pc-(0.01*kkk/AlgorithmParams.MaxGeneration);
       AlgorithmParams.Pc=AlgorithmParams.Pc-(0.01*kkk/AlgorithmParams.MaxGeneration);

       AlgorithmParams.Pm=AlgorithmParams.Pm-(0.002*kkk/AlgorithmParams.MaxGeneration);;

       AlgorithmParams.Pr=1 - AlgorithmParams.Pc - AlgorithmParams.Pm-AlgorithmParams.Pi-AlgorithmParams.Pg;
       end

       
end  


     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %% Selecting population
      
      RecombSelected =[];%%%%%for each generation is different.
      RecombSelected = Population_for_MinChannel(1:AlgorithmParams.NumberofRecomb,:);

      
      NCost = max(COSTFUNCTION_for_MinChannel) - COSTFUNCTION_for_MinChannel;  % Normalized Cost
      Cost2 = NCost;
% 
      pdfCost2 = Cost2/(sum(Cost2)); % Probability Density Function

      
      cdfCost2 = pdfCost2(1); % Cumulative Distribution Function
      for ii = 2:AlgorithmParams.PopSize 
          cdfCost2(ii) = cdfCost2(ii-1) + pdfCost2(ii);
      end
%     % Now CDF is ready for Rollet Wheel selection
%     
%     % Selecting Parents
       a = rand(1,AlgorithmParams.NumberofCrossOver);
       SelectedM = [];
       
       if rem(numel(a),2)~=0
           NO=numel(a)-1;
       else
           NO=numel(a);
       end    
       for ii = 1:NO;
         b = a(ii) - cdfCost2;
         
         c = b(b>0);
         Selected = numel(c)+1;
         SelectedM = [SelectedM ; Selected];
       end
%     
      CParentsM_for_MinChannel=[];
      CParentsM_for_MinChannel = Population_for_MinChannel(SelectedM,:);
% 

      OFFSPRINGS_for_MinChannel=[];      

     p=randperm(NO)
      for ii = 1:2:NO
                  OFFSPRINGSM=[];
                     
         Parent1_for_MinChannel = CParentsM_for_MinChannel(p(ii),:);
         Parent2_for_MinChannel = CParentsM_for_MinChannel(p(ii+1),:);
         N=ClusterParams.Number_of_Cluster;
         MinChannel=ProblemParams.MinNumber_of_Channel;


        if ( numel(find(Parent1_for_MinChannel~=0))<= N+MinChannel && numel(find(Parent2_for_MinChannel~=0))<= N+MinChannel)
           OFFSPRINGSM=[Parent1_for_MinChannel;Parent2_for_MinChannel];
        else  

         OFFSPRINGSM = CrossOver_for_MinChannel4_6(Parent1_for_MinChannel,Parent2_for_MinChannel);
        end 
         OFFSPRINGS_for_MinChannel=[OFFSPRINGS_for_MinChannel;OFFSPRINGSM];
      end
    
  
      %%
 
% f = randperm(AlgorithmParams.PopSize);
% f2 = f(1:AlgorithmParams.NumberofMutation);
MParents_for_MinChannel=[];
MParents_for_MinChannel= Population_for_MinChannel(end-AlgorithmParams.NumberofMutation+1:end,:);
Mutated_for_MinChannel =[];
Mutated_for_MinChannel = Mutation_for_MinChannel2_6(MParents_for_MinChannel,AlgorithmParams.NumberofMutation); 
%%

MParents_for_Inversion=[];
MParents_for_Inversion= Population_for_MinChannel(end-AlgorithmParams.NumberofInversion+1:end,:);
Inversion_Parent_MinChannel = Inversion_for_MinChannel(MParents_for_Inversion); 

New_Population= New_GeneratPopulation_MinChannel_Neighbor_Adjacency1(AlgorithmParams.NumberofNewGeneartion);


Population_for_MinChannel=[];
Population_for_MinChannel = [RecombSelected ; New_Population;OFFSPRINGS_for_MinChannel; Mutated_for_MinChannel;Inversion_Parent_MinChannel];
      
%%%%%%%%one of below function must is selected
       
%           COSTFUNCTION_for_MinChannel=COST_Chromosom_for_MinChannel(Population_for_MinChannel,AlgorithmParams,ProblemParams,ClusterParams);
      
COSTFUNCTION_for_MinChannel= COST_Chromosom_for_MinChannel_V3(Population_for_MinChannel);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
   
   [COSTFUNCTION_for_MinChannel,indx] = sort(COSTFUNCTION_for_MinChannel,'ascend');
       
     
   Population_for_MinChannel = Population_for_MinChannel(indx,:);

       
%    
            
      
      
      [kkk min(COSTFUNCTION_for_MinChannel)];
% % % %      subplot(2,1,1)
       [V,I]=min(COSTFUNCTION_for_MinChannel)
      MinimumCostM(kkk) = min(COSTFUNCTION_for_MinChannel); % For drawing purposes we keep trak of minimum and maximum costs of population.
      MeanCostM(kkk) = mean(COSTFUNCTION_for_MinChannel);
      
      %%%%%Here we consider that what is the effect of these sloutions on other functions. Without considereing them as
      %%%%%objective function to minimze or maximize 
     Other_Functions=[];
      Other_Functions=OThers_Objective_Functions11(Population_for_MinChannel);
      Min_Other_FUN(kkk,:)=  Other_Functions(:,I);
      Mean_Other_FUN(kkk,:)=mean(Other_Functions,2);
      Best_chromosom{kkk}=Population_for_MinChannel(I,:);
          
           figure(2);
     title('Plot of Minimim number of Channel to Assined to Cluster')
     xlabel('Generation');
     ylabel('Objective Function');
     legend('MinimumCostFunction','MeanCostFunction', 'MeanCoChannelInterfrence' ,'MeanPowerInterfrence');

     plot(MinimumCostM,'r','linewidth',1)
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
      xlim([1 AlgorithmParams.MaxGeneration]);
     pause(.05)


        Diff_SIZE= AlgorithmParams.PopSize-size(Population_for_MinChannel,1);
       if Diff_SIZE > 0
        New_Population= New_GeneratPopulation_MinChannel_Neighbor_Adjacency1(Diff_SIZE);
        Population_for_MinChannel=[Population_for_MinChannel; New_Population];
        COST_New_for_MinChannel= COST_Chromosom_for_MinChannel_V3(New_Population);
        COSTFUNCTION_for_MinChannel=[COSTFUNCTION_for_MinChannel,COST_New_for_MinChannel];
       else Diff_SIZE < 0    
     
         Population_for_MinChannel(end-abs(Diff_SIZE)+1:end,:)=[];
         COSTFUNCTION_for_MinChannel(end-abs(Diff_SIZE)+1:end)=[];
     
       end
        
   
  
          
end

%  BestSolution_for_MinChannel = Population_for_MinChannel(AlgorithmParams.PopSize,:);
%  BestCost_for_MinChannel = COSTFUNCTION_for_MinChannel(AlgorithmParams.PopSize);
%  Size_Solution=size(find(BestSolution_for_MinChannel~=0),2)
%  N=ClusterParams.Number_of_Cluster;
%  Min_Number_of_Channel=numel(BestSolution_for_MinChannel(N+1:Size_Solution));
MINIMUM_COST(S)=MinimumCostM(kkk);
MEAN_COST(S,:)=MeanCostM;
MEAN_OtherCost(S,:,:)=Mean_Other_FUN;
MINIMUM_OtherCOST(S,:,:)=Min_Other_FUN;
BEST_Solution{S}=Best_chromosom


 end