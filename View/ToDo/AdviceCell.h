//
//  AdviceCell.h
//  Canlendar
//
//  Created by ruyicai on 13-1-14.
//  Copyright (c) 2013年 beyondsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetAdviceViewController.h"
@interface AdviceCell : UITableViewCell
{
    BOOL                                m_isAdvice;
    NSDate                              *m_adviceDate;
    UISwitch*                           m_swith;
    SetAdviceViewController*            m_susperViewController;
}
@property(nonatomic,retain) SetAdviceViewController* susperViewController;
@property(nonatomic,retain) NSDate* adviceDate;
@property(nonatomic,assign) BOOL isAdvice;

-(void) refreshCell;
@end