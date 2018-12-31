  function   COST_Country_for_Clustering_V1;

global ProblemParams;
global Country;
global AlgorithmParams;



Num_country=AlgorithmParams.NumOfCountries;
N=ProblemParams.NODE.Number;

for p=1:Num_country
    
    Path= Country(p).Sequence;
    NO_CONN=COST_Connectivity(Path);
    
  
  Country(p).Cost=numel(Path)/N+ 1/NO_CONN;
%       No_INT= COST_INTERFRENCE(Path);
%   Country(p).Cost=0.6*(No_INT)+0.4*(numel(Path)/N);
end

 
 
  
    


