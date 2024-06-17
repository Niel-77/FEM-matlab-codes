clc
clear
format shortEng
%% 
% nel= elements
% 
% nnd= number of nodes
nel=3;
nnd=4;
for i = 1:nel
    prompt1 = sprintf('Enter the length of element %d: ', i);
    L(i) = input(prompt1);
    prompt2 = sprintf('Enter the diameter of element %d: ', i);
    D(i) =input(prompt2);
    prompt3 = sprintf('Enter the elastic modulus of bar element %d: ', i);
    E(i) =input(prompt3);
end
A=pi()*(D).^2/4;
k=A.*E./L;
gstiff= zeros(nnd,nnd);
gload=zeros(nnd,1);
P=input("Enter the value of P in N: ");
Q=input("Enter the value of Q in N (Don't include negative sign as it is included already): ");
gload(2)=-Q;
gload(3)=P;


%% 
% connectivity matrix=conn
% 
conn=[1 2;2 3;3 4]

% gdisp=displacement
gdisp= zeros(nnd,1);
for n=1:nel
    i=conn(n,1);j=conn(n,2)
    kel=[k(n) -k(n); -k(n) k(n)];
    gstiff([i,j],[i,j])=gstiff([i,j],[i,j])+kel;
end
%% 
% Extracting the unknown parts from the matrix
gstiff1=gstiff([2:3],[2:3]);
gload1=gload([2:3]);
disp1=gstiff1\gload1;
gdisp([2:3])=disp1;
Force=gstiff*gdisp;
%% 
% Display

for n=1:nnd
    fprintf('Displacement at node %d = %d m\n',n, gdisp(n));
end
fprintf("In array form the displacement in metre in each nodes is given as: \n");
disp(gdisp);

fprintf("The reaction force at fixed end at node 1 is %.4f N.\n",Force(1));
fprintf("The reaction force at fixed end at node 4 is %.4f N.\n",Force(4));

% Force on each bar

for n=1:nel
    i=conn(n,1);j=conn(n,2);
    fs(n)=k(n)*(gdisp(j)-gdisp(i));
    fprintf('Force in bar %d = %.4f N\n',n, fs(n));
    stress(n)=fs(n)/A(n);
    fprintf('Stress in bar %d = %.4f Pa\n',n, stress(n)); 
end
fprintf("In array form the force in Newtons(N) in each bar is given as: \n");
disp(fs);
fprintf("In array form the stress in Pascals (Pa) in each bar is given as: \n");
disp(stress);
