//
//  CalendarView.m
//  ZhangBen
//
//  Created by tinyfool on 08-10-26.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "TdCalendarView.h"
#import <QuartzCore/QuartzCore.h>
#import "Common.h"
const float headHeight=50;
const float itemHeight=37;
const float prevNextButtonSize=10;
const float prevNextButtonSpaceWidth=80;
const float prevNextButtonSpaceHeight=5 + 3;
const float titleFontSize=20;
const int	weekFontSize=12;
const int	dateFontSize=18;

@implementation TdCalendarView

@synthesize currentMonthDate;
@synthesize currentSelectDate;
@synthesize currentTime;
@synthesize viewImageView;
@synthesize calendarViewDelegate;
 
-(void)initCalView{
	currentTime=CFAbsoluteTimeGetCurrent();
	currentMonthDate=CFAbsoluteTimeGetGregorianDate(currentTime,CFTimeZoneCopyDefault());
//	currentMonthDate.day=1;
	currentSelectDate.year = 0;
	monthFlagArray=malloc(sizeof(int)*31);
	[self clearAllDayFlag];
    
    cal = [[Cal alloc] init];
    
    /*
     2013
     节日 	放假时间   	调休上班日期               	放假天数
     元旦 	1月1日~3日 	1月5日（周六）、1月6日（周日） 	3天
     春节 	2月9日~15日 	2月16日（周六）、2月17日（周日） 	7天
     清明节 	4月4日~6日 	4月7日（周日） 	3天
     劳动节 	4月29日~5月1日 	4月27日（周六）、4月28日（周日） 	3天
     端午节 	6月10日~12日 	6月8日（周六）、6月9日（周日） 	3天
     中秋节 	9月19日~21日 	9月22日（周日） 	3天
     国庆节 	10月1日~7日 	9月29日（周日）、10月12日（周六） 	7天
     */
 
    m_holidayArray = [[NSMutableArray alloc] initWithCapacity:5];
    
    
    holiday_2013 = [[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"1-1"],[NSString stringWithFormat:@"1-2"],[NSString stringWithFormat:@"1-3"]
                    ,[NSString stringWithFormat:@"2-9"],[NSString stringWithFormat:@"2-10"],[NSString stringWithFormat:@"2-11"],[NSString stringWithFormat:@"2-12"],[NSString stringWithFormat:@"2-13"],[NSString stringWithFormat:@"2-14"],[NSString stringWithFormat:@"2-15"]
                    
                    ,[NSString stringWithFormat:@"4-4"],[NSString stringWithFormat:@"4-5"],[NSString stringWithFormat:@"4-6"]
                    
                    ,[NSString stringWithFormat:@"4-29"],[NSString stringWithFormat:@"4-30"],[NSString stringWithFormat:@"5-1"]
                    
                    ,[NSString stringWithFormat:@"6-10"],[NSString stringWithFormat:@"6-11"],[NSString stringWithFormat:@"6-12"]
                    
                    ,[NSString stringWithFormat:@"9-19"],[NSString stringWithFormat:@"9-20"],[NSString stringWithFormat:@"9-21"]
                    
                    ,[NSString stringWithFormat:@"10-1"],[NSString stringWithFormat:@"10-2"],[NSString stringWithFormat:@"10-3"],[NSString stringWithFormat:@"10-4"],[NSString stringWithFormat:@"10-5"],[NSString stringWithFormat:@"10-6"],[NSString stringWithFormat:@"10-7"]
                    
                    ,nil];
    workDay_2013 = [[NSArray alloc]initWithObjects:
                    [NSString stringWithFormat:@"1-5"],[NSString stringWithFormat:@"1-6"]
                    
                    ,[NSString stringWithFormat:@"2-16"],[NSString stringWithFormat:@"2-17"]
                    
                    ,[NSString stringWithFormat:@"4-7"] 
                    
                    ,[NSString stringWithFormat:@"4-27"],[NSString stringWithFormat:@"4-28"]
                    
                    ,[NSString stringWithFormat:@"6-8"],[NSString stringWithFormat:@"6-9"]
                    
                    ,[NSString stringWithFormat:@"9-22"] 
                    
                    ,[NSString stringWithFormat:@"9-29"]
                    ,nil];
 
    /*
     2014
     节日 	放假时间   	调休上班日期               	放假天数
     元旦	1月1日        无                           1天
     春节	1月31日~2月6日 1月26日（周日）、2月8日（周六）	7天
     清明节	4月5日~7日     无                           3天
     劳动节	5月1日~3日     5月4日（周日）                    3天
     端午节	5月31日~6月2日	无                           3天
     中秋节	9月6日~8日         无                               3天
     国庆节	10月1日~7日        9月28日（周日）、10月11日（周六）	7天
     */
    holiday_2014 = [[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"1-1"]
                    ,[NSString stringWithFormat:@"1-31"],[NSString stringWithFormat:@"2-1"],[NSString stringWithFormat:@"2-2"],[NSString stringWithFormat:@"2-3"],[NSString stringWithFormat:@"2-4"],[NSString stringWithFormat:@"2-5"],[NSString stringWithFormat:@"2-6"]
                    
                    ,[NSString stringWithFormat:@"4-5"],[NSString stringWithFormat:@"4-6"],[NSString stringWithFormat:@"4-7"]
                    
                    ,[NSString stringWithFormat:@"5-1"],[NSString stringWithFormat:@"5-2"],[NSString stringWithFormat:@"5-3"]
                    
                    ,[NSString stringWithFormat:@"5-31"],[NSString stringWithFormat:@"6-1"],[NSString stringWithFormat:@"6-2"]
                    
                    ,[NSString stringWithFormat:@"9-6"],[NSString stringWithFormat:@"9-7"],[NSString stringWithFormat:@"9-8"]
                    
                    ,[NSString stringWithFormat:@"10-1"],[NSString stringWithFormat:@"10-2"],[NSString stringWithFormat:@"10-3"],[NSString stringWithFormat:@"10-4"],[NSString stringWithFormat:@"10-5"],[NSString stringWithFormat:@"10-6"],[NSString stringWithFormat:@"10-7"]
                    
                    ,nil];
    
    workDay_2014 = [[NSArray alloc]initWithObjects:
                    [NSString stringWithFormat:@"1-26"],[NSString stringWithFormat:@"2-8"]
 
                    ,[NSString stringWithFormat:@"5-4"] 
 
                    ,[NSString stringWithFormat:@"9-28"]
                    
                    ,[NSString stringWithFormat:@"10-11"]
                    ,nil];
    
    
//    //手势
//    UISwipeGestureRecognizer* recognizer1 = [[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)] autorelease];
//    [recognizer1 setDirection:(UISwipeGestureRecognizerDirectionRight)];
//    [self addGestureRecognizer:recognizer1];
// 
//    UISwipeGestureRecognizer* recognizer2 = [[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)] autorelease];
//    [recognizer2 setDirection:(UISwipeGestureRecognizerDirectionLeft)];
//    [self addGestureRecognizer:recognizer2];
    //-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    //
    ////    if(recognizer.direction==UISwipeGestureRecognizerDirectionDown) {
    ////        NSLog(@"swipe down");
    ////        //执行程序
    ////    }
    ////
    ////    if(recognizer.direction==UISwipeGestureRecognizerDirectionUp) {
    ////        NSLog(@"swipe up");
    ////        //执行程序
    ////    }
    //}
    
}
- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
		[self initCalView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
	
	if (self = [super initWithFrame:frame]) {
		[self initCalView];
	}
	return self;
}

