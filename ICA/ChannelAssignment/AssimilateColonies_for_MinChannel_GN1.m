% AssimilateColonies(TheEmpire,AlgorithmParams,ProblemParams)  
      function TheEmpire = AssimilateColonies_for_MinChannel_GN1(TheEmpire)
global ClusterParams;
global ProblemParams;
global AlgorithmParams
%%%%%%%%For assimaltion operation, we need determin how many of colonies must be assimalted.
%%%%%%%%And how many resourses must be assined to the colon as same with the assining the resourse to Emprialist.  
%%%%%%%%what is the assimulated Points.



% TheEmpire=Empires(ii);

N=ClusterParams.Number_of_Cluster;
INT_Cluster=ClusterParams.Cluster_Interfrence;
NeighborCluster=ClusterParams.Cluster_Neighbor;
MinChannel=ProblemParams.MinNumber_of_Channel;
MaxChannel=ProblemParams.MaxNumber_of_Channel;
NumOfColonies =numel(TheEmpire.Colonies.Cost);
UPPER=min(N,MaxChannel);
 %%%%%%%%% It deremine the number of colony that must change in each Empires. 
%  Number_of_Assimialted_Colony = ceil((AlgorithmParams.Assimilation_NC_Coefficient)*(TheEmpire.TotalCost)* NumOfColonies);
 Number_of_Assimialted_Colony = ceil((TheEmpire.NormalizedPower)* NumOfColonies);
 %%%%%the coefficent (1-TheEmpire.NormalizedPower) raise in Assimilation rate in power less country to incresze its power.
 %%%%%the weakest colonies in each empires choose first 
 
 NumberResourceOfImperialist=TheEmpire.Imperialist.Resource;
 OrderResourceOfImperialist=TheEmpire.Imperialist.OrderResource;
 R=[];
 R=randperm(NumberResourceOfImperialist);
 
 AssimialtedPoint=R(1);

 
  for j=1:Number_of_Assimialted_Colony
     TEMP=[];
     TEMP=TheEmpire.Colonies.Position(j,:)%%because the weakest have lower positionin array.
     TEMP1=[];
     TEMP2=[];
     
     TEMP1=TEMP(1:N);
     TEMP2=TheEmpire.Colonies.OrderResource{j};

        
     %%%%%Considering one allocated resousers of coloni must assimulated to imprialist 
     Replaced_Resource_Empire=TheEmpire.Imperialist.Position(N+AssimialtedPoint);
     if TheEmpire.Colonies.Resource(j)>= TheEmpire.Imperialist.Resource
     DifferentNoResource=TheEmpire.Colonies.Resource(j)- TheEmpire.Imperialist.Resource;
     DifferentCost=TheEmpire.Colonies.Cost(j)-TheEmpire.Imperialist.Cost;
     Assimilated_Resources_Index=[];%%%%%%
     Assimilated_Resources=[];
     %%
     
if  DifferentNoResource >0 && TheEmpire.Colonies.Resource(j)> MinChannel  %%%%%%if colony has more resourses tahn imperialist 
         
