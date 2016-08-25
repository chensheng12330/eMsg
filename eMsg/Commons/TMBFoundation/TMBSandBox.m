/*
 *  @file TMBSandBox.m
 *
 *  @brief 应用沙盒地址获取
 *
 *  @author 黄盼青
 *
 *  @date 2015-12-9
 *
 */

#import "TMBSandBox.h"

@implementation TMBSandBox

+(NSString *)AppPath {
    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
    
}

+(NSString *)DocPath {
    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
    
}

+(NSString *)LibPrefPath {
    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Preference"];
    
}

+(NSString *)LibCachePath {
    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Caches"];
    
}


+(NSString *)TmpPath {
    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/tmp"];
    
}



@end
