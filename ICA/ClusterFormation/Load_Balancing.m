Nc=ClusterParams.Number_of_Cluster;

 Node=[70,100,150,200,250];
N=Node(i)
 Meu=(N-Nc)/Nc;
x=[];
for ii=1:ClusterParams.Number_of_Cluster
    mem=[];
    mem=cell2mat(ClusterParams.Member_of_Cluster(ii));
    x(ii)=numel(mem);
   
end
    
LBF_LID(2,i)=Nc/sum(( x-Meu).^2)
plot(LBF_LID,'o-r')

%%%ACO#2
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
%     hold on 
% LBF_ACOn2(i)=Nc/sum(( x-Meu).^2)
% plot(LBF_ACOn2,'.-k')
% 
%%%ACO#1
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
% LBF_ACOn1(i)=Nc/sum(( x-Meu).^2)
%     hold on 
%  plot(LBF_ACOn1,'.-b')

