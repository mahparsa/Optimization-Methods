
global ProblemParams;


for ii=1:20
    
   ProblemParams=[]; 
   ProblemParams=SAMPLE(ii).ProblemParams;
   [C]=Cluster_Ad_Hoc_Network_ACO_V3_1;
   SAMPLE(ii).ClusterParams=[];
   SAMPLE(ii).ClusterParams=C;
   
end
