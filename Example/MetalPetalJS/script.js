(function () {
    console.log(MTIImage);

    var kernel = MTIRenderPipelineKernel.kernelWithJSONDescriptor({
        fragmentFunction: { 
            name: "shader", 
            library: MTIJSUtilities.joinPath(MTIJSEnvironment.mainBundlePath, "default.metallib") 
        },
        vertexFunction: {
             name: "passthroughVertex" 
        }
    });

    var image = MTIImage.imageWithContentsOfFileOptionsAlphaType(
        MTIJSUtilities.joinPath(MTIJSEnvironment.mainBundlePath, "test.jpg"),
        { MTKTextureLoaderOptionSRGB: false },
        MTIAlphaType.alphaIsOne);
    
    /*
     var grayScaleFilter = MTINativeFilter.filterWithName("MTISaturationFilter");
     grayScaleFilter.setValueForKey(0.0, "saturation");
     grayScaleFilter.setValueForKey(image, "inputImage");
     image = grayScaleFilter.valueForKey("outputImage");
     
     var filter = MTINativeFilter.filterWithName("MTIMPSGaussianBlurFilter");
     filter.setValueForKey(20.0, "radius");
     filter.setValueForKey(image, "inputImage");
     
     image = filter.valueForKey("outputImage");
     */

    var geometry = MTIVertices.squareVerticesForRect({ x: -1, y: -1, width: 2, height: 2 });

    var command = MTIRenderCommand.renderCommandWithKernelGeometryImagesParameters(kernel, geometry, [image], {});

    var descriptor = MTIRenderPassOutputDescriptor.renderPassOutputDescriptorWithSizePixelFormat(image.size, 0);

    var outputImage = MTIRenderCommand.imagesByPerformingRenderCommandsOutputDescriptors([command], [descriptor])[0];

    return outputImage;
})();
