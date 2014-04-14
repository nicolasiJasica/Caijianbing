//
//  RuYiCaiStartViewController.h
//  RuYiCai
//
//  Created by LiTengjie on 11-8-3.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StartView.h"

@class CanlendarAppDelegate;
@interface StartViewController : UIViewController {
	StartView *m_startView;
    CanlendarAppDelegate *m_delegate;
}

- (void)showLoading:(id)sender;

@end
