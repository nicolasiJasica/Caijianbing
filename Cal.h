//
//  Cal.h
//  Canlendar
//
//  Created by ruyicai on 12-11-23.
//  Copyright (c) 2012年 beyondsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cal : NSObject
{
    NSArray *yearArray;
    NSArray *animalsAry;
    NSArray *ganAry;
    NSArray *zhiAry;
    NSDate *now;
    int a[13];
    int b[13];
    
    unsigned int solar_year;
    unsigned int lunar_year;//农历年份
    unsigned char solar_month;
    unsigned char lunar_month;//农历月
    unsigned int solar_day;
    unsigned int lunar_day;
    
    NSMutableString *ndays;
    NSMutableString *ydays;
    unsigned long int lunar_info[151];
    int selectmonth;
 
}
@property(nonatomic,retain) NSArray *yearArray;
@property(nonatomic,retain) NSArray *animalsAry;
@property(nonatomic,retain) NSArray *ganAry;
@property(nonatomic,retain) NSArray *zhiAry;
@property(nonatomic,retain) NSDate *now;
@property(nonatomic,assign) int *b;
@property(nonatomic,assign) int *a;
@property(nonatomic,assign) unsigned long int *lunar_info;
@property(nonatomic,retain) NSMutableString *ndays;
@property(nonatomic,retain) NSMutableString *ydays;

@property(nonatomic,assign) unsigned int solar_year;
@property(nonatomic,assign) unsigned int lunar_year;
@property(nonatomic,assign) unsigned char solar_month;
@property(nonatomic,assign) unsigned char lunar_month;
@property(nonatomic,assign) unsigned int solar_day;
@property(nonatomic,assign) unsigned int lunar_day;
 
-(NSString *) GetAnimals:(NSString *)_year;
-(NSString *) GetGan:(NSString *)_year;
-(NSString *) GetZhi:(NSString *)_year;

-(unsigned char)get_leap_month:(unsigned int )lunar_year;
-(unsigned char)get_leap_month_day:(unsigned int)lunar_year;
-(unsigned char)get_lunar_month_total:(unsigned int)lunar_year  lunar_month:(unsigned char)lunar_month;
-(unsigned int)get_lunar_year_total:(unsigned int)lunar_year;
-(unsigned int)leap:(unsigned int) _year;
-(unsigned int) get_solar_total:(unsigned int)solar_year solar_month:(unsigned char)solar_month;
-(NSString *)solar_lunar:(unsigned int)kp_year kp_month:(unsigned char)kp_month kp_day:(unsigned char) kp_day;
-(NSMutableString *)GetDay:(int)_m d:(int)_d;
-(NSMutableString *)GetHoliday:(NSString *)_yday nday:(NSString *)_nday;
-(NSString *)GetJQ:(int)year Month:(int)month Day:(int)day IADAY:(BOOL)isday;//二十四节气;
-(NSString *)GetYinDate:(unsigned int)kp_year kp_month:(unsigned char)kp_month kp_day:(unsigned char) kp_day;
-(NSString *)GetSj;
//根据 阳历 获得农历日期
-(NSString*) getLunarDateByKpDate:(unsigned int)kp_year kp_month:(unsigned int)kp_month kp_day:(unsigned int)kp_day;
//干支纪月
-(NSString*)getMonth_GanZhi:(NSString*)year_ganzhi MONTH:(int)month;
//干支纪日
-(NSString*)getDay_GanZhi:(int)year_nongli MONTH:(int)month_nongli DAY:(int)day_nongli;//
////返回立春日期 2月份，如2000 年2.4号立春，返回4
//-(int)GetLiChunDay:(int)year_yang;
-(BOOL)MaxDate:(int)c_month C_DAY:(int)c_day M_MONTH:(int)m_month M_Day:(int)m_day;
-(BOOL)betweenDate:(int)min_Date B_Date:(int)b_date MAX_DATE:(int)max_date;
@end
