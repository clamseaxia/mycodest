//
//  CrazyDragViewController.m
//  CrazyDrag
//
//  Created by 夏海平 on 13-11-8.
//  Copyright (c) 2013年 clamsea. All rights reserved.
//


#import "CrazyDragViewController.h"
#import "AboutViewController.h"
#import "AVFoundation/AVFoundation.h"

@interface CrazyDragViewController (){
    
    int currentValue;
    int targetValue;
    int score;
    int round;
    
}
- (IBAction)startOver:(id)sender;
- (IBAction)sliderMoved:(UISlider*)sender;  //按钮
- (IBAction)showInfo:(id)sender;
@property (strong, nonatomic) IBOutlet UISlider *slider;  //文字

@property (strong, nonatomic) IBOutlet UILabel *targetLabel;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *roundLabel;

@property (nonatomic,strong)AVAudioPlayer *audioplayer;

- (IBAction)showAlert:(id)sender;


@end


@implementation CrazyDragViewController
@synthesize slider;
@synthesize targetLabel;
@synthesize scoreLabel;
@synthesize roundLabel;
@synthesize audioplayer;

- (void)palyBackgroundMusic{
    NSString *musicPath =[[NSBundle mainBundle]pathForResource:@"no" ofType:@"mp3"];
    NSURL *url =[NSURL fileURLWithPath:musicPath];
    NSError *error;
    
    audioplayer =[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    audioplayer.numberOfLoops = -1;
    if (audioplayer == nil) {
        NSString *errorlnfo = [NSString stringWithString:[error description]];
        NSLog(@"the error is:%@",errorlnfo);
    } else {
        [audioplayer play];
    }
}


- (void)updateLabels     //界面更新显示数据
{
    self.targetLabel.text = [NSString stringWithFormat:@"%d",targetValue];
    self.scoreLabel.text = [NSString stringWithFormat:@"%d",score];
    self.roundLabel.text = [NSString stringWithFormat:@"%d",round];
    
}


- (void)startNewRound   //生成随机值
{
    round += 1;
    targetValue = 1 +(arc4random() % 100);
    currentValue = 50;
    self.slider.value = currentValue;
    
    //NSLog(@"startNewRound的targetValue：%D",targetValue);

}

- (void)startNewGame{
    score = 0;
    round = 0;
    [self startNewRound];
}



- (void)viewDidLoad                                          //定义viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self palyBackgroundMusic];
    //  设置背景音乐开
    
    UIImage *thumbImageNormal =[UIImage imageNamed:@"SliderThumb-Normal"];
    [self.slider setThumbImage:thumbImageNormal forState:UIControlStateNormal];
    
    UIImage *thumbImageHighlighted = [UIImage imageNamed:@"SliderThumb-Highlighted"];
    [self.slider setThumbImage:thumbImageHighlighted forState:UIControlStateHighlighted];
    
    UIImage *trackRightImage = [UIImage imageNamed:@"SliderTrackRight"];
    [self.slider setMaximumTrackImage:trackRightImage forState:UIControlStateNormal ];

    [self startNewRound];
    [self updateLabels];
//    currentValue = self.slider.value;                        //初始化数值
//    targetValue = 1 + (arc4random() % 100);                 //随机值生成

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)sliderMoved:(UISlider*)sender {
//    UISlider *slider = (UISlider*)sender;
    
    currentValue = (int)lroundf(sender.value);
    
    
    // NSLog(@"滑动条的当前数值是：%f",slider.value);
}



- (IBAction)showAlert:(id)sender {
    

    //算法1
    /*
    int difference;
     if (currentValue >targetValue) {
        difference = currentValue - targetValue;
    } else if(targetValue > currentValue){
        difference = targetValue -currentValue;
    } else {
        difference = 0;
    }
    
    */
    
    //算法2
    /*
    
    int difference =targetValue -currentValue;
    if (difference < 0) {
        difference = -difference;
    }
    
    */
     
    //算法3  使用取正函数 abs
    int difference =abs(targetValue - currentValue);
    
    int points = 100 - difference;
    
    score += points;
    
    NSString *title;

    if (difference == 0) {
        title = @"完美表现！额外再奖励100分";
        points += 100;
    } else if (difference < 5) {
        title = @"表现太棒了，额外再奖励50分！";
        points += 50;
    } else if (difference < 10) {
        title = @"好吧，，勉强算个土豪！";
    } else {
        title = @"不是土豪少装！";
    }
    

    NSString *message = [NSString stringWithFormat:@"您的选择是：%d，所以您的得分是:%d", currentValue,points];
    
    [[[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil]show];
    

    
}

- (IBAction)startOver:(id)sender {
    
    //添加过渡效果
    CATransition *transaction = [CATransition animation];
    transaction.type = kCATransitionFade;
    transaction.duration =2;
    transaction.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    
    [self startNewGame];
    [self updateLabels];
    
    [self.view.layer addAnimation:transaction forKey:nil];
}

- (IBAction)showInfo:(id)sender {
    AboutViewController *controller = [[AboutViewController alloc]initWithNibName:@"AboutViewController" bundle:nil];
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{

[self startNewRound];   //调用startNewRound方法
[self updateLabels];

    
    
}


@end