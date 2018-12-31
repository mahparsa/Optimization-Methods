 function  TEMP = Remove_Clustes_V4(TheEmpire);
 
% global ClusterParams;
 global ProblemParams;
% global AlgorithmParams;

   %UNTITLED Summary of this function goes here
%   Detailed explanation goes here
Neighbor=ProblemParams.NODE.Neighbors;
N=ProblemParams.NODE.Number;
TEMP=[];
TEMP=TheEmpire.Imperialist.Sequence;%%because the weakest have lower positionin array.
TEMP1=[];
TEMP2=[];


PATH=TEMP;
DIGREE=  INT_of_NODE_in_Sequence(PATH);
node=[];
Index_node=[];
[node,Index_node]=max(DIGREE);
TEMP(Index_node)=[];



% Path=TEMP;
% Matrix_CONN=zeros(numel(Path),numel(Path));
% for bb=1:numel(Path)
%     for jj=1:numel(Path)
%         if bb~=jj
%         Similar_Neighbor=intersect(Neighbor{Path(bb)},Neighbor{Path(jj)});
%         [VAL,IND]=find(  Similar_Neighbor==Path(bb))
%         Similar_Neighbor(IND)=[];
%         [VAL,IND]=find(  Similar_Neighbor==Path(jj))
%         if numel(IND)~=0
%         Similar_Neighbor(IND)=[];
%         end
%         if numel(Similar_Neighbor)~=0;
%                       
%                Matrix_CONN(bb,jj)=1;
%         end
% 
%         end
%     end
%     MAX_CONN_OtherClsuters(bb)=sum(Matrix_CONN(bb,:));    
% end
% node=[];
% Index_node=[];
% [node,Index_node]=min(  MAX_CONN_OtherClsuters);
% TEMP(Index_node)=[];



 




     