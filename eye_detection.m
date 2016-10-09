% Please edit this function only, and submit this Matlab file in a zip file
% along with your PDF report

function [left_x, right_x, left_y, right_y] = eye_detection(img)
% INPUT: RGB image
% OUTPUT: x and y coordinates of left and right eye.
% Please rewrite this function, and submit this file in Moodle (in a zip file with the report).

s = size(img);
img = imresize(img, 0.3);
image_gray = rgb2gray(img);

tem = imread('./validation/v02.jpg');
tem4 = imread('./validation/v04.jpg');

left_tem4 = tem4(325:375, 200:300);
right_tem4 = tem4(325:375, 320:420);

left_tem = tem(370:450, 175:280, :);
right_tem = tem(370:450, 375:500,:);

left_tem = imfuse(left_tem,left_tem4,'blend','Scaling','joint');
right_tem = imfuse(right_tem,right_tem4,'blend','Scaling','joint');

left_tem = imresize(left_tem, 0.3);
right_tem = imresize(right_tem, 0.3);

left_template = rgb2gray(left_tem);
right_template = rgb2gray(right_tem);

left_template = imgaussfilt(left_template, 1);
right_template = imgaussfilt(right_template, 1);
img = imgaussfilt(image_gray, 2);

c = normxcorr2(left_template, img);
c2 = normxcorr2(right_template, img);

[max1, ind1] = max(c(:));
[ypeak, xpeak] = find(c == max1);

yoffSet = ypeak-size(left_template,1)/2;
xoffSet = xpeak-size(left_template,2)/2;

[max2, ind2] = max(c2(:));
[ypeak1, xpeak1] = find(c2 == max2);

yoffSet1 = ypeak1-size(right_template,1)/2;
xoffSet1 = xpeak1-size(right_template,2)/2;

resized = size(img);
left_x = xoffSet * s(1) / resized(1);
right_x = xoffSet1 * s(1) / resized(1);
left_y = yoffSet * s(2) / resized(2);
right_y = yoffSet1 *s(2) / resized(2);

end

