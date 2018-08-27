%   function [ClusterParams]=Cluster_5_2_Ad_Hoc_Network(ProblemParams);

noOfNodes=ProblemParams.NODE.Number;
L=ProblemParams.NODE.GeographicalRange;
R=ProblemParams.NODE.TrRange;
Node.Number=ProblemParams.NODE.Number;
R=ProblemParams.NODE.TrRange;
distance=ProblemParams.Distance;
Point=ProblemParams.Point;

netXloc=Point(1,:);
netYloc=Point(2,:);
Point=[netXloc;netYloc];
netXloc=Point(1,:);
netYloc=Point(2,:);

Node.Number=ProblemParams.NODE.Number;
Node.ClusterAhead=zeros(1,Node.Number);
BEST_Solution=BEST_ANT.Sequence;
Node.Cluster_ID=BEST_Solution;
Node.Cluster_Number=numel(BEST_Solution); 
Node.Neighbors=Neighbor;
Node.ClusterAhead=zeros(1,Node.Number);
Node.ClusterAhead(Node.Cluster_ID )=Node.Cluster_ID; 
for k=1:Node.Number
    if Node.ClusterAhead(k )==0

     [VALUE,INDEX]=Intersect(Node.Neighbors{k},Node.Cluster_ID ) 
     
     if numel(VALUE)==1 
        Node.ClusterAhead(k)=VALUE;
     elseif  numel(VALUE)>=2  
         [vv,ii]=min(distance(k,VALUE));
         Node.ClusterAhead(k)=VALUE(ii);
     end      
    end   
    
end        

for ii=1:Node.Cluster_Number
VALUE=0;
INDEX=0;

[VALUE,INDEX]=find(Node.ClusterAhead==Node.Cluster_ID(ii) ) 
Node.Cluster_Member{ii}=INDEX;
     
end

Node.Cluser_Gatway=cell(1,Node.Cluster_Number);
 Node.Cluster_Neighbor=cell(1,Node.Cluster_Number); 
for j=1:Node.Cluster_Number
   
      vv=[];ii=[];
      Other_cluster=setdiff(  Node.Cluster_ID, Node.Cluster_ID(j) );
      [vv,ii]= sort(distance(Node.Cluster_ID(j),Other_cluster),'ascend');
      k1=find(Node.Cluster_ID==Other_cluster(ii(1)));
      
      k2=find(Node.Cluster_ID==Other_cluster(ii(2)));
      
      vv=[];ii=[];
      [vv,ii]= min(distance(Node.Cluster_Member{j},Node.Cluster_ID(k1)));
      Node.Cluser_Gatway{j}(end+1)=Node.Cluster_Member{j}(ii);
       Node.Cluster_Neighbor{j}(end+1)=k1
      Node.Cluster_Member{k1}(end+1)=Node.Cluster_Member{j}(ii);
      Node.Cluser_Gatway{k1}(end+1)=Node.Cluster_Member{j}(ii);
      Node.Cluster_Neighbor{k1}(end+1)=j
      
      
      
      vv=[];ii=[];
      [vv,ii]= min(distance(Node.Cluster_Member{j},Node.Cluster_ID(k2)));
      Node.Cluser_Gatway{j}(end+1)=Node.Cluster_Member{j}(ii);
      Node.Cluster_Neighbor{j}(end+1)=k2
      Node.Cluster_Member{k2}(end+1)=Node.Cluster_Member{j}(ii);
      Node.Cluser_Gatway{k2}(end+1)=Node.Cluster_Member{j}(ii);
      Node.Cluster_Neighbor{k2}(end+1)=j
      
end


for ii=1:Node.Cluster_Number
  for jj=1:Node.Cluster_Number
   
      if ii~=jj
     [VALUE,INDEX]=Intersect(Node.Cluster_Member{ii},Node.Cluster_Member{jj} );
     if numel(VALUE)~=0
        
         Node.Cluster_Neighbor{ii}(end+1)=jj;
         Node.Cluster_Neighbor{jj}(end+1)=ii;
     end    
      end
  end
end

for ii=1:Node.Cluster_Number
    
 Node.Cluster_Neighbor{ii}=unique( Node.Cluster_Neighbor{ii});
 Node.Cluster_NO_Neighbor(ii)=numel(unique( Node.Cluster_Neighbor{ii}));
end


%%calculate the disatnce
%%in this algorithm instead of finding the point in the middel. we focous
%%on finding a point that has largest number of neighbor. if two cluster
%%has same gatway, the cluster that has more member 
X_M=500;Y_M=500;
 [VV,II]=sort(Node.Cluster_NO_Neighbor);
 if VV(end)==VV(end-1)
      if numel(Node.Cluster_Member{II(end)})>= numel(Node.Cluster_Member{II(end-1)})
      i_M=II(end);
      else 
          i_M=II(end-1);
      end
 else
     i_M=II(end);
 end    
