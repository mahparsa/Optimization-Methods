
function TheEmpire =COST_Imperialist_for_Clustering_V1(TheEmpire)
 
global ProblemParams;



N=ProblemParams.NODE.Number; 
 Path=[];
 Path=TheEmpire.Imperialist.Sequence;

 
 NO_CONN=COST_Connectivity(Path);

   
 TheEmpire.Imperialist.Cost= (numel(Path)/N+ 1/NO_CONN);










