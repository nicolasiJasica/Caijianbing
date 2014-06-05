//
//  CanlendarAppDelegate.m
//  Canlendar
//
//  Created by xie mengyue on 11-7-15.
//  Copyright 2011年 beyondsoft. All rights reserved.
//

#import "CanlendarAppDelegate.h"
#import "Common.h"
#import "SidebarViewController.h"
#import "MobClick.h"
#import "StartViewController.h"
#import "UMFeedback.h"
#import "ToDoViewController.h"
@interface CanlendarAppDelegate()
-(void) UMengConfigCallBack:(id)sender;
@end


@implementation CanlendarAppDelegate
@synthesize window=_window;
@synthesize viewController=_viewController;
@synthesize canlendarViewController = m_canlendarViewController;
#pragma mark 友盟
-(void)UMeng{
    /*
     //友盟 统计  修改渠道名称(channelId)
     */
    [MobClick setCrashReportEnabled:YES]; // 如果不需要捕捉异常，注释掉此行
    [MobClick startWithAppkey:KUMengAppkey reportPolicy:REALTIME channelId:KChannelId];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onlineConfigCallBack:) name:UMOnlineConfigDidFinishedNotification object:nil];
    //使用在线参数功能，可以让你动态修改应用中的参数值
    [MobClick updateOnlineConfig];
    
}
//格言警句
-(NSString*) get_UMeng_geyanjingju
{
    m_geyanjingju = [MobClick getConfigParams:KUMeng_geyanjingjuKey];
    if ([m_geyanjingju length] > 0) {
        return m_geyanjingju;
    }
    else
        return KUMeng_geyanjingju;
}

//在线参数 监听事件
- (void)onlineConfigCallBack:(NSNotification *)notification {
    NSLog(@"online config has fininshed and params = %@", notification.userInfo);
    
    m_geyanjingju = [notification.userInfo objectForKey:KUMeng_geyanjingjuKey];
    
    //    NSTimer* myTimer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(UMengConfigCallBack:) userInfo:nil repeats:NO];
    //    [myTimer setFireDate:[NSDate distantPast]];
    
    //    [self setupTimer];
}

-(void) UMengConfigCallBack:(id)sender
{
    if (self.canlendarViewController) {
        [self.canlendarViewController UMENGConfigCall];
    }
}
-(void) setupTimer
{
    //不重复，只调用一次。timer运行一次就会自动停止运行
    [self performSelector:@selector(UMengConfigCallBack:) withObject:nil afterDelay:2];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self UMeng];
    
    SidebarViewController* todo = [[SidebarViewController alloc] initWithNibName:@"SidebarViewController" bundle:nil];
    [self.window setRootViewController:todo];
    [self.window makeKeyAndVisible];
    
    m_startViewController = [[StartViewController alloc] init];
    [self showStartView];
    
    //检查 留言反馈
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(umCheck:) name:UMFBCheckFinishedNotification object:nil];
    [UMFeedback checkWithAppkey:KUMengAppkey];
    
    return YES;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSLog(@"查看feedback");
        [UMFeedback showFeedback:self.viewController withAppkey:KUMengAppkey];
    }else{
        
    }
}

- (void)umCheck:(NSNotification *)notification {
    UIAlertView *alertView;
    if (notification.userInfo) {
        NSArray * newReplies = [notification.userInfo objectForKey:@"newReplies"];
        NSLog(@"newReplies = %@", newReplies);
        NSString *title = [NSString stringWithFormat:@"有%d条新回复", [newReplies count]];
        NSMutableString *content = [NSMutableString string];
        for (int i = 0; i < [newReplies count]; i++) {
            NSString * dateTime = [[newReplies objectAtIndex:i] objectForKey:@"datetime"];
            NSString *_content = [[newReplies objectAtIndex:i] objectForKey:@"content"];
            [content appendString:[NSString stringWithFormat:@"%d  %@\r\n", i+1,dateTime]];
            [content appendString:_content];
            [content appendString:@"\r\n\r\n"];
        }
        
        alertView = [[UIAlertView alloc] initWithTitle:title message:content delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"查看", nil];
        ((UILabel *) [[alertView subviews] objectAtIndex:1]).textAlignment = NSTextAlignmentLeft ;
        [alertView show];
        [alertView release];
        
    }else{
        //        alertView = [[UIAlertView alloc] initWithTitle:@"没有新回复" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
    }
    
}

//设置的时间到了以后  如果此时你的客户端 软件仍在打开，则会调用？？？
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification*)notif {
    
    UIApplicationState state = application.applicationState;
    if (state == UIApplicationStateActive) {//弹出alert
        //添加处理代码
        if (notif) {
            NSLog(@"didFinishLaunchingWithOptions\n");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"随身日历-闹钟提醒" message:notif.alertBody delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] ;
            [alert show];
            [alert release];
        }
    }
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
    //刷新友盟数据  检查留言反馈
    [MobClick updateOnlineConfig];
    [UMFeedback checkWithAppkey:KUMengAppkey];
}

