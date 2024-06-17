clc
clear
format shortEng
% nel= elements
% nnd= number of nodes
nel=10;
nnd=8;
for i = 1:nel
    prompt = sprintf('Enter the stiffness of spring %d: ', i);
    k(i) =input(prompt);
end
gstiff= zeros(nnd,nnd);
gload=zeros(nnd,1);
gload(3)=input("Enter the value of P in N: ");
gload(5)=input("Enter the value of Q in N: ");

%% 

% connectivity matrix=conn
conn=[1 2;2 3;2 4;3 4;3 6;4 5;5 6;5 7;6 7;7 8];

%% 

% global stiffnes matrix and global load set to zero
% 
% disp=displacement


gdisp= zeros(nnd,1);
for n=1:nel
    i=conn(n,1);j=conn(n,2);
    kel=[k(n) -k(n); -k(n) k(n)];
    gstiff([i,j],[i,j])=gstiff([i,j],[i,j])+kel;
end

%%
% Extracting the unknown parts from the matrix

gstiff1=gstiff([2:7],[2:7]);
gload1=gload([2:7]);
disp1=gstiff1\gload1;
gdisp([2:7])=disp1;
Force=gstiff*gdisp;
%% 
% Display

for n=1:nnd
    fprintf('Displacement at node %d = %d m\n',n, gdisp(n))
end
fprintf("In array form the displacement in metre in each nodes is given as: \n");
disp(gdisp);

fprintf("The reaction force at fixed end at node 1 is %.4f N.\n",Force(1));
fprintf("The reaction force at fixed end at node 8 is %.4f N.\n",Force(8));

% Force on each element

for n=1:nel
    i=conn(n,1);j=conn(n,2);
    fs(n)=k(n)*(gdisp(j)-gdisp(i));
    fprintf('Force in spring %d = %.4f N\n',n, fs(n));
end
fprintf("In array form the force in Newtons(N) in each spring is given as: \n");
disp(fs);

