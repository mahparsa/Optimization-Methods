global BEST_SOLUTION
global ProblemParams
for SS=1:20

ProblemParams=SAMPLE(SS).ProblemParams;
for k=1:ProblemParams.NODE.Number
ProblemParams.NODE.Neighbors{k}=find(distance(k,:)<= Rang);
end
[CHParams]=Form_Cluster_Ad_Hoc_Network_for_ICA(BEST_SOLUTION{SS}.Position);
SAMPLE(SS).ClusterParams=CHParams;

end    