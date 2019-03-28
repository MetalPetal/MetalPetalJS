//
//  MTIViewController.m
//  MetalPetalJS
//
//  Created by yuao on 06/25/2018.
//  Copyright (c) 2018 yuao. All rights reserved.
//

#import "MTIViewController.h"
#import "MetalPetalJS_Example-Swift.h"

@import JavaScriptCore;
@import MetalPetalJS;

@interface MTIViewController ()

@property (nonatomic, strong) JSVirtualMachine *jsVirtualMachine;
@property (nonatomic, strong) JSContext *jsContext;

@property (nonatomic, weak) MTIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIButton *downloadRendererButton;

@end

@implementation MTIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MTIImageView *imageView = [[MTIImageView alloc] initWithFrame:self.view.bounds];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view insertSubview:imageView atIndex:0];
    self.imageView = imageView;
    
    // Setup JS Context
    self.jsVirtualMachine = [[JSVirtualMachine alloc] init];
    self.jsContext = [[JSContext alloc] initWithVirtualMachine:self.jsVirtualMachine];
    [MTIJSExtension exportToJSContext:self.jsContext];
}

- (IBAction)downloadRendererButtonTapped:(id)sender {
    [self downloadRenderer];
}

- (void)downloadRenderer {
    
    NSURL *workingDirectory = [[NSURL fileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:[NSUUID UUID].UUIDString];
    
    self.downloadRendererButton.enabled = NO;
    [self.downloadRendererButton setTitle:@"Downloading..." forState:UIControlStateNormal];
    //Download
    [[NSURLSession.sharedSession downloadTaskWithURL:[NSURL URLWithString:@"https://github.com/MetalPetal/MetalPetalJS/raw/master/Assets/renderer.zip"] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSCAssert(error == nil, @"Resource download failed.");
        
        NSError *unzipError;
        [Unzip unzipFileAtURL:location toURL:workingDirectory error:&unzipError];
        
        NSCAssert(unzipError == nil, @"Resource unzip failed.");
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.downloadRendererButton setTitle:@"Downloaded" forState:UIControlStateNormal];

            MTIImage *inputImage = [[MTIImage alloc] initWithContentsOfURL:[NSBundle.mainBundle URLForResource:@"test" withExtension:@"jpg"] options:@{MTKTextureLoaderOptionSRGB: @NO}];
            
            NSURL *scriptFileURL = [workingDirectory URLByAppendingPathComponent:@"script.js"];
            
            [self.jsContext evaluateScript:[NSString stringWithContentsOfURL:scriptFileURL encoding:NSUTF8StringEncoding error:nil] withSourceURL:scriptFileURL];
            
            JSValue *renderFunction = self.jsContext[@"render"];
            
            NSDictionary *options = @{@"resourcePath": workingDirectory.path};
            
            MTIImage *image = [[renderFunction callWithArguments:@[inputImage, options]] toObjectOfClass:[MTIImage class]];
            
            if(self.jsContext.exception) {
                NSLog(@"%@", self.jsContext.exception);
            }
            
            [self.jsContext mti_garbageCollect];
            
            self.imageView.image = image;
        });
    }] resume];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
