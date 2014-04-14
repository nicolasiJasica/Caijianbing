//
//  CalendarView.h
//  ZhangBen
//
//  Created by tinyfool on 08-10-26.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CalendarViewDelegate;
#import "Cal.h"
@class HolidayImageView;
@interface TdCalendarView : UIView {
	CFGregorianDate currentMonthDate;
	CFGregorianDate currentSelectDate;
	CFAbsoluteTime	currentTime;
	UIImageView* viewImageView;
	id<CalendarViewDelegate> calendarViewDelegate;
	int *monthFlagArray; 
    NSInteger touchPosX;
    Cal*            cal;
    NSArray* holiday_2013;
    NSArray* workDay_2013;
    
    NSArray* holiday_2014;
    NSArray* workDay_2014;
    
    UIView*         m_holidayAndWorkDayView;
    
    NSMutableArray*        m_holidayArray;
}

@property CFGregorianDate currentMonthDate;
@property CFGregorianDate currentSelectDate;
@property CFAbsoluteTime  currentTime;

@property (nonatomic, retain) UIImageView* viewImageView;

@property (nonatomic, assign) id<CalendarViewDelegate> calendarViewDelegate;
-(int)getDayCountOfaMonth:(CFGregorianDate)date;
-(int)getMonthWeekday:(CFGregorianDate)date;
-(int)getDayFlag:(int)day;
-(void)setDayFlag:(int)day flag:(int)flag;
-(void)clearAllDayFlag;
-(void)drawCurrentSelectDate;
@end



@protocol CalendarViewDelegate<NSObject>
@optional
- (void) selectDateChanged:(CFGregorianDate) selectDate;
- (void) monthChanged:(CFGregorianDate) currentMonth viewLeftTop:(CGPoint)viewLeftTop height:(float)height;
- (void) beforeMonthChange:(TdCalendarView*) calendarView willto:(CFGregorianDate) currentMonth;
- (void) datePicker;
@end

@interface HolidayImageView : UIImageView

@end


