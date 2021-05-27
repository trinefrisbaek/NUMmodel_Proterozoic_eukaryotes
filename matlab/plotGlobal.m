%
% Plot maps of global run
%
% In:
%  sim: the simulation to plot
%  iTime: (not needed) the time step to plot (defaults to the last).
%  sProjection: default 'fast'.
%
function plotGlobal(sim, iTime, sProjection)

arguments
    sim struct;
    iTime double = length(sim.t);
    sProjection string = 'fast';
end

%if (nargin()==1)
%    iTime = length(sim.t); % Choose the last timestep if none is given
%end
%if (nargin()<3)
%    sProjection = 'fast'; % Use fast plotting as default
%end
%
% Do the plots:
%
clf
set(gcf,'color','w');

bSilicate = isfield(sim.p,'idxSi');
nPanels = 4 + bSilicate;
% DOC
%text(0, 1, labels(i),'Units','normalized')
subplot(nPanels,1,1)
panelGlobal(sim.x,sim.y,sim.DOC(:,:,1,iTime),'DOC',sProjection);

% Nitrogen
subplot(nPanels,1,2)
c = panelGlobal(sim.x,sim.y,sim.N(:,:,1,iTime),'N',sProjection);
c.Label.String  = 'Concentration [\mug N l^{-1}]';

% Silicate
subplot(nPanels,1,3)
c = panelGlobal(sim.x,sim.y,sim.Si(:,:,1,iTime),'Si',sProjection);
c.Label.String  = 'Concentration [\mug Si l^{-1}]';

% Unicellular plankton
subplot(nPanels,1,nPanels-1)
panelGlobal(sim.x,sim.y,log10(sum(sim.B(:,:,1,findIxUnicellular(sim.p),iTime),4)),'Unicellular plankton (log10)',sProjection);
caxis([1 3])

% Multicellular plankton
subplot(nPanels,1,nPanels)
panelGlobal(sim.x,sim.y,log10(sum(sim.B(:,:,1,findIxMulticellular(sim.p),iTime),4)),'Multicellular plankton (log10)',sProjection);
caxis([1 3])

if isfield(sim,'CnetPerArea')
    subplot(4,1,4)
    panelGlobal(sim.x, sim.y, log10(sim.CnetPerArea(:,:,1)),'Average net primary production (log10 gC/m2/yr)', sProjection);
    caxis([8 11])
end
