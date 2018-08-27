     function [next_ind,next_node]=TransProbaility_NextIteration_V3_1(TheANT,Feasiable,tau);
global ProblemParams;
global AlgorithmParams;

%%% first for each feasiable node, find the color of its adjacent nodes.
%%%
Path=TheANT.Sequence;
h=Path;%%%%
ANT_Number=AlgorithmParams.NumOfANT ;
N=ProblemParams.NODE.Number;
Neighbor=ProblemParams.NODE.Neighbors;
distance=ProblemParams.Distance;
INTRang=ProblemParams.NODE.InrRange;
VisitedNodes=TheANT.Sequence;
ReminedNode=setdiff(randperm(N),VisitedNodes);
CoveredNodes=TheANT.CoverNodes;
NonCoveredNodes=setdiff(ReminedNode,CoveredNodes);

alpha=AlgorithmParams.alpha;        % Phromone Exponential Weight
beta=AlgorithmParams.beta;         
eta=[];%%%%is heuristic of probelem.
P=[];
%%%%%%the heurstic information is very important. 
%%%%%%the heuristic information is defined based on four factors: 
% 1. number of coverd nodes. === number of cluster heads or their neighbors 
% 2. number of connected nodes === number of cluster that have common
% neigbors
% 3. number of interfrence node=== number of nodes that are in same
% interfrence range

for ii=1:numel(Feasiable)
       
 
   hh1=numel(Neighbor{Feasiable(ii)})/N
   hh2=numel(find (distance(CoveredNodes,Feasiable(ii))<INTRang))/numel(CoveredNodes);
%    hh3=numel(intersect(Neighbor{Feasiable(ii)},CoveredNodes))/numel(CoveredNodes);
%   
   eta(ii)=0.85*hh1+0.15*hh2;
       
end
 

tau_local=tau( Path(end),Feasiable);
    
P=(tau_local.^alpha).*(eta.^beta);
P=P/sum(P)
next_ind=RouletteWheelSelection(P)
next_node=Feasiable(next_ind)


%    end   
% n=1

    


   


 