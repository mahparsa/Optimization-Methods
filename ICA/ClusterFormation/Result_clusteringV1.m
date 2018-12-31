% NODE=[100,200,300,400];
for SS=1:20

CHParams=SAMPLE(SS).ClusterParams;
NO_CLUSTER(SS)=SAMPLE(SS).ClusterParams.Number_of_Cluster;
% MEUE(SS)=(NODE(ff)-NO_CLUSTER(SS))/NO_CLUSTER(SS);
% for k=1: numel(NO_CLUSTER(SS))
%      NO_MEM=[];
%     NO_MEM=cell2mat(SAMPLE(SS).ClusterParams.Member_of_Cluster(k));
%      XX(k)=numel(NO_MEM);
% 
%   
%     ZIGMA(K)=1/(XX(k)-MEUE(SS))^2;
% end    
% LBF(SS)=NO_CLUSTER(SS)/sum( ZIGMA);
end  
AVE_NO_CLUSTER(ff)=sum(NO_CLUSTER)/20