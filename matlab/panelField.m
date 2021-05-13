%
% Plots a field with correct depth and size or time values
%
% x is a vector of x-value of the left side of the cells.
%   the last value the left side of the last cell.
% y a vector of y-value of the upper side of cells, with the last value
%   being the lower side of the last cell
% z values of all cells
%
function panelField(x,y,z)

arguments
    x,y,z double;
end
%
% Check size of z:
%

%if isequal(size(z), [length(y)-1, length(x)-1])
%    z = z';
%end

dim = size(z);
if ~isequal(dim(1:2), [length(x)-1, length(y)-1])
    error('Wrong dimension of z(%i,%i,:). Should be (%i,%i,:)\n',...
        size(z,1),size(z,2),length(x)-1, length(y)-1);
end
%
% Make the plot
%
for i = 1:length(x)-1
    for j = 1:length(y)-1
        if length(dim)==2
            patch(x(i+[0,1,1,0]), y(j+[0,0,1,1]), z(i,j), 'edgecolor','none')
        else
            patch(x(i+[0,1,1,0]), y(j+[0,0,1,1]), z(i,j,:), 'edgecolor','none')
        end
    end
end

axis tight
end
