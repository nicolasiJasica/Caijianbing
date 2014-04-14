//
//  ToDoCell.h
//  Canlendar
//
//  Created by ruyicai on 13-1-10.
//  Copyright (c) 2013年 beyondsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoViewController.h"
#import "FinishViewController.h"
@interface ToDoCell : UITableViewCell
{
    UIButton*                           m_finishButton;
    BOOL                                m_isFinish;
    
    NSDictionary*                       m_data;
    
    UILabel*                            m_titleLable;
    UILabel*                            m_timeLable;
    
    NSInteger                           m_userIndex;
    BOOL                                m_isFinishEvent;
    
    ToDoViewController*                 m_susperViewcontroller;
    FinishViewController*               m_susperFinishViewcontroller;
}
@property(nonatomic,retain) ToDoViewController* susperViewcontroller;
@property(nonatomic,retain) FinishViewController* susperFinishViewcontroller;
@property(nonatomic,retain) NSDictionary* data;
@property(nonatomic,assign) BOOL isFinish;
@property(nonatomic,assign) BOOL isFinishEvent;
@property(nonatomic,assign) NSInteger userIndex;
-(void) refreshCell;


@end