-(int)getDayCountOfaMonth:(CFGregorianDate)date{
	switch (date.month) {
		case 1:
		case 3:
		case 5:
		case 7:
		case 8:
		case 10:
		case 12:
			return 31;
			
		case 2:
			if((date.year%4==0 && date.year%100!=0)|| date.year % 400==0)
				return 29;
			else
				return 28;
		case 4:
		case 6:
		case 9:		
		case 11:
			return 30;
		default:
			return 31;
	}
}

-(void)drawPrevButton:(CGPoint)leftTop
{
	CGContextRef ctx=UIGraphicsGetCurrentContext();
	CGContextSetGrayStrokeColor(ctx,0,1);
	CGContextMoveToPoint	(ctx,  0 + leftTop.x, prevNextButtonSize/2 + leftTop.y);
	CGContextAddLineToPoint	(ctx, prevNextButtonSize + leftTop.x,  0 + leftTop.y);
	CGContextAddLineToPoint	(ctx, prevNextButtonSize + leftTop.x,  prevNextButtonSize + leftTop.y);
	CGContextAddLineToPoint	(ctx,  0 + leftTop.x,  prevNextButtonSize/2 + leftTop.y);
	CGContextFillPath(ctx);
}

-(void)drawNextButton:(CGPoint)leftTop
{
	CGContextRef ctx=UIGraphicsGetCurrentContext();
	CGContextSetGrayStrokeColor(ctx,0,1);
	CGContextMoveToPoint	(ctx,  0 + leftTop.x,  0 + leftTop.y);
	CGContextAddLineToPoint	(ctx, prevNextButtonSize + leftTop.x,  prevNextButtonSize/2 + leftTop.y);
	CGContextAddLineToPoint	(ctx,  0 + leftTop.x,  prevNextButtonSize + leftTop.y);
	CGContextAddLineToPoint	(ctx,  0 + leftTop.x,  0 + leftTop.y);
	CGContextFillPath(ctx);
}
-(int)getDayFlag:(int)day
{
	if(day>=1 && day<=31)
	{
		return *(monthFlagArray+day-1);
	}
	else 
		return 0;
}
-(void)clearAllDayFlag
{
	memset(monthFlagArray,0,sizeof(int)*31);
}
-(void)setDayFlag:(int)day flag:(int)flag
{
	if(day>=1 && day<=31)
	{
		if(flag>0)
			*(monthFlagArray+day-1)=1;
		else if(flag<0)
			*(monthFlagArray+day-1)=-1;
	}
	
}
-(void)drawTopGradientBar{
	
//	CGContextRef ctx=UIGraphicsGetCurrentContext();
//	
//	size_t num_locations = 3;
//	CGFloat locations[3] = { 0.0, 0.0, 0.0};
//    CGFloat components[8] = {  
//		0.f / 255.f, 137.f / 225.f, 217.f / 255.f, 1.f,
//		0.f / 255.f, 172.f / 225.f, 217.f / 255.f, 1.f,
//	};
//	CGGradientRef myGradient;
//	CGColorSpaceRef myColorspace = CGColorSpaceCreateDeviceRGB();
//	myGradient = CGGradientCreateWithColorComponents (myColorspace, components,
//													  locations, num_locations);
//	CGPoint myStartPoint, myEndPoint;
//	myStartPoint.x = headHeight;
//	myStartPoint.y = 0.0;
//	myEndPoint.x = headHeight;
//	myEndPoint.y = headHeight;
//	
//	CGContextDrawLinearGradient(ctx,myGradient,myStartPoint, myEndPoint, 0);
//	CGGradientRelease(myGradient);

	[self drawPrevButton:CGPointMake(prevNextButtonSpaceWidth,prevNextButtonSpaceHeight)];
	[self drawNextButton:CGPointMake(self.frame.size.width-prevNextButtonSpaceWidth-prevNextButtonSize,prevNextButtonSpaceHeight)];
}



