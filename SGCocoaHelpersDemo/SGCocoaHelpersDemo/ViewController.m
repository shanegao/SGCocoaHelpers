//
//  ViewController.m
//  SGCocoaHelpersDemo
//
//  Created by Shane Gao on 8/6/13.
//  Copyright (c) 2013 touchmob.com. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Helpers.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //
    UIButton *testButton = [UIViewHelper textButtonWithFrame:CGRectMake(20, 30, 100, 60) title:@"Hello" font:[UIFont systemFontOfSize:18] titleColor:[UIColor redColor] target:self action:@selector(helloword:)];
    [self.view addSubview:testButton];
    
    NSLog(@"left:%f, right:%f, top:%f, bottom:%f", testButton.left, testButton.right, testButton.top, testButton.bottom);
    testButton.right = 200.f;
    testButton.bottom = 320.f;
    NSLog(@"left:%f, right:%f, top:%f, bottom:%f", testButton.left, testButton.right, testButton.top, testButton.bottom);
    
    CloseButton *closeButton = [[CloseButton alloc] initWithFrame:CGRectMake(140, 30, 60, 60)];
    [self.view addSubview:closeButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)helloword:(id)sender
{
    
}
@end

@implementation CloseButton

- (void)drawRect:(CGRect)rect
{
    
}

@end
