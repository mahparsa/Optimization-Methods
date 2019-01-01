 function Other_Functions=OThers_Objective_Functions2(Solution)
global ClusterParams;
global ProblemParams;

N=ClusterParams.Number_of_Cluster;
MaxChannel=ProblemParams.MaxNumber_of_Channel;
MinChannel=ProblemParams.MinNumber_of_Channel;

AssinedCH_To_Index_Cluster=zeros(1,N);
AssinedCH_To_ID_Cluster=zeros(1,N);
Cluster_ID=ClusterParams.Index_of_Cluster;
dist_cluster=ClusterParams.Distance_Cluster_Ahead; %%
nn=ProblemParams.Path_Loss_Exponents;
INT_RANGE=ProblemParams.InrRange+10; 
 h=Solution;
for k=1:numel(h)
              
         INT=[];
         INT= cell2mat(ClusterParams.Cluster_Interfrence(k));
         if numel(INT)~=0
         Dist_Interfre_Nodes=[];
         Dist_Interfre_Nodes=dist_cluster(k,INT).^(-nn);  
         Power_of_Interfrence_Cluster(k)=sum(Dist_Interfre_Nodes);
         else 
         Power_of_Interfrence_Cluster(k)=INT_RANGE^(-nn);  
         end 
          
end
      POW_INT_FUN=sum(Power_of_Interfrence_Cluster);
    
      f3=POW_INT_FUN/N;
      LOGARITMIC_INT=10*log10(1000*f3);
Other_Functions= LOGARITMIC_INT;  



