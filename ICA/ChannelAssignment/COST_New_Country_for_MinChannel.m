function COST=COST_New_Country_for_MinChannel(Initial);
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
    for i=1:Size_POP
        
        L_H(i)=size(find(h(p,1:N)==h(p,i+N)),2);
    
    end
    

    f1(p)=(Size_POP-MinChannel+max(L_H))/Size_POP*N;

    COST(p)= f1(p);           

end

