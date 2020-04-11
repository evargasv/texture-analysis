%conv3x
%
% 3D convolution with seperable kernel
%
% kego: Dec 2011

function J = conv3x(I,hx,hy,hz)

narginchk(4,4)

    J = double(I);
    
    for a = 1:size(I,3)
        J(:,:,a) = conv2(J(:,:,a),hx(:).','same');
        J(:,:,a) = conv2(J(:,:,a),hy(:),'same');
    end
    
    for a = 1:size(I,1)
        J(a,:,:) = conv2(squeeze(J(a,:,:)),hz(:).','same');
    end
    
    J = J / (kernel_sum(hx) * kernel_sum(hy) * kernel_sum(hz));
    
return


function S = kernel_sum(h)
    S = sum(h);
    if S < sqrt(eps), S = 1; end
return
