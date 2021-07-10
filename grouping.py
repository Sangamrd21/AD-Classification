# -*- coding: utf-8 -*-
"""
Created on Sat Apr  3 22:57:17 2021

@author: DELL
"""
import pandas as pd
import os

df = pd.read_csv("C:/Users/DELL/Desktop/Change/ADNI1_Screening_1.5T_4_16_2021.csv")
path = "D:/A\/Skull_Stripped/Png_Img"
files = os.listdir(path)
j = 1
for i in range(2185):
    for file in files:
        try:
            if df['Subject'][i] in file:
                d = path +"/"+ str(df['Group'][i])+"("+str(j)+')'+'.png'
                os.rename(path+"/"+file, d)
                j = j+1
        except:
            print('no')