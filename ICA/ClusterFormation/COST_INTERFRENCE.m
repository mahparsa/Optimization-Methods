 function   NO_INT= COST_INTERFRENCE(h)
%%%%calculate interfrence power between clusterhead.

global ProblemParams
distance=ProblemParams.Distance;
INTRang=ProblemParams.NODE.InrRange;
Numbe_of_Intefrence_Cluster=zeros(numel(h),numel(h)) ; %%%the vector shows the number of cluster ahead have interernce with this cluster.
NO_INT_CLUSTER=[];
Numbe_of_Intefrence_Cluster=[];
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
%      Num_INT_FUN=find(Numbe_of_Intefrence_Cluster >1);    
      
NO_INT= (sum(Numbe_of_Intefrence_Cluster))/(numel(h)*numel(h));
      