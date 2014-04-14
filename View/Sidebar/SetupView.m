//
//  SetupView.m
//  Canlendar
//
//  Created by ruyicai on 13-1-2.
//  Copyright (c) 2013年 beyondsoft. All rights reserved.
//

#import "SetupView.h"
#import "CanlendarViewController.h"
#import "SidebarViewController.h"
#import "Common.h"
#import "UMFeedback.h"
#import "AboutViewController.h"
/*
 反馈建议 以邮件的形式 发送到我的 google 邮箱 nicolasi.wei@gmail.com
 */
#import "ToDoViewController.h"
#import "CanlendarAppDelegate.h"
@implementation SetupView
@synthesize mainView, delegate;
@synthesize susperViewController = m_susperViewController;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([delegate respondsToSelector:@selector(rightSideBarSelectWithController:)]) {
        [delegate leftSideBarSelectWithController:[self subConWithIndex:0]];
//        _selectIdnex = 0;
    }
 
    mainView.frame = CGRectMake(47, 0, 273, [UIScreen mainScreen].bounds.size.height);
    mainView.delegate = self;
    mainView.scrollEnabled = YES;
    mainView.contentSize = CGSizeMake(273, 568);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
 
}

- (IBAction) todoButtonPress:(id)sender
{
    [m_susperViewController moveAnimationWithDirection:SideBarShowDirectionNone duration:MoveAnimationDuration];
 
    ToDoViewController* viewController = [[[ToDoViewController alloc] initWithNibName:@"ToDoViewController" bundle:[NSBundle mainBundle]] autorelease];
    
    if ([self respondsToSelector:@selector(presentViewController:animated:completion:)]) {
        [self presentViewController:viewController animated:YES completion:nil];
    }else{
        [self presentModalViewController:viewController animated:YES];
    }
 
    
//    在调用时判断一下
//    
//    同理，dismiss时也是类似操作
//    [cpp]
//    if ([self respondsToSelector:@selector(dismissViewControllerAnimated:completion:)]) {
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }else{
//        [self dismissModalViewControllerAnimated:YES];
//    }
    
 
//    [self presentViewController:<#(UIViewController *)#> animated:<#(BOOL)#> completion:^(void){}];
//    [self presentViewController:viewController animated:YES completion:nil animated:YES];
//
//    [self presentModalViewController:viewController animated:YES];
    
//    CanlendarAppDelegate *m_delegate = (CanlendarAppDelegate*)[[UIApplication sharedApplication] delegate];
//    m_delegate.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
//    m_delegate.window.rootViewController = viewController;
//    [m_delegate.window makeKeyAndVisible];
 
    
}



- (UINavigationController *)subConWithIndex:(int)index
{
    CanlendarViewController *con = [[[CanlendarViewController alloc] initWithNibName:@"CanlendarViewController" bundle:nil] autorelease];
    UINavigationController *nav= [[[UINavigationController alloc] initWithRootViewController:con] autorelease];
    nav.navigationBar.hidden = YES;
    return nav ;
}

#pragma mark xib 按钮方法

-(IBAction) feedBack:(id)sender
{
    [UMFeedback showFeedback:self withAppkey:KUMengAppkey];
//    [UMFeedback showFeedback:(UIViewController *)viewController withAppkey:(NSString *)appKey];
    
//    [self addEmail];
}
- (IBAction) aboutUsPress:(id)sender
{
    AboutViewController* view = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:[NSBundle mainBundle]];
    if ([self respondsToSelector:@selector(presentViewController:animated:completion:)]) {
        [self presentViewController:view animated:YES completion:^(void){}];
    }else{
        [self presentModalViewController:view animated:YES];
 
    }
    [view release];

}
//检测邮箱 是否配置
-(void)addEmail{
    
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    
    if (mailClass != nil){
        
        if ([mailClass canSendMail]){
            
            [self displayComposerSheet];
            
        }else{
            
            [self launchMailAppOnDevice];
            
        }
        
    }else{
        
        [self launchMailAppOnDevice];
        
    }
 
}
-(void) displayComposerSheet
{
    //    一、创建视图控制器：
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    //    二、设置邮件主题：
    [mc setSubject:@"随身日历，用户留言反馈"];
    
    //    三、设置收件人，收件人有三种：
    //    1、设置主收件人
    [mc setToRecipients:[NSArray arrayWithObjects:@"nicolasi.wei@gmail.com"/*,
                                                                            "@dave@iphonedevbook.com"*/, nil]];
    //     2、设置cc 抄送
//    [mc setCcRecipients:[NSArray arrayWithObject:@"wll-coolcool@163.com"]];
    //     3、设置bcc 密送
//    [mc setBccRecipients:[NSArray arrayWithObject:@"1040144237@qq.com"]];
    
    //     四、设置邮件主体，有两种格式。
    //     一种是纯文本
    
    [mc setMessageBody:@"关于 随身日历 的一些意见：" isHTML:NO];
    
    //     一个是html格式
    //     [mc setMessageBody:@"<HTML><B>Hello, Joe!</B><BR/>What do you know?</HTML>"
    //                 isHTML:YES];
    
    ////     五、添加附件
    ////     添加附件需要三个参数，一个是NSData类型的附件，一个是mime type，一个附件的名称。
    //     NSString *path = [[NSBundle mainBundle] pathForResource:@"blood_orange" ofType:@"png"];
    //     NSData *data = [NSData dataWithContentsOfFile:path];
    //     [mc addAttachmentData:data mimeType:@"image/png" fileName:@"blood_orange"];
    
    //     六、视图呈现
    [self presentModalViewController:mc animated:YES];
    [mc release];
}
-(void) launchMailAppOnDevice
{
    UIAlertView* isEmailalert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"请配置您的邮箱" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好的",nil];
    
    [isEmailalert show];
    [isEmailalert release];
}
//回调方法
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result  error:(NSError*)error
{
    NSString *msg;
 
    switch (result)
    {
             
        case MFMailComposeResultCancelled:
            msg = @"邮件发送取消";
            break;
        case MFMailComposeResultSaved:
            msg = @"邮件保存成功";
            break;
        case MFMailComposeResultSent:
            msg = @"邮件发送成功";
            break;
        case MFMailComposeResultFailed:
            msg = @"邮件发送失败";
            break;
        default:
            break;
            
    } 
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"邮件发送提示"
													message:msg
												   delegate:self
										  cancelButtonTitle:nil
										  otherButtonTitles:@"确定", nil];
	[alert show];
	[alert release];
    
    [self dismissModalViewControllerAnimated:YES];
    
}

@end
