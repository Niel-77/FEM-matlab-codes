clc
clear
nel=input("Enter the number of springs: ");
nnd=nel+1;
for i = 1:nel
    prompt = sprintf('Enter the stiffness of spring in N/m %d: ', i)
    k(i) = input(prompt)
end
gstiff= zeros(nnd,nnd)
gload=zeros(nnd,1)
forcenodes= input("Enter the number of nonzero external force nodes")
for j = 1:forcenodes
    node = input("Enter the value of node where external load is present: "  )
    gload(node) = input("Enter the value of external load in N: ")
end

%% 
% nel= elements
% 
% nnd= number of nodes

for i=1:nel
    conn(i,1)=i
    conn(i,2)=i+1
end
%% 
% connectivity matrix=conn
% 
% global stiffnes matrix and global load set to zero
% 
% disp=displacement


disp= zeros(nnd,1)
for n=1:nel
    i=conn(n,1);j=conn(n,2)
    kel=[k(n) -k(n); -k(n) k(n)]
    gstiff([i,j],[i,j])=gstiff([i,j],[i,j])+kel
end
gstiff
% gload(3)=P
%% 
% Extracting the unknown parts from the matrix

gstiff1=gstiff([2:nnd],[2:nnd])
gload1=gload([2:nnd])
disp1=gstiff1\gload1
disp([2:nnd])=disp1
Force=gstiff*disp
%% 
% Display

Force
disp
fprintf("The reaction is %f",Force(1))
%% 
% Force on each element

k
for n=1:nel
    i=conn(n,1);j=conn(n,2);
    fs(n)=k(n)*(disp(j)-disp(i));
end
fs