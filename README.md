# MetalPetalJS

An experimental JavaScript API for MetalPetal using the JavaScriptCore.framework

## Example

The example project demonstrate how to download shader libraries and render scripts from the server then use the downloaded renderer to process the test image.

The metal shader library and the render script is bundled in a [zip file](Assets/renderer.zip).

In the zip archive:

- script.js 

  The javascript file contains the render logic of this demo.
  
- default.metablib
  
  The metal shader library contains the following shader code:

  ```
  #include "MTIShaderLib.h"

  using namespace metalpetal;

  fragment float4 shader(VertexOut vertexIn [[ stage_in ]],
                         texture2d<float, access::sample> inputTexture [[ texture(0) ]],
                         constant float &offset [[buffer(0)]],
                         sampler s [[ sampler(0) ]]) {
      float4 colorR = inputTexture.sample(s, vertexIn.textureCoordinate + float2(offset));
      float4 colorG = inputTexture.sample(s, vertexIn.textureCoordinate);
      float4 colorB = inputTexture.sample(s, vertexIn.textureCoordinate - float2(offset));
      return float4(colorR.r, colorG.g, colorB.b, 1.0);
  }
  ```
  
## Install

You can use [CocoaPods](https://cocoapods.org/) to install the lastest version.

```
use_frameworks!

pod 'MetalPetalJS', :git => 'https://github.com/MetalPetal/MetalPetalJS.git'

```
