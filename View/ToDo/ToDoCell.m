//
//  ToDoCell.m
//  Canlendar
//
//  Created by ruyicai on 13-1-10.
//  Copyright (c) 2013年 beyondsoft. All rights reserved.
//

#import "ToDoCell.h"
#import "Common.h"
#import "AddEventViewController.h"
#import "CanlendarAppDelegate.h"
@interface ToDoCell (inter)
-(void) finishButton;
@end


@implementation ToDoCell
@synthesize data = m_data;
@synthesize isFinish = m_isFinish;
@synthesize susperViewcontroller = m_susperViewcontroller;
@synthesize susperFinishViewcontroller = m_susperFinishViewcontroller;
@synthesize userIndex = m_userIndex;
@synthesize isFinishEvent = m_isFinishEvent;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIImageView* bgview = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 290, 45)] autorelease];
        bgview.image = [UIImage imageNamed:@"todotablecellbg.png"];
        [self addSubview:bgview];
        
        m_finishButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 28, 28)];
        [m_finishButton addTarget:self action: @selector(finishButton) forControlEvents:UIControlEventTouchUpInside];
        [m_finishButton setImage:[UIImage imageNamed:@"todocheckbox_normal.png"] forState:UIControlStateNormal];
        [m_finishButton setImage:[UIImage imageNamed:@"todocheckbox_normal.png"] forState:UIControlStateHighlighted];
        m_finishButton.showsTouchWhenHighlighted = TRUE;
        [self addSubview:m_finishButton];
 
        m_titleLable = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 200, 30)];
        m_titleLable.textAlignment = UITextAlignmentLeft;
        m_titleLable.backgroundColor = [UIColor clearColor];
        m_titleLable.font = [UIFont systemFontOfSize:15];
        [self addSubview:m_titleLable];
 
        m_timeLable = [[UILabel alloc] initWithFrame:CGRectMake(80, 25, 200, 15)];
        m_timeLable.textAlignment = UITextAlignmentLeft;
        m_timeLable.backgroundColor = [UIColor clearColor];
        m_timeLable.textColor = [UIColor grayColor];
        m_timeLable.font = [UIFont systemFontOfSize:12];
        [self addSubview:m_timeLable];
        
        UIImageView* view = [[[UIImageView alloc] initWithFrame:CGRectMake(265, 15, 8, 25/2)] autorelease];
        view.image = [UIImage imageNamed:@"todosanjiao.png"];
        [self addSubview:view];
        
    }
    return self;
}
 
-(void) refreshCell
{
    if (m_isFinish) {
        [m_finishButton setImage:[UIImage imageNamed:@"todocheckbox_select.png"] forState:UIControlStateNormal];
        [m_finishButton setImage:[UIImage imageNamed:@"todocheckbox_select.png"] forState:UIControlStateHighlighted];
    }
    else
    {
        [m_finishButton setImage:[UIImage imageNamed:@"todocheckbox_normal.png"] forState:UIControlStateNormal];
        [m_finishButton setImage:[UIImage imageNamed:@"todocheckbox_normal.png"] forState:UIControlStateHighlighted];
    }
    if (m_data != nil) {
        m_titleLable.text = [m_data objectForKey:KToDo_Title];
        if ([[m_data objectForKey:KToDo_Notice] isEqualToString:@"true"]) {
 
            m_timeLable.text = [(CanlendarAppDelegate*)[[UIApplication sharedApplication] delegate] getTime_byNSdate:[m_data objectForKey:KToDo_NoticeTime]];
        }
        else{
            m_timeLable.text = @"";
        }
    }
 
}
-(void) finishButton
{
    if (m_isFinish) {
        [m_finishButton setImage:[UIImage imageNamed:@"todocheckbox_normal.png"] forState:UIControlStateNormal];
        [m_finishButton setImage:[UIImage imageNamed:@"todocheckbox_normal.png"] forState:UIControlStateHighlighted];
    }
    else
    {
        [m_finishButton setImage:[UIImage imageNamed:@"todocheckbox_select.png"] forState:UIControlStateNormal];
        [m_finishButton setImage:[UIImage imageNamed:@"todocheckbox_select.png"] forState:UIControlStateHighlighted];
    }
    m_isFinish = !m_isFinish;
    
    if (m_isFinishEvent) {
        [m_susperFinishViewcontroller finishButtonPress:m_isFinish INDEX:m_userIndex DATA:m_data];
    }
    else
    {
        [m_susperViewcontroller finishButtonPress:m_isFinish INDEX:m_userIndex DATA:m_data];    
    }
}
@end
