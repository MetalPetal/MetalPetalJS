function render(image, options) {
    
    var filter = MTINativeFilter("MTIMPSBoxBlurFilter");
    filter.size$int2 = MTIVector.fromIntValues([5,5]);
    filter.inputImage = image;
    
    var blurredImage = filter.outputImage;
    
    var maskImage = MTIImage.build({
        filePath: MTIJSUtilities.joinPath(MTIJSEnvironment.mainBundlePath, "mask.png"),
        options: { MTKTextureLoaderOptionSRGB: false },
        alphaType: MTIAlphaType.alphaIsOne
    });
 
    var blendFilter = MTINativeFilter.build({
        name: "MTIBlendFilter",
        options: {"blendMode": "Multiply"}
    });
    
    blendFilter.intensity = 1.0;
    blendFilter.inputBackgroundImage = blurredImage;
    blendFilter.inputImage = maskImage;
    
    var vignetteImage = blendFilter.outputImage;

    var geometry = MTIVertices.fullViewportSquareVertices();

    var kernel = MTIRenderPipelineKernel.build({
        fragmentFunction: {
            name: "shader",
            library: MTIJSUtilities.joinPath(options.resourcePath, "default.metallib")
        },
        vertexFunction: {
            name: "passthroughVertex"
        }
    });
    
    var command = MTIRenderCommand.build({
        kernel,
        geometry,
        images: [vignetteImage],
        parameters: {"offset": MTIVector.vectorWithFloatValues([0.008]) }
    });

    var descriptor = MTIRenderPassOutputDescriptor.build({
        size: blurredImage.size,
        pixelFormat: 0
    });

    var outputImage = MTIRenderCommand.perform({
        commands: [command],
        outputDescriptors: [descriptor]
    })[0];

    return outputImage;
}
