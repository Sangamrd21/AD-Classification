clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear;

d = uigetdir(pwd, 'Select a folder');
files = dir(fullfile(d, '*.png'));
folder = "C:\Users\DELL\Documents\1Monopoly Deal\New folder";

for i = 1:numel(files)
    baseFileName = files(i).name;
    fullFileName = fullfile(folder, baseFileName);
    img = imread(fullFileName);
    img = img(:, :, 2);
    fimg = imbinarize(img,'adaptive','ForegroundPolarity','dark','Sensitivity',0.4);
    imwrite(fimg, strcat('MP_', num2str(i), '.png'))
end