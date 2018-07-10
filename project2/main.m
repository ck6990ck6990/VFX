[images, gray_images, flen] = read_img();
row = size(images, 1);
col = size(images, 2);
image_num = size(images, 4);

keypoints = cell(image_num, 1);
des = cell(image_num, 1);
projected_images = cell(image_num, 1);
ordinate = cell(image_num, 1);
for i = 1:image_num
    %project
    projected_images{i} = proj(images(:,:,:,i), flen(i));
    
    % harris detect
    [kpx, kpy] = harris(images(:,:,:,i));
    
    % feature descriptor
    [desc_vec, coord] = descrip(images(:,:,:,i), kpx, kpy);
    des{i} = desc_vec;
    ordinate{i} = coord;   
end 

% feature match
match = cell(image_num, 1);
for i = 1:image_num-1
    match{i} = ransac(des{i}, des{i+1}, ordinate{i}, ordinate{i+1});
end

% image match
transformation = cell(image_num, 1);
for i = 1:image_num-1
    transformation{i} = do_match(match{i}, ordinate{i}, ordinate{i+1});
end

% image blending
output_img = projected_images{1};
for i = 2:image_num
    output_img = blending(output_img, projected_images{i}, transformation{i-1});
end
imshow(output_img);
imwrite(output_img, 'output_image/out.jpg');
