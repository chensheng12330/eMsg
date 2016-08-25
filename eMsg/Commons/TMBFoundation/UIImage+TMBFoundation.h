//
//  UIImage+TMBFoundation.h
//  TMBFoundation
//
//  Created by 黄盼青 on 15/12/29.
//  Copyright © 2015年 深蓝蕴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TMBFoundation)

+ (UIImage *)noCacheImageNamed:(NSString *)imageName;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)streImageNamed:(NSString *)imageName;
+ (UIImage *)streImageNamed:(NSString *)imageName capX:(CGFloat)x capY:(CGFloat)y;

- (UIImage *)stretched;
- (UIImage *)grayscale;
- (UIImage *)roundCornerImageWithRadius:(CGFloat)cornerRadius;

- (UIColor *)patternColor;

-(UIImage *)TransformtoSize:(CGSize)Newsize;

@end
