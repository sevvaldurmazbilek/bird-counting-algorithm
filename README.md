# bird-counting-algorithm

Image segmentation partitions an image into region of interest. The first stage in many automatic image analysis systems. Many counting algorithms are based on image segmentation. Therefore, the thresholding step should implement to the image. Automating the thresholding step helps to apply the algorithm to many images. A Bird Counting Algorithm consists of 5 main steps.
1. Grayscale Conversion
2. Thresholding
3. Morphological Operations
4. Labeling
5. Counting

A. Grayscale Conversion
Grayscale is simply reducing complexity compare to RGB images. Many tasks do not work better with a 3-dimensional matrix. That’s why we need to convert images to grayscale from RGB for the Bird Counting Algorithm. This can be done automatically with the “rgb2gray” function, on the other hand, the image can be converted into divided bands and multiplied by each band weight.

![image](https://github.com/sevvaldurmazbilek/bird-counting-algorithm/assets/59259659/9dfbab33-43c4-4a26-9aae-288ccccfa93e)


B. Thresholding
Thresholding is a simple segmentation process. It produces a binary image. It labels each pixel in or out of the region of interest by comparison of the gray level with a threshold value. We can choose the threshold value with the trial and error method or automatic methods. Since the automatic thresholding helps to apply the algorithm to many images, a automatic thresholding was implemented in this algorithm. There are many algorithms in order to determine the threshold value automatically such as K-Means Clustering or Otsu's Method. Otsu's method is the clustering-based image thresholding. It works when the histogram is bimodal. The method basically tries to minimize the within-class variance and at the same time, it maximizes the between-class variance.

![image](https://github.com/sevvaldurmazbilek/bird-counting-algorithm/assets/59259659/f5311be6-fae0-4d0e-ada4-46d78688d351)
![image](https://github.com/sevvaldurmazbilek/bird-counting-algorithm/assets/59259659/5f37befd-c213-44b7-ae0f-7d4e372757bf)


C. Morphological Operations
As shown in Figure 3, there may be some deficiencies that may adversely affect the object count in the image after thresholding. Therefore, some morphological operations should be applied to the image in order to eliminate these deficiencies and to make the edges of the objects smoother. For this purpose, the opening and closing operators are applied. Opening removes small objects from the foreground (usually taken as the bright pixels) of an image, placing them in the background, while closing removes small holes in the foreground, changing small islands of background into the foreground. Together with closing, the opening serves in computer vision and image processing as a basic workhorse of morphological noise removal. 

![image](https://github.com/sevvaldurmazbilek/bird-counting-algorithm/assets/59259659/d763fa74-a1b0-44f2-97a6-5dba4b1994cd)

![image](https://github.com/sevvaldurmazbilek/bird-counting-algorithm/assets/59259659/d56a0a6c-167f-450a-a547-858ae8cc151b)

D. Labeling
In order to be able to count the objects in the image, labeling is necessary. Connected components labelling labels each connected component of a binary image with a separate number. It is a method for identifying each object.

E. Counting
The last step of the algorithm is to count the objects labeled with the connected component.

![image](https://github.com/sevvaldurmazbilek/bird-counting-algorithm/assets/59259659/fa0053d0-32c8-4653-8a82-78de42b46a8f)

![image](https://github.com/sevvaldurmazbilek/bird-counting-algorithm/assets/59259659/ab47212f-2864-44e3-a03c-bde9f424ba30)
