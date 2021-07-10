# -*- coding: utf-8 -*-
"""
Created on Thu Nov 19 10:00:07 2020

@author: DELL
"""
from keras.preprocessing.image import ImageDataGenerator
from skimage import io
import numpy as np

datagen = ImageDataGenerator(
    rotation_range=15,
    horizontal_flip=True,
    brightness_range=(0.8,1.2)
    )

dataset = []

import os
from PIL import Image
from numpy import expand_dims

image_directory = "E:/Project/ADNI_aug/trian/AD/"
dataset = []

my_images = os.listdir(image_directory)
for i, image_name in enumerate(my_images):
    if(image_name.split('.')[1] == 'png'):
        image = io.imread(image_directory + image_name)
        image = Image.fromarray(image)
        image = np.array(image)
        image = np.expand_dims(image, axis=0)
        i = 0
        for batch in datagen.flow(image, batch_size=1,
            save_to_dir = "E:/Project/ADNI_aug/trian/AD/",
            save_prefix = 'ADa',
            save_format='png'):
            i +=1
            if i > 1:
                break
    

