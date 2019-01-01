function Index = SelectAnEmpire(Probability)
    R = rand(size(Probability));
    D = Probability - R;
    [MaxD Index] = max(D);
end
