
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
    return MTIComputePipelineKernel.fromJSONDescriptor(desc);
};

MTIComputePipelineKernel.prototype.apply = function(desc) {
    return this.applyToInputImagesParametersOutputTextureDimensionsOutputPixelFormat(desc.images, desc.parameters, desc.outputTextureDimensions, desc.outputPixelFormat);
}

/* -- MTIImage -- */

MTIImage.build = function(parameters) {
    if (parameters.filePath) {
        if (parameters.alphaType) {
            return MTIImage.imageWithContentsOfFileOptionsAlphaType(parameters.filePath, parameters.options, parameters.alphaType);
        } else {
            return MTIImage.imageWithContentsOfFileOptions(parameters.filePath, parameters.options);
        }
    } else if (parameters.color) {
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

MTIVector.fromFloatValues = function(values) {
    return MTIVector.vectorWithFloatValues(values);
}

MTIVector.fromIntValues = function(values) {
    return MTIVector.vectorWithIntValues(values);
}

MTIVector.fromUIntValues = function(values) {
    return MTIVector.vectorWithUIntValues(values);
}

/* -- MTIMask -- */

MTIMask.build = function(desc) {
    return MTIMask.maskWithContentComponentMode(desc.content, desc.component, desc.mode);
}

/* -- MTILayer -- */

MTILayer.build = function(desc) {
    return MTILayer.layerWithContentContentIsFlippedContentRegionBlendModeCompositingMaskLayoutUnitPositionSizeRotationOpacity(
        desc.content,
        desc.contentIsFlipped,
        (desc.contentRegion || {x: 0, y: 0, width: desc.content.size.width, height: desc.content.size.height}),
        desc.blendMode,
        desc.compositingMask,
        desc.layoutUnit,
        desc.position,
        desc.size,
        desc.rotation,
        desc.opacity
    );
}

