//
//  AdviceCell_2.h
//  Canlendar
//
//  Created by ruyicai on 13-1-17.
//  Copyright (c) 2013年 beyondsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
 #import "AddEventViewController.h"
@interface AdviceCell_2 : UITableViewCell
{
    BOOL                                m_isAdvice;
    NSDate                              *m_adviceDate;
    
    UILabel*                            m_timeLable;
    UILabel*                            m_NoAdvieLable;
    AddEventViewController*             m_susperViewController;
}
@property(nonatomic,retain) AddEventViewController* susperViewController;
@property(nonatomic,retain) NSDate* adviceDate;
@property(nonatomic,assign) BOOL isAdvice;

-(void) refreshCell;
@end