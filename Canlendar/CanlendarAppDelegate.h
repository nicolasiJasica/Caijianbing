//
//  CanlendarAppDelegate.h
//  Canlendar
//
//  Created by xie mengyue on 11-7-15.
//  Copyright 2011年 beyondsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
 
@class SidebarViewController;
@class StartViewController;
#import "CanlendarViewController.h"
@interface CanlendarAppDelegate : NSObject <UIApplicationDelegate> {
    StartViewController          *m_startViewController;
    
    NSString*                     m_geyanjingju;//友盟上配置 key值为“geyanjingju”
 
    CanlendarViewController*      m_canlendarViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet SidebarViewController *viewController;
 
-(void) showLoading:(id)sender;
//umeng 在线参数
-(NSString*) get_UMeng_geyanjingju;
 
@property(nonatomic,retain) CanlendarViewController* canlendarViewController;

//根据nsdate 获得 显示时间
-(NSString*) getTime_byNSdate:(NSDate*)date;


//设置 本地闹钟提醒
-(void)schedulNotificationWithYear:(NSDate*)setDate andMsg:(NSString *)msg;
@end
