% Resize a 3D volume
%
% B = imresize3d(A,[nx ny nz],'interp',padding)
% B = imresize3d(A,[nx ny nz],'interp')
%
% Limitations: Padding doesn't mix well with interpolation and antialiasing

% kego (Jan 2012; Laste updated Mar 2015)

function B = imresize3d(A,sizes,interp_type,padding)
    
    narginchk(2,4)
    if nargin < 3, interp_type = 'triangle'; end
    if nargin < 4, padding = []; end

    assert(ndims(A) == 3, 'Expected a 3D greyscale image');
    assert(numel(sizes) == 3, 'Expected sizes to have 3 elements [nx,ny,nz]');
    assert(all(sizes >= 1) && all(mod(sizes,1)==0), 'Expected sizes to be integers >= 1')
    
    Nx = sizes(1);
    Ny = sizes(2);
    Nz = sizes(3);
    sx = Nx / size(A,2);
    sy = Ny / size(A,1);
    sz = Nz / size(A,3);
    
    % If downscaling apply antialiasing filter
    if sx < 1 || sy < 1 || sz < 1
        A = AntiAliasFilter(A,sx,sy,sz,padding);
    end
    
    % Rescale x,y directions first
    B = imresize(A, [Ny Nx],interp_type,'Antialiasing',false);
    
    % Rescale z direction
    B = ipermute(imresize(permute(B,[1 3 2]),[Ny Nz],interp_type,'Antialiasing',false),[1 3 2]);
    
    % If padding specified and interpolation not nearest neighbour
    % then replace padding values where necessary.
    if ~strcmp(interp_type,'nearest') && ~isempty(padding)
        B2 = imresize(A, [Ny Nx], 'nearest');
        B2 = ipermute(imresize(permute(B2,[1 3 2]),[Ny Nz],'nearest'),[1 3 2]);
        B(B2 == padding) = padding;
    end
    
return


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function Y = AntiAliasFilter(X,sx,sy,sz,padding)
    sigmaX = 0.375 / sx;
    sigmaY = 0.375 / sy;
    sigmaZ = 0.375 / sz;
    Y = GaussFilter3d(X,[sigmaX,sigmaY,sigmaZ],padding);
return
