import cv2
import numpy as np
import os.path as mypath

# Image Path Finding
img_path = mypath.dirname(mypath.realpath(__file__))
img_name = 'messi5.jpg'
img_fpath = img_path + "\\" + img_name

# OpenCV Image Parameters
pos_x = 0
pos_y = 0

# Image Processing
img = cv2.imread(img_fpath,0)
rows,cols = img.shape
M = np.float32([[1,0,pos_x],[0,1,pos_y]])
dst = cv2.warpAffine(img,M,(cols,rows))
cv2.imshow('img',dst)
cv2.waitKey(0)
cv2.destroyAllWindows()
