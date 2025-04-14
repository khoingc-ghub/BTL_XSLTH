clc;
close all;
clear all; 

%sampling

%đọc hình ảnh 
im=imread('D:\XLSTH\BTL XLSTH\lulu.jpg'); %đưa về ảnh màu 
im=rgb2gray(imread('D:\XLSTH\BTL XLSTH\lulu.jpg')); %đưa về ảnh trắng đen 


im1=imresize(im,[1024 1024]);   %n=10
im2=imresize(im1,[256 256]);     %n=8
im3=imresize(im2,[128 128]);     %n=7
im4=imresize(im3,[64 64]);       %n=6
im5=imresize(im4,[32 32]);       %n=5
im6=imresize(im5,[16 16]);       %n=4
im7=imresize(im6,[4 4]);         %n=2
im8=imresize(im7,[2 2]);         %n=1

figure(3),
subplot(2,4,1),imshow(im1),title('im1 [1024 1024]')
subplot(2,4,1);imshow(im1,[]);
subplot(2,4,2);imshow(im2,[]);
subplot(2,4,3);imshow(im3,[]);
subplot(2,4,4);imshow(im4,[]);
subplot(2,4,5);imshow(im5,[]);
subplot(2,4,6);imshow(im6,[]);
subplot(2,4,7);imshow(im7,[]);
subplot(2,4,8);imshow(im8,[]);

%quantization 

im=imread('D:\XLSTH\BTL XLSTH\lulu.jpg');
im1=rgb2gray(imread('D:\XLSTH\BTL XLSTH\lulu.jpg'));

im2=gray2ind(im1,2^7);
im3=gray2ind(im1,2^6);
im4=gray2ind(im1,2^5);
im5=gray2ind(im1,2^4);
im6=gray2ind(im1,2^3);
im7=gray2ind(im1,2^2);
im8=gray2ind(im1,2^1);

figure(1),  
subplot(2,4,1);imshow(im1,[]);
subplot(2,4,2);imshow(im2,[]);
subplot(2,4,3);imshow(im3,[]);
subplot(2,4,4);imshow(im4,[]);
subplot(2,4,5);imshow(im5,[]);
subplot(2,4,6);imshow(im6,[]);
subplot(2,4,7);imshow(im7,[]);
subplot(2,4,8);imshow(im8,[]);
subplot(2,4,1),imshow(im1),ylabel('different gray level "constrast resolution"')

%noise and reconstructor 


im=imread('D:\XLSTH\BTL XLSTH\lulu.jpg');
im1=rgb2gray(im);

t1=imnoise(im1,'salt & pepper',.15);

t2=medfilt2(t1);
t3=medfilt2(t2);

figure,
imshow(im1);figure,imshow(t1);figure,imshow(t2)
figure,imshow(t3);



