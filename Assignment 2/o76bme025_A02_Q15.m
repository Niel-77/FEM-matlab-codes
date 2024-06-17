clc
clear
format shortEng
%% 

% Input
H1=input("Enter the depth at the left end (H1) (m): ");
H2=input("Enter the depth at the right end (H2) (m): ");
t=input("Enter the thickness of the bar(t) (m): ");
L=input("Enter the length of the bar (L) (m): ");
P=input("Enter the magnitude of load (P) (N): ");
E=input("Enter the modulus of elasticity of the bar material (N/m^2): ");
nel=input("Enter the number of elements: ");
 
% Exact Value:
ev= P*L*log(H1/H2)/((H1-H2)*E*t);

for n=1:nel
    for m=1:1+n
        x(m)=(m-1)*L/n; %creating n positions in the bar
        Hx(m)=H1-x(m)/L*(H1-H2); %finding depth at given x
        Ax(m)=Hx(m)*t; %finding area at the given x
    end
    %setting number nodes for 1 to number of elements
    %required
    nnd=n+1; 
    %k=zeros(noe);
    %Am=zeros(noe);
    %l=onces(noe)*L/noe;

    for x=1:n
        Am(x)=(Ax(x)+Ax(x+1))/2;
        k(x)=Am(x)*E*n/L;
    end
    %conn=zeros(noe,2);
    for i=1:n
        conn(i,1)=i;
        conn(i,2)=i+1;
    end
    %creating the required stiffnes, force and global displacemtn matrix
    gstiff=zeros(nnd,nnd);
    gload=zeros(nnd,1);
    gdisp=zeros(nnd,1);
    %finding the global stiffness matrix
    for m=1:n
        i=conn(m,1);j=conn(m,2);
        kel=[k(m) -k(m);-k(m) k(m)];
        gstiff([i,j],[i,j])=gstiff([i,j],[i,j])+kel;
    end
    %Applying boundary conditions
    gload(nnd)=P;
    gdisp(1)=0;
    %Extracting the required stiffness matrix for finding the required
    %values
    gstiff1=gstiff([2:nnd],[2:nnd]);
    gload1=gload([2:nnd]);
    disp1=gstiff1\gload1;
    gdisp([2:nnd])=disp1;
    Force=gstiff*gdisp;
    
    %total displacement at free end
    td(n)=gdisp(nnd);   
    %pe(n)=((td(n)-ev)/ev)*100;
end
fprintf("The displacement at the free end of the bar considering %d elements is %d. \n",nel,td(n));
fprintf("The reaction force at fixed end at node 1 is %d N.\n",Force(1));

% Output Plot:

plot(1:nel,td)
