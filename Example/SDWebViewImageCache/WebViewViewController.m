//
//  WebViewViewController.m
//  SDWebViewImageCache
//
//  Created by hj on 2017/9/6.
//  Copyright © 2017年 jiehu5114. All rights reserved.
//

#import "WebViewViewController.h"
#import <SDWebViewImageCache/NSURL+SDWebViewCache.h>

@interface WebViewViewController ()

@property (nonatomic, strong) UIWebView *myWebView;

@end



@implementation WebViewViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.myWebView = [UIWebView new];
    //self.myWebView.delegate = self;
    [self.view addSubview:self.myWebView];
}



- (void)viewDidAppear:(BOOL)animated {
    self.myWebView.frame = self.view.bounds;
    NSURL *url = [NSURL URLWithString:@"http://192.168.31.202:6163/__static/img/1.png"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [self.myWebView loadRequest:request];
}


@end
