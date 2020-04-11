# texture-analysis

Discriminating one texture from another can be a challenge even for the human eye in some situations. In Computer Vision, textures can be described by a different amount of features studied through the literature. The main challenge consist in determining which features are relevant enough to successfully distinguish one texture from another.

n medical image analysis, texture is one of the most useful features, since it can be applied
to a wide variety of problems. One example is the classification of organ tissue, which is hard to
classify using shape or gray level information because shape is not consistent and the intensities
overlap for the case of soft tissues. The use of textures might be useful in this context, considering
that it is homogeneous among the slices forming the 3D image.

This projects deals with the problem of texture classification, applied to Computer Tomography
(CT) imaging. Our goal is to differentiate between four different tissues, belonging to Region
of Interest (ROI) previously defined: kidneys, liver, lungs and spleen.

<img src="/img/kidneys.png" width="50px">


