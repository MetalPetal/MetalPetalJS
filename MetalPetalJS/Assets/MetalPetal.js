
/* -- MTINativeFilter -- */

function MTINativeFilter(name, options) {
    var filter = MTIJSNativeFilter.filterWithName(name, options);
    var proxy = new Proxy(filter, {
        get(target, propertyKey, receiver) {
            return target[propertyKey] || target.valueForPropertyKey(propertyKey) || undefined;
        },
        set(target, propertyKey, value, receiver) {
            if (propertyKey in target) {
                return false
            } else {
                return target.setValueForPropertyKey(value, propertyKey);
            }
        }
    });
    return proxy;
}

MTINativeFilter.build = function(desc) {
    return MTINativeFilter(desc.name, desc.options);
}

/* -- Kernels -- */

MTIRenderPipelineKernel.build = function(desc) {
    return MTIRenderPipelineKernel.fromJSONDescriptor(desc);
};

MTIRenderPipelineKernel.passthroughKernel = MTIRenderPipelineKernel.passthroughRenderPipelineKernel();

MTIComputePipelineKernel.build = function(desc) {
    return MTIRenderPipelineKernel.fromJSONDescriptor(desc);
};

MTIComputePipelineKernel.apply = function(desc) {
    return MTIComputePipelineKernel.applyToInputImagesParametersOutputTextureDimensionsOutputPixelFormat(desc.images, desc.parameters, desc.outputTextureDimensions, desc.outputPixelFormat);
}

/* -- MTIImage -- */

MTIImage.build = function(parameters) {
    if (parameters.filePath) {
        if (parameters.alphaType) {
            return MTIImage.imageWithContentsOfFileOptionsAlphaType(parameters.filePath, parameters.options, parameters.alphaType);
        } else {
            return MTIImage.imageWithContentsOfFileOptions(parameters.filePath, parameters.options);
        }
    } else if (options.color) {
        return MTIImage.imageWithColorSRGBSize(parameters.color, parameters.sRGB, parameters.size);
    }
    return undefined;
}

/* -- MTIRenderPassOutputDescriptor -- */

MTIRenderPassOutputDescriptor.build = function(parameters) {
    if (parameters.size) {
        if (parameters.loadAction) {
            return MTIRenderPassOutputDescriptor.renderCommandWithKernelGeometryImagesParameters(parameters.size, parameters.pixelFormat, parameters.loadAction);
        }
        return MTIRenderPassOutputDescriptor.renderPassOutputDescriptorWithSizePixelFormat(parameters.size, parameters.pixelFormat);
    } else if (parameters.dimensions) {
        return MTIRenderPassOutputDescriptor.renderPassOutputDescriptorWithDimensionsPixelFormatLoadActionStoreAction(parameters.dimensions, parameters.pixelFormat, parameters.loadAction, parameters.storeAction);
    }
    return undefined;
}

/* -- MTIRenderCommand -- */

MTIRenderCommand.build = function(desc) {
    return MTIRenderCommand.renderCommandWithKernelGeometryImagesParameters(desc.kernel, desc.geometry, desc.images, desc.parameters);
}

MTIRenderCommand.perform = function(parameters) {
    if (parameters.command && parameters.outputDescriptor) {
        return MTIRenderCommand.imagesByPerformingRenderCommandsOutputDescriptors([parameters.command], [parameters.outputDescriptor]);
    } else {
        return MTIRenderCommand.imagesByPerformingRenderCommandsOutputDescriptors(parameters.commands, parameters.outputDescriptors);
    }
}

/* -- MTIVector -- */

MTIVector.fromValues = function(values) {
    return MTIVector.vectorWithValues(values);
}


