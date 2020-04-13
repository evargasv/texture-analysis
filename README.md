# Texture Enhanced Tissue Analysis

## Motivation

Discriminating one texture from another can be a challenge even for the human eye in some situations. In Computer Vision, textures can be described by a different amount of features studied through the literature. The main challenge consist in determining which features are relevant enough to successfully distinguish one texture from another.

In medical image analysis, texture is one of the most useful features, since it can be applied
to a wide variety of problems. One example is the classification of organ tissue, which is hard to
classify using shape or gray level information because shape is not consistent and the intensities
overlap for the case of soft tissues. The use of textures might be useful in this context, considering
that it is homogeneous among the slices forming the 3D image.

This projects deals with the problem of texture classification, applied to Computer Tomography
(CT) imaging. Our goal is to differentiate between four different tissues, belonging to Region
of Interest (ROI) previously defined: kidneys, liver, lungs and spleen.

<p align="center">
  <img src="/img/kidneys.png" width="200px">
  <img src="/img/liver.png" width="200px">
  <img src="/img/lungs.png" width="200px">
  <img src="/img/spleen.png" width="200px">
</p>

## Texture Analysis

MATLAB implementation of Varma and Zisserman classifier, using the intensity values of a local
neighbourhood as texture features, in order to perform single image classification on different
texture class instances in CT imaging.

<p align="center">
  <img src="/img/seg_kidney.png" width="200px">
  <img src="/img/seg_liver.png" width="200px">
  <img src="/img/seg_lung.png" width="200px">
  <img src="/img/seg_spleen.png" width="200px">
</p>


## References

- Varma, M. and Zisserman, A.,*Texture classification: Are filter banks necessary?*. In IEEE Computer Society Conference on Computer Vision and Pattern Recognition, 2003. Proceedings. (Vol. 2, pp. II-691). IEEE.



