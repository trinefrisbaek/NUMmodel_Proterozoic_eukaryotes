function rates = calcDerivativesGeneralists(ixStart, ixEnd, u, rates, p)
ix = ixStart:ixEnd;

B = u(ix);
m = p.pGeneralists.m;
mort2 = p.pGeneralists.mort2*B;

mortloss = sum(B.*(p.pGeneralists.remin2.*mort2 + p.mortHTLm(ix)));

dNdt   =  (sum((...
    -rates.JN(ix)...
    +rates.JNloss(ix)).*B./m)  ...
    + mortloss)/p.pGeneralists.rhoCN;

rates.mort(ix) = p.pGeneralists.mort + ...
    rates.mortpred(ix) +  ...
    mort2 +  ...
    p.mortHTLm(ix);
dBdt = (rates.Jtot(ix)./m - rates.mort(ix)).*B;
%dBdt[(B<1e-3) & (dBdt<0)] = 0 % Impose a minimum concentration even if it means loss of mass balance

dDOCdt =  - sum(rates.JDOC(ix).*B./m) + ...
    sum(rates.JCloss(ix).*B./m) + ...
    mortloss;

rates.dudt(1) = dNdt;
rates.dudt(2) = dDOCdt;
rates.dudt(ix) = dBdt;