-(void)drawTopBarWords{
	int width=self.frame.size.width;
	int s_width=width/7;

	[[UIColor blackColor] set];
	NSString *title_Month   = [[NSString alloc] initWithFormat:@"%ld年%d月",currentMonthDate.year,currentMonthDate.month];
	
	int fontsize=[UIFont buttonFontSize];
    UIFont   *font    = [UIFont systemFontOfSize:titleFontSize];
	CGPoint  location = CGPointMake(width/2 -2.5*titleFontSize, 0);
    [title_Month drawAtPoint:location withFont:font];
	[title_Month release];
	
	
	UIFont *weekfont=[UIFont boldSystemFontOfSize:weekFontSize];
	fontsize+=3;
	fontsize+=8;
	
	[@"MON一" drawAtPoint:CGPointMake(s_width*0+6,fontsize) withFont:weekfont];
	[@"TUE二" drawAtPoint:CGPointMake(s_width*1+8,fontsize) withFont:weekfont];
	[@"WED三" drawAtPoint:CGPointMake(s_width*2+8,fontsize) withFont:weekfont];
	[@"THU四" drawAtPoint:CGPointMake(s_width*3+8,fontsize) withFont:weekfont];
	[@"FRI五" drawAtPoint:CGPointMake(s_width*4+8,fontsize) withFont:weekfont];
	[[UIColor redColor] set];
	[@"SAT六" drawAtPoint:CGPointMake(s_width*5+8,fontsize) withFont:weekfont];
	[@"SUN日" drawAtPoint:CGPointMake(s_width*6+8,fontsize) withFont:weekfont];
	[[UIColor blackColor] set];
	
}

-(void)drawGirdLines{
	
	CGContextRef ctx=UIGraphicsGetCurrentContext();
	int width=self.frame.size.width;
	int row_Count=([self getDayCountOfaMonth:currentMonthDate]+[self getMonthWeekday:currentMonthDate]-2)/7+1;

	
	int s_width=width/7;
	int tabHeight=row_Count*itemHeight+headHeight;

	CGContextSetGrayStrokeColor(ctx,0,1);
	CGContextMoveToPoint	(ctx,0,headHeight);
	CGContextAddLineToPoint	(ctx,0,tabHeight);
	CGContextStrokePath		(ctx);
	CGContextMoveToPoint	(ctx,width,headHeight);
	CGContextAddLineToPoint	(ctx,width,tabHeight);
	CGContextStrokePath		(ctx);
	
 
	for(int i=1;i<7;i++){
		CGContextSetGrayStrokeColor(ctx,1,1);
		CGContextMoveToPoint(ctx, i*s_width-1, headHeight);
		CGContextAddLineToPoint( ctx, i*s_width-1,tabHeight);
		CGContextStrokePath(ctx);
	}
	
	for(int i=0;i<row_Count+1;i++){
		CGContextSetGrayStrokeColor(ctx,1,1);
		CGContextMoveToPoint(ctx, 0, i*itemHeight+headHeight+3);
		CGContextAddLineToPoint( ctx, width,i*itemHeight+headHeight+3);
		CGContextStrokePath(ctx);
		
		CGContextSetGrayStrokeColor(ctx,0.3,1);
		CGContextMoveToPoint(ctx, 0, i*itemHeight+headHeight);
		CGContextAddLineToPoint( ctx, width,i*itemHeight+headHeight);
		CGContextStrokePath(ctx);
	}
	for(int i=1;i<7;i++){
		CGContextSetGrayStrokeColor(ctx,0.3,1);
		CGContextMoveToPoint(ctx, i*s_width+2, headHeight);
		CGContextAddLineToPoint( ctx, i*s_width+2,tabHeight);
		CGContextStrokePath(ctx);
	}
}


