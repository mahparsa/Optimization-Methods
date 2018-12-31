 function  NO_CONN=COST_Connectivity(Path);

global ProblemParams;
global Country;
global AlgorithmParams;


Neighbor=ProblemParams.NODE.Neighbors;
Matrix_CONN=zeros(numel(Path),numel(Path));
for bb=1:numel(Path)
    for jj=1:numel(Path)
        if bb~=jj
        Similar_Neighbor=intersect(Neighbor{Path(bb)},Neighbor{Path(jj)});
        [VAL,IND]=find(  Similar_Neighbor==Path(bb));
        Similar_Neighbor(IND)=[];
        [VAL,IND]=find(  Similar_Neighbor==Path(jj));
        if numel(IND)~=0
        Similar_Neighbor(IND)=[];
        end
        if numel(Similar_Neighbor)~=0;
                      
               Matrix_CONN(bb,jj)=1;
        end

        end
    end
end
NO_CONN=sum(sum(triu(Matrix_CONN,1)));
%  NO_CONN=numel(Path)-NO_CONN;


 






