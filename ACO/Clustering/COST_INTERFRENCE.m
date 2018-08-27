 function   NO_INT= COST_INTERFRENCE(h);
%%%%calculate interfrence power between clusterhead.
global ProblemParams;
global AlgorithmParams;
Path=[];
distance=ProblemParams.Distance;

INTRang=ProblemParams.NODE.InrRange;
Numbe_of_Intefrence_Cluster=zeros(numel(Path),numel(Path)) ; %%%the vector shows the number of cluster ahead have interernce with this cluster.
Path=h;

for k=1:numel(Path)
            NO_INT_CLU=0;
            OTHER_CLUSTER=setdiff(Path,Path(k) )
            TOTAL_Interfrence_Nodes= distance(Path(k),OTHER_CLUSTER);
                                          
           
            Value1=[]; 
            
            Index1=[];
  
            [Index1 Value1]= find(TOTAL_Interfrence_Nodes<INTRang);
            
            if numel(Index1)
                 NO_INT_CLU=NO_INT_CLU+numel(Index1);
            end

               
                                                        
            Numbe_of_Intefrence_Cluster(k)=NO_INT_CLU;
            
                  
             
                 
                     
                  
          
      end
       Num_INT_FUN=sum(Numbe_of_Intefrence_Cluster)/numel(Path)^2;    
      
     NO_INT= Num_INT_FUN;
      
      
     
   
    
        
    
   
    

    
