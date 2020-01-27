function main(pop,gen)
clc
clear all
g1 = sprintf('\nInput genration :' );
g2 = sprintf('\nInput population size :' );
pop=input(g2);
gen=input(g1);
if isnumeric(pop) == 0 || isnumeric(gen) == 0
    error('Both input arguments pop and gen should be integer datatype');
end
if pop < 20
    error('Minimum population for running this function is 20');
end
if gen < 5
    error('Minimum number of generations is 5');
end
pop = max(20,pop);
gen = max(5,gen);

% This functions is based on evolutionary algorithm for finding the optimal
% solution for multiple objective i.e. pareto front for the objectives. 
% Initially enter only the population size and the stoping criteria or
% the total number of generations after which the algorithm will
% automatically stopped.

M=3;                                                 
V=0;
% Generate initial population from function 'sf1' and store in the following 
% varialbles.
[t_x,t_y,t_z,w,d,n,p,D]= sf1(pop,gen);

% Compute fitness value for the initial population and store in matrix
% 'fit' in function 'objective'.
[fit] = objective(t_x,t_y,t_z,w,d,n,p,D);

% Here, decision variables and fitness values are passed to 'nds' function
% for Non-Dominated Sorting. Two more columns are appended here, one for
% rank and the other for crowding distance.
[c_fit3,x,y,z]=nds(fit,M,V,t_x,t_y,t_z);

%% Start the evolution process
% The following are performed in each generation
% * Select the parents which are fit for reproduction
% * Perfrom crossover and Mutation operator on the selected parents
% * Perform Selection from the parents and the offsprings
% * Replace the unfit individuals with the fit individuals to maintain a
%   constant population size.

for i=1:gen
    % Select the parents
    % Parents are selected for reproduction to generate offspring. The
    % original NSGA-II uses a tournament selection based on the
    % crowded-comparision operator.
    clear c_x c_y c_z c_fit c_fit2 c_x1 c_y1 c_z1
    
    % In a tournament selection process two individuals are selected
    % at random and their fitness is compared. The individual with better
    % fitness is selcted as a parent. Tournament selection is carried out
    % until the pool size is filled. Here, pool_select function is used to 
    % to get the mating pool using tournament selection process.
    [p_x,p_y,p_z] = pool_select(x,y,z,c_fit3,pop);
    
    % 'genetic' function is used to perform genetic operations - crossover
    % and mutation. Crossover occurs between any two rows of the variable
    % in the polulation.
    [c_x,c_y,c_z]=genetic(p_x,p_y,p_z,d,D);
    [c_fit]=objective(c_x,c_y,c_z,w,d,n,p,D);
    [c_fit2,c_x1,c_y1,c_z1]=nds(c_fit,M,V,c_x,c_y,c_z);
    clear c_fit3 x y z
    [c_fit3,x,y,z]  = remove (c_x1,c_y1,c_z1,c_fit2,M,V,pop);
    plot(c_fit3(:,V+1),c_fit3(:,V+2),'*');
    drawnow
    if ~mod(i,100)
        clc
        fprintf('%d generations completed\n',i);
    end
    i
    
end
%save solution_sc.txt y -ASCII
%plot(c_fit1(:,V + 1),c_fit1(:,V + 2),'*');