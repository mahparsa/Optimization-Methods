function COSTFUNCTION_for_MinChannel=COST_Imperialist_for_Clustering_SO(TheEmpire);

global ClusterParams;
global ProblemParams;

h=TheEmpire.Imperialist.Position;

N=ClusterParams.Number_of_Cluster;
MaxChannel=ProblemParams.MaxNumber_of_Channel;
MinChannel=ProblemParams.MinNumber_of_Channel;
Num_country=size(h,1);
 L_H=zeros(1,MaxChannel);
    Size_POP=TheEmpire.Imperialist.Resource;

    
    
  f1=(Size_POP-MinChannel)/N;
      

   COSTFUNCTION_for_MinChannel= f1;           






