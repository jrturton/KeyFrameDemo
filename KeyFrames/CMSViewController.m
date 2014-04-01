//
//  CMSViewController.m
//  KeyFrames
//
//  Created by Richard Turton on 01/04/2014.
//  Copyright (c) 2014 Mubaloo. All rights reserved.
//

#import "CMSViewController.h"

@interface CMSViewController ()
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *verticalPosition;
@property (strong, nonatomic) IBOutlet UIView *bouncingBox;
@property (strong, nonatomic) IBOutlet UIButton *calculationMode;
@property (nonatomic) UIViewKeyframeAnimationOptions calculationModeOption;

@end

@implementation CMSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.calculationModeOption = UIViewKeyframeAnimationOptionCalculationModeLinear;
    [self updateCalculationModeText];
}

-(void)updateCalculationModeText
{
    static NSDictionary *calculationTitles = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        calculationTitles = @{
            @(UIViewKeyframeAnimationOptionCalculationModeLinear): @"Linear",
            @(UIViewKeyframeAnimationOptionCalculationModeDiscrete): @"Discrete",
            @(UIViewKeyframeAnimationOptionCalculationModePaced): @"Paced",
            @(UIViewKeyframeAnimationOptionCalculationModeCubic): @"Cubic",
            @(UIViewKeyframeAnimationOptionCalculationModeCubicPaced): @"Cubic Paced"
            };
    });
    
    [self.calculationMode setTitle:calculationTitles[@(self.calculationModeOption)] forState:UIControlStateNormal];
}
- (IBAction)changeCalculationMode:(UIButton *)sender
{
    static NSArray *calculationModeValues = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        calculationModeValues = @[
          @(UIViewKeyframeAnimationOptionCalculationModeLinear),
          @(UIViewKeyframeAnimationOptionCalculationModeDiscrete),
          @(UIViewKeyframeAnimationOptionCalculationModePaced),
          @(UIViewKeyframeAnimationOptionCalculationModeCubic),
          @(UIViewKeyframeAnimationOptionCalculationModeCubicPaced)
          ];
    });
    
    NSUInteger index = [calculationModeValues indexOfObject:@(self.calculationModeOption)];
    index++;
    if (index == [calculationModeValues count])
    {
        index = 0;
    }
    
    self.calculationModeOption = [calculationModeValues[index] integerValue];
    [self updateCalculationModeText];
}

- (IBAction)start:(UIButton *)sender
{
    self.bouncingBox.backgroundColor = [UIColor blackColor];
    sender.enabled = NO;
    [UIView animateKeyframesWithDuration:5.0 delay:0.0 options:self.calculationModeOption animations:^{
        self.bouncingBox.backgroundColor = [UIColor redColor];
        
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
            self.verticalPosition.constant = 200.0;
            [self.view layoutIfNeeded];
        }];
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.25 animations:^{
            self.verticalPosition.constant = 50.0;
            [self.view layoutIfNeeded];
        }];
        [UIView addKeyframeWithRelativeStartTime:0.75 relativeDuration:0.125 animations:^{
            self.verticalPosition.constant = 200.0;
            [self.view layoutIfNeeded];
        }];
        [UIView addKeyframeWithRelativeStartTime:0.875 relativeDuration:0.0625 animations:^{
            self.verticalPosition.constant = 50.0;
            [self.view layoutIfNeeded];
        }];
        [UIView addKeyframeWithRelativeStartTime:0.9375 relativeDuration:0.03125 animations:^{
            self.verticalPosition.constant = 200.0;
            [self.view layoutIfNeeded];
        }];
        [UIView addKeyframeWithRelativeStartTime:0.96875 relativeDuration:0.015625 animations:^{
            self.verticalPosition.constant = 50.0;
            [self.view layoutIfNeeded];
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.25 animations:^{
            sender.transform = CGAffineTransformMakeScale(1.5, 1.5);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.75 relativeDuration:0.25 animations:^{
            sender.transform = CGAffineTransformIdentity;
        }];
    } completion:^(BOOL finished){
        sender.enabled = YES;
    }];
}

@end
