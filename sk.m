clear all;
clc
[filename pathname] = uigetfile({'*.png';'*.bmp'},'Select MRI');
inputimage=strcat(pathname, filename);
I = imread(inputimage);
figure,imshow(I), title('input');
se = strel('disk',1);
closeBW = imclose(I,se);
figure, imshow(closeBW);title('close operation');
afterOpening = imopen(closeBW,se);
figure, imshow(afterOpening,[]);title('open operation');
J=I-afterOpening;
figure, imshow(J,[]);title('Skull of MRI');
K=I-J;
figure, imshow(K,[]);title('Skull removed MRI');