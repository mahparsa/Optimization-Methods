                function Empires_for_Clustering= CreateInitialEmpires_for_Clustering;

global AlgorithmParams;

global Country;
Initial=Country;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%::::::::::::::::::::::::::::::::::::::::what means Position::::::::::::::::::::::::::::
%////ImperialistsPosition has the value of country that determine as imperialist.

AllImperialists = Initial(1:AlgorithmParams.NumOfInitialImperialists);
AllColonies = Initial(AlgorithmParams.NumOfInitialImperialists+1:end);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%:::::::::::::::::::::::::::::::::::It is true for minimizing problem.
AllImperialistsCost=[AllImperialists(:).Cost];
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
 
AllImperialistNumOfColonies = round(AllImperialistNormalized_Power * numel(AllColonies));
%%////for last Imperalist, the reminig colonies are jointed to it.
if sum(AllImperialistNumOfColonies(1:end-1))< numel(AllColonies)
   AllImperialistNumOfColonies(end) = numel(AllColonies)-sum(AllImperialistNumOfColonies(1:end-1));
else
    AllImperialistNumOfColonies(end) =0
end    
RandomIndex=[];
RandomIndex = randperm(numel(AllColonies));
%%%%%the Index of Colonies.
for ii = 1:numel(AllImperialists)
     Empires(ii).Imperialist= AllImperialists(ii);
    if AllImperialistNumOfColonies(ii)<1
        NO_new=3;
%         AlgorithmParams.NumOfAllColonies=AlgorithmParams.NumOfAllColonies+NO_new;
        NewC=GenerateNewCountry_Clustering(NO_new);
         
       
       
        Empires(ii).Colonies =NewC
        
        
        Empires(ii).TotalCost = Empires(ii).Imperialist.Cost + AlgorithmParams.Zeta * mean([Empires(ii).Colonies(:).Cost]);
    
    else
       
    R =AllImperialistNumOfColonies(ii); %RandomIndex(AllImperialistNumOfColonies(ii)+1:end);
    Empires(ii).Colonies = AllColonies(ii:ii+R-1);
    Empires(ii).TotalCost = Empires(ii).Imperialist.Cost + AlgorithmParams.Zeta * mean([Empires(ii).Colonies(:).Cost]);
    Empires(ii).NormalizedPower = AllImperialistNormalized_Power(ii);
    end
end



 
 
Empires_for_Clustering=Empires;