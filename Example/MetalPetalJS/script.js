(function() {
 console.log(MTIImage);
 
 var kernel = MTIRenderPipelineKernel.kernelWithJSONDescriptor({ fragmentFunction: { name: "shader", library: MTIJSEnvironment.pathByAppendingPathComponentToPath("default.metallib", MTIJSEnvironment.mainBundlePath())},
                                                               vertexFunction: { name: "passthroughVertex" }});
 
 var image = MTIImage.imageWithContentsOfFileOptionsAlphaType(MTIJSEnvironment.pathByAppendingPathComponentToPath("test.jpg", MTIJSEnvironment.mainBundlePath()), {MTKTextureLoaderOptionSRGB: false}, MTIAlphaType.alphaIsOne);
 
 var geometry = MTIVertices.squareVerticesForRect({ x: -1, y: -1, width: 2, height: 2});
 var command = MTIRenderCommand.renderCommandWithKernelGeometryImagesParameters(kernel, geometry, [image], {});
 
 var descriptor = MTIRenderPassOutputDescriptor.renderPassOutputDescriptorWithSizePixelFormat({width: image.size.width, height: image.size.height}, 0);
 
 var outputImage = MTIRenderCommand.imagesByPerformingRenderCommandsOutputDescriptors([command], [descriptor])[0];
 
 console.log(outputImage);
 
 return outputImage;
})();