-(int)getMonthWeekday:(CFGregorianDate)date
{
	CFTimeZoneRef tz = CFTimeZoneCopyDefault();
	CFGregorianDate month_date;
	month_date.year=date.year;
	month_date.month=date.month;
	month_date.day=1;
	month_date.hour=0;
	month_date.minute=0;
	month_date.second=1;
	return (int)CFAbsoluteTimeGetDayOfWeek(CFGregorianDateGetAbsoluteTime(month_date,tz),tz);
}

-(void)drawDateWords{
	CGContextRef ctx=UIGraphicsGetCurrentContext();

	int width=self.frame.size.width;
	
	int dayCount=[self getDayCountOfaMonth:currentMonthDate];
	int day=0;
	int x=0;
	int y=0;
	int s_width=width/7;
	int curr_Weekday=[self getMonthWeekday:currentMonthDate];
	UIFont *weekfont=[UIFont boldSystemFontOfSize:dateFontSize];

	for(int i=1;i<dayCount+1;i++)
	{
		day=i+curr_Weekday-2;
		x=day % 7;
		y=day / 7;
        
        //放假  加班调休
        if (currentMonthDate.year == 2013) {
            NSString* currentDay = [NSString stringWithFormat:@"%d-%d",currentMonthDate.month,i];
            //假
            for (int i = 0; i < [holiday_2013 count]; i++) {
                if ([currentDay isEqualToString:[holiday_2013 objectAtIndex:i]]) {
                    
                    HolidayImageView* view = [[HolidayImageView alloc] initWithFrame:CGRectMake(x*s_width, y*itemHeight+headHeight, 20, 20)];
                    view.image = [UIImage imageNamed:@"holiday.png"];
                    view.backgroundColor = [UIColor clearColor];
                    [m_holidayArray addObject:view];
                    [self addSubview:view];
                }
            }
            //加班
            for (int i = 0; i < [workDay_2013 count]; i++) {
                if ([currentDay isEqualToString:[workDay_2013 objectAtIndex:i]]) {
                    HolidayImageView* view01 = [[HolidayImageView alloc] initWithFrame:CGRectMake(x*s_width, y*itemHeight+headHeight, 20, 20)];
                    view01.tag = 3000 + i;
                    view01.image = [UIImage imageNamed:@"workday.png"];
                    view01.backgroundColor = [UIColor clearColor];
                    [m_holidayArray addObject:view01];
                    [self addSubview:view01];
                }
            }
        }
        //放假  加班调休
        if (currentMonthDate.year == 2014) {
            NSString* currentDay = [NSString stringWithFormat:@"%d-%d",currentMonthDate.month,i];
            //假
            for (int i = 0; i < [holiday_2014 count]; i++) {
                if ([currentDay isEqualToString:[holiday_2014 objectAtIndex:i]]) {
                    
                    HolidayImageView* view = [[HolidayImageView alloc] initWithFrame:CGRectMake(x*s_width, y*itemHeight+headHeight, 20, 20)];
                    view.image = [UIImage imageNamed:@"holiday.png"];
                    view.backgroundColor = [UIColor clearColor];
                    [m_holidayArray addObject:view];
                    [self addSubview:view];
                }
            }
            //加班
            for (int i = 0; i < [workDay_2014 count]; i++) {
                if ([currentDay isEqualToString:[workDay_2014 objectAtIndex:i]]) {
                    HolidayImageView* view01 = [[HolidayImageView alloc] initWithFrame:CGRectMake(x*s_width, y*itemHeight+headHeight, 20, 20)];
                    view01.tag = 4000 + i;
                    view01.image = [UIImage imageNamed:@"workday.png"];
                    view01.backgroundColor = [UIColor clearColor];
                    [m_holidayArray addObject:view01];
                    [self addSubview:view01];
                }
            }
        }
        
 
        CGContextSetRGBFillColor(ctx, 0, 0, 0, 1);
		NSString *date=[[[NSString alloc] initWithFormat:@"%2d",i] autorelease];
        int nongli_year = 2013;
        int nongli_month = 1;
        int nongli_day = 1;
        NSString* string_nongli = [cal getLunarDateByKpDate:currentMonthDate.year kp_month:currentMonthDate.month kp_day:/*currentMonthDate.day*/i];
        NSArray* array_nongli = [string_nongli componentsSeparatedByString:@"|"];
        if ([array_nongli count] == 3) {
            nongli_year = [[array_nongli objectAtIndex:0] intValue];
            nongli_month = [[array_nongli objectAtIndex:1] intValue];
            nongli_day = [[array_nongli objectAtIndex:2] intValue];
        }
        NSString *dateNongLi = [NSString stringWithFormat:@"%@",[cal GetDay:nongli_month d:nongli_day]];
        
//        NSString *dateNongLi = [NSString stringWithFormat:@"%@",[cal GetDay:currentMonthDate.month d:i]];
        NSRange range;
        if (dateNongLi.length > 2) {
            range = NSMakeRange(2,dateNongLi.length - 2);
        }
        else
            range = NSMakeRange(0,dateNongLi.length);

        dateNongLi = [dateNongLi substringWithRange:range];
        
        [dateNongLi drawAtPoint:CGPointMake(x*s_width+7 + 20,y*itemHeight+headHeight+10) forWidth:25 withFont:[UIFont systemFontOfSize:8] lineBreakMode:NSLineBreakByWordWrapping];
        
		[date drawAtPoint:CGPointMake(x*s_width+7,y*itemHeight+headHeight+5) withFont:weekfont];
		if([self getDayFlag:i]==1)
		{
			CGContextSetRGBFillColor(ctx, 1, 0, 0, 1);
			[@"." drawAtPoint:CGPointMake(x*s_width+9,y*itemHeight+headHeight+5) withFont:[UIFont boldSystemFontOfSize:25]];
		}
		else if([self getDayFlag:i]==-1)
		{
			CGContextSetRGBFillColor(ctx, 0, 8.5, 0.3, 1);
			[@"." drawAtPoint:CGPointMake(x*s_width+9,y*itemHeight+headHeight+9) withFont:[UIFont boldSystemFontOfSize:25]];
		}	
		
        
        CGContextSetRGBFillColor(ctx, 1, 0, 0, 1);
//        CGContextSetRGBFillColor(ctx, 170.0/255.0, 56.0/255.0, 9.0/255.0, 1);
        NSString* event = @"";
        [cal solar_lunar:currentMonthDate.year kp_month:currentMonthDate.month kp_day:i];
        NSString *s1 = [cal GetJQ:currentMonthDate.year Month:currentMonthDate.month Day:i IADAY:NO];
        NSString *s2 = [cal GetHoliday:cal.ydays nday:cal.ndays];
        event = [NSString stringWithFormat:@"%@%@",s1,s2];
        
        [event drawInRect:CGRectMake(x*s_width, y*itemHeight+headHeight+5 + 18,s_width, itemHeight/2) withFont:[UIFont systemFontOfSize:10] lineBreakMode:NSLineBreakByWordWrapping alignment:UITextAlignmentCenter];
   
        CGContextSetRGBFillColor(ctx, 0, 0, 0, 1);
        
	}
}


