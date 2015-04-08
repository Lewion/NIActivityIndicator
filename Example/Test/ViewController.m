//
//  ViewController.m
//  Test
//
//  Created by Nikki Vergracht on 07/04/15.
//  Copyright (c) 2015 Lewion.ninja All rights reserved.
//

#import "ViewController.h"
#import "NIActivityIndicator.h"

@interface ViewController ()
@property (nonatomic, strong) NIActivityIndicator *indA;
@property (nonatomic, strong) NIActivityIndicator *indB;
@property (nonatomic, strong) NIActivityIndicator *indC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.indA = [[NIActivityIndicator alloc] initWithFrame:CGRectMake(20, 40, 50, 50)];
    self.indA.duration = 1;
    self.indA.strokeColor = [UIColor purpleColor];
    self.indA.strokeWidth = 8;
    [self.view addSubview:self.indA];
    [self.indA startAnimation];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.indA finishAnimation];
    });
    
    self.indB = [[NIActivityIndicator alloc] initWithFrame:CGRectMake(20, 100, 70, 70)];
    self.indB.duration = 2;
    self.indB.strokeColor = [UIColor blueColor];
    self.indB.strokeWidth = 10;
    [self.view addSubview:self.indB];
    [self.indB startAnimation];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.indB finishAnimation];
    });
    
    self.indC = [[NIActivityIndicator alloc] initWithFrame:CGRectMake(20, 180, 146, 146)];
    self.indC.duration = 2.5;
    self.indC.strokeColor = [UIColor orangeColor];
    self.indC.strokeWidth = 14;
    [self.view addSubview:self.indC];
    [self.indC startAnimation];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.indC finishAnimation];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
