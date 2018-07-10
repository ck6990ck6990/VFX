% read in images
function [images, gray_images, flen] = read_img()
    fid = fopen('input_image/image_list.txt', 'r');
    image_num = str2double(fgets(fid)); % read in first line

    files = {}; % testing purpose
    %initialize
    img = imread('input_image/1.jpg');
    info = imfinfo('input_image/1.jpg');
    images = zeros(info.Height, info.Width, info.NumberOfSamples, image_num, 'uint8');
    gray_images = zeros(info.Height, info.Width, image_num, 'uint8');
    flen = zeros(image_num, 1);
%     
    % read files according to image_list.txt
    for i = 1:image_num
        line = strsplit(fgets(fid));
        str = strcat('input_image/', line{1, 1});
        flen(i) = str2double(line{1, 2});
        % read image 
        img = imread(str);
        images(:,:,:,i) = img;
        gray_images(:,:,i) = rgb2gray(img);
%         imshow(images(:,:,:,i));
    end
end
