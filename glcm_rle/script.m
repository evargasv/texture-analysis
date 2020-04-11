clear;clc;close all;

M = xlsread('massive_table_single_slice_by_noise_stats.csv');

glcm = 17:117;
rle = 118:271;
stats = 5:11;
glcm_catg = [31,41,55,65,79,89,103,113];
rle_catg = [269,270];
rle_glnu = 17 + [109 120 131 142 153 164 175 186 197 208 219 230 241 252];
rle_rlnu = 17 + [110 121 132 143 154 165 176 187 198 209 220 231 242 253];

%% EXPERIMENT TYPE I

exp_i = zeros(4,5);
noise = [1,25,50,75,88];

for i=1:5
    % train with 0_no_idr, test with aidr
    [ X_train, Y_train ] = generate_set( M, -1, [stats glcm_catg rle_catg], 3 );
    [ X_test, Y_test ] = generate_set( M, noise(i), [stats glcm_catg rle_catg], 2 );
    
    % normalize
    xmin = min([X_train;X_test]);
    xmax = max([X_train;X_test]);
    xminrep = repmat(xmin,size(X_train,1),1);
    xmaxrep = repmat(xmax,size(X_train,1),1);
    X_train = (X_train - xminrep) ./ (xmaxrep - xminrep);
    
    xminrep = repmat(xmin,size(X_test,1),1);
    xmaxrep = repmat(xmax,size(X_test,1),1);
    X_test = (X_test - xminrep) ./ (xmaxrep - xminrep);
    
    organ_acc = classify( X_train, Y_train, X_test, Y_test );
    exp_i(:,i) = organ_acc;
end

%% EXPERIMENT TYPE II

exp_ii = zeros(4,5);
noise = [-1,-25,-50,-75,-88];

for i=1:5
    % train with 0_no_idr, test with aidr
    [ X_train, Y_train ] = generate_set( M, 1, [rle_glnu rle_rlnu], 3 );
    [ X_test, Y_test ] = generate_set( M, noise(i), [rle_glnu rle_rlnu], 2 );
    
    % normalize
    xmin = min([X_train;X_test]);
    xmax = max([X_train;X_test]);
    xminrep = repmat(xmin,size(X_train,1),1);
    xmaxrep = repmat(xmax,size(X_train,1),1);
    X_train = (X_train - xminrep) ./ (xmaxrep - xminrep);
    
    xminrep = repmat(xmin,size(X_test,1),1);
    xmaxrep = repmat(xmax,size(X_test,1),1);
    X_test = (X_test - xminrep) ./ (xmaxrep - xminrep);
    
    organ_acc = classify( X_train, Y_train, X_test, Y_test );
    exp_ii(:,i) = organ_acc;
end




