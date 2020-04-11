% % ------
% % Author: Elizabeth Vargas
% % E-mail: EVargas@tmvse.com
% % Created: 09-04-2015, using MATLAB 8.4.0.150421 (R2014b)
% % Modified: 28-04-2015
% % Copyright 2015 Toshiba Medical Visualization Systems Europe (TMVS)
% 
% clear;clc;close all;
% 
% % read dicom volume
[I,info,voxelSizes] = dicomreadvolume('c:\MyDicomLibrary\04635\04635_*_23_*.dcm');
[X,Y,Z] = size(I);
slice = I(101:390,35:465,600);
imshow(slice,[80-350,80+350])
set(gca,'position',[0 0 1 1],'units','normalized')

[mask,labels] = ReadVyNamedSelections('C:\rois\04635\Liver.txt');

slice_mask = mask(101:390,35:465,600);

roi = slice .* int16(slice_mask);
imshow(roi,[])
set(gca,'position',[0 0 1 1],'units','normalized')




imshow(slice, [])
% Make a truecolor all-green image.
green = cat(3, zeros(size(slice)), ones(size(slice)), zeros(size(slice)));
hold on
h = imshow(green);
hold off
set(h, 'AlphaData', slice_mask)

% B = imresize3d(I,[round(X/2),round(Y/2),round(Z/4)],'bicubic');
% write_itk(B, '04635');
% 
% [img,info] = read_itk('04635.mhd');
% 
% % padding -2048
% min(I(:));
%        
% % display one slice
% % imagesc(I(:,:,500))
% % colorbar
% % colormap(gray)
% 
% % animation of all the slices
% while(1);for a = 1:20:size(img,3); imagesc(img(:,:,a),[-1000 500]); colormap(gray); drawnow; end; end
% % animation of the mask
% %while(1);for a = 1:20:size(mask,3); imshow(mask(:,:,a),[]); colormap(gray); drawnow; end; end
% 
% % slice 740: two regions but one bounding box
% 
% slice = im2double(I(:,:,700));
% imagesc(slice)
% colormap(gray)
% imshow(slice,[]);
% 
% %%LUNG
% % read mask and labels
% [mask_lung,labels] = ReadVyNamedSelections('C:\rois\04636\Lung.txt');
% mask_img = mask_lung(:,:,443);
% mybin = mask_img > 0.5;
% % Make a truecolor all-red image.
% red_img = cat(3, ones(size(mask_img)),zeros(size(mask_img)), zeros(size(mask_img)));
% hold on  
% h = imshow(red_img);
% set(h, 'AlphaData', mybin )
% 
% %% TEST SEGMENTATION STATISTICS
% 
% seg = [0 0 0 0 0 0;
%        0 1 1 0 0 0;
%        0 0 0 1 0 0;
%        0 0 0 0 0 0];
% gt = [0 0 0 0 0 0;
%       0 1 1 1 1 1;
%       0 0 0 0 1 1;
%       0 0 0 0 0 0];
% 
% [ ntp, ntn, nfp, nfn ] = segmentation_stats( seg, gt )

%% BOUNDING BOX GT

[itk_volume,~] = read_itk('C:\MyResizedItkLibrary\04638\Kidney');

NR_SLICES = size(itk_volume,3);

idx = [];
bb = [];

for i=1:NR_SLICES
    I = itk_volume(:,:,i);
    % extract statistics
    stats = regionprops(I,'BoundingBox');
    
    if ~isempty(stats)
        % extract bounding boxes
        bound_bx = stats.BoundingBox;
        % number of bounding boxes
        nr_bound_bx = size(bound_bx,1);

        if nr_bound_bx > 0
            idx = [idx, i];
            bb = [bb; bound_bx];       
        end
    end
    
end

bb(:,3) = bb(:,1) + bb(:,3);
bb(:,4) = bb(:,2) + bb(:,4);

idx_bb = zeros(1,4);
% start point
idx_bb(:,1:2) = min(bb(:,1:2));
% end point
idx_bb(:,3:4) =max(bb(:,3:4));

x = idx_bb(1);
y = idx_bb(2);
w = idx_bb(3) - idx_bb(1);
h = idx_bb(4) - idx_bb(2);

slide_start = min(idx)
slide_end = max(idx)

 while(1);
     for a = slide_start:slide_end; 
        imshow(itk_volume(:,:,a),[]);
        hold on;
        rectangle('Position',[x,y,w,h],'EdgeColor','w');
        colormap(gray); 
        drawnow;
     end
 end
 
[mask,~] = ReadVyNamedSelections('Lung.txt');
% save the resized mask as itk file
write_itk(int16(mask), strcat('C:\MyItkLibrary\04639\Lung'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

I = zeros(3,3,3);

I(:,:,1) = [4 9 20;30 50 1;2 8 4];
I(:,:,2) = [9 25 30;12 21 13;1 4 8];
I(:,:,3) = [4 9 30;8 12 5;1 22 16];

[Iadj , Radj, Nfound ] = neighbourND( 14, size(I) )

I(Iadj)