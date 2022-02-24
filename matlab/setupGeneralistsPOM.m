%
% Sets up a spectrum of generalists.
%
% In:
%  n - number of size classes
%  bParallel - Whether to prepare parallel execution (for global runs)
%
function p = setupGeneralistsPOM(n, nPOM, bParallel)

arguments
    n int32 {mustBeInteger, mustBePositive} = 10;
    nPOM int32 {mustBeInteger, mustBePositive} = 10;
    bParallel logical = false;
end

loadNUMmodelLibrary(bParallel);

calllib(loadNUMmodelLibrary(), 'f_setupgeneralistspom', int32(n), int32(nPOM) );
if bParallel
    h = gcp('nocreate');
    poolsize = h.NumWorkers;
    parfor i=1:poolsize
        calllib(loadNUMmodelLibrary(), 'f_setupgeneralistspom',int32(n), int32(nPOM));
    end
end

% Nutrients:
p = setupNutrients_N_DOC;

% Generalists:
p = parametersAddgroup(1,p,n);

% POM:
p = parametersAddgroup(100, p, nPOM);

p = getMass(p);

p.u0(1:2) = [150, 0]; % Initial conditions (and deep layer concentrations)
p.u0(p.idxB:p.n) = 1;