function Country=Generat_Country_Clustering_V1;
global ProblemParams;
global AlgorithmParams;

Country_Number=AlgorithmParams.NumOfCountries  ;
N=ProblemParams.NODE.Number;
Neighbor=ProblemParams.NODE.Neighbors;
for bb=1:N
   Digree(bb)=numel(Neighbor{bb});
end   
MAX_CLUSTER= ProblemParams.Maximum_No_Cluster;
 [node,Index_node]=sort(Digree,'descend');
Cluster_node=Index_node(1:MAX_CLUSTER);
for k=1:Country_Number
    
    Visite_NODE=[];
    no_cluster=[];
    Seq=[];
    no_cluster=randi([3,MAX_CLUSTER],1,1);
    
    Seq=Index_node(k:no_cluster+k);
    Visite_NODE=Index_node(1:no_cluster);
    for jj=1: no_cluster
       Un_Visited=setdiff(   Neighbor{ Seq(jj)},Visite_NODE); 
       
       Visite_NODE=[ Visite_NODE,Un_Visited];  
  
    end
    
    Un_Visited_f=[];
    Un_Visited_f=setdiff(   randperm(N),Visite_NODE); 
    while numel(Un_Visited_f)~=0 
    
      no_cluster=no_cluster+1;   
    
    if numel(Un_Visited_f)~=1
       [VALUE,INDEX]=max(Digree(Un_Visited_f)) ;
        
    else
    INDEX=1;
    end
    Seq(end+1)=Un_Visited_f(INDEX);
    Visite_NODE(end+1)=Un_Visited_f(INDEX);
    Un_Visited=[];
    Un_Visited=setdiff( Neighbor{ Seq(end)},Visite_NODE); 
    Visite_NODE=[ Visite_NODE,Un_Visited];  
    Un_Visited_f=[];
    Un_Visited_f=setdiff(randperm(N),Visite_NODE); 
    
    end
    
    Seq2=unique(Seq);
    INDEX=[];
    INDEX=randperm(numel(unique(Seq)))
    Country(k).Sequence=Seq2(INDEX);
    Country(k).NoCluster=numel(unique(Seq));
    Country(k).NoCoverNodes=numel(Visite_NODE);
    Country(k).CoverNodes=Visite_NODE;  
    Country(k).Cost=0;
   
end
 
 
 
 
 
 
 
 
 
 
 
 
   
    
 
 
 


