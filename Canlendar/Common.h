//
//  Common.h
//  Canlendar
//
//  Created by ruyicai on 13-1-5.
//  Copyright (c) 2013年 beyondsoft. All rights reserved.
//
#import <Foundation/NSObjCRuntime.h>
#import "CanlendarAppDelegate.h"
#define KCurrentVersion  [[UIDevice currentDevice].systemVersion doubleValue]//判定系统版本。

//KChannelId 为nil或@""时,默认会被被当作@"App Store"渠道
/*
 91 
 tongbutui
 */
#define KChannelId @"App Store"

//广告
#define KGuoMengAdvertising  1

#define KGuoMengAppkey @"e6iqj1dcltpra5v169"

#define KUMengAppkey @"50e931ff52701567ff00009c"
//友盟获取不到 格言警句 时的默认值
#define KUMeng_geyanjingjuKey @"geyanjingju"
 
#define KUMeng_geyanjingju @"我希望每天叫我起床的不是闹钟，而是梦想、、、"

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

/*
 用来判断 字典的值 是否为null
 如果是null  则 返回@“”，
 否则 返回 原来的值
 */
#define KISNullValue(array,i,key) ([[array objectAtIndex:i] objectForKey:key] == (NSString*)[NSNull null] ? @"" : [[array objectAtIndex:i] objectForKey:key])

#define KISDictionaryNullValue(dict,key) ([dict objectForKey:key] == (NSString*)[NSNull null] ? @"" : [dict objectForKey:key])
 
//设置页面 切换 
#define ContentOffset 273
#define ContentMinOffset 60
#define MoveAnimationDuration 0.3

//提醒事项
#define KToDo_finishEvent  @"ToDo_finishEvent"
#define KToDo_unfinishEvent  @"ToDo_unfinishEvent"

#define KToDo_Title  @"ToDo_Title"
#define KToDo_Notice  @"ToDo_Notice"

#define KToDo_Repeat  @"ToDo_Repeat"
#define KToDo_NoticeTime  @"ToDo_NoticeTime"
 


#define DEBUG_ 0
#if DEBUG_
#undef NSLog
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#undef NSLog
#define NSLog(...) do{}while(0)
#endif

#define NSTrace() NSLog(@"%s,%d",__FUNCTION__,__LINE__)
//初始化 用事宜忌
#define KYiJiArray [NSArray arrayWithObjects:@"祭祀",@"祈福",@"求嗣",@"开光",@"塑绘",@"出行",@"齐醮",@"出火",@"纳采",@"裁衣",@"合帐",@"冠笄",@"嫁娶",@"纳婿",@"沐浴",@"剃头",@"整手足甲",@"分居",@"进人口",@"解除",@"修造",@"起基动土",@"伐木做梁",@"竖柱",@"上梁",@"开柱眼",@"穿屏扇架",@"安门",@"盖屋合脊",@"求医疗病 ",@"安床",@"移徙",@"入宅",@"挂匾",@"开市",@"立券",@"纳财",@"酝酿",@"捕捉",@"栽种",@"畋猎",@"纳畜",@"教牛马",@"破屋坏垣",@"拆卸",@"开井",@"作陂",@"开厕",@"造仓库",@"塞穴",@"",@"平治道涂",@"修墓",@"启攒",@"开生坟",@"合寿木",@"谢土",@"安葬",@"入殓",@"成服",@"除服",@"移柩",@"破土",@"开仓",@"筑堤",@"归宁",@"普渡",@"经络",@"安葬",@"订盟",@"赴任",@"挂匾",@"酬神",@"理发",@"余事勿取",@"诸事不宜",nil]


#define CADAPP ((CanlendarAppDelegate*) [UIApplication sharedApplication].delegate)

#define MY_IOS_VERSION_7 (CADAPP.DeviceSystemMajorVersion >= 7)

#define VIEW_TOP_MARGIN (MY_IOS_VERSION_7 ? 20 : 10)
