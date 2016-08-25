/************************************************************
 *  * Temobi CONFIDENTIAL
 * __________________
 * Copyright (C) 2015 Temobi Technologies. All rights reserved.
 *
 * NOTICE: All information included here,to protect technology propert
 * of Temobi,all reproduction and dissemination of this material without
 * permission is strictly forbidden.
 */

#import "YZCommon.h"

static YZCommon *_sharedYZCommon = nil;

@implementation YZCommon

#pragma mark - object init
+(YZCommon*) sharedCommon
{
    @synchronized(self)
    {
        if (nil == _sharedYZCommon ) {
            _sharedYZCommon = [[self alloc] init];
        }
    }
    return _sharedYZCommon;
}

+(id)alloc
{
    @synchronized([YZCommon class]) //线程访问加锁
    {
        NSAssert(_sharedYZCommon == nil, @"Shewin: Attempted to allocate a second instance of a singleton.Please call +[sharedExerciseManage] method.");
        _sharedYZCommon  = [super alloc];
        return _sharedYZCommon;
    }
    return nil;
}

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

//////////////


+(UIImage *)normalizedImage:(UIImage *)image
{
    if (image.imageOrientation == UIImageOrientationUp) return image;
   
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    [image drawInRect:(CGRect){0, 0, image.size}];
    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return normalizedImage;
}


+(UIImage *)fixOrientation:(UIImage *)image
{
    
    // No-op if the orientation is already correct
    if (image.imageOrientation == UIImageOrientationUp) return image;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (image.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, image.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (image.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                             CGImageGetBitsPerComponent(image.CGImage), 0,
                                             CGImageGetColorSpace(image.CGImage),
                                             CGImageGetBitmapInfo(image.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.height,image.size.width), image.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.width,image.size.height), image.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

+(NSString *) getUserName
{
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    return username;
}

-(BOOL) getFirstGuide
{
    NSNumber *isFirstGuide = [[NSUserDefaults standardUserDefaults] objectForKey:@"DevConFirstGuide"];
    return isFirstGuide==NULL?YES:[isFirstGuide boolValue];
}

-(void) setFirstGuide:(BOOL)bYesOrNo
{
    [[NSUserDefaults standardUserDefaults] setObject:@(bYesOrNo) forKey:@"DevConFirstGuide"];
}


//!  获取APP名称
+(NSString *) getAPPName
{
    return [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
}

+(NSString *) getAPPIconName
{
    NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
    NSString *icon = [[infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
    return icon;
}

//!  获取APP版权公司名
+(NSString *) getCompanyName
{
    return [NSBundle mainBundle].infoDictionary[@"app_company_info"];
}

//!  获取APP商户名ID
+(NSString *) getAgentID
{
    return [NSBundle mainBundle].infoDictionary[@"app_agent_id"];
}

//!  获取APP版权公司名
+(NSString *) getVersionCode
{
    return [NSBundle mainBundle].infoDictionary[@"app_version_code"];
}

//!获取app当前版本号
+(NSString *)getAPPCurrentVersion
{
    return [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
}
@end
