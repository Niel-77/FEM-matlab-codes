clc
clear
format shortEng
nel=input("Enter the number of springs: ");
nnd=nel+1;
for i = 1:nel
    prompt = sprintf('Enter the stiffness of spring %d in N/m: ', i);
    k(i) = input(prompt);
end
gstiff= zeros(nnd,nnd);
gload=zeros(nnd,1);
forcenodes= input("Enter the number of nonzero external force nodes: ");
for j = 1:forcenodes
    node = input("Enter the value of node where external load is present: "  );
    gload(node) = input("Enter the value of external load in N: ");
end

% nel= elements
% 
% nnd= number of nodes

for i=1:nel
    conn(i,1)=i;
    conn(i,2)=i+1;
end

% connectivity matrix=conn
% 
% global stiffnes matrix and global load set to zero
% 
% gdisp=displacement


gdisp= zeros(nnd,1);
for n=1:nel
    i=conn(n,1);j=conn(n,2);
    kel=[k(n) -k(n); -k(n) k(n)];
    gstiff([i,j],[i,j])=gstiff([i,j],[i,j])+kel;
end
% gload(3)=P
%% 
% Extracting the unknown parts from the matrix

gstiff1=gstiff([2:nnd],[2:nnd]);
gload1=gload([2:nnd]);
disp1=gstiff1\gload1;
gdisp([2:nnd])=disp1;
Force=gstiff*gdisp;

% Display

for n=1:nnd
    fprintf('Displacement at node %d = %d m\n',n, gdisp(n))
end
fprintf("In array form the displacement in metre in each nodes is given as: \n");
disp(gdisp);

fprintf("The reaction force at fixed end is %.4f N.\n",Force(1))

% Force on each element

for n=1:nel
    i=conn(n,1);j=conn(n,2);
    fs(n)=k(n)*(gdisp(j)-gdisp(i));
    fprintf('Force in spring %d = %.4f N\n',n, fs(n));
end
fprintf("In array form the force in Newtons(N) in each spring is given as: \n");
disp(fs);

