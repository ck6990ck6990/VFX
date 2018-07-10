function [feature_x feature_y] = harris(img)

    k = 0.04;
    Threshold = 50000;
    gray_img = rgb2gray(img);
    
    row = size(gray_img, 1);
    col = size(gray_img, 2);
    fx = [-1, 0, 1; -1, 0, 1; -1, 0, 1];
    fy = [-1, -1, -1; 0, 0, 0; 1, 1, 1];

    Ix = filter2(fx, gray_img);
    Iy = filter2(fy, gray_img);
    h = fspecial('gaussian', [5, 5], 1.5);

    Ix2 = filter2(h,Ix.*Ix);
    Iy2 = filter2(h,Iy.*Iy);
    Ixy = filter2(h,Ix.*Iy);
    map = zeros(row, col);

    for r=1:row
        for c=1:col
            M = [Ix2(r,c),Ixy(r,c);Ixy(r,c),Iy2(r,c)];
            R = det(M) - k * (trace(M) ^ 2);
            if (R > Threshold)
                map(r,c) = R;
            end
        end
    end
    dilation_kernel = [1,1,1;1,0,1;1,1,1];
    keypoints = map > imdilate(map, dilation_kernel);
    [feature_x, feature_y] = find(keypoints);
%     imshow(keypoints);

end