

% RevolveColonies(TheEmpire,AlgorithmParams,ProblemParams)  
 function TheEmpire = RevolveColonies_for_Clustering_Level1_V1(TheEmpire)
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

%
TEMP1=Remove_Clustes_V1(TheEmpire);

TheEmpire.Imperialist.Sequence=[];
     TheEmpire.Imperialist.Sequence=TEMP1;
     
     
     TheEmpire.Imperialist.NoCluster=numel(TEMP1);
     

% TheEmpire=Add_Resource(TheEmpire,NumOfRevolvingColonies_group2);
end

