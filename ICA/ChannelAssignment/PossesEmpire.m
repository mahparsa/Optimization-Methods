%PossesEmpire(TheEmpire)  
  function TheEmpire = PossesEmpire(TheEmpire)
    
    ColoniesCost = TheEmpire.Colonies.Cost;
    ColoniesResource=TheEmpire.Colonies.Resource;
    [MinColoniesResource IdColonyResource]=min(ColoniesResource); 
    [MinColoniesCost BestColonyInd]=min(ColoniesCost);%%%%%%for the DSA problem, the optimal soltion is maximum
    if MinColoniesCost < TheEmpire.Imperialist.Cost

        OldImperialistPosition = TheEmpire.Imperialist.Position;
        OldImperialistCost = TheEmpire.Imperialist.Cost;
        OldImperialistResource=TheEmpire.Imperialist.Resource;
        OldImperialistOrderResource=TheEmpire.Imperialist.OrderResource;


        TheEmpire.Imperialist.Position =TheEmpire.Colonies.Position(BestColonyInd,:);
        TheEmpire.Imperialist.Cost=TheEmpire.Colonies.Cost(BestColonyInd);
        TheEmpire.Imperialist.Resource=TheEmpire.Colonies.Resource(BestColonyInd);
        TheEmpire.Imperialist.OrderResource=TheEmpire.Colonies.OrderResource{BestColonyInd};
      
        
        TheEmpire.Colonies.Position(BestColonyInd,:)=OldImperialistPosition;
        TheEmpire.Colonies.Cost(BestColonyInd)=OldImperialistCost;
        TheEmpire.Colonies.Resource(BestColonyInd)=OldImperialistResource;
        TheEmpire.Colonies.OrderResource{BestColonyInd}=OldImperialistOrderResource;
    elseif (MinColoniesCost == TheEmpire.Imperialist.Cost) && (MinColoniesResource <TheEmpire.Imperialist.Resource)
        
        OldImperialistPosition = TheEmpire.Imperialist.Position;
        OldImperialistCost = TheEmpire.Imperialist.Cost;
        OldImperialistResource=TheEmpire.Imperialist.Resource;
        OldImperialistOrderResource=TheEmpire.Imperialist.OrderResource;


        TheEmpire.Imperialist.Position =TheEmpire.Colonies.Position(BestColonyInd,:);
        TheEmpire.Imperialist.Cost=TheEmpire.Colonies.Cost(BestColonyInd);
        TheEmpire.Imperialist.Resource=TheEmpire.Colonies.Resource(BestColonyInd);
        TheEmpire.Imperialist.OrderResource=TheEmpire.Colonies.OrderResource{BestColonyInd};
      
        
        TheEmpire.Colonies.Position(BestColonyInd,:)=OldImperialistPosition;
        TheEmpire.Colonies.Cost(BestColonyInd)=OldImperialistCost;
        TheEmpire.Colonies.Resource(BestColonyInd)=OldImperialistResource;
        TheEmpire.Colonies.OrderResource{BestColonyInd}=OldImperialistOrderResource;
        

        
 end
  end
 
%  
