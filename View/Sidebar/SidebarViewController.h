//
//  ViewController.h
//  SideBarNavDemo
//
//  Created by JianYe on 12-12-11.
//  Copyright (c) 2012年 JianYe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideBarSelectedDelegate.h"

@class SetupView;
@interface SidebarViewController : UIViewController<SideBarSelectDelegate,UINavigationControllerDelegate>
{
    UIViewController  *_currentMainController;
    UITapGestureRecognizer *_tapGestureRecognizer;//主页点击手势
    //    UIPanGestureRecognizer *_panGestureReconginzer;//滑动的手势
    BOOL sideBarShowing;
    CGFloat currentTranslate;
}
@property (strong,nonatomic)SetupView *rightSideBarViewController;
 
@property (strong,nonatomic)IBOutlet UIView *contentView;
@property (strong,nonatomic)IBOutlet UIView *navBackView;

+ (id)share;
- (void)moveAnimationWithDirection:(SideBarShowDirection)direction duration:(float)duration;
-(BOOL) getSideBarShowing;
@end
