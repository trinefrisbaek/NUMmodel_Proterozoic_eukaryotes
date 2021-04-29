function p = setupDiatomsOnly(n)

arguments
   n {mustBeInteger, mustBePositive} = 10;  % Number of grid points
end

loadNUMmodelLibrary();
calllib(loadNUMmodelLibrary(), 'f_setupdiatomsonly', int32(n) );

p.idxN = 1;
p.idxDOC = 2;
p.idxSi = 3;
p.idxB = 4; % We have three nutrient groups so biomass groups starts at index 4.

p.n = 3;
% Diatoms:
p = parametersAddgroup(1,p,n);

p = getMass(p); % Get masses

p.u0(1:3) = [150, 0, 150]; % Initial conditions (and deep layer concentrations)
p.u0(p.ixStart:p.ixEnd) = 1;