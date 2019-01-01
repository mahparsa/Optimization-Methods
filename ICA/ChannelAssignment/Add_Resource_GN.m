   function  TheEmpire  = Add_Resource_GN(TheEmpire);
global ClusterParams;
global ProblemParams;
global AlgorithmParams;

   %UNTITLED Summary of this function goes here
%   Detailed explanation goes here

N=ClusterParams.Number_of_Cluster;
INT_Cluster=ClusterParams.Cluster_Interfrence;
NeighborCluster=ClusterParams.Cluster_Neighbor;
MinChannel=ProblemParams.MinNumber_of_Channel;
MaxChannel=ProblemParams.MaxNumber_of_Channel;
NumOfColonies =numel(TheEmpire.Colonies.Cost);
UPPER=min(N,MaxChannel);
NumOfAddingRecource = min(ceil(AlgorithmParams.RevolutionRate2 *( MaxChannel-TheEmpire.Imperialist.Resource))-1,MaxChannel-TheEmpire.Imperialist.Resource);                  
if NumOfAddingRecource > 0
   

TEMP=[];
TEMP=TheEmpire.Imperialist.Position;%%because the weakest have lower positionin array.
     TEMP1=[];
     TEMP2=[];
     
     TEMP1=TEMP(1:N);
     TEMP2=TheEmpire.Imperialist.OrderResource;
     
     %change the assighned resource to province :::::::::::::::::::::TEMP1
     
     V=0;I=0;[V,I]=setdiff(randperm(MaxChannel),TEMP2);
     
    
    
    Revelotion_Point_Resource=V(1:NumOfAddingRecource)
    TEMP2=[TEMP2,Revelotion_Point_Resource ];
    Index_ADD=[];
    Index_ADD=randperm(N);
    Revelotion_Point_Province=Index_ADD(1:NumOfAddingRecource);
    TEMP1(Revelotion_Point_Province)=-1;
%      V=0;I=0;[V,I]=intersect(TEMP1,Revelotion_Point_Province);TEMP1(I)=-1;
Available_Resource=unique(TEMP1);Resource_TO_Province=unique(TEMP2);



if find(Available_Resource ==-1); 
   Available_Resource(1)=[];
   
end

 V=0;I=0;[V,I]=setdiff( Available_Resource,Resource_TO_Province);
 
 if numel(V)~=0
    [CH_V,CH_I]=intersect( TEMP2,V  ); TEMP2(CH_I)=[];
 end
 
 

% if find(Available_Resource==0); 
%    Resource_TO_Province(1)=[];
%    
% end

%change the avaiable resource:::::::::::::::TEMP2.is like to crossover of grouping genetic algorithm. 
%%


% [CH_V,CH_I]=intersect( TEMP2,Revelotion_Point  ); TEMP2(CH_I)=[max(TheEmpire.Imperialist.OrderResource)+1]; TEMP2=[TEMP2,Revelotion_Point ];



%%%%%%%%%%%%%%%%%%%%%the value of assined to index cluster is the same of value of TEMP1
% AssinedCH_To_Index_Cluster(Index_AS)=TEMP1(Index_AS) %%%channel is assined to cluste_index
    
      
      
Value8=[];
Index8=[];
[Value8, Index8]= find(  TEMP1 == -1);



Value_AS=[];
Index_AS=[];
[Value_AS, Index_AS]= find(  TEMP1 ~= -1);

while numel(Value8)%%%%%%%%%%the cluster that has not assined Chanel
     
     [Value8, Index8]= find( TEMP1 == -1);
     if numel(Value8)==0
         break;
     end    
     Remained_CH=[];
     Unassined_Index_Cluster=Index8(1);%%%it has the index of cluster that is not assined any channel, it is the index of the cluste and it is not Cluster_ID           
     
     
     Adjacent_Cluster=NeighborCluster(Index8(1));
      Index9=Adjacent_Cluster;

     
%      Adjacent_Cluster=NeighborCluster(Index8(1));
% %      Interfernce_Cluster=INT_Cluster{Index8(1),1};
% %      Index9=Interfernce_Cluster;
%      Index9=Adjacent_Cluster;
     
