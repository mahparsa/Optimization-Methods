clc;
clear;
close all

prompt = {'Enter number of nodes:','Enter the geographical length of network :', 'Enter the communication range  :' , 'Enter the interfence range   :','Enter the max available channel   :' ,'Enter the min available channel   :'};
dlg_title = 'Input for ad hoc network ';
num_lines = 1;
def = {'100','1000','250','500'};
answer = inputdlg(prompt,dlg_title,num_lines);



ProblemParams.NODE.Number =str2num(answer{1,1});
rand('state', 0);
figure(1);
clf;
hold on;
ProblemParams.NODE.GeographicalRange = str2num(answer{2,1});
ProblemParams.NODE.TrRange= str2num(answer{3,1}); % maximum range;
ProblemParams.NODE.InrRange=str2num(answer{4,1});
ProblemParams.MaxNumber_of_Channel=str2num(answer{5,1});
ProblemParams.MinNumber_of_Channel=str2num(answer{6,1})
ProblemParams.Distance=[];
Distance=[];
ProblemParams.Path_Loss_Exponents=2;
ProblemParams.InrRange =ProblemParams.NODE.InrRange;
% ==========================================================================
% Create_Network
% [ProblemParams.Distance,ProblemParams.Adjacecy,ProblemParams.Point]=Creat_Ad_Hoc_Network(ProblemParams);

for ii=1:100
 Distance=[];

noOfNodes=ProblemParams.NODE.Number;
L=ProblemParams.NODE.GeographicalRange;
R=ProblemParams.NODE.TrRange;
netXloc = rand(1,noOfNodes)*L;
netYloc = rand(1,noOfNodes)*L;
figure(1);

for i = 1:noOfNodes
    
 plot(netXloc(i), netYloc(i), 'O','MarkerSize', 18);
 hold on 
text(netXloc(i), netYloc(i), num2str(i),'FontSize',15);
for j = 1:noOfNodes
  
    distance(i,j) = sqrt((netXloc(i) - netXloc(j))^2 + (netYloc(i) - netYloc(j))^2);
if distance(i,j) <= R

 matrix(i, j) = 1; % there is a link;

   
% if i==j
%     matrix(i,j)=0;
% else
% matrix(i, j) = 1; % there is a link;
% end
% 
hold on 
 line([netXloc(i) netXloc(j)], [netYloc(i) netYloc(j)], 'LineStyle', ':');
else
        matrix(i, j) = inf;
end;

end;
grid on 
end;




ProblemParams.Distance=distance;
ProblemParams.Point=[netXloc;netYloc];
ProblemParams.Adjacecy=matrix;
ProblemParams.MaxNumber_of_Channel=randi([2*str2num(answer{6,1}),str2num(answer{5,1})],1,1);

     
SAMPLE(ii).ProblemParams=ProblemParams;

end
