# -*- coding: utf-8 -*-
"""
Created on Sun Mar 28 19:36:30 2021

@author: DELL
"""
import numpy as np
import os #traversal folder
import nibabel as nib #nii format will generally use this package
import imageio #convert to image
import matplotlib.pyplot as plt

    
path_name = "D:/A/ADNI1_Complete_1Yr_1.5T_1"
files = os.listdir(path_name)
for file in files:
    path = path_name+'/'+str(file)
    img = nib.load(path)
    img_fdata = img.get_fdata()
    fname = file.replace('.nii', '')
    img_f_path = os.path.join(path_name, fname)
    (x,y,z) = img.shape
    while(input('Enter y/n:')!='y'):
        s = int(input('Enter the value:'))
        plt.imshow(img_fdata[s, :, :])
    imageio.imwrite('D:/A/ADNI_1Year/'+fname+'.png', slice)