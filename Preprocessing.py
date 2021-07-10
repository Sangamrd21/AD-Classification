# -*- coding: utf-8 -*-
"""
Created on Sat Dec 19 16:32:06 2020

@author: Codovert
"""
import cv2
from matplotlib import pyplot as plt
from skimage.restoration import denoise_tv_chambolle
import os

 
img_dir = "D:/A/Skull_Stripped/test/AD/"
my_images = os.listdir(img_dir)

for i, img_name in enumerate(my_images):
    img = cv2.imread(img_dir + img_name)
    lab = cv2.cvtColor(img, cv2.COLOR_BGR2LAB)
    l, a, b = cv2.split(lab)
    clahe = cv2.createCLAHE(clipLimit=0.05, tileGridSize=(8,8))
    
    clahe_img = clahe.apply(l)
    lab2 = cv2.merge((clahe_img, a, b))    
    C_img = cv2.cvtColor(lab2, cv2.COLOR_LAB2BGR)
            

    denoise_TV = denoise_tv_chambolle(C_img, weight=0.008, multichannel=False)

    print(str(i)+"/"+str(len(my_images)))
    plt.imsave("E:/Project/Pre-processed/test/AD/" + str(i) + "AD.png", denoise_TV)
    
    
