function [SNR_neg,SNR_LMA,Heart_Rate_neg,Heart_Rate_LMA]=ica_undercomplete(video,gd)

tic
%Vid=VideoReader('D:\HR estimation with U-ICA\data_v1_source2\p104_v1_source2_89.avi');
Vid=VideoReader(video);

img1=read(Vid,1);

%img1=imresize(img1,0.7);
%img1=im_resize(img1);

%img1=imadjust(img1,[],[],0.9);
[thresh,img_rgb]=detectFace(img1);
%%
thresh=im_resize(thresh);
size_video=Vid.NumFrames;
final_sig=[];
for i= 1:size_video
    frame=read(Vid,i);
    frame=im_resize(frame);
    frame=imresize(frame,[size(thresh,1),size(thresh,2)]);
    %frame=imadjust(frame,[],[],2.5);    
    [img_rgb_mean] = spatialAverage(thresh,frame);
    final_sig=[final_sig;img_rgb_mean];
    
end


%% Detrending

%detrending R channel
z1=final_sig(:,1);
detrended_R=detrending(z1);

%detrending G channel
z2=final_sig(:,2);
detrended_G=detrending(z2);

%detrending B channel
z3=final_sig(:,3);
detrended_B=detrending(z3);
detrended_RGB=[detrended_R,detrended_G,detrended_B];

window_size=25;


f=window_size*round(size_video/Vid.Duration);%Number of frames for preprocessing


main_R=[];%preprocessed R component initialization
main_G=[];%preprocessed G component initialization
main_B=[];%preprocessed B component initialization

%final preprocessed components
for i=1:size(detrended_RGB,1)-f

    temp_R=detrended_R(i:i+f-1);
    temp_G=detrended_G(i:i+f-1);
    temp_B=detrended_B(i:i+f-1);

    main_R=[main_R;temp_R];%preprocessed R component
    main_G=[main_G;temp_G];%preprocessed G component
    main_B=[main_B;temp_B];%preprocessed B component

end
%% Centering
D(:,1)=(main_R-mean(main_R)).\std(main_R);
D(:,2)=(main_G-mean(main_G)).\std(main_G);
D(:,3)=(main_B-mean(main_B)).\std(main_B);
%% Whitening step
cov_x=D'*D;
[u,diag]=eig(cov_x);
x_new=u*diag^(-1/2)*u'*D';
%% W selection
[y_neg]=neg_optim(x_new);
[y_LMA]=LMA_optim(x_new);
%% FFT, Bandpass filtering and Heart rate calculation
[SNR_LMA,Heart_Rate_LMA]=Heart_cal(y_LMA,Vid.FrameRate,gd);
[SNR_neg,Heart_Rate_neg]=Heart_cal(y_neg,Vid.FrameRate,gd);
toc
return





