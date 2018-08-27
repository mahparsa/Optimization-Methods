ProblemParams.SINR.Threshold=10
ProblemParams.Path_Loss_Exponents=2.7;
ProblemParams.Maximum_No_Cluster=15;
distance=ProblemParams.Distance;
Rang=ProblemParams.NODE.TrRange;
INTRang=ProblemParams.NODE.InrRange;
SINR_TH=ProblemParams.SINR.Threshold;
for k=1:ProblemParams.NODE.Number
ProblemParams.NODE.Neighbors{k}=find(distance(k,:)<= Rang);
end
Neighbor=ProblemParams.NODE.Neighbors; 
MAX_CLUSTER= ProblemParams.Maximum_No_Cluster

N=ProblemParams.NODE.Number;
AlgorithmParams.NumOfANT=10;               % Number of initial countries.number of population
AlgorithmParams.NumOfIterations =90; %%%Number of itteration
AlgorithmParams.EvaporationRate=0.65; 
roh=AlgorithmParams.EvaporationRate;% Evaporation Rate
AlgorithmParams.tau0=0.001 %%%page 371: the intial value of tau is small value. 
Delta_Tau_NODE=zeros(N,N);%%%for all of nodes of network
tau=AlgorithmParams.tau0*ones(N,N);
AlgorithmParams.alpha=0.6;        % Phromone Exponential Weight.:::large value for rapiding convergence
AlgorithmParams.beta=0.5;         % Heuristic Exponential Weight
ANT_Number=AlgorithmParams.NumOfANT ;
MaxIt=AlgorithmParams.NumOfIterations;
COST_OF_ALL_ANTS=[];
COLOR_OF_ALL_ANTS=[];
Other_COST_OF_ALL_ANTS=[];
BestSolution=[];
%--#1.------------------------------
ANT = Generat_ANT_CLUSTERING_V3(AlgorithmParams,ProblemParams);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%ANTS move to other nodes for first time.
% tau0=10*sum(ones(1, round(ANT_Number/2)) *(1/(MinChannel+MaxChannel)));
for it=1:MaxIt
    
    COST_OF_ALL_ANTS=[];
    if it==1
       first_ant=1
    else 
       first_ant=2
       ANT = Generat_ANT_CLUSTERING_V3(AlgorithmParams,ProblemParams);
       ANT(1)= BEST_ANT ;
       COST_OF_ALL_ANTS=[COST_OF_ALL_ANTS,ANT(1).Cost ];
    end   
   
for kk=first_ant:ANT_Number
       Uncovered_Node=1
 while Uncovered_Node
        
         Feasiable=[];
         Feasiable=FindFeasible_V1(ANT(kk),ProblemParams); %%%%Here, we choose the feasiable nodes to choose as cluster heads.  
         if   numel(Feasiable)==0
            Uncovered_Node==0;
            break;
         end   
         if it==1
         [next_ind,next_node]=TransProbaility_First_Iteration_V3_1(ANT(kk),Feasiable,AlgorithmParams,ProblemParams,ANT(kk).Sequence);
         else

         [next_ind,next_node]=TransProbaility_NextIteration_V3_1(ANT(kk),Feasiable,AlgorithmParams,ProblemParams,tau);
         end
         SelectedNode=next_node;
                     
         ANT(kk).Sequence(end+1)=SelectedNode;
         ANT(kk).NoCluster=numel(ANT(kk).Sequence); 
         New_Cover=numel( Neighbor{ANT(kk).Sequence(end)});
         index=numel(  Neighbor{ANT(kk).Sequence(end) })-1
         ANT(kk).CoverNodes(end:end+index)=Neighbor{ANT(kk).Sequence(end)}
         ANT(kk).NoCoverNodes=numel(unique(ANT(kk).CoverNodes));
        
         for bb=1:ANT(kk).NoCluster-1
             CommonNeighbor=intersect( ANT(kk).Sequence(bb), ANT(kk).Sequence(end))
             if numel(CommonNeighbor)>0
                ANT(kk).NoConnectedNode= ANT(kk).NoConnectedNode+1;
             end
         end    
         
         
        
    %%%%%After finding feasiable nodes. We should define the best node to move based on transition probability. 
    %%in first iteration, there is no any global information,  we use the defualt value and intialzation value of 
    %tau and eta to find the probaility of transition. 
 
 end
  
 %=========================COST= 1-exp(-abs(f3+f1-f2));
 COSTFUNCTION_for_CLUSTERING= COST_ANT_V3_1(ProblemParams,ANT(kk).Sequence);
 %=========================COST
 
 ANT(kk).Cost= COSTFUNCTION_for_CLUSTERING;
 
 COST_OF_ALL_ANTS=[COST_OF_ALL_ANTS,ANT(kk).Cost ];

 
%  Other_COST_ANT=OThers_Objective_Functions2_ANT(ProblemParams,ClusterParams,ANT(kk).Sequence);
% 
%  Other_COST_OF_ALL_ANTS=[Other_COST_OF_ALL_ANTS, Other_COST_ANT];
 
end%%%%%%The end for ANTS
[V,I] =min(COST_OF_ALL_ANTS);

BEST_ANT_for_Iteartion(it) =ANT(I);
BestCost_for_Iteartion(it)=ANT(I).Cost ;
Other_COST_BEST_ANT =OThers_Objective_Functions2_ANT(ProblemParams,ANT(I).Sequence);
 OTHER_COST(it,:)= Other_COST_BEST_ANT;







% Other_COST_OF_ALL_ANTS=[Other_COST_OF_ALL_ANTS, Other_COST_ANT];





% Other_COST_OF_BEST_ANT(:,1)=Other_COST_OF_ALL_ANTS(:,I);
% Tau=UpdatedPheromon(ANT(kk),AlgorithmParams,ProblemParams,ClusterParams);
% tau=ones(N,N)* (sum( ones(1, round(ANT_Number/2) )) * (1/(MinChannel+MaxChannel)));

%After this step, we start the iteration cycle of algorithm. Ants start to pass the garphs based on generted pheromon on each edge.
% Other_COST_OF_ALL_ANTS=[];
 if it==1
        BEST_ANT=ANT(I)
 elseif BEST_ANT_for_Iteartion(it).Cost <   BEST_ANT.Cost
     BEST_ANT=BEST_ANT_for_Iteartion(it);
end     
  

Delta_Tau_NODE=UpdatedPheromon_V3_1(BEST_ANT,BEST_ANT_for_Iteartion(it),AlgorithmParams,ProblemParams,tau);


tau=(1-roh).*tau+(Delta_Tau_NODE);

 
 end %%%%iteration of ANTs 
 figure(3)
plot( OTHER_COST(:,1),'--b')
% figure;
% plot(BestCost_for_Iteartion,'LineWidth',2);
% xlabel('Iteration');
% ylabel('Best Cost');
% BEST_Solution=BEST_ANT.Sequence;
% 
