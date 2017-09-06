//
//  ImageViewViewController.m
//  SDWebViewImageCache
//
//  Created by hj on 2017/9/6.
//  Copyright © 2017年 jiehu5114. All rights reserved.
//

#import "ImageViewViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ImageViewViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iamgeView;

@end

@implementation ImageViewViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://192.168.31.202:6163/__static/img/1.png"];
    
    [self.iamgeView sd_setImageWithURL:url
                               completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                   
                               }];
    
}


@end
