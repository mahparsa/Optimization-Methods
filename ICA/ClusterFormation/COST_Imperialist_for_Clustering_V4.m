function TheEmpire =COST_Imperialist_for_Clustering_V4(TheEmpire)
 
global ProblemParams;



N=ProblemParams.NODE.Number; 
 Path=[];
 Path=TheEmpire.Imperialist.Sequence;

 
 NO_CONN=COST_Connectivity(Path);

   


 No_INT= COST_INTERFRENCE(Path);

   
 TheEmpire.Imperialist.Cost= 0.3*(numel(Path)/N)+ 0.15*(1/NO_CONN)+0.55*No_INT;

















