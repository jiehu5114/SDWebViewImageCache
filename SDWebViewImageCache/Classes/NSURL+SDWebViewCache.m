//
//  NSURL+SDWebViewCache.m
//  Pods
//
//  Created by hj on 2017/9/6.
//
//

#import "NSURL+SDWebViewCache.h"

@implementation NSURL (SDWebViewCache)

- (BOOL)isImageJpg {

    if([[self.pathExtension lowercaseString] isEqualToString:@"jpg"] ||
       [[self.pathExtension lowercaseString] isEqualToString:@"jpeg"]) {
        return YES;
    }
    return NO;
}

- (BOOL)isImagePng{
    if([[self.pathExtension lowercaseString] isEqualToString:@"png"]) {
        return YES;
    }
    return NO;
}

@end
