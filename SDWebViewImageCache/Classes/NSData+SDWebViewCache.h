//
//  NSData+SDWebViewCache.h
//  Pods
//
//  Created by hj on 2017/9/6.
//
//

#import <Foundation/Foundation.h>


@interface NSData (SDWebViewCache)

/**
 *  Compute the content type for an image data
 *
 *  @param data the input data
 *
 *  @return the content type as string (i.e. image/jpeg, image/gif)
 */
+ (NSString *)sw_contentTypeForImageData:(NSData *)data;



@end
