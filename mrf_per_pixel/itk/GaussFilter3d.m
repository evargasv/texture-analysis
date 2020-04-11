%GaussFilter3d
%
% Apply Gaussian low-pass filter to 3D image with standard deviation(s) equal
% to sigmas. Ignore padding if present
%
%    J = gauss_filt3d(I,sigma);   % isotropic sigma
%    J = gauss_filt3d(I,[sigmaX,sigmaY,sigmaZ])
%    J = gauss_filt3d(I,[sigmaX,sigmaY,sigmaZ],padding)

% kego (Jan 2012)

function J = GaussFilter3d(I,sigma,padding)

    narginchk(2,3)
    assert(numel(sigma) == 1 | numel(sigma) == 3,'Must specify one sigma or [x y z] sigmas')
    assert(ndims(I) == 3,'Expected 3D image')
    
    if numel(sigma) == 1
        sigmaX = sigma; sigmaY = sigma; sigmaZ = sigma;
    else
        sigmaX = sigma(1); sigmaY = sigma(2); sigmaZ = sigma(3);
    end

    if nargin < 3, padding = []; end

    % Separate kernels for x, y and z directions
    hx = GaussKernel(sigmaX);
    hy = GaussKernel(sigmaY);
    hz = GaussKernel(sigmaZ);

    if isempty(padding)
        J = conv3x(I,hx,hy,hz);
    else
        mask = (I ~= padding);
        J = NormSepConv3d(I,hx,hy,hz,mask);
        J(~mask) = padding;
    end
  
return


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function h = GaussKernel(sigma)
    N = get_gauss_filter_width(sigma,0.001);
    if N == 1
        h = 1;
    else
        h = fspecial('gaussian',[N 1],sigma);
    end    
return

function width = get_gauss_filter_width(sigma,delta)
    % Default: Gaussian function must have fallen to at least 1% of maximum.
    if nargin == 1, delta = .01; end        
    width = ceil(sigma * sqrt(-2*log(delta)));

    % Ensure width is odd
    width = width + mod(width+1,2);
return
