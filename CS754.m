global T;
T = 25 ; % number of frames (Testing with 5 -> original target 50)
addpath("MMread")
video = mmread('cars.avi', (1:T)) ; % read the first t frames from the video


global H;
global W;
global globalmask;
global original_video;
H = 256 ;
W = 256 ;
frames = zeros(H, W, 3, T); 
original_video = zeros(H, W, T) ;
mask = rand(H,W,T)>0.85;

for i = 1:T
    temp = video.frames(i).cdata((video.height-H)/2 +1:(video.height+H)/2,(video.width-W)/2 + 1:(video.width+W)/2,:) ;
   
    frames(:,:,:,i) = temp;
    
    original_video(:,:,i) = rgb2gray(temp) ; 
    
    
end
for i=1:25
imwrite(original_video(:,:,i)/256,"oracle_images/image-" + int2str(i) + ".jpeg")
end

figure(1);
imshow(original_video(:,:,1)/256);

gaussian_std = 20;
kappa = 5;

original_video = imnoise(original_video/256,"poisson");
original_video = imnoise(original_video,'gaussian',0,(20/256)*(20/256));
original_video = imnoise(original_video,'salt & pepper',0.15);

original_video = 255*original_video;
% for i=1:25
% imwrite(original_video(:,:,i)/256,"noisy_vid_frames/image-" + int2str(i) + ".jpeg")
% end

globalmask = zeros(H,W,T);
figure(2);imshow(original_video(:,:,1)/256);
for i=1:256
   
    for j=1:256
        for k=1:T
            AdaptiveMedianfilterL1(i,j,k,1);
        end
    end
    
end
figure(3);
imshow(original_video(:,:,1)/256);

recon_video = zeros(size(original_video));
recon_av = zeros(size(original_video));
for i = 1:4:(size(original_video,1) - 7)
   
    for j = 1:4:(size(original_video,2) - 7)
            
        for k = 1:size(original_video,3)
            tic
            ind = Blockmatching(i,j,k,T);
            [Q,P,mask] = func_index(ind,40,1e-4,50,1.15);
            for h = 1:size(ind,1)
               recon_video(ind(h,1):ind(h,1) + 7, ind(h,2):ind(h,2) + 7,ind(h,3)) = recon_video(ind(h,1):ind(h,1) + 7, ind(h,2):ind(h,2) + 7,ind(h,3)) + reshape(Q(:,h),8,8);
               recon_av(ind(h,1):ind(h,1) + 7, ind(h,2):ind(h,2) + 7,ind(h,3)) = recon_av(ind(h,1):ind(h,1) + 7, ind(h,2):ind(h,2) + 7,ind(h,3)) + ones(8,8); 
            end
            toc
        end
        
    end
   
end
recon_video = recon_video./recon_av;
figure(1);imshow(recon_video(:,:,1)/256);
figure(2);imshow(recon_video(:,:,2)/256);



