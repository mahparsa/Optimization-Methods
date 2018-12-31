% RevolveColonies(TheEmpire,AlgorithmParams,ProblemParams)  
 function TheEmpire = RevolveColonies_GN(TheEmpire,AlgorithmParams,ProblemParams,ClusterParams)
%%%%%%%%we consider two revelotion rate.
%%%%%%%%During the revolution the charcteristic of country change.
%%%%%%%%the first  one is AlgorithmParams.RevolutionRate1:change the feature of country randomly. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%For Grapg Coloring Problem%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%it likes mutation operation in group genetic algorithm. 
%1. the revelotion point is choosen and  the resource is removed. Here
%two group of country are choosen:

%:::::first the country with minimu cost, remove some resources of them.
%:::::second, the countries with mazimum adjacent add some resource.

%%%%%%%%%%%%%%%%%%%%%%::::::::::::::::::::::::::::::::remove one resourse from colony:::::::::::::::::::::::::::::::%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%::::::::::::::::::::::::::::::::add one resoursse to Imperialist ::::::::::::::::::::::::::::::  



%%%%%%%%the second one is AlgorithmParams.RevolutionRate2: change the feature of Impralist randomly. 
%%%%%%%%After the revelotion may be the position of colony and imprialist
%%%%%%%%change
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%For minimum number of channel  the revelotion is like to mutation
N=ClusterParams.Number_of_Cluster;
INT_Cluster=ClusterParams.Cluster_Interfrence;
NeighborCluster=ClusterParams.Cluster_Neighbor;

MinChannel=ProblemParams.MinNumber_of_Channel;
MaxChannel=ProblemParams.MaxNumber_of_Channel;

NumOfColonies =numel(TheEmpire.Colonies.Cost);
UPPER=min(N,MaxChannel);


N=ClusterParams.Number_of_Cluster;
AssinedCH_To_Index_Cluster=zeros(1,N);
AssinedCH_To_ID_Cluster=zeros(1,N);
Cluster_ID=ClusterParams.Index_of_Cluster;
dist_cluster=ClusterParams.Distance_Cluster_Ahead; %%%%%%the distance between cluster     
MinChannel=ProblemParams.MinNumber_of_Channel;
MaxChannel=ProblemParams.MaxNumber_of_Channel;

%  NumOfRevolvingColonies = ceil((1-TheEmpire.NormalizedPower)* numel(TheEmpire.Colonies.Cost))-1;
 NumOfRevolvingColonies = ceil((TheEmpire.TotalCost)* numel(TheEmpire.Colonies.Cost))-1;

if NumOfRevolvingColonies <=0
NumOfRevolvingColonies_group1=1;

else
NumOfRevolvingColonies_group1=NumOfRevolvingColonies;
end    
% NumOfRevolvingColonies_group1=round(NumOfRevolvingColonies/2);
%%%in these colonies some resources will be removed because of their cost.
% NumOfRevolvingColonies_group2=round(NumOfRevolvingColonies/2)+1;
%%%in these colonies some resources are added because of increasing in
%%%adjacency.
if AlgorithmParams.RevolutionRate1>0

%         R = randperm(numel(TheEmpire.Colonies.Cost));%%%%%number of element in array  
%         R = R(1:NumOfRevolvingColonies);
%
TheEmpire=Remove_Resource_GN(TheEmpire,NumOfRevolvingColonies_group1,AlgorithmParams,ProblemParams,ClusterParams);

% TheEmpire=Add_Resource(TheEmpire,NumOfRevolvingColonies_group2);
end

if AlgorithmParams.RevolutionRate2>0

%         R = randperm(numel(TheEmpire.Colonies.Cost));%%%%%number of element in array  
%         R = R(1:NumOfRevolvingColonies);
%
TheEmpire=Add_Resource_GN(TheEmpire,AlgorithmParams,ProblemParams,ClusterParams);


% TheEmpire=Add_Resource(TheEmpire,NumOfRevolvingColonies_group2);
end