%      Interfernce_Cluster=INT_Cluster{Index8(1),1};
%      Index9=Interfernce_Cluster;
     
     %%the goal of this if is that determine the available channel that can
     %%be assined to unassined cluster without interfrence. 
     
      
      if numel(Index9)~=0 %%%%%%if there is cluster has interfrence with this one%%%%%%%%%%%%%%%
        Set_Channel_To_Adjacent_Cluster=TEMP1(Index9); %%%has two value positive int  or zero
        %%%positive int shows that a channel is assined. 
        AS_CH=[];,AS_Ind=[];
        [AS_CH,AS_Ind]=unique(Set_Channel_To_Adjacent_Cluster);
        
        if find(AS_CH==-1)
            AS_CH(find(AS_CH==-1))=[]; 
        end

        
        if find(AS_CH==0)
            AS_CH(find(AS_CH==0))=[]; 
        end

        Resource_TO_Province=[];
        Resource_TO_Province=unique(TEMP2);
          if find (Resource_TO_Province==-1 )
             Resource_TO_Province(find (Resource_TO_Province==-1 ))=[];
             TEMP2(find(TEMP2==-1))=[];
          end

          if find (Resource_TO_Province==0 ) 
             Resource_TO_Province(find (Resource_TO_Province==0 ) )=[];
             TEMP2(find(TEMP2==0))=[];
          end
       Set_For_Assined_CH=[];
        
      
       
        Set_For_Assined_CH=setdiff(Resource_TO_Province,AS_CH);%%%%Set_For_Assined_CH2=setdiff(AS_CH,Resource_TO_Province);
        %%%%%now it has the channel that are assined to interfrence channel
        if numel(Set_For_Assined_CH)~=0
            
            Assined_CH=min(Set_For_Assined_CH);
            TEMP1(Index8(1))=Assined_CH;
        else%%%%there is no available cahnnel to assineg 
            %%add new channel
            AV_CH=[];
            AV_CH=setdiff(randperm(max(Resource_TO_Province)),Resource_TO_Province);
            
            %::::::::::::::::::::::be careful that the number of  randperm(max(Resource_TO_Province)) is more than the number of Resource_TO_Province
            if numel(AV_CH)~=0
            Assined_CH=min(AV_CH);
            else   
            Assined_CH=max(Resource_TO_Province)+1;
            
            end
            
            %%%%%%%%%%%%%change the TEMP2
            TEMP2(end+1)=Assined_CH; 
            TEMP1(Index8(1))=Assined_CH;
        end
        
     else                %%%%%%if there is no cluster has interfrence with this one%%%%%%%%%%%%%%%
     
        Assined_CH=min(Resource_TO_Province);%%%%%%we use the first channel when there is no limitation to reuse other channels. It  decreses the number of assined channel.     
        TEMP1(Index8(1))=Assined_CH;
     end                 %%%%%%if there is any cluster that has interfrence with this one%%%%%%%%%%%%%%%  
     
     if find(TEMP2~=Assined_CH)
         TEMP2=[TEMP2,Assined_CH];
     end   
 end   %%%%%%%%%%while the clusters that have s not assined Chanel    

     
     
     
 

   

Available_Resource=[];Resource_TO_Province=[];
Available_Resource=unique(TEMP1);Resource_TO_Province=unique(TEMP2);


% if find(Available_Resource ==-1); 
%    Resource_TO_Province(1)=[];
%    
% end
% 
% if find(Available_Resource==0); 
%    Resource_TO_Province(1)=[];
%    
% end
TEMP2=[];

 
Index=randperm(numel(Available_Resource))
TEMP2=Available_Resource(Index);
 

 

 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
     %%
  
TEMP=[]; 
TEMP=[TEMP1,TEMP2] ;           

TheEmpire.Imperialist.Resource=numel(TEMP2);
TheEmpire.Imperialist.OrderResource=TEMP2;
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TheEmpire.Imperialist.Position(1:numel(TEMP))=TEMP;
TheEmpire.Imperialist.Position(numel(TEMP)+1:N+UPPER)=0;
TheEmpire.Imperialist.Resource=numel(TEMP2);
TheEmpire.Imperialist.OrderResource=TEMP2;

end



