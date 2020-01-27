function [gx,gy,gz]=genetic(x,y,z,d,D)
p = 1;
c_x=x;
c_y=y;
c_z=z;
po=length(x);
% Flags used to set if crossover and mutation were actually performed. 
was_crossover = 0;
was_mutation = 0;
n=size(x{1});
n=int32(n(1,1));
for i=1:po
    
    if rand(1)<0.9
        child_1 = [];
        child_2 = [];
        parent_1=round(po*n*rand(1));
        if parent_1 < 1
            parent_1 = 1;
        end
        parent_2 = round(po*n*rand(1));
        if parent_2 < 1
            parent_2 = 1;
        end
        while isequal(parent_1,parent_2)
            parent_2 = round(po*n*rand(1));
            if parent_2 < 1
                parent_2 = 1;
            end
        end
        [Q,R] = quorem(sym(parent_1),sym(n));
        if R==0
            r1=Q;
            c1=n;
        else
            r1=Q+1;
            c1=R;
        end
        parent_1=x{r1}(c1,:);
        [Q,R] = quorem(sym(parent_2),sym(n));
        if R==0
            r2=Q;
            c2=n;
        else
            r2=Q+1;
            c2=R;
        end
        parent_2=x{r2}(c2,:);
        half=round(n/2);
        child_1=[parent_1(1,1:half) parent_2(1,half+1:n)];
        child_2=[parent_2(1,1:half) parent_1(1,half+1:n)];
        if length(child_1)~=n || length(child_2)~=n
            error('load in mutation of x');
        end
        c_x{r1}(c1,:)=child_1;
        c_x{r2}(c2,:)=child_2;
        x{end+1}=c_x{r1};
        x{end+1}=c_x{r2};
    end
end
for i=1:length(x)
    if size(x{i})~=[10,10]
        error('error in dim during mutation of x');
    end
end
for i=1:length(x)
    for j=1:n
        for k=1:n
            if rand(1)<0.2
                if x{i}(j,k)==0
                    x{i}(j,k)==1;
                else
                    x{i}(j,k)==1;
                end
            end
        end
    end
end
po=length(y);
for i=1:po
    if rand(1)<0.9
        childy_1 = [];
        childy_2 = [];
        parenty_1=round(po*rand(1));
        if parenty_1 < 1
            parenty_1 = 1;
        end
        parenty_2 = round(po*rand(1));
        if parenty_2 < 1
            parenty_2 = 1;
        end
        while isequal(parenty_1,parenty_2)
            parenty_2 = round(po*rand(1));
            if parenty_2 < 1
                parenty_2 = 1;
            end
        end
        childy_1=[y{parenty_1}(1,1:half) y{parenty_2}(1,half+1:n)];
        childy_2=[y{parenty_2}(1,1:half) y{parenty_1}(1,half+1:n)];
        if length(childy_1)~=n || length(childy_2)~=n
            error('load in mutation of y');
        end
        c_y{parenty_1}=childy_1;
        c_y{parenty_2}=childy_2;
        y{end+1}=c_y{parenty_1};
        y{end+1}=c_y{parenty_2};
    end
end

for i=1:length(y)
    for j=1:n
        if rand(1)<0.2
            if y{i}(1,j)==0
                y{i}(1,j)==1;
            else
                y{i}(1,j)==0;
            end
        end
    end
end
minx=length(x);
miny=length(y);
max_pop=min([minx,miny]);
gx={};
gy={};
gz={};
for i=1:max_pop
    gx(i)=x(i);
    gy(i)=y(i);
end
for i=1:max_pop
    gz{i}=zeros(1,n);
    for j=1:n
        temp=0;
        for k=1:n
            if d(j,k)<=D
                temp=temp+1;
            end
        end
        if temp~=0
            gz{1}(1,j)=1;
        end
    end
end