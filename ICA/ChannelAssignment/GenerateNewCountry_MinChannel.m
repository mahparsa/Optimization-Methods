% GenerateNewCountry(NumOfCountries)  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%this function genertate new country and add to countries

function NewCountry = GenerateNewCountry_MinChannel(NumOfCountries)
global ClusterParams;
global ProblemParams;


N=ClusterParams.Number_of_Cluster; %%%%%%the number of Cluster of networks
NeighborCluster=ClusterParams.Cluster_Neighbor;
MinChannel=ProblemParams.MinNumber_of_Channel;
MaxChannel=ProblemParams.MaxNumber_of_Channel;


p=NumOfCountries   ;
UPPER=min(N,MaxChannel)
HHH=zeros(p,N+UPPER); %%%%the country consists of two parts, one part is number of proviance.The second part is number of 







dis=ProblemParams.Distance %%%%%%the distance between all of nodes
dist_cluster=ClusterParams.Distance_Cluster_Ahead %%%%%%the distance between cluster 
Cluster_ID=ClusterParams.Index_of_Cluster;
Cluster_CH=zeros(1,N)
Assined_CH_Cluster=zeros(1,N);
R_CH=[];



for i=1:p
    AssinedCH_To_Index_Cluster=zeros(1,N);
    AssinedCH_To_ID_Cluster=zeros(1,N);
    II=randperm(MaxChannel);
    F_choose=II(1);
    S_choose=max(MinChannel,  F_choose);
    
    Number_CH=min(S_choose,N); %%%% for each individulal a number of channel is considered.Number channel shows how many color is yuilized for this chromozom.   
    %%%%%%% How many channel can be assined to this chromozom.
    
    
    HHH(i,N+1:N+Number_CH)=randperm(Number_CH);    
      %%%%Coloring the Cluster in order to minimze the interfrence  
     NoResource(i)=Number_CH;  
     OrResource{i}=HHH(i,N+1:N+Number_CH);
    Index_Cluster=[];  
    Index_Cluster=randperm(N); %%%%%Number_Cluster is refrred to index of cluster.
    First_CH_Cluster=[];
    First_CH_Cluster=HHH(i,N+1:N+Number_CH);%%% choosing channel to assing the cluster. one channel to one cluster
    
      
      
      
     AssinedCH_To_Index_Cluster(Index_Cluster(1:Number_CH))=First_CH_Cluster %%%channel is assined to cluste_index
      
     AssinedCH_To_ID_Cluster( Cluster_ID( Index_Cluster (1:Number_CH) ) )=First_CH_Cluster;
     %%%%Which channel is assined to wich cluster
      %%%%it is an array that is equal to size the number of channel. Each
      %%%%index is refreed to cluster_ID and show which channel is assined
      %%%%for that cluster-ID. 
      Value=[];
           Index=[];
           [Value, Index]=find (AssinedCH_To_Index_Cluster==0)
      if size(Value,2)~=0     
      for ii=1:size(Value,2)
           
           Remained_CH=[];
           Unassined_Index_Cluster=Index(ii)%%%it has the index of cluster that is not assined any channel, it is the index of the cluste and it is not Cluster_ID           
           
           Value1=[];
           Index1=[];
           Index_Adjacent_Cluster=ClusterParams.Cluster_Neighbor{Unassined_Index_Cluster} ;
           
           Index1=Index_Adjacent_Cluster;
             if numel( Index1)> 0
              NVauel_CH=[];
              NAssined_CH=[];
           
              [NVauel_CH, NAssined_CH]=find( AssinedCH_To_Index_Cluster(Index1) ==0)%%%%We have the Index of clustes that have interfrence with the unsined index cluster
              Set_Channel_To_Adjacent_Cluster=AssinedCH_To_Index_Cluster(Index1);
              Set_Channel_To_Adjacent_Cluster(NAssined_CH)=[];           
              Remained_CH=[];
              
              if  size(Set_Channel_To_Adjacent_Cluster,2)>=1

              Remained_CH=setdiff(First_CH_Cluster,Set_Channel_To_Adjacent_Cluster )
                             
            
            if size(Remained_CH,2)~=0
             
                 II=[];
                  II=randperm(size(Remained_CH,2)); 
             m=II(1);%%%%we assined 
            
            
            AssinedCH_To_Index_Cluster(Index(ii))=Remained_CH(m);
      
            AssinedCH_To_ID_Cluster( Cluster_ID( Index(ii)))=Remained_CH(m);
            
            
            else %%%if size(Remained_CH,2)~=0

                
                
%                 ASSINED_CHANNEL=[];
%                 
%                  ASSINED_CHANNEL=randperm(Number_CH)
%                 New_CH=setdiff(randperm(Number_CH+1),ASSINED_CHANNEL )
%                 m=randint(1,1,[1 size(New_CH,2)]);
             II=randperm(Number_CH); 
             m=II(1);%%%%we assined randomly one reused channel
             AssinedCH_To_Index_Cluster(Index(ii))=m;
             AssinedCH_To_ID_Cluster( Cluster_ID( Index(ii)))=m;
             
%              
%                 
% %             m=randint(1,1,[1,Number_CH]); %%%%we assined randomly one reused channel
%             AssinedCH_To_Index_Cluster(Index(ii))=m;
%       
%             AssinedCH_To_ID_Cluster( Cluster_ID( Index(ii)))=m;
%             
           
            end
                
            else %% if  size(Set_Channel_To_Adjacent_Cluster,2)>=1
                 II=randperm(Number_CH); 
               m=II(1);%%%%we assined randomly one reused channel
                 AssinedCH_To_Index_Cluster(Index(ii))=m;
                 AssinedCH_To_ID_Cluster( Cluster_ID( Index(ii)))=m;
              
              end      
          
             else %%%%if size(Value1,2) > =1
               II=randperm(Number_CH); 
               m=II(1);%%%%we assined randomly one reused channel
             AssinedCH_To_Index_Cluster(Index(ii))=m;
      
             AssinedCH_To_ID_Cluster( Cluster_ID( Index(ii)))=m;
            
            end %%%%if size(Value1,2) > =1 
              
      end
      end
          
  HHH(i,1:N)=AssinedCH_To_Index_Cluster ;       
         
         
          
end    
NewCountry.Position =HHH ;
NewCountry.Resources=NoResource;
NewCountry.OrderResources=OrResource;







   
    

 
 





