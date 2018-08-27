   function ANT = Generat_ANT_CLUSTERING_V3;
 %%%%%here, we define the structure of ANTs for clustering problem.
 %%%%%we define the compnenet of problem using ANT.
 %%%%%for example, in clustering, ANT shoud keep track of the cluster
 %%%%%haeds, the number of coverd nodes, the cost function, 
 %%%%%also, it generts the value initial value of ANTS
global ProblemParams;
global AlgorithmParams;

ANT_Number=AlgorithmParams.NumOfANT ;
N=ProblemParams.NODE.Number;
Neighbor=ProblemParams.NODE.Neighbors;
for bb=1:N
   Digree(bb)=numel(Neighbor{bb});
end   
MAX_CLUSTER= ProblemParams.Maximum_No_Cluster;

[node,Index_node]=sort(Digree,'descend');
Cluster_node=Index_node(1:MAX_CLUSTER);
for k=1:ANT_Number
    ANT(k).NoCluster=0; 
    ANT(k).NoCoverNodes=0;

    ANT(k).NoConnectedNode=0;
    ANT(k).Sequence=[];
    ANT(k).CoverNodes=[];
    
     ANT(k).Cost=0;
end
%%%%%%initial state: the first node is selected by exah ant.


for k=1:ANT_Number
    ANT(k).NoCluster=1; 
    ANT(k).Sequence=Index_node(k);
    ANT(k).NoCoverNodes=numel(Neighbor{ANT(k).Sequence})+1;
    ANT(k).CoverNodes=Neighbor{ANT(k).Sequence(1)}
     ANT(k).CoverNodes=[ANT(k).CoverNodes,Index_node(k) ];
    ANT(k).NoConnectedNode=0;
     ANT(k).Cost=0;
   
end


 