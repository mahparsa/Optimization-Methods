NODE=[100,200,300,400];
global ProblemParams; 
for SS=1:20
CHParams=SAMPLE(SS).ClusterParams;
ProblemParams=SAMPLE(SS).ProblemParams;
NO_CLUSTER(SS)=SAMPLE(SS).ClusterParams.Number_of_Cluster;
MEUE(SS)=(NODE(ff)-NO_CLUSTER(SS))/NO_CLUSTER(SS);

 NO_CONN(SS)=COST_Connectivity_V3(SAMPLE(SS).ClusterParams.Index_of_Cluster);
NO_INT(SS)= COST_INTERFRENCE(SAMPLE(SS).ClusterParams.Index_of_Cluster);
for k=1: NO_CLUSTER(SS)
    NO_MEM=[];
    NO_MEM=cell2mat(SAMPLE(SS).ClusterParams.Member_of_Cluster(k));
     XX(k)=numel(NO_MEM);

  
    ZIGMA(k)=(XX(k)-MEUE(SS))^2;
 end    
LBF(SS)=NO_CLUSTER(SS)/sum( ZIGMA);
 end  
AVE_NO_CLUSTER1(ff)=sum(NO_CLUSTER)/20
AVE_LBF1(ff)=sum(LBF)/20;
 AVE_CONN1(ff)=sum(NO_CONN)/20;
AVE_INT1(ff)=sum(NO_INT)/20;

% Nc=ClusterParams.Number_of_Cluster;
% 
%  Node=[70,100,150,200,250];
% N=Node(i)
%  Meu=(N-Nc)/Nc;
% x=[];
% for ii=1:ClusterParams.Number_of_Cluster
%     mem=[];
%     mem=cell2mat(ClusterParams.Member_of_Cluster(ii));
%     x(ii)=numel(mem);
%    
% end
%     
% LBF_LID(2,i)=Nc/sum(( x-Meu).^2)
% plot(LBF_LID,'o-r')
