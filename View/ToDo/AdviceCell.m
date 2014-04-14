//
//  AdviceCell.m
//  Canlendar
//
//  Created by ruyicai on 13-1-14.
//  Copyright (c) 2013年 beyondsoft. All rights reserved.
//

#import "AdviceCell.h"
#import "CanlendarAppDelegate.h"
#import "Common.h"

@implementation AdviceCell
@synthesize adviceDate = m_adviceDate;
@synthesize isAdvice = m_isAdvice;
@synthesize susperViewController = m_susperViewController;
-(void)dealloc
{
    [m_swith release];
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code   
        UILabel* m_titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 60, 30)];
        m_titleLable.textAlignment = UITextAlignmentLeft;
        m_titleLable.backgroundColor = [UIColor clearColor];
        m_titleLable.font = [UIFont systemFontOfSize:15];
        m_titleLable.text = @"提醒我";
        m_titleLable.textColor = [UIColor lightGrayColor];
        [self addSubview:m_titleLable];
        
        m_swith = [[UISwitch alloc] initWithFrame:CGRectMake(210, 8, 79, 27)];
        m_swith.on = NO;
        m_swith.hidden = YES;
        [m_swith addTarget:self action:@selector(pressSwitch:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:m_swith];
 
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)pressSwitch:(id)sender
{
    UISwitch *temp = (UISwitch *)sender;
    
    if (temp.on) {
        m_isAdvice = YES;
    }
    else
    {
        m_isAdvice = NO;
        m_adviceDate = nil;
        [self refreshCell];
    }
    [m_susperViewController adviceButtonPress:m_isAdvice];
}

-(void) refreshCell
{
    if (m_isAdvice) {
        m_swith.hidden = NO;
        m_swith.on = YES;
    }
    else
    {
        m_swith.hidden = NO;
        m_swith.on = NO;
    }
    
}
 
@end

