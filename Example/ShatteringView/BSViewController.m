//
//  BSViewController.m
//  ShatteringView
//
//  Created by Stas Batururimi on 08/06/2015.
//  Copyright (c) 2015 Stas Batururimi. All rights reserved.
//

#import "BSViewController.h"
#import "shatteringView.h"

@interface BSViewController ()
@property (weak, nonatomic) IBOutlet ShatteringView *viewToSplash;

@end

@implementation BSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)animationAction:(id)sender {
    self.viewToSplash.animationDuration = 5.0f;
    self.viewToSplash.radiusMultiplier = 2.;
    
    [self.viewToSplash smashIt:YES onCompletion:^(BOOL finished) {
        self.viewToSplash.hidden = NO;
    }];
}

@end