- (void) movePrevNext:(int)isPrev{
	currentSelectDate.year=0;
	[calendarViewDelegate beforeMonthChange:self willto:currentMonthDate];
	int width=self.frame.size.width;
	int posX;
	if(isPrev==1)
	{
		posX=width;
	}
	else
	{
		posX=-width;
	}
	
	UIImage *viewImage;
	UIGraphicsBeginImageContext(self.bounds.size);
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];	
	viewImage= UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	if(viewImageView==nil)
	{
		viewImageView=[[UIImageView alloc] initWithImage:viewImage];
		
		viewImageView.center=self.center;
		[[self superview] addSubview:viewImageView];
	}
	else
	{
		viewImageView.image=viewImage;
	}
	
	viewImageView.hidden=NO;
	viewImageView.transform=CGAffineTransformMakeTranslation(0, 0);
	self.hidden=YES;
	[self setNeedsDisplay];
	self.transform=CGAffineTransformMakeTranslation(posX,0);
	
	
	float height;
	int row_Count=([self getDayCountOfaMonth:currentMonthDate]+[self getMonthWeekday:currentMonthDate]-2)/7+1;
	height=row_Count*itemHeight+headHeight;
	self.hidden=NO;
	[UIView beginAnimations:nil	context:nil];
	[UIView setAnimationDuration:0.5];
	self.transform=CGAffineTransformMakeTranslation(0,0);
	viewImageView.transform=CGAffineTransformMakeTranslation(-posX, 0);
	[UIView commitAnimations];
	[calendarViewDelegate monthChanged:currentMonthDate viewLeftTop:self.frame.origin height:height];
	
}
- (void)movePrevMonth{
	if(currentMonthDate.month>1)
		currentMonthDate.month-=1;
	else
	{
		currentMonthDate.month=12;
		currentMonthDate.year-=1;
	}
	[self movePrevNext:0];
}
- (void)moveNextMonth{
	if(currentMonthDate.month<12)
		currentMonthDate.month+=1;
	else
	{
		currentMonthDate.month=1;
		currentMonthDate.year+=1;
	}
	[self movePrevNext:1];	
}

