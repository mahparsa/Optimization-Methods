% Empires=ImperialisticCompetition(Empires)  
    function Empires=ImperialisticCompetition(Empires)
%     if rand > .11 
%         return
%     end
    

    if numel(Empires)<=1
        return;
    end
    TotalCosts=[];  
    TotalCosts = [Empires.TotalCost];
    [MaxTotalCost WeakestEmpireInd] = max(TotalCosts); %%%%%we change to max because the optimal solution minimze the cost function. 
    TotalPowers = MaxTotalCost-TotalCosts;             %%%%%%the one that has minimum cost, has maximum total.  
    PossessionProbability = TotalPowers / sum(TotalPowers);
    SelectedEmpireInd = SelectAnEmpire(PossessionProbability);
    nn = numel(Empires(WeakestEmpireInd).Colonies.Cost);
    R=[];
    R=randperm(nn);
   jj=R(1); 
%     jj = randint(1,1,[1 nn]);
    
    if jj~=0
    
    nn2=numel(Empires(SelectedEmpireInd).Colonies.Cost);
    Empires(SelectedEmpireInd).Colonies.Position(nn2+1,:) = Empires(WeakestEmpireInd).Colonies.Position(jj,:);
    Empires(SelectedEmpireInd).Colonies.Cost(nn2+1) =  Empires(WeakestEmpireInd).Colonies.Cost(jj);
    Empires(SelectedEmpireInd).Colonies.Resource(nn2+1) =  Empires(WeakestEmpireInd).Colonies.Resource(jj);
    Empires(SelectedEmpireInd).Colonies.OrderResource{nn2+1} =  Empires(WeakestEmpireInd).Colonies.OrderResource{jj};
    
    Empires(WeakestEmpireInd).Colonies.Position = Empires(WeakestEmpireInd).Colonies.Position([1:jj-1 jj+1:end],:);
    Empires(WeakestEmpireInd).Colonies.Resource = Empires(WeakestEmpireInd).Colonies.Resource([1:jj-1 jj+1:end]);
    Empires(WeakestEmpireInd).Colonies.Cost= Empires(WeakestEmpireInd).Colonies.Cost([1:jj-1 jj+1:end]);
    Empires(WeakestEmpireInd).Colonies.OrderResource = Empires(WeakestEmpireInd).Colonies.OrderResource([1:jj-1 jj+1:end]);
    end        
    %% Collapse of the the weakest colony-less Empire
    nn = numel(Empires(WeakestEmpireInd).Colonies.Cost);
if nn==0%%%%%%%%if empire has less than one colony     
    Empires(SelectedEmpireInd).Colonies.Position(nn2+1,:) = Empires(WeakestEmpireInd).Imperialist.Position;
    Empires(SelectedEmpireInd).Colonies.Cost(nn2+1) =  Empires(WeakestEmpireInd).Imperialist.Cost;
    Empires(SelectedEmpireInd).Colonies.Resource(nn2+1) =  Empires(WeakestEmpireInd).Imperialist.Resource;
    Empires(SelectedEmpireInd).Colonies.OrderResource{nn2+1} =  Empires(WeakestEmpireInd).Imperialist.OrderResource;
    
    
    Empires(WeakestEmpireInd).Imperialist.Position =[];
    Empires(WeakestEmpireInd).Imperialist.Resource =[];
    Empires(WeakestEmpireInd).Imperialist.Cost= [];
    Empires(WeakestEmpireInd).Imperialist.OrderResource = [];
    Empires=Empires([1:WeakestEmpireInd-1 WeakestEmpireInd+1:end]);

end
    
    
                                         
end
% 
%    end

 
 
