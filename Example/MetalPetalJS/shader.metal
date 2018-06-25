//
//  shader.metal
//  MetalPetalJS_Example
//
//  Created by Jackie on 2018/6/25.
//  Copyright © 2018 yuao. All rights reserved.
//

#include "MTIShaderLib.h"

using namespace metalpetal;

fragment float4 shader(VertexOut vertexIn [[ stage_in ]],
                       texture2d<float, access::sample> inputTexture [[ texture(0) ]],
                       sampler s [[ sampler(0) ]]) {
    float4 color = inputTexture.sample(s, vertexIn.textureCoordinate);
    color.r = 0;
    return color;
}

