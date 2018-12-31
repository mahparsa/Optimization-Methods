      function Empires_for_MinChannel= CreateInitialEmpires_for_MinChannel(Initial,AlgorithmParams,ProblemParams,ClusterParams);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%::::::::::::::::::::::::::::::::::::::::what means Position::::::::::::::::::::::::::::
%////ImperialistsPosition has the value of country that determine as imperialist.
AllImperialistsPosition = Initial.Countries(end-AlgorithmParams.NumOfInitialImperialists+1:end,:);
AllImperialistsCost = Initial.Cost(end-AlgorithmParams.NumOfInitialImperialists+1:end);
AllImperialistsResource= Initial.Resources(end-AlgorithmParams.NumOfInitialImperialists+1:end);
AllImperialistsOrderResource=Initial.OrderResources(end-AlgorithmParams.NumOfInitialImperialists+1:end);
AllColoniesPosition = Initial.Countries(1:end-AlgorithmParams.NumOfInitialImperialists,:);
AllColoniesCost = Initial.Cost(1:end-AlgorithmParams.NumOfInitialImperialists);
AllColoniesResource=Initial.Resources(1:end-AlgorithmParams.NumOfInitialImperialists);
AllColoniesOrderResource=Initial.OrderResources(1:end-AlgorithmParams.NumOfInitialImperialists);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%:::::::::::::::::::::::::::::::::::It is true for minimizing problem.

if max(AllImperialistsCost)>0
    AllImperialistsPower = 1.3 * max(AllImperialistsCost) - AllImperialistsCost;
else
    AllImperialistsPower = 0.7 * max(AllImperialistsCost) - AllImperialistsCost;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%:::::::::::::::::::::::::::::::::::However for  maximizing problem the below one must be used. 

%     AllImperialistsPower = AllImperialistsCost - 1.3 * min(AllImperialistsCost);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AllImperialistNormalized_Power =AllImperialistsPower/sum(AllImperialistsPower);
AllImperialistNumOfColonies = round(AllImperialistsPower/sum(AllImperialistsPower) * AlgorithmParams.NumOfAllColonies);
%%////for last Imperalist, the reminig colonies are jointed to it.
AllImperialistNumOfColonies(end) = AlgorithmParams.NumOfAllColonies - sum(AllImperialistNumOfColonies(1:end-1));

RandomIndex = randperm(AlgorithmParams.NumOfAllColonies);

%%%%%the Index of Colonies.

Empires(AlgorithmParams.NumOfInitialImperialists).Imperialist.Position = 0;

for ii = 1:AlgorithmParams.NumOfInitialImperialists
    Empires(ii).Imperialist.Position = AllImperialistsPosition(ii,:);
    Empires(ii).Imperialist.Cost = AllImperialistsCost(ii);
    Empires(ii).Imperialist.Resource = AllImperialistsResource(ii);
    Empires(ii).Imperialist.OrderResource = AllImperialistsOrderResource{ii};
    R = RandomIndex(sum(AllImperialistNumOfColonies(1:ii-1))+1:sum(AllImperialistNumOfColonies(1:ii-1))+AllImperialistNumOfColonies(ii)); %RandomIndex(AllImperialistNumOfColonies(ii)+1:end);
    Empires(ii).Colonies.Position = AllColoniesPosition(R,:);
    Empires(ii).Colonies.Cost = AllColoniesCost(R);
    Empires(ii).Colonies.Resource = AllColoniesResource(R);
    Empires(ii).Colonies.OrderResource=AllColoniesOrderResource();
    Empires(ii).TotalCost = Empires(ii).Imperialist.Cost + AlgorithmParams.Zeta * mean(Empires(ii).Colonies.Cost);
    Empires(ii).NormalizedPower = AllImperialistNormalized_Power(ii);
end


for ii = 1:numel(Empires)
    if numel(Empires(ii).Colonies.Position) == 0
        Empires(ii).Colonies.Position = GenerateNewCountry_MinChannel(1,AlgorithmParams,ProblemParams,ClusterParams);  
       
        
        %****Empires(ii).ColoniesCost = COST(Empires(ii).ColoniesPosition,size(Empires(ii).ColoniesPosition,3),size(Empires(ii).ColoniesPosition,2))'%%%(ProblemParams.FunctionName,Empires.ColoniesPosition);
    end
end
 
 
Empires_for_MinChannel=Empires;