%          NumberOfRemovedResource_Colony=ceil(min(DifferentNoResource,DifferentCost* (TheEmpire.Colonies.Resource(j)-MinChannel   )-1;
         NumberOfRemovedResource_Colony=ceil(DifferentCost* DifferentNoResource);
         %%%%%%%%%%%%%Determine the number of resource that must be removed from colony....... 
         if NumberOfRemovedResource_Colony> 0 && (TheEmpire.Colonies.Resource(j)-NumberOfRemovedResource_Colony)>= MinChannel 
%          Number_of_Assimilated_Resource=ceil(AlgorithmParams.Assimilation_NR_Coefficient*NumberOfRemovedResource_Colony )-1;
           Number_of_Assimilated_Resource=NumberOfRemovedResource_Colony;
        
         Assimilated_Resources=[TheEmpire.Colonies.Resource(j)-Number_of_Assimilated_Resource+1:TheEmpire.Colonies.Resource(j)];
         I=[];V=[];
         [V,I]=intersect(TheEmpire.Colonies.OrderResource{j},Assimilated_Resources);
         Assimilated_Resources_Index=I;
         else
            Assimilated_Resources_Index=[];%%%%%%
             Assimilated_Resources=[];  
         end        
end   %%%%%%if colony has more resourses than imperialist. We have to remove some of them.
%%
%%%%%%%This resource must be removed from the colony.       
%In below steps the resource and assigned resource to each province of colony have been changed.        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%::::::::::::::::::::::::::::::::::::::Frist the additional resource is removed.
%%%%in this step several resources are removed from TEMP2 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if numel(Assimilated_Resources_Index)~=0
    
    TEMP2(Assimilated_Resources_Index)=[];
    
end
%%:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
%change the avaiable resource:::::::::::::::TEMP2.is like to crossover of grouping genetic algorithm. 
%%


[CH_V,CH_I]=find( TEMP2 == Replaced_Resource_Empire  ); TEMP2(CH_I)=[]; TEMP2=[Replaced_Resource_Empire,TEMP2];

if CH_I~=1
    
    
 
%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%change the assighned resource to province :::::::::::::::::::::TEMP1
V=0;I=0;[V,I]=find(TEMP1==Replaced_Resource_Empire );TEMP1(I)=-1;
V=0;I=0;[V,I]=intersect(TEMP1, Assimilated_Resources );TEMP1(I)=-1;
V=0;I=0;[V,I]=find(TheEmpire.Imperialist.Position(1:N)==Replaced_Resource_Empire);TEMP1(I)=Replaced_Resource_Empire;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%for being sure that the availble resources and assigned resources to province are the same. 

Available_Resource=[];Resource_TO_Province=[];
Available_Resource=unique(TEMP1);Resource_TO_Province=unique(TEMP2);
if Available_Resource(1)==-1 
    Available_Resource(1)=[]
end

if Resource_TO_Province(1)==0 
   Resource_TO_Province(1)=[]
end

Value1=[];Index1=[];
   [Value1 Index1]= setdiff(Resource_TO_Province,Available_Resource)
    
%%%%%%if there is different, some channel is lost, they has ont be assighned to any cluster,

    if numel(Value1)~=0
        
        %##change the avaiable channel:::::::::::::::TEMP2
        TEMP2( Index1)=[];
    end    

%  Resource_TO_Province=unique(TEMP2);
%  Value1=[];Index1=[];
% [Value1 Index1]= setdiff(Available_Resource,Resource_TO_Province);
%     
% if numel(Value1)~=0
%         
%         %##change the avaiable channel:::::::::::::::TEMP2
%         TEMP2( Index1)=[Value1];
%     end    





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
    
     Adjacent_Cluster=NeighborCluster{Index8(1)};
      Index9=Adjacent_Cluster;   
     
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
        %%%%%now it has the channel that are assined to interfrence cluster
        %%%%%
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

     
     
     
 

 
 end%%%%% if CH_I~=1  

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
TEMP2=Available_Resource;
 

 

 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
     %%
  
TEMP=[]; 
TEMP=[TEMP1,TEMP2] ;           

Empires(1).Colonies.Resource(j)=numel(TEMP2);
Empires(1).Colonies.OrderResource{j}=TEMP2;
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TheEmpire.Colonies.Position(j,1:numel(TEMP))=TEMP;
TheEmpire.Colonies.Position(j,numel(TEMP)+1:N+UPPER)=0;
TheEmpire.Colonies.Resource(j)=numel(TEMP2);
TheEmpire.Colonies.OrderResource{j}=TEMP2;
     end
   end
 
%     
%             
%            
% 
%          
%             
%             
%             
%             
%             
%            
% 
% 
% 
