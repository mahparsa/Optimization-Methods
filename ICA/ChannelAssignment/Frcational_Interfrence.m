function F_INT=Frcational_Interfrence(Cluster,NUM_CHANNEL)


    INT=Cluster.Cluster_Interfrence;

for ii=1:Cluster.Number_of_Cluster
    Index=[];true=[];  Index2=[];true2=[];
    [true,Index]=find(NUM_CHANNEL==NUM_CHANNEL(ii));
    [true2,Index2]=intersect(Index,INT{ii}); 
    Number_Interfrence_Cluster_after_AssignedChannel(ii)=numel(Index2);
    Number_Interfrence_Cluster(ii)=numel(INT{ii})+1;
    
end   

 F_INT=sum(Number_Interfrence_Cluster_after_AssignedChannel)/sum(Number_Interfrence_Cluster);