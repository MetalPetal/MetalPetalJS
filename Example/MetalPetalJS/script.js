console.log(MTIImage);

var image = MTIImage.imageWithContentsOfFileOptionsAlphaType(MTIJSEnvironment.pathByAppendingPathComponentToPath("test.jpg", MTIJSEnvironment.mainBundlePath()), {}, MTIAlphaType.alphaIsOne);

console.log(image)
