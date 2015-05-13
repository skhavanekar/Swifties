//
//  ViewController.m
//  Test
//
//  Created by Sameer Khavanekar on 5/5/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self generateFibonacci];
}

-(void)generateFibonacci{
    NSMutableArray *series = [[NSMutableArray alloc] init];
    
    NSNumber *firstNumber = [[NSNumber alloc] initWithDouble:1];
    NSNumber *secondNumber = [[NSNumber alloc] initWithDouble:1];
    
    [series addObject:firstNumber];
    [series addObject:secondNumber];
    
    for (int i=2; i<20; i++) {
        double next = [[series objectAtIndex:i-1] doubleValue] + [[series objectAtIndex:i-2] doubleValue];
        [series addObject:[[NSNumber alloc] initWithDouble:next]];
    }
    NSLog(@"MY Series %@", series);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
