(function () {
    console.log(MTIImage);

    var kernel = MTIRenderPipelineKernel.build({
        fragmentFunction: { 
            name: "shader", 
            library: MTIJSUtilities.joinPath(MTIJSEnvironment.mainBundlePath, "default.metallib") 
        },
        vertexFunction: {
            name: "passthroughVertex" 
        }
    });

    var image = MTIImage.build({
        filePath: MTIJSUtilities.joinPath(MTIJSEnvironment.mainBundlePath, "test.jpg"),
        options: { MTKTextureLoaderOptionSRGB: false },
        alphaType: MTIAlphaType.alphaIsOne
    });
 
    var blendFilter = MTINativeFilter.build({
        name: "MTIBlendFilter",
        options: {"blendMode": "Multiply"}
    });
 
    var filter = MTINativeFilter("MTIMPSGaussianBlurFilter");
    filter.radius = 20.0;
    filter.inputImage = image;
    
    var blurredImage = filter.outputImage;

    var geometry = MTIVertices.fullViewportSquareVertices();

    var command = MTIRenderCommand.build({
        kernel,
        geometry,
        images: [blurredImage],
        parameters: {}
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
})();
