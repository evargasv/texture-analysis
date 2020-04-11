%dicomreadvolume
%
% [X,info,voxelSizes] = dicomreadvolume(filespec,filterspec)
%
% Examples:
%
% X = dicomreadvolume('images/*.dcm');
% [X,info] = dicomreadvolume('images/*.dcm');
% X = dicomreadvolume('images/*.dcm','SeriesInstanceUID==''1.2.3.4.5''');
% X = dicomreadvolume('images/*.dcm','SeriesNumber==7');
%
% ** Note that string tests have to be quoted; numeric ones must not be.
%
% Known limitations:
%
% 1. Frame of reference not considered
% 2. Gantry tilt not considered
% 3. Enhanced DICOM not considered (use dicomread directly instead)
% 4. It's a bit on the slow side...
% 5. eval statement not safe (i.e. bad filterspec could literally wipe hard-disk)

% kego (July 2013)

function [X,dicomInfos,voxelSizes] = dicomreadvolume(filespec,filterspec)

    narginchk(1,2)
    if nargin < 2, filterspec = []; end
    
    % If filespec is directory, select all files in directory
    if isdir(filespec), filespec = [filespec filesep '*']; end
    
    % Extract directory (if present)
    [P,~,~] = fileparts(filespec);
    if isempty(P), P='.'; end
    
    % Directory of matching (DICOM?) files
    D = dir(filespec);
    
    % Remove directories
    D([D.isdir]==1) = [];
    
    % Remove anything starting with a dot
    D(~cellfun(@isempty,regexp({D.name},'^\.'))) = [];

    filenames = {D.name}';
    if isempty(filenames)
        error('No files match for %s',filespec)
    end

    fprintf('    Info: %d files match file specification...\n', length(D))
    
    %
    % Read slices matching (optional) filter specification
    %
    nz = 0;
    for a = 1:length(D)
        try
            INFO = dicominfo([P filesep filenames{a}]);
        catch err
            if (strcmp(err.identifier,'images:dicominfo:notDICOM'))
                fprintf('Info: Ignoring non-DICOM file %s\n', filenames{a});
                continue
            else
                rethrow(err);
            end
        end
        
        % Filter on user specified criteria here
        if ~isempty(filterspec)
            testString = ['INFO.' filterspec];
            if ~eval(testString), continue ; end
        end
        
        nz = nz + 1;
        dicomInfos{nz} = INFO; %#ok<AGROW>
        dicomSlices{nz} = dicomread(INFO); %#ok<AGROW>
    end
    
    if nz == 0
        error('No DICOM files match filter specified!')
    end
    
    %
    % Now sort the slices into order. Check for pathological cases (e.g.
    % multiple slices with identical position, slices with different
    % dimensions etc.)
    %
    nx = size(dicomSlices{1},2);
    ny = size(dicomSlices{1},1);
    dataClass = class(dicomSlices{1});
        
    assert(all(cellfun(@(x) size(x,1)==ny & size(x,2)==nx,dicomSlices)), ...
           'Image dimensions mismatch detected');
    assert(all(cellfun(@(x) all(x.ImageOrientationPatient==dicomInfos{1}.ImageOrientationPatient),dicomInfos)),...
           'Image orientation mismatch detected');
    
    % Now sort out the slice order
    directionMatrix = MakeDirectionMatrix(dicomInfos{1});
    axialPositions = cellfun(@(x) sum(directionMatrix(:,3) .* x.ImagePositionPatient), dicomInfos);
    zSpacing = CalculateSliceSpacing(axialPositions);
    [~,sortedLocations] = sort(axialPositions,'ascend');

    % Insert slices in output volume
    X = zeros(ny,nx,nz,dataClass);
    for a = 1:length(sortedLocations)
        X(:,:,a) = dicomSlices{sortedLocations(a)};
    end

    voxelSizes = [dicomInfos{1}.PixelSpacing(1) dicomInfos{1}.PixelSpacing(2) zSpacing];
    
    fprintf('    Info: %d slices of %d x %d (%s) voxels: %g x %g x %g mm\n', ...
        nz, nx, ny, ...
        class(X), ...
        voxelSizes(1), voxelSizes(2), voxelSizes(3));
    
return


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function D = MakeDirectionMatrix(info)
    assert(isfield(info,'ImageOrientationPatient'))
    A = info.ImageOrientationPatient;
    D = [A(1:3) A(4:6) cross(A(1:3),A(4:6))];
return


function dz = CalculateSliceSpacing(zs)
    assert(~isempty(zs))
    sliceMinThreshold = sqrt(eps);
    sliceMaxThreshold = 0.1; 
    zs = sort(zs);
    if numel(zs) == 1
        dz = 1; % arbitrary distance for single slice
    else
        assert(all(abs(diff(zs)) >= sliceMinThreshold), ...
               'Multiple slices with same position detected')
        if ~(all(max(abs(diff(zs))) - min(abs(diff(zs))) <= sliceMaxThreshold))
               fprintf('!!! Warning: Irregular slice spacing detected (range %gmm to %gmm)\n',...
                   min(abs(diff(zs))),max(abs(diff(zs))));
        end
        dz = mean(diff(zs));
    end
return
