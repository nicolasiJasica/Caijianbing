//
//  AboutViewController.h
//  Canlendar
//
//  Created by ruyicai on 13-1-28.
//  Copyright (c) 2013年 beyondsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController<UIScrollViewDelegate>
{
    UIScrollView* mainView;
}
@property (strong,nonatomic)IBOutlet UIScrollView *mainView;
- (IBAction) comeBack:(id)sender;
@end


 
//DelegateObject.h
@protocol DelegateProtocol;
@interface DelegateObject : NSObject
@property(strong,nonatomic)id<DelegateProtocol> delegate;
@end
@protocol DelegateProtocol<NSObject>
-(void)print;
@end


//DelegateInvoker.h
@interface DelegateInvoker : NSObject<DelegateProtocol>
@property(strong, nonatomic)DelegateObject* delegateObject;
@end
//DelegateInvoker.m
 
