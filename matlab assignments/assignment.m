%input 
p=10e3;
E=200e9;
L=0.5;
d1=.1;
d2=.05;
nel=input('Total Number of Elements\n');
for V=1:nel    % this loop for generating free end disp for every element
    nell=V;
    uexact(V)=(4*p*L)/(pi*d1*d2*E);
gload1=zeros(nell,1); % load matrix
nod=nell+1;
gstiff=zeros(nod);
conn=[1:nod;2:nod+1]';
  l=L/nell; 
  x=l/2;            
    
    for I=1:nell
    i= conn(I,1);j=conn(I,2);    
    dx=d2+(d1-d2)*(1-x/L);    
    kel=(pi*dx^2*E/(4*l));
    kell=[kel -kel;-kel kel];
    gstiff([i, j],[i,j])=gstiff([i,j],[i,j]) + kell;
    x=x+l;
    end
    gstiff;   %yes global stiffness matrix succesfully created 
    
    gload1(nell,1)=gload1(nell,1)+p;
    gstiff1=gstiff([2:nod],[2:nod]);
    u= gstiff1\gload1;
    u(nell);
    ufinal(V)=u(nell);
    
end

Free_end_Displacement=ufinal'
 uexact';
 x=1:20;
 plot(x,Free_end_Displacement,x,uexact)
