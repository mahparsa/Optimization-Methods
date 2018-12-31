%PossesEmpire(TheEmpire)  
  function TheEmpire = PossesEmpire(TheEmpire)
  
  
  
 
  
  
  
    
    ColoniesCost = [TheEmpire.Colonies(:).Cost];
    ColoniesNoCluster= [TheEmpire.Colonies(:).NoCluster];
    [MinColoniesCluster IdColonyCluster]=min( ColoniesNoCluster); 
    [MinColoniesCost BestColonyInd]=min(ColoniesCost);%%%%%%for the DSA problem, the optimal soltion is maximum
    if MinColoniesCost < TheEmpire.Imperialist.Cost

        OldImperialist=TheEmpire.Imperialist; 
        
        
        TheEmpire.Imperialist =TheEmpire.Colonies(BestColonyInd);
                
        TheEmpire.Colonies(BestColonyInd)=OldImperialist;
        
    elseif ((MinColoniesCost == TheEmpire.Imperialist.Cost) & (MinColoniesCluster <TheEmpire.Imperialist.NoCluster))
         OldImperialist=[];
        
        OldImperialist = TheEmpire.Imperialist;
       

        TheEmpire.Imperialist =TheEmpire.Colonies(IdColonyCluster);
        
        
        TheEmpire.Colonies(IdColonyCluster)= [];
        TheEmpire.Colonies(IdColonyCluster)= OldImperialist;
       
        
 end
  end
 
%  
