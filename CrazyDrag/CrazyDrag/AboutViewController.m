//
//  AboutViewController.m
//  CrazyDrag
//
//  Created by 夏海平 on 13-11-25.
//  Copyright (c) 2013年 clamsea. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *webview;
- (IBAction)close:(id)sender;


@end

@implementation AboutViewController

@synthesize webview;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *htmlFile = [[NSBundle mainBundle]pathForResource:@"CrazyDrag" ofType:@"html"]; //获取本地文件路径
    NSData *htmalData = [NSData dataWithContentsOfFile:htmlFile];  //获取数值
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle]bundlePath]]; //根据指定的路径初始化并返回一个新的NSURL对象。
    [self.webview loadData:htmalData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:baseURL];
    
    /* //设置 webview 获取页面信息的方法
    NSURL *url =[NSURL URLWithString:@"http://m.baidu.com"];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [self.webview loadRequest:request];
    */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)close:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
