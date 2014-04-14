//
//  CanlendarViewController.h
//  Canlendar
//
//  Created by xie mengyue on 11-7-15.
//  Copyright 2011年 beyondsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TdCalendarView.h"
@class TdCalendarView;


//横幅(Banner)广告
#import "GuomobAdSDK.h"

@interface CanlendarViewController : UIViewController<UIScrollViewDelegate,CalendarViewDelegate,UIActionSheetDelegate,GuomobAdSDKDelegate>{
    TdCalendarView *tdCalendarView;
    UIScrollView*        detailView;
    UIImageView*       yearImage;
    UILabel*       lable1_year_ganzhi;//干支纪年
    
    UILabel*       lable1;//农历 纪月 纪日
 
    UILabel*       lable2;//
    UITextView*       lable3;//宜  UMeng在线参数 
    UITextView*       lable4;//宜  UMeng在线参数（用数组来随即取值）
    
    NSArray *dayArray;
    NSArray *monthArray;
    NSArray *yearArray;
    NSString *selectedRow;
    NSString *startDate;
	NSString *backDate;
    UITableView *tableview;
    UIPickerView *pick;
    
    NSInteger selectedYearRow;
	NSInteger selectedMonthRow;
    
    NSString *seletdate;
//    CFGregorianDate m_selectGregorianDate;
    UIActionSheet*      m_datePickerSheet;
    UIDatePicker*       m_datePicker;
    
    NSArray*            m_yongshiyiji;
    UITextView* geyanjingjuView;//格言警句
    //横幅(Banner)广告
    GuomobAdSDK *bannerAD;
}
@property (nonatomic, retain) IBOutlet TdCalendarView *tdCalendarView;
@property (nonatomic, retain)  UIView *detailView;

@property (nonatomic, retain)  NSArray *dayArray;
@property (nonatomic, retain)  NSArray *monthArray;
@property (nonatomic, retain)  NSArray *yearArray;
@property (nonatomic, retain)  NSString *selectedRow;
@property (nonatomic, retain)  NSString *startDate;
@property (nonatomic, retain)  NSString *backDate;
//@property (nonatomic, retain) IBOutlet UITableView *tableview;
 
@property (nonatomic, retain) NSString *seletdate;


@property (nonatomic) NSInteger selectedYearRow;
@property (nonatomic) NSInteger selectedMonthRow;

-(NSString *)getWeekDayFromDate:(NSInteger) date;
- (NSString *) getCurrentDate;
- (NSString *) getDefaultBackDate;
-(void)setDayArray;
-(void)setMonthArry;
-(void)setYearArray;

-(NSString *)getWeekDayByDate:(NSDate *) date;
-(void) yearChanged:(NSString *) selectedYear;
-(void) resetDay:(NSString *) selectedYear month:(NSString *) selectedMonth;
-(void) resetMonth;
-(NSString *)getWeekDayByCFDate:(CFGregorianDate) cfdate;
-(void) monthChanged:(NSString *) selectedYear month:(NSString *) selectedMonth;
-(void)SetSelectDate;//:(CFGregorianDate) selectDate;
-(void)SetTodayDate;
-(NSString *) GetEvent:(unsigned int)kp_year kp_month:(unsigned char)kp_month kp_day:(unsigned char) kp_day;

//友盟在线参数 回调
-(void)UMENGConfigCall;
@end
