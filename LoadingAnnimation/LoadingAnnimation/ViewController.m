//
//  ViewController.m
//  LoadingAnnimation
//
//  Created by FelixKung on 16/7/29.
//  Copyright © 2016年 FelixKung. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
#import "LDProgressView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (nonatomic, strong)UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong)UILabel *helloWorldLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    LDProgressView *progressView = [[LDProgressView alloc] initWithFrame:CGRectMake(2, 1, _bgView.frame.size.width-4, 40)];
    progressView.progress = 0.40;
    progressView.background = [UIColor whiteColor];
    progressView.flat = @YES;
    progressView.showBackgroundInnerShadow = @NO;
    progressView.animate = @YES;
    progressView.borderRadius = @0;
    progressView.showStroke = @NO;
    progressView.showText = @NO;
//    [self.progressViews addObject:progressView];
    [_bgView addSubview:progressView];

    
    
    NSMutableArray *imgs = [NSMutableArray array];
    NSInteger i = 1;
    do {
        NSString *imgName = [NSString stringWithFormat:@"lu%ld.png",(long)i];
        [imgs addObject:[UIImage imageNamed:imgName]];
        i++;
    } while (i < 3);
    
    _imgView.animationImages = [imgs copy];
    imgs = nil;
    _imgView.animationDuration = 0.4;
    _imgView.animationRepeatCount = 0;
    
    
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestures:)];
    self.panGestureRecognizer.minimumNumberOfTouches = 1;
    self.panGestureRecognizer.maximumNumberOfTouches = 1;
    self.imgView.userInteractionEnabled = YES;
    [self.imgView addGestureRecognizer:self.panGestureRecognizer];
}

-(void)handlePanGestures:(UIPanGestureRecognizer *)recognizer{
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    
    [recognizer setTranslation:CGPointZero inView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        CGPoint velocity = [recognizer velocityInView:self.view];
        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
        CGFloat slideMult = magnitude / 200;
        NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult);
        
        float slideFactor = 0.1 * slideMult; // Increase for more of a slide
        CGPoint finalPoint = CGPointMake(recognizer.view.center.x + (velocity.x * slideFactor),
                                         recognizer.view.center.y + (velocity.y * slideFactor));
        finalPoint.x = MIN(MAX(finalPoint.x, 0), self.view.bounds.size.width);
        finalPoint.y = MIN(MAX(finalPoint.y, 0), self.view.bounds.size.height);
        
        [UIView animateWithDuration:slideFactor*2 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            recognizer.view.center = finalPoint;
            
            //
            //            if (recognizer.view.frame.origin.x<=_labelFrame.origin.x-200||recognizer.view.frame.origin.x>=_labelFrame.origin.x+100) {
            //                [self.helloWorldLabel removeFromSuperview];
            //                [self hello:[UIColor colorWithRed:arc4random()%3 green:arc4random()%3 blue:arc4random()%3 alpha:1]];
            //                [self addShou];
            //
            //            }else{
            recognizer.view.frame = CGRectMake(self.view.center.x - 119/2, _bgView.frame.origin.y + _bgView.frame.size.height + 50, 119, 122);
            
            //            }
        } completion:^(BOOL finished) {
            [_imgView startAnimating];
        }];
        
    }

}

- (IBAction)onNext:(UIButton *)sender {
    TestViewController *vc = [TestViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
