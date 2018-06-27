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
 
    var filter = new MTINativeFilter("MTIMPSGaussianBlurFilter");
    filter.radius = 20.0;
    filter.inputImage = image;
    
    var blurredImage = filter.outputImage;

    var geometry = MTIVertices.squareVerticesForRect({ x: -1, y: -1, width: 2, height: 2 });

    var command = MTIRenderCommand.renderCommandWithKernelGeometryImagesParameters(kernel, geometry, [blurredImage], {});

    var descriptor = MTIRenderPassOutputDescriptor.renderPassOutputDescriptorWithSizePixelFormat(blurredImage.size, 0);

    var outputImage = MTIRenderCommand.imagesByPerformingRenderCommandsOutputDescriptors([command], [descriptor])[0];

    return outputImage;
})();
