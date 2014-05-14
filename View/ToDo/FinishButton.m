//
//  FinishButton.m
//  Canlendar
//
//  Created by ruyicai on 13-1-10.
//  Copyright (c) 2013年 beyondsoft. All rights reserved.
//

#import "FinishButton.h"
#import "Common.h"
@implementation FinishButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSMutableArray* array = (NSMutableArray*)[[NSUserDefaults standardUserDefaults] objectForKey:KToDo_finishEvent];
        m_finishEventArray = [[NSMutableArray alloc] initWithArray:array];
 
        m_countLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 30)];
        m_countLable.text = [NSString stringWithFormat:@"%d", [m_finishEventArray count]];
        //uilable 加阴影
        m_countLable.shadowColor = [UIColor blackColor];
        m_countLable.shadowOffset = CGSizeMake(0.0f, 1.0f);
//        //加粗;
//        [UILabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
        
        m_countLable.textAlignment = UITextAlignmentCenter;
        m_countLable.backgroundColor = [UIColor clearColor];
        m_countLable.textColor = [UIColor grayColor];
        m_countLable.font = [UIFont systemFontOfSize:18];
        [self addSubview:m_countLable];
 
        UILabel* tip = [[[UILabel alloc] initWithFrame:CGRectMake(80, 10, 200, 30)] autorelease];
        tip.text = @"已完成";
        tip.textAlignment = UITextAlignmentLeft;
        tip.backgroundColor = [UIColor clearColor];
        tip.textColor = [UIColor grayColor];
        tip.font = [UIFont systemFontOfSize:15];
        [self addSubview:tip];
 
        UIImageView* view = [[[UIImageView alloc] initWithFrame:CGRectMake(275, 15 + 5, 8, 25/2)] autorelease];
        view.image = [UIImage imageNamed:@"todosanjiao.png"];
        [self addSubview:view];
    }
    return self;
}

-(NSInteger) subCount
{
    return [m_finishEventArray count];
}
-(void) addSubEvent:(NSDictionary*)finishEvent
{
    if (m_finishEventArray == Nil) {
        NSMutableArray* array = (NSMutableArray*)[[NSUserDefaults standardUserDefaults] objectForKey:KToDo_finishEvent];
        m_finishEventArray = [[[NSMutableArray alloc] initWithArray:array] autorelease];
    }
    if (finishEvent != Nil) {
        [m_finishEventArray addObject:finishEvent];
    }
    [[NSUserDefaults standardUserDefaults] setObject:m_finishEventArray forKey:KToDo_finishEvent];
    [[NSUserDefaults standardUserDefaults] synchronize];//tongbu
}
-(void) removeSubEvent:(NSInteger)index
{
    if (index < [m_finishEventArray count]) {
        [m_finishEventArray removeObjectAtIndex:index];
        [[NSUserDefaults standardUserDefaults] setObject:m_finishEventArray forKey:KToDo_finishEvent];
        [[NSUserDefaults standardUserDefaults] synchronize];//tongbu
    }
}
-(void) refreshButton
{
    NSMutableArray* array = (NSMutableArray*)[[NSUserDefaults standardUserDefaults] objectForKey:KToDo_finishEvent];
    [m_finishEventArray release];
    m_finishEventArray = [[NSMutableArray alloc] initWithArray:array];
    
    m_countLable.text = [NSString stringWithFormat:@"%d", [m_finishEventArray count]];
}
-(void)dealloc
{
    [m_finishEventArray release];
    [m_countLable release];
    [super dealloc];
}
@end
