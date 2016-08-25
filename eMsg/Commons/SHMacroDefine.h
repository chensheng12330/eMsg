//
//  SHMacroDefine.h
//  TestFrame
//
//  Created by sherwin.chen on 13-6-15.
//  Copyright (c) 2013年 sherwin.chen. All rights reserved.
//

#ifndef SHMacroDefine
#define SHMacroDefine




#define NavigationBar_HEIGHT 44

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define SH_IOS7_SET {if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {\
                          self.edgesForExtendedLayout = UIRectEdgeNone;}}

#define SH_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SH_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define SH_SAFE_RELEASE(x) [x release];x=nil
#define SH_IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define SH_CurrentSystemVersion ([[UIDevice currentDevice] systemVersion])
#define SH_CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
#define SH_BACKGROUND_COLOR [UIColor colorWithRed:242.0/255.0 green:236.0/255.0 blue:231.0/255.0 alpha:1.0]

#define SH_CLEARCOLOR [UIColor clearColor]
#define SCH_Gre [UIColor colorWithRed:67/255.0 green:196/255.0 blue:8/255.0 alpha:1]


#define SHAlert(info)  [[[UIAlertView alloc] initWithTitle:@"温馨提示" message:info delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil] show];
#define SHAlertEx(title,info)  [[[[UIAlertView alloc] initWithTitle:title message:info delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil] autorelease] show];


//devices
#define DEVICE_IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height >= 568)
#define DEVICE_IS_IPHONE4 ([[UIScreen mainScreen] bounds].size.height == 480)
#define DEVICE_IS_IPAD     ([[UIScreen mainScreen] bounds].size.width > 320)

#define DEVICE_Version_Value [[[UIDevice currentDevice] systemVersion] floatValue]
#define DEVICE_IS_IOS7 ((DEVICE_Version_Value>=7.0)&&(DEVICE_Version_Value)<8.0)
#define DEVICE_IS_IOS8 ((DEVICE_Version_Value>=8.0)&&(DEVICE_Version_Value)<9.0)

#define DEVICE_IS_480IOS7 (SH_SCREEN_HEIGHT==480 && DEVICE_IS_IOS7)

#define DEVICE_RightDrawerWidth (DEVICE_IS_IPAD?SH_SCREEN_WIDTH:SH_SCREEN_WIDTH-70)
//#define DEVICE_IS_IPAD ()
//#if !TARGET_OS_IPHONE || __IPHONE_OS_VERSION_MIN_REQUIRED > __IPHONE_2_2
//file dir
#define SH_LibraryDir ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0])
#define SH_FileMag ([NSFileManager defaultManager])
#define SH_APP ([UIApplication sharedApplication])
#define SH_Window ([[UIApplication sharedApplication].windows lastObject])
#define SH_loadNibName(name,target) [[[NSBundle mainBundle] loadNibNamed:name owner:target options:nil] firstObject];
#define SH_BundlePath(name,type) [[NSBundle mainBundle] pathForResource:name ofType:type]


//use JS Function Interaction
#define JSDebugAlert(info) {UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"JS调试出错!" message:info delegate:nil cancelButtonTitle:@"马上修改" otherButtonTitles:nil];\
[alert show];[alert release];}

#define JSGetArgmForNumber(argument) ([argument isKindOfClass:[NSNumber class]] ? argument:[argument isKindOfClass:[NSString class]]?[NSNumber numberWithDouble:[argument doubleValue]]:NULL)
#define JSGetArgmForString(argument) ([argument isKindOfClass:[NSString class]] ? argument:[argument isKindOfClass:[NSNumber class]]?[argument stringValue]:NULL)

//exception info
#define SHExcpInfo(xx, ...) [NSString stringWithFormat:@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__]
#define SHExcp(er_lvl,er_info) ([NSException exceptionWithName:er_lvl reason: SHExcpInfo(@"内部异常: %@",er_info) userInfo:nil])

#define SH_isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define SH_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//方正黑体简体字体定义
#define FONT(F) [UIFont fontWithName:@"FZHTJW--GB1-0" size:F]

//安全删除对象
#define SAFE_DELETE(P) if(P) { [P release], P = nil; }

#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

//文件管理
//缓存目录
#define SH_DefaultCaches  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)
#define SH_DefaultFileManager              [NSFileManager defaultManager]

//判断类是否可用
#define SH_USABLE_CLASS(a)    ([UICollectionView class]==NULL?FALSE:TRUE)
#define SH_USABLE_SELECTOR(c,s) ([c instancesRespondToSelector:s]==NULL?FALSE:TRUE)

///字符串NULL处理
#define StringNULL(string) (string==NULL?@"":string)
#define SH_StringIsNULL(stringT) ([stringT isKindOfClass:[NSNull class]] || (stringT.length<1))

//ARC
#if __has_feature(objc_arc)
//compiling with ARC
#else
// compiling without ARC
#endif


//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)


#define SH_USER_DEFAULT [NSUserDefaults standardUserDefaults]
#define SH_ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer]]


#pragma mark - common functions
#define RELEASE_SAFELY(__POINTER) { [__POINTER release]; __POINTER = nil; }


#pragma mark - degrees/radian functions
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

#pragma mark - color functions
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]



// .h
#define single_interface(class)  + (class *)shared##class;

// .m
// \ 代表下一行也属于宏
// ## 是分隔符
#define single_implementation(class) \
static class *_instance; \
\
+ (class *)shared##class \
{ \
if (_instance == nil) { \
_instance = [[self alloc] init]; \
} \
return _instance; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
}
#endif

/////////集成ISeePlus过的宏
//判断设备类型
#define IS_IPHONE5_BEFORE ([UIScreen mainScreen].bounds.size.width==320.0f)?YES:NO
#define IS_IPHONE6 ([UIScreen mainScreen].bounds.size.width==375.0f)?YES:NO
#define IS_IPHONE6PLUS ([UIScreen mainScreen].bounds.size.width==414.0f)?YES:NO
#define IS_IPAD ([UIScreen mainScreen].bounds.size.width==768.0f)?YES:NO

//屏幕大小
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size


//导航栏主颜色
#define AS_COLOR_NAVI [UIColor colorWithRed:0.988 green:0.518 blue:0.157 alpha:1.000]

//按钮主颜色
#define AS_COLOR_MAINBTN [UIColor colorWithRed:0.875 green:0.188 blue:0.212 alpha:1.000]
//按钮主颜色高亮
#define AS_COLOR_MAINBTN_LIGHT [UIColor colorWithRed:0.667 green:0.150 blue:0.169 alpha:1.000]


//APP版本号获取
#define APP_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#define APP_BUILD_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

//消息间隔时间
#define CHAT_MSG_TIME 60.0

