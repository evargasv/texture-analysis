% ReadVyNamedSelections
%
% [mask,labels] = ReadVyNamedSelections(filename);
%
% Limitations...
%    Limited to 255 regions
%    Regions cannot overlap 
%    Regions may be flipped left/right, up/down, front/back...

% kego (3/3/15)

function [mask,labels] = ReadVyNamedSelections(filename, returnIsotropicVolume)

if nargin == 1, returnIsotropicVolume = false; end

% Read VyNamedSelections file into memory
fid = fopen(filename,'r');
assert(fid > 0, 'Failed to open %s', filename)
C = textscan(fid,'%s','Delimiter','\n');
fclose(fid);

% Calculate the virtual (isotropic) size and the physical number of slices
nPhysical = NumberOfPhysicalSlices(C);
[nx,ny,nz] = VirtualSize(C);

mask = zeros(ny,nx,nz,'uint8');
selections = SelectionsList(C);

for a = 1:length(selections)
    
    labels{a} = RegionName(C, selections(a));
    
    [intervalCodingStart,intervalCodingEnd] = IntervalCodingRange(C, selections(a));
        
    for b = intervalCodingStart:intervalCodingEnd
        [x1,x2,y,z] = IntervalCodingParameters(C, b);
        mask(y,x1:x2,z) = a;
    end
    
end

if ~returnIsotropicVolume
    mask = imresize3d(mask,[size(mask,2),size(mask,1),nPhysical],'nearest');
end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function n = NumberOfPhysicalSlices(C)
    idx1 = find(strcmp(C{1},'<imageuids>'));
    idx2 = find(strcmp(C{1},'</imageuids>'));
    n = idx2 - idx1 - 1;
end

function [nx,ny,nz] = VirtualSize(C)
    minRow = find(~cellfun(@isempty,strfind(C{1},'MinCorner')),1);
    mins = textscan(C{1}{minRow},'%*s = %f %f %f');
    maxRow = find(~cellfun(@isempty,strfind(C{1},'MaxCorner')),1);
    maxs = textscan(C{1}{maxRow},'%*s = %f %f %f');
    nx = maxs{1} - mins{1} + 1;
    ny = maxs{2} - mins{2} + 1;
    nz = maxs{3} - mins{3} + 1;
end

function selections = SelectionsList(C)
    selections = find(strcmp(C{1},'<Selection>'));
end

function name = RegionName(C, idxSection)
   idx = find(strcmp(C{1}(idxSection:end),'<Name>'),1);
   name = C{1}{idxSection + idx};
end

function [start,finish] = IntervalCodingRange(C, idxSection)
   idxStart = find(strcmp(C{1}(idxSection:end),'<IntervalCoding3D>'),1);
   start = idxSection + idxStart;
   idxEnd = find(strcmp(C{1}(idxSection:end),'</IntervalCoding3D>'),1);
   finish = idxSection + idxEnd - 2;
end

function [x1,x2,y,z] = IntervalCodingParameters(C, idx);
    A = sscanf(C{1}{idx},'%d %d %d %d');
    x1 = A(1); x2 = A(2); y = A(3); z = A(4);
end
