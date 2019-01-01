function COST=COST_New_Country_for_MinChannel_SO(Initial);
global ClusterParams;
global ProblemParams;

h=Initial.Countries;
Num_country=size(h,1);
N=ClusterParams.Number_of_Cluster;
MaxChannel=ProblemParams.MaxNumber_of_Channel;
MinChannel=ProblemParams.MinNumber_of_Channel;

for p=1:Num_country
 
    L_H=zeros(1,MaxChannel);
    
    Size_POP=Initial.Resources(p);
    
    f1(p)=(Size_POP-MinChannel)/N;

    COST(p)= f1(p);           

end

