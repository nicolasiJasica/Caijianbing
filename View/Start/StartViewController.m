//
//  RuYiCaiStartViewController.m
//  RuYiCai
//
//  Created by LiTengjie on 11-8-3.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
/*
 开机加载页面 用于显示 loading 图片 以及 启动 新功能介绍页面
 */
#import "StartViewController.h"
#import "StartView.h"
#import "NewFuctionIntroductionView.h"
#import "CanlendarAppDelegate.h"
#import "Common.h"
@implementation StartViewController
#define kStartViewShowTime  (1.0f) //开机页面 显示时长
- (void)viewDidLoad 
{
    [super viewDidLoad];

	self.view.backgroundColor = [UIColor clearColor] ;
	m_startView = [[StartView alloc] initWithFrame:/*[[UIScreen mainScreen] bounds]]*/
                   CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height - (iPhone5 ? 0 : 20))];//剪掉 statusBar的高度
	m_startView.hidden = NO;
	[self.view insertSubview:m_startView atIndex:0];
    
    m_delegate = (CanlendarAppDelegate*)[[UIApplication sharedApplication] delegate];
    [self performSelector:@selector(showLoading:) withObject:nil afterDelay:kStartViewShowTime];
    
}

- (void)showLoading:(id)sender
{
    [m_startView removeFromSuperview];
    [m_delegate showLoading:nil];
//    //安装后 首次进入 才有 
//    if ([m_delegate isShowNewFuctionInfo])
//    {
//        [m_delegate showLoading:nil];
//    }
//    else
//    {
//        //调用 新功能介绍页面
//        NewFuctionIntroductionView* m_newFuctionInfoView = [[NewFuctionIntroductionView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//        m_newFuctionInfoView.hidden = NO;
//        m_newFuctionInfoView.delegate = m_delegate;
//        [self.view addSubview:m_newFuctionInfoView];
//        [m_newFuctionInfoView release];
//        if([appStoreORnormal isEqualToString: @"appStore"])
//        {
//            UIAlertView*  alter = [[UIAlertView alloc] 
//                                   initWithTitle:@"尊敬的用户" 
//                                   message:@"如意彩客户端将访问您的设备识别符" 
//                                   delegate:self 
//                                   cancelButtonTitle:@"确定" 
//                                   otherButtonTitles:nil];
//            [alter show];
//            [alter release];
//        }
//    }   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
}

- (void)dealloc 
{
	[m_startView release];
	[super dealloc];
}
@end