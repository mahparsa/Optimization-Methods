 function Delta_Tau=UpdatedPheromon_V3_1(BEST_ANT,BEST_ANT_It,Delta_Tau);

global ProblemParams;
global AlgorithmParams;


N1=ProblemParams.NODE.Number;
Detla=zeros(N1,N1);

rho=AlgorithmParams.EvaporationRate       % Evaporation Rate;       % Evaporation Rate
ANT_Number=AlgorithmParams.NumOfANT ;

%%%%%%%Here we consider the transition based on the choosing the nodes(here cluster head) 

for k=1:2
    h=[];
%%%we updated for each link in the sequence of ant
if k==1
    ANT(k)=BEST_ANT;
else
    ANT(k)=BEST_ANT_It;
end

h=ANT(k).Sequence; 
   N=numel(h) ;
         for ii=1:N
    
              for jj=ii+1:N
                    
            
                                Partial_COST_INT= COST_INTERFRENCE(ANT(k).Sequence(1:jj)); 

                            



                                Delta_Tau(h(ii),h(jj))= 1/((0.15*Partial_COST_INT+0.85*( numel(ANT(k).Sequence(1:jj))  )/N1 ))+ Delta_Tau(h(ii),h(jj));

                                
                        
                      
                end
            end
end

        