//
//  TestViewController.m
//  LoadingAnnimation
//
//  Created by FelixKung on 16/8/1.
//  Copyright © 2016年 FelixKung. All rights reserved.
//

#import "TestViewController.h"
#import "LDProgressView.h"

@interface TestViewController ()
@property (weak, nonatomic) IBOutlet UIView *progressView;
@property (weak, nonatomic) IBOutlet UIImageView *mouseImgView;

@property (weak, nonatomic) LDProgressView *ldProgressView;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LDProgressView *progressView = [[LDProgressView alloc] initWithFrame:_progressView.bounds];
    progressView.progress = 0.20;
    progressView.background = [UIColor whiteColor];
    progressView.flat = @YES;
    progressView.showBackgroundInnerShadow = @NO;
    progressView.animate = @YES;
    progressView.borderRadius = @0;
    progressView.showStroke = @NO;
    progressView.showText = @NO;
    self.ldProgressView = progressView;
    [_progressView addSubview:progressView];

//    
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"position"];
    anima.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.view.center.x -  _mouseImgView.frame.size.width/2, self.view.frame.size.height + _mouseImgView.frame.size.height / 2)];
    anima.toValue = [NSValue valueWithCGPoint:CGPointMake(self.view.center.x -  _mouseImgView.frame.size.width/2, self.view.frame.size.height + 50)];
    anima.duration = 0.8f;
    anima.repeatCount = MAXFLOAT;
    //anima.fillMode = kCAFillModeForwards;
    //anima.removedOnCompletion = NO;
    [_mouseImgView.layer addAnimation:anima forKey:@"positionAnimation"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)add:(UIButton *)sender {
    if (self.ldProgressView.progress == 1.0) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        self.ldProgressView.progress += 0.1;
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
