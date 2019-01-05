
function COSTFUNCTION_for_MinChannel=COST_Chromosom_for_MinChannel_V3(Population_for_MinChannel)
global ClusterParams;
global ProblemParams;
global AlgorithmParams;
h=[];
h=Population_for_MinChannel;
N=ClusterParams.Number_of_Cluster;
MaxChannel=ProblemParams.MaxNumber_of_Channel;
MinChannel=ProblemParams.MinNumber_of_Channel;


for p=1:  size(h,1)
 
    L_H=zeros(1,MaxChannel);
 Assined_channel=[];
    Assined_channel=find(h(p,N+1:end)~=0);
    Size_POP=numel(unique( Assined_channel));
    

  for i=1:Size_POP
        
        L_H(i)=size(find(h==i),2);
        
    end
    
    f1(p)=(Size_POP-MinChannel+max(L_H)/Size_POP)/N;
             

end
 COSTFUNCTION_for_MinChannel=f1;


