function [f,xc,yc,zc]  = remove (x,y,z,fit,M,V,pop)

sorted_fit=[];
[len, m] = size(fit);
[temp,index] = sort(fit(:,M+V+1));
clear temp m
for i = 1 : length(index)
    sorted_fit(i,:) = fit(index(i),:);
end
max_rank = max(fit(:,M + V + 1));
% Start adding each front based on rank and crowing distance until the
% whole population is filled.
previous_index = 0;
for i = 1 : max_rank
    % Get the index for current rank i.e the last the last element in the
    % sorted_chromosome with rank i. 
    current_index = max(find(sorted_fit(:,M + V + 1) == i));
    % Check to see if the population is filled if all the individuals with
    % rank i is added to the population. 
    if current_index > pop
        % If so then find the number of individuals with in with current
        % rank i.
        remaining = pop - previous_index;
        % Get information about the individuals in the current rank i.
        temp_pop = ...
            sorted_fit(previous_index + 1 : current_index, :);
        % Sort the individuals with rank i in the descending order based on
        % the crowding distance.
        [temp_sort,temp_sort_index] = ...
            sort(temp_pop(:, M + V + 2),'descend');
        % Start filling individuals into the population in descending order
        % until the population is filled.
        for j = 1 : remaining
            f(previous_index + j,:) = temp_pop(temp_sort_index(j),:);
        end
        break;
    elseif current_index < pop
        % Add all the individuals with rank i into the population.
        f(previous_index + 1 : current_index, :) = ...
            sorted_fit(previous_index + 1 : current_index, :);
    else
        % Add all the individuals with rank i into the population.
        f(previous_index + 1 : current_index, :) = ...
            sorted_fit(previous_index + 1 : current_index, :);
        break;
    end
    % Get the index for the last added individual.
    previous_index = current_index;
end
xc=[];
yc=[];
zc=[];
[r,c]=size(f);
for i=1:r
    xc{i}=x{f(i,M+V)};
    yc{i}=y{f(i,M+V)};
    zc{i}=z{f(i,M+V)};
end
