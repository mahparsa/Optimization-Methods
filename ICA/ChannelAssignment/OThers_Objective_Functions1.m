    function Other_Functions=OThers_Objective_Functions1(Solution)
global ClusterParams;
global ProblemParams;

N=ClusterParams.Number_of_Cluster;
MaxChannel=ProblemParams.MaxNumber_of_Channel;
MinChannel=ProblemParams.MinNumber_of_Channel;
INT_RANGE=ProblemParams.InrRange+10;


AssinedCH_To_Index_Cluster=zeros(1,N);
AssinedCH_To_ID_Cluster=zeros(1,N);
Cluster_ID=[];
Cluster_ID=ClusterParams.Index_of_Cluster;
dist_cluster=[];
dist_cluster=ClusterParams.Distance_Cluster_Ahead; %%
nn=ProblemParams.Path_Loss_Exponents;
 h=Solution;


for k=1:numel(h)
       
          
          INT=[];
          INT= cell2mat(ClusterParams.Cluster_Interfrence(k));
          Value=[]; 
          Index=[];
          [Value Index]= find(h==h(k));
          Same_Index=find(Index==k);
          Index(Same_Index)=[];
          Value(Same_Index)=[];
                  Intefrence_Cluster=[]; 
                  Dist_Interfre_Nodes=[];
                  if numel(Index)~=0
                  for jj=1:numel(Value)
                    INT_clusters=intersect(Index(jj),INT);
                    
                     if numel(INT_clusters)~=0
                        Dist_Interfre_Nodes(jj)=dist_cluster(k,INT_clusters)^(-nn); 
                     else
                          Dist_Interfre_Nodes(jj)=dist_cluster(k,Index(jj))^(-nn); 
                     end    
                                          
                  end
                  
                   else 
                       Dist_Interfre_Nodes(1)=max( dist_cluster(k,:) )^(-nn);
                  
                  end    
                     
          Power_of_Interfrence_Cluster(k)=sum(Dist_Interfre_Nodes);
        
end
      POW_INT_FUN=sum (Power_of_Interfrence_Cluster);
    
      f3=POW_INT_FUN/N;
      
      LOGARITMIC_INT=10*log10(1000*f3);

 

Other_Functions= LOGARITMIC_INT;  



