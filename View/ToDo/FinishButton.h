//
//  FinishButton.h
//  Canlendar
//
//  Created by ruyicai on 13-1-10.
//  Copyright (c) 2013年 beyondsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinishButton : UIButton
{
    NSMutableArray*         m_finishEventArray;
    UILabel*                m_countLable;
}
-(NSInteger) subCount;
-(void) addSubEvent:(NSDictionary*)finishEvent;
-(void) removeSubEvent:(NSInteger)index;
-(void) refreshButton;
@end
