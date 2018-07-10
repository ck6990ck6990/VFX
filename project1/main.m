shift_bit = 4;
srow = 20;
scol = 40;
lambda = 3;
alpha = 3;
[gray_images, images, expo_time] = read_img();
expo_time = log(expo_time);
[row, col, channel, num] = size(images); 
for i = 1:num-1
    shift_ret = zeros(1, 2);
    [shift_ret] = GetExpShift(gray_images(:,:,i), gray_images(:,:,i+1), shift_bit, shift_ret);
    images(:,:,:,i+1) = imtranslate(images(:,:,:,i+1), [shift_ret(1), shift_ret(2)], 'FillValues', 255);
    gray_images(:,:,i+1) = imtranslate(gray_images(:,:,i+1), [shift_ret(1), shift_ret(2)], 'FillValues', 255);
%     imshow(images(:,:,:,i+1));
end
simages = zeros(srow, scol, channel, num);
for i = 1 : num
    simages(:,:,:,i) = imresize(images(:,:,:,i), [srow scol], 'bilinear');
end

%find response curve
g = zeros(256, 3);
ln_E = zeros(srow*scol, 3);
w = weighting();
for color = 1 : channel
    re_img = reshape(simages(:,:,color,:), srow*scol, num);
    [g(:,color), ln_E(:,color)] = gsolve(re_img, expo_time, lambda, w);
end

hdr_img = cal_E(images, g, expo_time, w);
str = ['output_image/library.hdr'];
hdrwrite(hdr_img, str);
% imshow(hdr_img);

%tonemapping
rgb = tonemapping(hdr_img, alpha);
% ii = tonemap(hdr_img);
imwrite(rgb, 'output_image/library.jpg');
% imshow(rgb);
