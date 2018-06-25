(function() {
 console.log(MTIImage);
 
 var image = MTIImage.imageWithContentsOfFileOptionsAlphaType(MTIJSEnvironment.pathByAppendingPathComponentToPath("test.jpg", MTIJSEnvironment.mainBundlePath()), {MTKTextureLoaderOptionSRGB: false}, MTIAlphaType.alphaIsOne);
 
 var grayScaleFilter = MTINativeFilter.filterWithName("MTISaturationFilter");
 grayScaleFilter.setValueForKey(0.0, "saturation");
 grayScaleFilter.setValueForKey(image, "inputImage");
 image = grayScaleFilter.valueForKey("outputImage");
 
 var filter = MTINativeFilter.filterWithName("MTIMPSGaussianBlurFilter");
 filter.setValueForKey(20.0, "radius");
 filter.setValueForKey(image, "inputImage");
 
 image = filter.valueForKey("outputImage");
 
 console.log(image);
 
 return image;
})();
