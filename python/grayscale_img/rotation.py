#!/usr/bin/python3
import cv2
import os.path as mypath

# Image Path Finding
img_path = mypath.dirname(mypath.realpath(__file__))
img_name = 'messi5.jpg'
img_fpath = img_path + "\\" + img_name

# OpenCV Parameters
rotate_degress = 90
img_zoom = 1

# Image Processing
img = cv2.imread(img_fpath,0)
rows,cols = img.shape
M = cv2.getRotationMatrix2D((cols/2,rows/2), rotate_degress, img_zoom)
dst = cv2.warpAffine(img,M,(cols,rows))
cv2.imshow('img',dst)
cv2.waitKey(0)
cv2.destroyAllWindows()
