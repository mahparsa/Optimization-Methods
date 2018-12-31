function DIGREE=  INT_of_NODE_in_Sequence(PATH)
global ProblemParams
distance=ProblemParams.Distance;
INTRang=ProblemParams.NODE.InrRange;
h=PATH;
for k=1:numel(h)
            NO_INT_CLUSTER=0;
            OTHER_CLUSTER=[];
            OTHER_CLUSTER=setdiff(h,h(k));
            TOTAL_Interfrence_Nodes= distance(h(k),OTHER_CLUSTER);
                                    
           
            Value1=[]; 
            
            Index1=[];
  
            [Index1 Value1]= find(TOTAL_Interfrence_Nodes<INTRang);
            
            if numel(Index1)
                  NO_INT_CLUSTER= numel(Index1);
            end

               
                                                        
            Numbe_of_Intefrence_Cluster(k)= NO_INT_CLUSTER;
            
     
                            
                     
                  
          
end
DIGREE=  Numbe_of_Intefrence_Cluster;