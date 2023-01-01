clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear;  % Erase all existing variables. Or clearvars if you want.
workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;
fontSize = 24;

% Check that user has the Image Processing Toolbox installed.
hasIPT = license('test', 'image_toolbox');
if ~hasIPT
  % User does not have the toolbox installed.
  message = sprintf('Sorry, but you do not seem to have the Image Processing Toolbox.\nDo you want to try to continue anyway?');
  reply = questdlg(message, 'Toolbox missing', 'Yes', 'No', 'Yes');
  if strcmpi(reply, 'No')
    % User said No, so exit.
    return;
  end
end

%===============================================================================
% Read in a standard MATLAB gray scale demo image.
folder = "C:\Users\DELL\Desktop\ADNI_dataset\skl";
baseFileName = 's.png';
% Get the full filename, with path prepended.
fullFileName = fullfile(folder, baseFileName);
% Check if file exists.
if ~exist(fullFileName, 'file')
  % File doesn't exist -- didn't find it there.  Check the search path for it.
  fullFileNameOnSearchPath = baseFileName; % No path this time.
  if ~exist(fullFileNameOnSearchPath, 'file')
    % Still didn't find it.  Alert user.
    errorMessage = sprintf('Error: %s does not exist in the search path folders.', fullFileName);
    uiwait(warndlg(errorMessage));
    return;
  end
end
grayImage = imread(fullFileName);
% Get the dimensions of the image.
% numberOfColorBands should be = 1.
[rows, columns, numberOfColorBands] = size(grayImage);
if numberOfColorBands > 1
  % It's not really gray scale like we expected - it's color.
  % Convert it to gray scale by taking only the green channel.
  grayImage = grayImage(:, :, 2); % Take green channel.
end
% Display the original gray scale image.
subplot(2, 3, 1);
imshow(grayImage, []);
axis on;
title('Original Grayscale Image', 'FontSize', fontSize);
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
% Give a name to the title bar.
set(gcf, 'Name', 'Demo by ImageAnalyst', 'NumberTitle', 'Off')

% Let's compute and display the histogram.
[pixelCount, grayLevels] = imhist(grayImage);
subplot(2, 3, 2);
bar(grayLevels, pixelCount);
grid on;
title('Histogram of original image', 'FontSize', fontSize);
xlim([0 grayLevels(end)]); % Scale x axis manually.

% Crop image to get rid of light box surrounding the image
grayImage = grayImage(3:end-3, 4:end-4);
% Threshold to create a binary image
binaryImage = grayImage > 20;
% Get rid of small specks of noise
binaryImage = bwareaopen(binaryImage, 10);
% Display the original gray scale image.
subplot(2, 3, 3);
imshow(binaryImage, []);
axis on;
title('Binary Image', 'FontSize', fontSize);

% Seal off the bottom of the head - make the last row white.
binaryImage(end,:) = true;
% Fill the image
binaryImage = imfill(binaryImage, 'holes');

% Erode away 15 layers of pixels.
se = strel('disk', 10, 0);
binaryImage = imerode(binaryImage, se);
subplot(2, 3, 4);
imshow(binaryImage, []);
axis on;
title('Eroded Binary Image', 'FontSize', fontSize);

% Mask the gray image
finalImage = grayImage; % Initialize.
finalImage(~binaryImage) = 0;
subplot(2, 3, 5);
imshow(finalImage, []);
axis on;
title('Skull stripped Image', 'FontSize', fontSize);

% Let's compute and display the histogram.
[pixelCount, grayLevels] = imhist(finalImage);
subplot(2, 3, 6);
bar(grayLevels, pixelCount);
grid on;
title('Histogram of skull stripped image', 'FontSize', fontSize);
xlim([0 grayLevels(end)]); % Scale x axis manually.

msgbox('Done with demo');