v=Node.Cluster_NO_Neighbor(i_M)

  
   
  [j,jj]=setdiff(Node.Cluster_ID,Node.Cluster_Neighbor{i_M});
  [j1,jj1]=setdiff(j,Node.Cluster_ID(i_M));
 [vv,ind]=sort(distance(Node.Cluster_ID(i_M),j1),'ascend');
   [j2,jj2]=setdiff(Node.Cluster_Member{i_M},Node.Cluster_ID(i_M));

  [v1,i1]= min(distance(j2,j1(ind(1))))
   Node.Cluser_Gatway{i_M}(end+1)=j2(i1);
 [h,hh] = find(Node.Cluster_ID== j1(ind(1)))
   
   
   Node.Cluster_Member{hh}(end+1)=j2(i1);
   Node.Cluser_Gatway{hh}(end+1)=j2(i1)
   Node.Cluster_Neighbor{i_M}(end+1)=hh;
   Node.Cluster_Neighbor{hh}(end+1)=i_M;
  
   
for ii=1:Node.Cluster_Number
 Node.Cluser_Gatway{ii}= unique(  Node.Cluser_Gatway{ii});  

 end
% %  
%  
%     

figure(4);
grid on 

% for i = 1:noOfNodes
%     
%  plot(netXloc(i), netYloc(i), 'O','MarkerSize', 18);
%  hold on 
% text(netXloc(i), netYloc(i), num2str(i),'FontSize',25);
% for j = 1:noOfNodes
%   
%     distance(i,j) = sqrt((netXloc(i) - netXloc(j))^2 + (netYloc(i) - netYloc(j))^2);
% if distance(i,j) <= R
% 
%  matrix(i, j) = 1; % there is a link;
% 
%    
% % if i==j
% %     matrix(i,j)=0;
% % else
% % matrix(i, j) = 1; % there is a link;
% % end
% % 
% hold on 
% grid on 
%   line([netXloc(i) netXloc(j)], [netYloc(i) netYloc(j)],'color', 'k','LineStyle', '--');
% else
%         matrix(i, j) = inf;
% end;
% end
% end


    
    INC_Color=1/Node.Cluster_Number;
    LOOP=Node.Cluster_Number+1
    Zarib=(0.5/LOOP);
    
    
    for ii=1:3:LOOP
        m(ii)=INC_Color+Zarib*ii 
        m(ii+1)=INC_Color+Zarib*(ii+1)
        m(ii+2)=INC_Color+Zarib*(ii+2)
        
    end    
    
       
 for i = 1:Node.Cluster_Number
    


     n1=15+i
     n2=rem(15+i,4)+1
     n3=16+i
     n4=rem(20+i,5)+1
     n=rem(Node.Cluster_Number,3)+1
     color=[0 0 0] 
     color(n)=m(i);
     nn=rem(n,3)+1;
     color(nn)=1;
    
       
   hold on 
    plot(netXloc(Node.Cluster_ID(i)), netYloc(Node.Cluster_ID(i)), 'O','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor',color,'MarkerSize',n1 );

    hold on

   
   Gatway=Node.Cluser_Gatway{i}
   for cc=1:numel(Gatway)
      hold on     
   plot(netXloc( Gatway(cc)), netYloc( Gatway(cc)), 's','LineWidth',1,'MarkerEdgeColor','k','MarkerFaceColor',color,'MarkerSize',n1-8 );
          
   end


  
    member=[];
    member=Node.Cluster_Member{i};
    for ii=1:numel(member)

      
            if Node.Cluster_Member{i}(ii)~=  Node.Cluster_ID(i); 
        color=[0 0 0];
        color(n)=1-m(i);
        color(nn)=0;
    hold on 
    
%   
   



    line([netXloc(Node.Cluster_ID(i)) netXloc(Node.Cluster_Member{i}(ii))], [netYloc(Node.Cluster_ID(i)) netYloc(Node.Cluster_Member{i}(ii))],'LineWidth',n2,'Color',color, 'LineStyle', ':');
%    line([netXloc(Node.Cluster_Member{i,1}(ii)) netXloc(member(Connect_I))], [ netYloc(Node.Cluster_Member{i,1}(ii)) netYloc(member(Connect_I))],'LineWidth',n4,'Color',color, 'LineStyle', ':');
    
        

    
%      plot(netXloc(Node.Cluster_Member{i,1}(ii)), netYloc(Node.Cluster_Member{i,1}(ii)), 'O','MarkerFaceColor',color,'MarkerSize', n3);
      

       

 
 end
 
    end
 
 end
 Node.Dist_Cluster_Ahead =[];
 for j=1:numel(Node.Cluster_ID)
 
    Node.Dist_Cluster_Ahead(j,:)=ProblemParams.Distance(Node.Cluster_ID(j),Node.Cluster_ID);
 end    

 for j=1:Node.Cluster_Number
      
     [VV,II]=find(Node.Dist_Cluster_Ahead(j,:)<= ProblemParams.NODE.InrRange);
     
     Node.Cluster_INT{j,1}=setdiff(II,j);
end
% 
% 
% 
ClusterParams.Number_of_Cluster=Node.Cluster_Number;                       
ClusterParams.Member_of_Cluster=Node.Cluster_Member; 
ClusterParams.Index_of_Cluster=Node.Cluster_ID;
ClusterParams.Cluster_Ahead_of_Node=Node.ClusterAhead;
ClusterParams.Distance_Cluster_Ahead=Node.Dist_Cluster_Ahead;                       
ClusterParams.Cluster_Interfrence=Node.Cluster_INT; 
ClusterParams.Cluster_Gatway=Node.Cluser_Gatway;
ClusterParams.Cluster_Neighbor= Node.Cluster_Neighbor; 

 
 

