//
//  shader.metal
//  MetalPetalJS_Example
//
//  Created by Jackie on 2018/6/25.
//

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

