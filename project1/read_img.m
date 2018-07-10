%% read in images
function [gray_images, images, expo_time] = read_img()
    fid = fopen('input_image/image_list.txt', 'r');
    image_num = str2double(fgets(fid)); % read in first line

    files = {}; % testing purpose
    % initialize
    img = imread('input_image/1.jpg');
    info = imfinfo('input_image/1.jpg');
    images = zeros(info.Height, info.Width, info.NumberOfSamples, image_num, 'uint8');
    gray_images = zeros(info.Height, info.Width, image_num, 'uint8');
    expo_time = zeros(image_num, 1);

    % read files
    for i = 1:image_num
        line = strsplit(fgets(fid));
        str = strcat('input_image/', line{1, 1});
       
        % read image 
        img = imread(str); 
        images(:,:,:,i) = img;
        gray_images(:,:,i) = rgb2gray(img);

        % read shutter speed
        expo_time(i, 1) = 1/str2double(line{1, 2});
    end
end
