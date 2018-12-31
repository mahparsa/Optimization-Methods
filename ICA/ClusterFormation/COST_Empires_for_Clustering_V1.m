function TheEmpire=COST_Empires_for_Clustering_V1(TheEmpire);

global ProblemParams;
Num_country=numel([TheEmpire.Colonies(:).Cost]);
N=ProblemParams.NODE.Number;

for p=1:Num_country
  
    
 Path= TheEmpire.Colonies(p).Sequence

  NO_CONN=COST_Connectivity(Path);
   
  
 TheEmpire.Colonies(p).Cost= (numel(Path)+ NO_CONN)/N;
end



 










