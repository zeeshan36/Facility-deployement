function [x,y,z,w,d,n,p,D]= sf1(pop,gen)

% g = sprintf('\nInput the number of wards available :' );
% n = input(g);
% g = sprintf('\nInput the number of police facilities available :' );
% p= input(g);
% g = sprintf('\nInput prefined distance from facility :' );
% D= input(g);
% w=zeros(1,n);
n=10;
p=7;
D=3;
for i=1:n
    w(i)=rand*(5-105);
end
d=[0 2 2 3 3 6 5 5 6 6;
    2 0 4 6 5 6 7 3 3 5;
    2 4 0 4 5 6 4 3 7 4;
    3 6 4 0 4 6 3 6 7 7;
    3 5 5 4 0 3 6 6 4 8;
    6 6 6 6 3 0 6 7 5 8;
    5 7 4 3 6 6 0 5 7 4;
    5 3 3 6 6 7 5 0 6 3
    6 3 7 7 4 5 7 6 0 8;
    6 5 4 7 8 8 4 3 8 0];
    
for i=1:n
    for j=1:n
        d(j,i)=d(i,j);
    end
    d(i,i)=0;
end

x={};
y={};
z={};

for i=1:pop
    tempy = randi([1 n],1,p);
    y{i}=zeros(1,n);
    for j=1:p
        y{i}(1,tempy(1,j))=1;
    end
    x{i}=zeros(n,n);
    for j=1:n
        ind=randi([1,n],1,1);
        x{i}(j,ind)=1;
    end
    z{i}=zeros(1,n);
    for j=1:n
        if sum(x{i}(j,:))~=0
            z{i}(1,j)=1;
        end
    end
end