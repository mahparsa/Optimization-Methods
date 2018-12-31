function TheEmpire=COST_Empires_for_Clustering_V4(TheEmpire);

global ProblemParams;
Num_country=numel([TheEmpire.Colonies(:).Cost]);
N=ProblemParams.NODE.Number;

for p=1:Num_country
  
    
 Path= TheEmpire.Colonies(p).Sequence

  NO_CONN=COST_Connectivity(Path);
   
  
  
  
    No_INT= COST_INTERFRENCE(Path);

  

  
 TheEmpire.Colonies(p).Cost= 0.3*(numel(Path)/N)+ 0.15*(1/NO_CONN)+0.55*No_INT;
end



 