//应用在准备进入前台运行时执行的函数。（当应用从启动到前台，或从后台转入前台都会调用此方法）
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    
    //它是类里自带的方法,这个方法得说下，很多人都不知道有什么用，它一般在整个应用程序加载时执行，挂起进入后也会执行，所以很多时候都会使用到，将小红圈清空
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [_viewController release];
    
    if(iPhone5)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:UMOnlineConfigDidFinishedNotification];
    }
    
    [super dealloc];
}

- (void)showStartView
{
    
    [self.window addSubview:m_startViewController.view];
    m_startViewController.view.hidden = NO;
}

-(void) showLoading:(id)sender
{
    m_startViewController.view.hidden = YES;
    //    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    //    self.viewController = [[SidebarViewController alloc] initWithNibName:nil bundle:nil];
    //    self.window.rootViewController = self.viewController;
    //    [self.window addSubview:self.viewController.view];       //加入这样一句代码，我就是这样解决的
    //    [self.window makeKeyAndVisible];
    
}

/////////////////////////////////////////////////////////////
-(NSString*) getTime_byNSdate:(NSDate*)date
{
    //    //格式化日期时间
    NSLog(@"getTime_byNSdate   %@",date);
    
    NSCalendar *calendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    int week = [comps weekday];
    int year = [comps year];
    int month = [comps month];
    int day = [comps day];
    int hour = [comps hour];
    int min = [comps minute];
    
    //a就是星期几，1代表星期日，2代表星期一，后面依次
    NSString* weekStr = @"";
    switch (week) {
        case 1:
        {
            weekStr = @"日";
            break;
        }
        case 2:
        {
            weekStr = @"一";
            break;
        }
        case 3:
        {
            weekStr = @"二";
            break;
        }
        case 4:
        {
            weekStr = @"三";
            break;
        }
        case 5:
        {
            weekStr = @"四";
            break;
        }
        case 6:
        {
            weekStr = @"五";
            break;
        }
        case 7:
        {
            weekStr = @"六";
            break;
        }
        default:
            break;
    }
    
    NSString* time = @"";
    time = [time stringByAppendingFormat:@"%d年%d月%d日，周%@ %d:%d",year,month,day,weekStr,hour,min];
    return time;
}


-(void)schedulNotificationWithYear:(NSDate*)setDate andMsg:(NSString *)msg{
    
    //    // Set up the fire time
    //    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    //    NSDateComponents *dateComps = [[NSDateComponents alloc] init];
    //    [dateComps setDay:d];
    //    [dateComps setMonth:m];
    //    [dateComps setYear:y];
    //    [dateComps setHour:h];
    //    [dateComps setMinute:mi];
    //    [dateComps setSecond:0];
    //    NSDate *itemDate = [calendar dateFromComponents:dateComps];
    //    [dateComps release];
    
    //删除本地消息
    [self cancelLocalNotification];
    
    NSArray* array = (NSArray*)[[NSUserDefaults standardUserDefaults] objectForKey:KToDo_unfinishEvent];
    for (int j = 0; j < [array count]; j++) {
        
        NSDictionary* dic = [NSDictionary dictionaryWithDictionary:(NSDictionary*)[array objectAtIndex:j]];
        
        if ([[dic objectForKey:KToDo_Notice] isEqualToString:@"true"]) {
            
            NSDate* adviceDate = [NSDate dateWithTimeInterval:0 sinceDate:[dic objectForKey:KToDo_NoticeTime]];
            NSString* title = [dic objectForKey:KToDo_Title];
            UILocalNotification *localNotif = [[[UILocalNotification alloc] init] autorelease];
            if (localNotif == nil)
                break;
            NSDate *now=[NSDate new];
            NSLog(@"now   %@\n setDate : %@",now,adviceDate);
            /*注意时间 一定要设置对
             当时间设置的比现在时间早时，会立刻 有本地消息推送
             */
            NSTimeInterval TimeInterval = [adviceDate timeIntervalSinceNow];
            if (TimeInterval <= 0) {
                break;
            }
            localNotif.fireDate = /*[now dateByAddingTimeInterval:10]*/[now dateByAddingTimeInterval:TimeInterval];
            localNotif.alertBody = title;
            
            //    localNotif.timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
            //    localNotif.alertAction = @"查看";
            //    newNotification.soundName = UILocalNotificationDefaultSoundName;//设置声音选项
            localNotif.soundName = UILocalNotificationDefaultSoundName;
            localNotif.applicationIconBadgeNumber = 1;//设置BadgeNumber
            //    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"someValue" forKey:@"someKey"];
            //    localNotif.userInfo = infoDict;
            [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
        }
    }
    
}
//删除所有本地通知
-(void) cancelLocalNotification
{
    NSArray *localNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for(UILocalNotification *notification in localNotifications)
    {
        NSLog(@"old localNotification:%@", [notification fireDate]);
        [[UIApplication sharedApplication] cancelLocalNotification:notification];
    }
}


//官方推荐判断系统设备的方法
-(NSInteger)DeviceSystemMajorVersion {
    static NSUInteger _deviceSystemMajorVersion = -1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion]
                                       componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
    });
    return _deviceSystemMajorVersion;
}
@end