- (void)moveDatePicker{
    [calendarViewDelegate datePicker];
}

- (void) drawToday{
	int x;
	int y;
	int day;
	CFGregorianDate today=CFAbsoluteTimeGetGregorianDate(currentTime, CFTimeZoneCopyDefault());
	if(today.month==currentMonthDate.month && today.year==currentMonthDate.year)
	{
		int width=self.frame.size.width;
		int swidth=width/7;
		int weekday=[self getMonthWeekday:currentMonthDate];
		day=today.day+weekday-2;
		x=day%7;
		y=day/7;
		CGContextRef ctx=UIGraphicsGetCurrentContext(); 
		CGContextSetRGBFillColor(ctx, 0.5, 0.5, 0.5, 1);
		CGContextMoveToPoint(ctx, x*swidth+1, y*itemHeight+headHeight);
		CGContextAddLineToPoint(ctx, x*swidth+swidth+2, y*itemHeight+headHeight);
		CGContextAddLineToPoint(ctx, x*swidth+swidth+2, y*itemHeight+headHeight+itemHeight);
		CGContextAddLineToPoint(ctx, x*swidth+1, y*itemHeight+headHeight+itemHeight);
		CGContextFillPath(ctx);

		CGContextSetRGBFillColor(ctx, 1, 1, 1, 1);
		UIFont *weekfont=[UIFont boldSystemFontOfSize:dateFontSize];
		NSString *date=[[[NSString alloc] initWithFormat:@"%2d",today.day] autorelease];
		[date drawAtPoint:CGPointMake(x*swidth+7,y*itemHeight+headHeight+5) withFont:weekfont];
        
        //农历
        int nongli_year = 2013;
        int nongli_month = 1;
        int nongli_day = 1;
        NSString* string_nongli = [cal getLunarDateByKpDate:currentMonthDate.year kp_month:currentMonthDate.month kp_day:today.day];
        NSArray* array_nongli = [string_nongli componentsSeparatedByString:@"|"];
        if ([array_nongli count] == 3) {
            nongli_year = [[array_nongli objectAtIndex:0] intValue];
            nongli_month = [[array_nongli objectAtIndex:1] intValue];
            nongli_day = [[array_nongli objectAtIndex:2] intValue];
        }
        NSString *dateNongLi = [NSString stringWithFormat:@"%@",[cal GetDay:nongli_month d:nongli_day]];
//        NSString *dateNongLi = [NSString stringWithFormat:@"%@",[cal GetDay:currentMonthDate.month d:today.day]];
        NSRange range;
        if (dateNongLi.length > 2) {
            range = NSMakeRange(2,dateNongLi.length - 2);
        }
        else
            range = NSMakeRange(0,dateNongLi.length);
        dateNongLi = [dateNongLi substringWithRange:range];
        [dateNongLi drawAtPoint:CGPointMake(x*swidth+7 + 20,y*itemHeight+headHeight+10) forWidth:25 withFont:[UIFont systemFontOfSize:8] lineBreakMode:NSLineBreakByWordWrapping];
 
        
        CGContextSetRGBFillColor(ctx, 1, 0, 0, 1);
        NSString* event = @"";
        [cal solar_lunar:today.year kp_month:today.month kp_day:today.day];
        NSString *s1 = [cal GetJQ:today.year Month:today.month Day:today.day IADAY:NO];
        NSString *s2 = [cal GetHoliday:cal.ydays nday:cal.ndays];
        event = [NSString stringWithFormat:@"%@%@",s1,s2];
        
        [event drawInRect:CGRectMake(x*swidth, y*itemHeight+headHeight+5 + 18,swidth, itemHeight/2) withFont:[UIFont systemFontOfSize:10] lineBreakMode:NSLineBreakByWordWrapping alignment:UITextAlignmentCenter];
 
		if([self getDayFlag:today.day]==1)
		{
			CGContextSetRGBFillColor(ctx, 1, 0, 0, 1);
			[@"." drawAtPoint:CGPointMake(x*swidth+9,y*itemHeight+headHeight+6) withFont:[UIFont boldSystemFontOfSize:25]];
		}
		else if([self getDayFlag:today.day]==-1)
		{
			CGContextSetRGBFillColor(ctx, 0, 8.5, 0.3, 1);
			[@"." drawAtPoint:CGPointMake(x*swidth+9,y*itemHeight+headHeight+6) withFont:[UIFont boldSystemFontOfSize:25]];
		}
		
	}
}
- (void) drawCurrentSelectDate{
	int x;
	int y;
	int day;
	int todayFlag;
	if(currentSelectDate.year!=0)
	{
		CFGregorianDate today=CFAbsoluteTimeGetGregorianDate(currentTime, CFTimeZoneCopyDefault());

		if(today.year==currentSelectDate.year && today.month==currentSelectDate.month && today.day==currentSelectDate.day)
			todayFlag=1;
		else
			todayFlag=0;
		
		int width=self.frame.size.width;
		int swidth=width/7;
		int weekday=[self getMonthWeekday:currentMonthDate];
		day=currentSelectDate.day+weekday-2;
		x=day%7;
		y=day/7;
		CGContextRef ctx=UIGraphicsGetCurrentContext();
		//[UIColor colorWithRed:170.0/255.0 green:56.0/255.0 blue:9.0/255.0 alpha:1.0]
		if(todayFlag==1)
//			CGContextSetRGBFillColor(ctx, 0, 0, 0.7, 1);
            CGContextSetRGBFillColor(ctx, 170.0/255.0, 56.0/255.0, 9.0/255.0, 1);
		else
			CGContextSetRGBFillColor(ctx, 170.0/255.0, 56.0/255.0, 9.0/255.0, 1);
		CGContextMoveToPoint(ctx, x*swidth+1, y*itemHeight+headHeight);
		CGContextAddLineToPoint(ctx, x*swidth+swidth+2, y*itemHeight+headHeight);
		CGContextAddLineToPoint(ctx, x*swidth+swidth+2, y*itemHeight+headHeight+itemHeight);
		CGContextAddLineToPoint(ctx, x*swidth+1, y*itemHeight+headHeight+itemHeight);
		CGContextFillPath(ctx);	
		
		if(todayFlag==1)
		{
			CGContextSetRGBFillColor(ctx, 0, 0, 1, 1);
			CGContextMoveToPoint	(ctx, x*swidth+4,			y*itemHeight+headHeight+3);
			CGContextAddLineToPoint	(ctx, x*swidth+swidth-1,	y*itemHeight+headHeight+3);
			CGContextAddLineToPoint	(ctx, x*swidth+swidth-1,	y*itemHeight+headHeight+itemHeight-3);
			CGContextAddLineToPoint	(ctx, x*swidth+4,			y*itemHeight+headHeight+itemHeight-3);
			CGContextFillPath(ctx);	
		}
		
		CGContextSetRGBFillColor(ctx, 1, 1, 1, 1);

		UIFont *weekfont=[UIFont boldSystemFontOfSize:dateFontSize];
		NSString *date=[[[NSString alloc] initWithFormat:@"%2d",currentSelectDate.day] autorelease];
		[date drawAtPoint:CGPointMake(x*swidth+7,y*itemHeight+headHeight+5) withFont:weekfont];
        
        //农历
        int nongli_year = 2013;
        int nongli_month = 1;
        int nongli_day = 1;
        NSString* string_nongli = [cal getLunarDateByKpDate:currentSelectDate.year kp_month:currentSelectDate.month kp_day:currentSelectDate.day];
        NSArray* array_nongli = [string_nongli componentsSeparatedByString:@"|"];
        if ([array_nongli count] == 3) {
            nongli_year = [[array_nongli objectAtIndex:0] intValue];
            nongli_month = [[array_nongli objectAtIndex:1] intValue];
            nongli_day = [[array_nongli objectAtIndex:2] intValue];
        }
        NSString *dateNongLi = [NSString stringWithFormat:@"%@",[cal GetDay:nongli_month d:nongli_day]];
//        NSString *dateNongLi = [NSString stringWithFormat:@"%@",[cal GetDay:currentSelectDate.month d:currentSelectDate.day]];
        NSRange range;
        if (dateNongLi.length > 2) {
            range = NSMakeRange(2,dateNongLi.length - 2);
        }
        else
            range = NSMakeRange(0,dateNongLi.length);
        dateNongLi = [dateNongLi substringWithRange:range];
        [dateNongLi drawAtPoint:CGPointMake(x*swidth+7 + 20,y*itemHeight+headHeight+10) forWidth:25 withFont:[UIFont systemFontOfSize:8] lineBreakMode:NSLineBreakByWordWrapping];
        
        //节日 节气
        CGContextSetRGBFillColor(ctx, 1, 1, 1, 1);
        NSString* event = @"";
        [cal solar_lunar:currentSelectDate.year kp_month:currentSelectDate.month kp_day:currentSelectDate.day];
        NSString *s1 = [cal GetJQ:currentSelectDate.year Month:currentSelectDate.month Day:currentSelectDate.day IADAY:NO];
        NSString *s2 = [cal GetHoliday:cal.ydays nday:cal.ndays];
        event = [NSString stringWithFormat:@"%@%@",s1,s2];
        
        [event drawInRect:CGRectMake(x*swidth, y*itemHeight+headHeight+5 + 18,swidth, itemHeight/2) withFont:[UIFont systemFontOfSize:10] lineBreakMode:NSLineBreakByWordWrapping alignment:UITextAlignmentCenter];
        
		if([self getDayFlag:currentSelectDate.day]!=0)
		{
			[@"." drawAtPoint:CGPointMake(x*swidth+9,y*itemHeight+headHeight+6) withFont:[UIFont boldSystemFontOfSize:25]];
		}		
	}
}
- (void) touchAtDate:(CGPoint) touchPoint{
	int x;
	int y;
	int width=self.frame.size.width;
	int weekday=[self getMonthWeekday:currentMonthDate];
	int monthDayCount=[self getDayCountOfaMonth:currentMonthDate];
	x=touchPoint.x*7/width;
	y=(touchPoint.y-headHeight)/itemHeight;
	int monthday=x+y*7-weekday+2;
	if(monthday>0 && monthday<monthDayCount+1)
	{
            currentSelectDate.year=currentMonthDate.year;
            currentSelectDate.month=currentMonthDate.month;
            currentSelectDate.day=monthday;
            currentSelectDate.hour=0;
            currentSelectDate.minute=0;
            currentSelectDate.second=1;
            [calendarViewDelegate selectDateChanged:currentSelectDate];
            [self setNeedsDisplay];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch* touch = [touches anyObject];
	CGPoint touchPoint = [touch locationInView: self];
	
	touchPosX = touchPoint.x;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	int width=self.frame.size.width;
	UITouch* touch=[touches anyObject];
	CGPoint touchPoint=[touch locationInView:self]; 
	if(touchPoint.x > 60 && touchPoint.x<120 && touchPoint.y<headHeight)
		[self movePrevMonth];
	else if(touchPoint.x>width-120 && touchPoint.x < width-60 && touchPoint.y<headHeight)
		[self moveNextMonth];
    else if(touchPoint.x>120 && touchPoint.x < width - 120 && touchPoint.y<headHeight)
		[self moveDatePicker];
	else if(touchPoint.y>headHeight)
	{
		[self touchAtDate:touchPoint];
	}
}

- (void)drawRect:(CGRect)rect{
    
//    NSLog(@"x = %fd ,y = %fd w = %fd ,h = %fd ",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
	static int once=0;
	currentTime=CFAbsoluteTimeGetCurrent();
 
	[self drawTopGradientBar];
	[self drawTopBarWords];
	[self drawGirdLines];//注释掉 即可去掉边线框
	
	if(once==0)
	{
		once=1;
		float height;
		int row_Count=([self getDayCountOfaMonth:currentMonthDate]+[self getMonthWeekday:currentMonthDate]-2)/7+1;
		height=row_Count*itemHeight+headHeight;
		[calendarViewDelegate monthChanged:currentMonthDate viewLeftTop:self.frame.origin height:height];
		[calendarViewDelegate beforeMonthChange:self willto:currentMonthDate];

	}
    //删除添加的 假期 图片
    int count = [m_holidayArray count];
    for (int i = 0; i < count;i++ ) {
 
        HolidayImageView* view = (HolidayImageView*)[m_holidayArray objectAtIndex:i];
        [view removeFromSuperview];
        [view release];
 
//        [m_holidayArray removeObjectAtIndex:i];
//        if ([[[self subviews] objectAtIndex:i] isKindOfClass:[UIImageView class]]) {
//            
//            [[[self subviews] objectAtIndex:i] removeFromSuperview];
//        }
    }
    if (m_holidayArray) {
        [m_holidayArray release];
    }
    m_holidayArray = [[NSMutableArray alloc] initWithCapacity:5];
    

	[self drawDateWords];
	[self drawToday];
	[self drawCurrentSelectDate];
	
}

- (void)dealloc {
    [cal release];
    [holiday_2013 release];
    [workDay_2013 release];
    [m_holidayArray release];
    [super dealloc];
	free(monthFlagArray);
}
@end


@implementation HolidayImageView

- (id)initWithFrame:(CGRect)frame {
	
	if (self = [super initWithFrame:frame]) {
		 
	}
	return self;
}
-(void)dealloc
{
    [super dealloc];
}
@end