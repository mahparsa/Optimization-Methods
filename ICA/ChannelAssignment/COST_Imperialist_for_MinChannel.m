function COSTFUNCTION_for_MinChannel=COST_Imperialist_for_MinChannel(TheEmpire);

global ClusterParams;
global ProblemParams;

h=TheEmpire.Imperialist.Position;

N=ClusterParams.Number_of_Cluster;
MaxChannel=ProblemParams.MaxNumber_of_Channel;
MinChannel=ProblemParams.MinNumber_of_Channel;
Num_country=size(h,1);
 L_H=zeros(1,MaxChannel);
    Size_POP=TheEmpire.Imperialist.Resource;

    for i=1:Size_POP
        
        L_H(i)=size(find(h(1:N)==h(i+N)),2);
    
    end
    
  f1=(Size_POP-MinChannel+max(L_H))/Size_POP*N;
   
   COSTFUNCTION_for_MinChannel= f1;           






