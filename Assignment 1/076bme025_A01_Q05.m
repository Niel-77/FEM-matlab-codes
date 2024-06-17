%Inputs
clc
clear
%% 
% 

format long
L=input("Enter the lenght in meter: ");
D1=input("Enter the diameter 1 in meter: ");
D2=input("Enter the diameter 2 in meter: ");
E=input("Enter the elastic modulus in N/m^2: ");
P=input("Enter the force applied in N: ");
%% 
% Exact Value Calculation:

ev= 4*P*L/(pi()*D1*D2*E);
%% 
% Input the number of elements for finding the deflection using FEM

e=input("Enter the number of elements: ");
%% 
% Loop for finding the value of x,D and A required for each element

for n=1:e
   for m=1:1+n
    x(m)=(m-1)*L/n;
    D(m)=D1-(D1-D2)*x(m)/L;
    A(m)=pi()*(D(m)^2)/4;
    end
%% 
% Area average
% 
% Taking initial deformation =0 and taking average of area at two ends for area 
% of the element, we have,

td(n)=0;
for m=1:n
     Aa(m)=(A(m)+A(m+1))/2;
    td(n)= td(n)+ P*(L/n)/(E*Aa(m));
end
error_percentage(n)=abs((td(n)-ev))*100/ev;
end
fprintf("The total deformation is %f. \n",td(n))
subplot(2,1,1)
plot(1:e,td)
xlabel("Number of elements (e)")
ylabel("Total deformation,td (m)")
title("Total deforamtion vs Number of elements")
subplot(2,1,2)
plot(1:e,error_percentage)
xlabel("Number of elements (e)")
ylabel("Percentage error (%)")
title("Percentage error vs Number of elements")
deformation=transpose(td);
error=transpose(error_percentage);
table=[deformation,error];
xlswrite('Assignment1_5.xls',table);