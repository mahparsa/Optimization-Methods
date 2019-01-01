      function Empires_for_MinChannel= CreateInitialEmpires_for_MinChannel(Initial);
global ClusterParams;
global ProblemParams;
global AlgorithmParams;


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
    AllImperialistsPower =  1 - AllImperialistsCost;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%:::::::::::::::::::::::::::::::::::However for  maximizing problem the below one must be used. 

%     AllImperialistsPower = AllImperialistsCost - 1.3 * min(AllImperialistsCost);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AllImperialistNormalized_Power =AllImperialistsPower/sum(AllImperialistsPower);
AllImperialistNumOfColonies = round(AllImperialistNormalized_Power * AlgorithmParams.NumOfAllColonies);
%%////for last Imperalist, the reminig colonies are jointed to it.
AllImperialistNumOfColonies(end) = AlgorithmParams.NumOfAllColonies - sum(AllImperialistNumOfColonies(1:end-1));
RandomIndex=[];
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
        NO_new=3;
%         AlgorithmParams.NumOfAllColonies=AlgorithmParams.NumOfAllColonies+NO_new;
        NewC=GenerateNewCountry_MinChannel(NO_new);
         
       
        Empires(ii).Colonies.Position =  NewC.Position;  
        Empires(ii).Colonies.Resource =NewC.Resources
        Empires(ii).Colonies.OrderResource=NewC.OrderResources;
         Empires(ii).Colonies.Cost = COST_Country_for_MinChannel_MO(Empires(ii)); 
        Empires(ii).TotalCost = Empires(ii).Imperialist.Cost + AlgorithmParams.Zeta * mean(Empires(ii).Colonies.Cost);

        %****Empires(ii).ColoniesCost = COST(Empires(ii).ColoniesPosition,size(Empires(ii).ColoniesPosition,3),size(Empires(ii).ColoniesPosition,2))'%%%(ProblemParams.FunctionName,Empires.ColoniesPosition);
    end
end
 
 
Empires_for_MinChannel=Empires;