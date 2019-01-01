

function COSTFUNCTION_for_MinChannel=COST_Country_for_MinChannel(TheEmpire);

global ClusterParams;
global ProblemParams;

h=TheEmpire.Colonies.Position;
N=ClusterParams.Number_of_Cluster;
MaxChannel=ProblemParams.MaxNumber_of_Channel;
MinChannel=ProblemParams.MinNumber_of_Channel;
Num_country=size(h,1);

for p=1:Num_country
 L_H=zeros(1,MaxChannel);
    Size_POP=TheEmpire.Colonies.Resource(p);
    L_H=zeros(1,MaxChannel);
    
    for i=1:Size_POP
        
        L_H(i)=size(find(h(p,1:N)==h(p,i+N)),2);
    
    end
    NO_INT=NO_Interfrence(h(p,1:N));
    f1(p)=((Size_POP-MinChannel)+NO_INT)/N;

    COST(p)= f1(p);           

end

COSTFUNCTION_for_MinChannel=COST(p);


