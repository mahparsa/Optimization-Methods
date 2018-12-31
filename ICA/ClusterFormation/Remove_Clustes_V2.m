   function  TEMP = Remove_Clustes_V2(TheEmpire);
% 
% global ClusterParams;
 global ProblemParams;
% global AlgorithmParams;

   %UNTITLED Summary of this function goes here
%   Detailed explanation goes here
Neighbor=ProblemParams.NODE.Neighbors;
N=ProblemParams.NODE.Number;


TEMP=[];
TEMP=TheEmpire.Imperialist.Sequence;%%because the weakest have lower positionin array.
TEMP1=[];
TEMP2=[];
 Digree_of_NODE_in_Sequence=[];
for kk=1:numel(TEMP)
    cc=TEMP(kk);
    Digree_of_NODE_in_Sequence(kk)=numel(Neighbor{cc});
end
node=[];
Index_node=[];
[node,Index_node]=min( Digree_of_NODE_in_Sequence);
TEMP(Index_node)=[];




 




     %