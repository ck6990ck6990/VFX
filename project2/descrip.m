function [desc_vec, coord] = descrip(img, tmpkpx, tmpkpy)
    [row, col] = size(img(:,:,1));
    coord = [];
    tmpkp_num = size(tmpkpx);        
    desc_vec = [];
    kp_num = 0;
    kpx = [];
    kpy = [];
    for i = 1:tmpkp_num
        if tmpkpx(i)>3 && tmpkpx(i)<col-2 && tmpkpy(i)>3 && tmpkpy(i)<row-2
            kpx = [kpx, tmpkpx(i)];
            kpy = [kpy, tmpkpy(i)];
            kp_num = kp_num + 1;
        end
    end
    for i = 1:kp_num
        tmpx = kpx(i);
        tmpy = kpy(i);
        coord = [coord; [tmpx, tmpy]];
        tmp_vec = zeros(49, 3);

        idx = 1;
        for y = -3:3
            for x = -3:3
                tmp_vec(idx, 1) = img(tmpy+y, tmpx+x, 1);
                tmp_vec(idx, 2) = img(tmpy+y, tmpx+x, 2);
                tmp_vec(idx, 3) = img(tmpy+y, tmpx+x, 3);
                idx = idx + 1;
            end
        end
        tmp_vec = reshape(tmp_vec, 1, []);
        desc_vec = [desc_vec; tmp_vec];
    end

end