//
//  AdviceCell_2.m
//  Canlendar
//
//  Created by ruyicai on 13-1-17.
//  Copyright (c) 2013年 beyondsoft. All rights reserved.
//

#import "AdviceCell_2.h"
#import "CanlendarAppDelegate.h"
#import "Common.h"
@implementation AdviceCell_2
 
@synthesize adviceDate = m_adviceDate;
@synthesize isAdvice = m_isAdvice;
@synthesize susperViewController = m_susperViewController;
-(void)dealloc
{
    [m_timeLable release];
    [m_NoAdvieLable release];
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UILabel* m_titleLable = [[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 60, 30)] autorelease];
        m_titleLable.textAlignment = UITextAlignmentLeft;
        m_titleLable.backgroundColor = [UIColor clearColor];
        m_titleLable.font = [UIFont systemFontOfSize:15];
        m_titleLable.text = @"提醒我";
        m_titleLable.textColor = [UIColor lightGrayColor];
        [self addSubview:m_titleLable];
        
        m_NoAdvieLable = [[UILabel alloc] initWithFrame:CGRectMake(170, 15, 80, 20)];
        m_NoAdvieLable.textAlignment = UITextAlignmentRight;
        m_NoAdvieLable.backgroundColor = [UIColor clearColor];
        m_NoAdvieLable.textColor = [UIColor grayColor];
        m_NoAdvieLable.text = @"不提醒";
        m_NoAdvieLable.font = [UIFont systemFontOfSize:12];
        [self addSubview:m_NoAdvieLable];
        m_NoAdvieLable.hidden = YES;
        
        m_timeLable = [[UILabel alloc] initWithFrame:CGRectMake(90, 20, 200, 20)];
        m_timeLable.textAlignment = UITextAlignmentLeft;
        m_timeLable.backgroundColor = [UIColor clearColor];
        m_titleLable.textColor = [UIColor grayColor];
        m_timeLable.font = [UIFont systemFontOfSize:12];
        [self addSubview:m_timeLable];
        
        
        UIImageView* view = [[[UIImageView alloc] initWithFrame:CGRectMake(260, 15, 8, 25/2)] autorelease];
        view.image = [UIImage imageNamed:@"todosanjiao.png"];
        [self addSubview:view];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
 
}
 

-(void) refreshCell
{
    if (m_isAdvice) {
        m_timeLable.hidden = NO;
        m_NoAdvieLable.hidden = YES;
        if (m_adviceDate == nil) {
            return;
        }
        m_timeLable.text = [(CanlendarAppDelegate*)[[UIApplication sharedApplication] delegate] getTime_byNSdate:m_adviceDate];
    }
    else
    {
        m_NoAdvieLable.hidden = NO;
        m_timeLable.hidden = YES;
    }
}
 

@end
