//
//  SDWebViewCacheProtocol.m
//  Pods
//
//  Created by hj on 2017/9/6.
//
//

#import "SDWebViewCacheProtocol.h"
#import <SDWebImage/SDWebImageManager.h>
#import "NSURL+SDWebViewCache.h"
#import "NSData+SDWebViewCache.h"

static NSSet *SDWebViewCacheSupportedSchemes;
static NSString * const SDWebViewRequestHasInitKey = @"sdwebviewcache.hasinit.key";

@interface SDWebViewCacheProtocol ()

@property (nonatomic, strong) id <SDWebImageOperation> sdImageOperation;

@end

@implementation SDWebViewCacheProtocol

+ (void)initialize {
    if (self == [SDWebViewCacheProtocol class]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            SDWebViewCacheSupportedSchemes = [NSSet setWithObjects:@"http",@"https", nil];
        });
    }
}

#pragma mark - NSURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    if ([SDWebViewCacheSupportedSchemes containsObject:[[request URL] scheme]] &&
        [SDWebViewCacheProtocol isRequestImage:request] &&
        ![NSURLProtocol propertyForKey:SDWebViewRequestHasInitKey inRequest:request]) {
        return YES;
    }
    return NO;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

- (void)startLoading {
    NSMutableURLRequest *mutableReqeust = [[self request] mutableCopy];
    [NSURLProtocol setProperty:@YES forKey:SDWebViewRequestHasInitKey inRequest:mutableReqeust];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.sdImageOperation = [[SDWebImageManager sharedManager] loadImageWithURL:self.request.URL
                                                                            options:SDWebImageRetryFailed
                                                                           progress:nil
                                                                          completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                                                                              if (error == nil && image !=nil) {
                                                                                  //成功下载并缓存
                                                                                  NSData *data ;
                                                                                  if([mutableReqeust.URL isImageJpg]) {
                                                                                      data = UIImageJPEGRepresentation(image,1);
                                                                                  } else if([mutableReqeust.URL isImagePng]) {
                                                                                      data = UIImagePNGRepresentation(image);
                                                                                  }
                                                                                  if (data) {
                                                                                      NSURLResponse *response = [[NSURLResponse alloc] initWithURL:mutableReqeust.URL
                                                                                                                                          MIMEType:[NSData sw_contentTypeForImageData:data]
                                                                                                                             expectedContentLength:data.length
                                                                                                                                  textEncodingName:nil];
                                                                                      [self.client URLProtocol:self
                                                                                            didReceiveResponse:response
                                                                                            cacheStoragePolicy:NSURLCacheStorageNotAllowed];
                                                                                      
                                                                                      [self.client URLProtocol:self didLoadData:data];
                                                                                      [self.client URLProtocolDidFinishLoading:self];
                                                                                  } else {
                                                                                      //图片编码失败
                                                                                      NSError *err = [NSError errorWithDomain:@"image encode error"
                                                                                                                         code:1
                                                                                                                     userInfo:nil];
                                                                                      [self.client URLProtocol:self didFailWithError:err];
                                                                                  }
                                                                              } else {
                                                                                  //图片下载失败
                                                                                  [self.client URLProtocol:self didFailWithError:error];
                                                                              }
                                                                              //清空标志位
                                                                              [NSURLProtocol removePropertyForKey:SDWebViewRequestHasInitKey inRequest:mutableReqeust];
                                                                          }];
    });
}


- (void)stopLoading {
    [self.sdImageOperation cancel];
}


#pragma mark - private 

+ (BOOL)isRequestImage:(NSURLRequest *)request{
    if (request) {
        NSString* extension = request.URL.pathExtension;
        if ([extension isEqualToString:@"jpg"] ||
            [extension isEqualToString:@"jpeg"] ||
            [extension isEqualToString:@"png"]) {
            return YES;
        }
    }
    return NO;
}
@end

