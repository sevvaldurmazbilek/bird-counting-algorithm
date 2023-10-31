# bird-counting-algorithm

Image segmentation partitions an image into region of interest. The first stage in many automatic image analysis systems. Many counting algorithms are based on image segmentation. Therefore, the thresholding step should implement to the image. Automating the thresholding step helps to apply the algorithm to many images. A Bird Counting Algorithm consists of 5 main steps.
1. Grayscale Conversion
2. Thresholding
3. Morphological Operations
4. Labeling
5. Counting

A. Grayscale Conversion
Grayscale is simply reducing complexity compare to RGB images. Many tasks do not work better with a 3-dimensional matrix. That’s why we need to convert images to grayscale from RGB for the Bird Counting Algorithm. This can be done automatically with the “rgb2gray” function, on the other hand, the image can be converted into divided bands and multiplied by each band weight.

![image](https://github.com/sevvaldurmazbilek/bird-counting-algorithm/assets/59259659/44a45a2c-2a65-4fc8-8467-051c251f6b01)



B. Thresholding
Thresholding is a simple segmentation process. It produces a binary image. It labels each pixel in or out of the region of interest by comparison of the gray level with a threshold value. We can choose the threshold value with the trial and error method or automatic methods. Since the automatic thresholding helps to apply the algorithm to many images, a automatic thresholding was implemented in this algorithm. There are many algorithms in order to determine the threshold value automatically such as K-Means Clustering or Otsu's Method. Otsu's method is the clustering-based image thresholding. It works when the histogram is bimodal. The method basically tries to minimize the within-class variance and at the same time, it maximizes the between-class variance.

![image](https://github.com/sevvaldurmazbilek/bird-counting-algorithm/assets/59259659/8ea5605b-73b5-4758-9f01-59d6fc0c79c9)

![image](https://github.com/sevvaldurmazbilek/bird-counting-algorithm/assets/59259659/69837b36-9f2b-4400-a0ec-d02359ad0db6)



C. Morphological Operations
As shown in Figure 3, there may be some deficiencies that may adversely affect the object count in the image after thresholding. Therefore, some morphological operations should be applied to the image in order to eliminate these deficiencies and to make the edges of the objects smoother. For this purpose, the opening and closing operators are applied. Opening removes small objects from the foreground (usually taken as the bright pixels) of an image, placing them in the background, while closing removes small holes in the foreground, changing small islands of background into the foreground. Together with closing, the opening serves in computer vision and image processing as a basic workhorse of morphological noise removal. 

![image](https://github.com/sevvaldurmazbilek/bird-counting-algorithm/assets/59259659/50888347-f77e-4187-89b6-7f0e4d24cae1)


![image](https://github.com/sevvaldurmazbilek/bird-counting-algorithm/assets/59259659/53703ffc-9be5-4fbd-a415-f80ef91ec069)


D. Labeling
In order to be able to count the objects in the image, labeling is necessary. Connected components labelling labels each connected component of a binary image with a separate number. It is a method for identifying each object.

E. Counting
The last step of the algorithm is to count the objects labeled with the connected component.

![image](https://github.com/sevvaldurmazbilek/bird-counting-algorithm/assets/59259659/976d16dc-3df4-40a5-b2ef-e2fc3debbaf3)


![image](https://github.com/sevvaldurmazbilek/bird-counting-algorithm/assets/59259659/e60ba367-6500-4952-86be-92a075d63072)

