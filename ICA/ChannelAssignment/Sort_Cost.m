  function TheEmpire = Sort_Cost(TheEmpire);


         [SortCost,SortIndex]=sort( TheEmpire.Colonies.Cost,'descend');
          TheEmpire.Colonies.Position=TheEmpire.Colonies.Position(SortIndex,:);
          TheEmpire.Colonies.Cost=TheEmpire.Colonies.Cost(SortIndex);
          TheEmpire.Colonies.Position=TheEmpire.Colonies.Position(SortIndex,:);
          TheEmpire.Colonies.Resource=TheEmpire.Colonies.Resource(SortIndex);
          TheEmpire.Colonies.OrderResource=TheEmpire.Colonies.OrderResource(SortIndex);
