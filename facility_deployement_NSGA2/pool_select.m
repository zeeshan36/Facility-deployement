function [fx,fy,fz] = pool_select(x,y,z,fit,pop)

% pool - size of the mating pool. It is common to have this to be half the
%        population size.
% tour - Tournament size. Original NSGA-II uses a binary tournament
%        selection, but to see the effect of tournament size this is kept
%        arbitary, to be choosen by the user.
pool = round(pop/2);
tour = 2;
for i=1:pool
    for j=1:tour
        candidate(j)=round(pop*rand(1));
        if candidate(j) == 0
            candidate(j) = 1;
        end
        if j > 1
            % Make sure that same candidate is not choosen.
            while ~isempty(find(candidate(1 : j - 1) == candidate(j)))
                candidate(j) = round(pop*rand(1));
                if candidate(j) == 0
                    candidate(j) = 1;
                end
            end
        end
    end
    for j = 1 : tour
        c_obj_rank(j) = fit(candidate(j),3);
        c_obj_distance(j) = fit(candidate(j),4);
    end
    % Find the candidate with the least rank
    min_candidate = ...
        find(c_obj_rank == min(c_obj_rank));
    % If more than one candiate have the least rank then find the candidate
    % within that group having the maximum crowding distance.
    if length(min_candidate) ~= 1
        max_candidate = ...
        find(c_obj_distance(min_candidate) == max(c_obj_distance(min_candidate)));
        % If a few individuals have the least rank and have maximum crowding
        % distance, select only one individual (not at random). 
        if length(max_candidate) ~= 1
            max_candidate = max_candidate(1);
        end
        % Add the selected individual to the mating pool
        fx{i} = x{candidate(min_candidate(max_candidate))};
        fy{i} = y{candidate(min_candidate(max_candidate))};
        fz{i} = z{candidate(min_candidate(max_candidate))};
    else
        % Add the selected individual to the mating pool
        fx{i} = x{candidate(min_candidate(1))};
        fy{i} = y{candidate(min_candidate(1))};
        fz{i} = z{candidate(min_candidate(1))};
    end
end