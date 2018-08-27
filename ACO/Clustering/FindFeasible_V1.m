%%%%this function get the current node of each ant and determine a set of nodes that are feasible. 

function Feasiable=FindFeasible_V1(TheANT)
global ProblemParams;

N=ProblemParams.NODE.Number;
MAX_CLUSTER= ProblemParams.Maximum_No_Cluster;
VisitedNodes=TheANT.Sequence;
ReminedNode=setdiff(randperm(N),VisitedNodes);
NonCoveredNodes=setdiff(ReminedNode,TheANT.CoverNodes)
Neighbor=ProblemParams.NODE.Neighbors; 






if numel(ReminedNode)==0 | numel(NonCoveredNodes)==0 
Feasiable=[];

else
Feasiable=NonCoveredNodes;
 

 end
    
