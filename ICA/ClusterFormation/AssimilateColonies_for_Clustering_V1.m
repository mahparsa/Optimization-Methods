
  function TheEmpire = AssimilateColonies_for_Clustering_V1(TheEmpire)
global ClusterParams;
global ProblemParams;
global AlgorithmParams;
%%%%%%%%For assimaltion operation, we need determin how many of colonies must be assimalted.
%%%%%%%%And how many resourses must be assined to the colon as same with the assining the resourse to Emprialist.  
%%%%%%%%what is the assimulated Points.
% TheEmpire=Empires(ii);
N=ProblemParams.NODE.Number;
NumOfColonies =numel([TheEmpire.Colonies(:).Cost]);
 %%%%%%%%% It deremine the number of colony that must change in each Empires. 
%  Number_of_Assimialted_Colony = ceil((AlgorithmParams.Assimilation_NC_Coefficient)*(TheEmpire.TotalCost)* NumOfColonies);
Number_of_Assimialted_Colony = ceil((TheEmpire.NormalizedPower)* NumOfColonies);
 %%%%%the coefficent (1-TheEmpire.NormalizedPower) raise in Assimilation rate in power less country to incresze its power.
 %%%%%the weakest colonies in each empires choose first 
  flag=[];
NumberResourceOfImperialist=TheEmpire.Imperialist.Sequence;
Resource_Empire=TheEmpire.Imperialist.Sequence;

for j=1:Number_of_Assimialted_Colony
     
    
     TEMP=[];
     TEMP=TheEmpire.Colonies(end-j+1).Sequence%%because the weakest have lower positionin array.
     %%%%%Considering one allocated resousers of coloni must assimulated to imprialist 
     DifferentNoResource_COLONY=setdiff(TEMP,Resource_Empire);
     DifferentNoResource_IMPERILST=setdiff(Resource_Empire,TEMP);

     
     if numel(DifferentNoResource_IMPERILST)~=0 & numel(DifferentNoResource_COLONY)~=0
     
     DIGREE_IMPERIALIST=Digree_of_NODE_in_Sequence( DifferentNoResource_IMPERILST);
     DIGREE_COLONY=Digree_of_NODE_in_Sequence( DifferentNoResource_COLONY);
   
     
     node=[];Index_node=[];
     [min_nei,Index_node]=min( DIGREE_COLONY);
     [VAL,IND]=find(TEMP==DifferentNoResource_COLONY(Index_node));
     
     node=[];Index_node=[];
     [max_nei,Index_node]=max(  DIGREE_IMPERIALIST );
     [VAL2,IND2]=find(Resource_Empire==DifferentNoResource_IMPERILST(Index_node));
      TEMP(IND)=Resource_Empire(IND2);
     elseif numel(DifferentNoResource_IMPERILST)==0 & numel(DifferentNoResource_COLONY)~=0
             
         DIGREE_COLONY=Digree_of_NODE_in_Sequence( DifferentNoResource_COLONY);
   
     
         node=[];Index_node=[];
        [node_REMOVE,Index_node]=min( DIGREE_COLONY);
     
        [VAL,IND]=find(TEMP==DifferentNoResource_COLONY(Index_node));
        
         TEMP(IND)=[];
     elseif numel(DifferentNoResource_IMPERILST)~=0 &  numel(DifferentNoResource_COLONY)==0
     
      DIGREE_IMPERIALIST=Digree_of_NODE_in_Sequence( DifferentNoResource_IMPERILST);   
     

     node=[];Index_node=[];
     [node_add,Index_node]=max(  DIGREE_IMPERIALIST );
     
     [VAL2,IND2]=find(Resource_Empire==DifferentNoResource_IMPERILST(Index_node));
     
     TEMP(end+1)=Resource_Empire(IND2);
     
     elseif numel(DifferentNoResource_IMPERILST)==0 &  numel(DifferentNoResource_COLONY)==0
   
     flag(end+1)=j;
         
         
     end
     
     
     TEMP2=[];
    
     TEMP2=unique(TEMP);
   
     TheEmpire.Colonies(end-j+1).Sequence=[];
     TheEmpire.Colonies(end-j+1).Sequence=TEMP2;
     TheEmpire.Colonies(end-j+1).NoCluster=numel(TEMP2);     
     
end

  for kk=1:numel(flag)
  
  TheEmpire.Colonies(flag(kk))=[];
  end    
      