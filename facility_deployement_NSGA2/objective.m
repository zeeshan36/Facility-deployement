function [fit]= objective(x,y,z,w,d,n,p,D)
po=length(x);
fit=[];
for q=1:po
    fit_1=0;
    fit_2=0;
    for i=1:n
        for j=1:n
            fit_1=fit_1+w(i)*(x{q}(i,j))*d(i,j);
        end
        fit_2=fit_2+w(i)*z{q}(i);
    end

    count1=0;
    count2=0;
    count3=0;
    count4=0;
    count5=0;
    % c1 
    for i=1:n
        if sum(x{q}(i,:))~=1
            count4=count4+1;
        end
    end
    % c2
    if sum(y{q}(1,:))~=p
        count3=count3+1;
    end
    % c3
    for i=1:n
        for j=1:n
            if x{q}(i,j)>y{q}(j)
                count1=count1+1;
            end
            if d(i,j)>D && x{q}(i,j)==1
                count5=count5+1;
            end
        end
    end
    % c4
    for i =1:n
        temp=0;
        for j=1:n
            if d(i,j)<=D
                temp=temp+y{q}(j);
            end
        end
        if temp<z{q}(i)
            count2=count2+1;
        end
    end
    fit_1;
    fit_2;
    fit(q,1)=((fit_1)/500)+count1+count3^2+count4^2+count5^3;
    fit(q,2)=(100/(1+fit_2)+(count2)^3+count3^3);
    fit(q,3)=q;
end