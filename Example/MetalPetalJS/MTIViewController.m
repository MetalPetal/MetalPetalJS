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

@end

@implementation MTIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.jsVirtualMachine = [[JSVirtualMachine alloc] init];
    self.jsContext = [[JSContext alloc] initWithVirtualMachine:self.jsVirtualMachine];
    [MTIJSExtension exportToJSContext:self.jsContext];
    [self.jsContext evaluateScript:[NSString stringWithContentsOfURL:[NSBundle.mainBundle URLForResource:@"script" withExtension:@"js"] encoding:NSUTF8StringEncoding error:nil]];
}

@end
