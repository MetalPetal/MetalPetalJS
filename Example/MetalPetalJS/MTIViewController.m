//
//  MTIViewController.m
//  MetalPetalJS
//
//  Created by yuao on 06/25/2018.
//  Copyright (c) 2018 yuao. All rights reserved.
//

#import "MTIViewController.h"
@import JavaScriptCore;
@import MetalPetalJS;

@interface MTIViewController ()

@property (nonatomic, strong) JSVirtualMachine *jsVirtualMachine;
@property (nonatomic, strong) JSContext *jsContext;

@property (nonatomic, weak) MTIImageView *imageView;

@end

@implementation MTIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MTIImageView *imageView = [[MTIImageView alloc] initWithFrame:self.view.bounds];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:imageView];
    self.imageView = imageView;
    
    
    self.jsVirtualMachine = [[JSVirtualMachine alloc] init];
    self.jsContext = [[JSContext alloc] initWithVirtualMachine:self.jsVirtualMachine];
    [MTIJSExtension exportToJSContext:self.jsContext];
    
    NSURL *scriptURL = [NSBundle.mainBundle URLForResource:@"script" withExtension:@"js"];
    JSValue *jsImage = [self.jsContext evaluateScript:[NSString stringWithContentsOfURL:scriptURL encoding:NSUTF8StringEncoding error:nil] withSourceURL:scriptURL];
    MTIImage *image = [jsImage toObjectOfClass:[MTIImage class]];
    
    if(self.jsContext.exception) {
        NSLog(@"%@", self.jsContext.exception);
    }
    
    [self.jsContext mti_garbageCollect];
    
    self.imageView.image = image;
}

@end
