//
//  SetupView.h
//  Canlendar
//
//  Created by ruyicai on 13-1-2.
//  Copyright (c) 2013年 beyondsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@protocol SideBarSelectDelegate;
@class SidebarViewController;
@interface SetupView : UIViewController<UIScrollViewDelegate,MFMailComposeViewControllerDelegate>
{

    SidebarViewController* m_susperViewController;
}
@property (nonatomic,retain) SidebarViewController* susperViewController;
@property (strong,nonatomic)IBOutlet UIScrollView *mainView;
@property (assign,nonatomic)id<SideBarSelectDelegate>delegate;
- (IBAction) todoButtonPress:(id)sender;
- (IBAction) aboutUsPress:(id)sender;
@end
