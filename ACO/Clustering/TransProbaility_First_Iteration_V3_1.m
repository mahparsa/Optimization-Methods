function [next_ind,next_node]=TransProbaility_First_Iteration_V3_1(TheANT,Feasiable,Path)
%%%%This function determine the probabilty of choosing the second nodes in first iteration. 
%%%%when there is no any pheromone that causes other ants can find the
%%%%route.
global ProblemParams;
global AlgorithmParams;
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
tau0=AlgorithmParams.tau0;
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
       
   NEIGHBOR(ii)=numel(Neighbor{Feasiable(ii)});
   hh1=numel(Neighbor{Feasiable(ii)})/N
   
   hh2=numel(find (distance(CoveredNodes,Feasiable(ii))<INTRang))/numel(CoveredNodes);
%    hh3=numel(intersect(Neighbor{Feasiable(ii)},CoveredNodes))/numel(CoveredNodes);
%   
   eta(ii)=0.85*hh1+0.15*hh2;
       
end
 

% tau0=10*sum(ones(1, round(ANT_Number/2)) *(1/(MinChannel+MaxChannel)));
   
% alpha=1;        % Phromone Exponential Weight
% beta=1;         % Heuristic Exponential Weight
 
% Evaporation Rate
P=(tau0^alpha)*(eta.^beta);
P=P/sum(P)
next_ind=RouletteWheelSelection(P)
next_node=Feasiable(next_ind)

  end   
% n=1

    


    