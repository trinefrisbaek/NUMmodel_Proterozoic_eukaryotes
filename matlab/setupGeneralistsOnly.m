function p = setupGeneralistsOnly(n)

arguments
    n {mustBeInteger, mustBePositive} = 10;
end

loadNUMmodelLibrary();
calllib(loadNUMmodelLibrary(), 'f_setupgeneralistsonly', int32(n) );

p.idxN = 1;
p.idxDOC = 2;
p.idxB = 3; % We have two nutrient groups so biomass groups starts at index 3.

p.n = n+p.idxB-1;
p.nGroups = 1;
p.typeGroups = 1;
p.ixStart = p.idxB;
p.ixEnd = p.n;

p = getMass(p);
%[p.m(p.idxB:p.n), p.mLower(p.idxB:p.n), p.mDelta(p.idxB:p.n)] = parametersCalcGrid(10^-8.5, 0.1, n);

p.u0(1:2) = [150, 0]; % Initial conditions (and deep layer concentrations)
p.u0(p.idxB:p.n) = 1;