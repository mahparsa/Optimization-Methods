  function  Other_COST_BEST_ANT =OThers_Objective_Functions2_ANT(ProblemParams,Path);


h=Path;
INTRang=ProblemParams.NODE.InrRange;
SINR_TH=ProblemParams.SINR.Threshold;
Neighbor=ProblemParams.NODE.Neighbors;
nn=ProblemParams.Path_Loss_Exponents;
distance=ProblemParams.Distance;
for bb=1:numel(Path)
    
   Digree(bb)=numel(Neighbor{bb});
 NI_NODE=[];
    NI_NODE=Neighbor{ Path(bb)}
    for jj=1:numel(NI_NODE)
    
        INT_NODE=find(distance( NI_NODE(jj),: )< INTRang)
        INDEX=find (INT_NODE==NI_NODE(jj))
        INT_NODE(INDEX)=[];
        DIST=[];    
        DIST=distance( NI_NODE(jj), INT_NODE ).^(-nn);
        INT_POWER(jj)=sum(DIST);
            
        Rec_POWER(jj)=1/(4*pi*distance(NI_NODE(jj),Path(bb))^2)             
                          
        SINR(jj)=  Rec_POWER(jj)/(INT_POWER(jj)+1);           
                     
    
    end
    MIN_SINR(bb)=min(SINR);

    
       
    

end

AVE_MINIMUM_SINR=sum( MIN_SINR)/numel(Path);

for bb=1:numel(Path)
    
  
 
        other_cluster=setdiff(Path,Path(bb))
        DIST=distance( Path(bb),   other_cluster ).^(-nn);
        INT_POWER_Cluster(bb)=sum( DIST)
        
        
    
    end
   
AVE_INT_POWER=sum( INT_POWER_Cluster)/numel(Path)
    
       
    
   Other_COST_BEST_ANT=[10*log10(AVE_INT_POWER),10*log10(AVE_MINIMUM_SINR) ]









 
 
 
 
 

    

    
