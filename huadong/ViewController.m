//
//  ViewController.m
//  huadong
//
//  Created by xiaoshi on 2017/9/12.
//  Copyright © 2017年 ClouderWork. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    CGPoint _startPoint;
    BOOL _isRunAnimate;
}
@property (weak, nonatomic) IBOutlet UIView *manView;
@property (weak, nonatomic) IBOutlet UIView *centerView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.manView.layer.cornerRadius = 20;
    self.manView.layer.masksToBounds = YES;
    self.manView.layer.borderColor = [UIColor redColor].CGColor;
    self.manView.layer.borderWidth = 1;
    self.manView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.3f];

    self.centerView.layer.cornerRadius = 18;
    self.centerView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = 18;
    self.imageView.layer.masksToBounds = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_isRunAnimate) { return; }
    UITouch *touch = [touches anyObject];
    if (touch.view.tag == 101) {
        CGPoint point = [touch locationInView:self.centerView];
        NSLog(@" %@ ", NSStringFromCGPoint(point));
        _startPoint = point;
    }
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_isRunAnimate) { return; }
    UITouch *touch = [touches anyObject];
    if (touch.view.tag == 101) {
        CGPoint point = [touch locationInView:self.centerView];
        CGFloat offsetX = point.x - _startPoint.x;
        CGRect frame = self.imageView.frame;
        frame.origin = CGPointMake(frame.origin.x + offsetX, frame.origin.y);
        self.imageView.frame = frame;
        _startPoint = point;
    }

}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_isRunAnimate) { return; }
    UITouch *touch = [touches anyObject];
    if (touch.view.tag == 101) {
        CGPoint point = [touch locationInView:self.centerView];
        CGFloat offsetX = point.x - _startPoint.x;
        CGRect frame = self.imageView.frame;
        CGFloat imageX = frame.origin.x+offsetX;
        if (imageX>80) {
            //滑动到最后
            _isRunAnimate = YES;
            [UIView animateWithDuration:0.5f*(160-imageX)/80 animations:^{
                self.imageView.frame = CGRectMake(160, 0, 36, 36);
            } completion:^(BOOL finished) {
                _isRunAnimate = NO;
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"开始跳转" preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *enterAction = [UIAlertAction actionWithTitle:@"好的" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
                [alert addAction:enterAction];
                [self presentViewController:alert animated:YES completion: nil];
            }];
        } else {
            //滑动到原来的位置
            _isRunAnimate = YES;
            [UIView animateWithDuration:0.5f*imageX/80 animations:^{
                self.imageView.frame = CGRectMake(0, 0, 36, 36);
            } completion:^(BOOL finished) {
                _isRunAnimate = NO;
                NSLog(@"从头开始");
            }];
        }
    }
}
@end
