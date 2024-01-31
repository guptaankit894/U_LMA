function [img1]=im_resize(img1)


new_height=size(img1,1)*0.7; %0.7 for U-ICA
new_width=size(img1,2)*0.7;  % 0.5 for U-ICA

%mid_normal=[floor(size(img1,1)/2),floor(size(img1,2)/2)];
mid_normal=[size(img1,1)/2,size(img1,2)/2];
mid_modi=[new_height/2,new_width/2];
dist_mid=mid_normal-mid_modi;

dist=sqrt((mid_normal(1)-new_height/2)^2 + (mid_normal(2)-new_width/2)^2);

min=[round(mid_normal(1)-dist-dist_mid),floor(mid_normal(2)-dist-dist_mid)];

img1=imcrop(img1,[min(1) min(2) floor(new_width) new_height+dist_mid(1)]);

%img1=imresize(img1,0.7);

%[thresh,img_rgb]=detectFace(img1);
% figure;
% imshow(img1)
return
