//
//  Cal.m
//  Canlendar
//
//  Created by ruyicai on 12-11-23.
//  Copyright (c) 2012年 beyondsoft. All rights reserved.
//

#import "Cal.h"
#import "Common.h"
 
@implementation Cal

@synthesize yearArray,animalsAry,ganAry,zhiAry,now,solar_year,lunar_year,solar_month,lunar_month,solar_day,lunar_day,ndays,ydays;
 
- (id)init {
    self = [super init];
    if (self)
    {
        animalsAry=[[NSArray alloc] initWithObjects:
                    [NSString stringWithFormat:@"猪"],
                    [NSString stringWithFormat:@"鼠"],[NSString stringWithFormat:@"牛"],[NSString stringWithFormat:@"虎"],[NSString stringWithFormat:@"兔"],[NSString stringWithFormat:@"龙"],[NSString stringWithFormat:@"蛇"],[NSString stringWithFormat:@"马"],[NSString stringWithFormat:@"羊"],[NSString stringWithFormat:@"猴"],[NSString stringWithFormat:@"鸡"],[NSString stringWithFormat:@"狗"], nil];
        
        ganAry=[[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"甲"],[NSString stringWithFormat:@"乙"],[NSString stringWithFormat:@"丙"],[NSString stringWithFormat:@"丁"],[NSString stringWithFormat:@"戊"],[NSString stringWithFormat:@"己"],[NSString stringWithFormat:@"庚"],[NSString stringWithFormat:@"辛"],[NSString stringWithFormat:@"壬"],[NSString stringWithFormat:@"癸"], nil];
        zhiAry=[[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"子"],[NSString stringWithFormat:@"丑"],[NSString stringWithFormat:@"寅"],[NSString stringWithFormat:@"卯"],[NSString stringWithFormat:@"辰"],[NSString stringWithFormat:@"巳"],[NSString stringWithFormat:@"午"],[NSString stringWithFormat:@"未"],[NSString stringWithFormat:@"申"],[NSString stringWithFormat:@"酉"],[NSString stringWithFormat:@"戌"],[NSString stringWithFormat:@"亥"], nil];
        int a1[13] = {0,31,28,31,30,31,30,31,31,30,31,30,31};
        int b1[13] = {0,31,29,31,30,31,30,31,31,30,31,30,31};
        [self setA:a1];
        [self setB:b1];
        
        solar_year=0;
        lunar_year=0;
        solar_month=0;
        lunar_month=0;
        solar_day=0;
        lunar_day=0;
 
        unsigned long int lunar_info[151]=
        {
            0x04bd8,0x04ae0,0x0a570,0x054d5,0x0d260,0x0d950,0x16554,0x056a0,0x09ad0,0x055d2,
            0x04ae0,0x0a5b6,0x0a4d0,0x0d250,0x1d255,0x0b540,0x0d6a0,0x0ada2,0x095b0,0x14977,
            0x04970,0x0a4b0,0x0b4b5,0x06a50,0x06d40,0x1ab54,0x02b60,0x09570,0x052f2,0x04970,
            0x06566,0x0d4a0,0x0ea50,0x06e95,0x05ad0,0x02b60,0x186e3,0x092e0,0x1c8d7,0x0c950,
            0x0d4a0,0x1d8a6,0x0b550,0x056a0,0x1a5b4,0x025d0,0x092d0,0x0d2b2,0x0a950,0x0b557,
            0x06ca0,0x0b550,0x15355,0x04da0,0x0a5b0,0x14573,0x052b0,0x0a9a8,0x0e950,0x06aa0,
            0x0aea6,0x0ab50,0x04b60,0x0aae4,0x0a570,0x05260,0x0f263,0x0d950,0x05b57,0x056a0,
            0x096d0,0x04dd5,0x04ad0,0x0a4d0,0x0d4d4,0x0d250,0x0d558,0x0b540,0x0b6a0,0x195a6,
            0x095b0,0x049b0,0x0a974,0x0a4b0,0x0b27a,0x06a50,0x06d40,0x0af46,0x0ab60,0x09570, //1980
            0x04af5,0x04970,0x064b0,0x074a3,0x0ea50,0x06b58,0x055c0,0x0ab60,0x096d5,0x092e0,
            0x0c960,0x0d954,0x0d4a0,0x0da50,0x07552,0x056a0,0x0abb7,0x025d0,0x092d0,0x0cab5, //2004 07552
            0x0a950,0x0b4a0,0x0baa4,0x0ad50,0x055d9,0x04ba0,0x0a5b0,0x15176,0x052b0,0x0a930,
            0x07954,0x06aa0,0x0ad50,0x05b52,0x04b60,0x0a6e6,0x0a4e0,0x0d260,0x0ea65,0x0d530, //2028
            0x05aa0,0x076a3,0x096d0,0x04bd7,0x04ad0,0x0a4d0,0x1d0b6,0x0d250,0x0d520,0x0dd45,
            0x0b5a0,0x056d0,0x055b2,0x049b0,0x0a577,0x0a4b0,0x0aa50,0x1b255,0x06d20,0x0ada0,
            0x14b63
        };
        
        [self setLunar_info:lunar_info];
 
        
    } 
    return self;
}
- (void)dealloc {
    
    [animalsAry release];

    [ganAry release];
    [zhiAry release];
    [ndays release];
    [ydays release];
    [super dealloc];
}

- (int *)a
{
    return a;
}

- (void)setA:(int *)_a
{
    if(_a != NULL)
    {
        for (int i=0; i<13; i++) {
            a[i] = _a[i];
        }
    }
}

- (int *)b
{
    return b;
}

- (void)setB :(int *)_b
{
    if(_b != NULL)
    {
        for (int i=0; i<13; i++) {
            b[i] = _b[i];
        }
    }
}
- (unsigned long int *)lunar_info
{
    return lunar_info;
}

- (void)setLunar_info:(unsigned long int *)_lunar_info
{
    if(_lunar_info != NULL)
    {
        for (int i=0; i<151; i++) {
            lunar_info[i] = _lunar_info[i];
        }
    }
}


#pragma mark  方法
-(NSString *) GetGan:(NSString *)_year
{
    NSString *string2 = [_year substringFromIndex:3];
    int i = [string2 intValue];
    int j;
    if(i < 3 )
    {
        j = (i+10)-3;
    }
    else
    {
        j = i-3;
    }
    if(j == 0)
    {
        j = [ganAry count];
    }
    return [ganAry objectAtIndex:(j-1)];
}

-(NSString *) GetZhi:(NSString *)_year
{
    NSString *y = [_year substringFromIndex:2];
    int i = [y intValue];
    int years = [_year intValue];
    NSString *ret = @"所选此年份超出范围";
    if((years>=900) && (years<=1999))
    {
        int temp = i+1-60;
        while (temp >= 12) {
            temp -= 12;
            if (temp < 12) {
                temp -= 1;
            }
        }
        while (temp < 0) {
            temp += 12;
        }

        return [zhiAry objectAtIndex:(temp)];
    }
    else if((years>=2000) && (years<=2099))
    {
        int temp = i+5-13;
        while (temp >= 12) {
            temp -= 12;
            if (temp < 12) {
                temp -= 1;
            }
        }
        while (temp < 0) {
            temp += 12;
        }
        return [zhiAry objectAtIndex:(temp)];
    }
    return ret ;
    
}

-(NSString *) GetAnimals:(NSString *)_year

{
    int y = [_year intValue];
    int j = (y-3)%12;
    return [animalsAry objectAtIndex:j];
}


-(unsigned char)get_leap_month:(unsigned int )_lunar_year //确定是否存在农历的闰月 并返回闰月
{
//    return ( lunar_info[lunar_year-1900] & 0xf);
    return ( lunar_info[_lunar_year-1900] & 0xf);//修改于2012.3.7
}


-(unsigned char)get_leap_month_day:(unsigned int)_lunar_year//若存在闰月,返回闰月的天数,30?29
{
    if([self get_leap_month:_lunar_year])
        return( ( lunar_info[_lunar_year-1900] & 0x10000 ) ? 30:29 );
    else
        return 0;
}

-(unsigned char)get_lunar_month_total:(unsigned int)_lunar_year  lunar_month:(unsigned char)_lunar_month //确定农历当月天数,30?29
{
    return( (lunar_info[_lunar_year-1900] & (0x10000>>_lunar_month) ) ? 30:29 );
}

-(unsigned int)get_lunar_year_total:(unsigned int)_lunar_year // 农历当年总天数,354?355 384 383
{
    /*sum=12*29 */  //12个月 29天一月
    unsigned int sum=348;
    unsigned int i;
    for(i=0x8000;i>0x8; i>>=1)
        sum += (lunar_info[_lunar_year-1900] & i )?1:0; //把大月的1加进去
    return( sum + [self get_leap_month_day:_lunar_year]); //判断这年是否有闰月
}

-(unsigned int)leap:(unsigned int) _year //判断是否为闰年
{
    if( ( _year%4==0 && _year%100!=0) || _year%400==0 )
        return 366;
    else
        return 365;
}

-(unsigned char) day:(unsigned int)_year month:(unsigned char) _month //判断当年当月天数
{
    if(_month==1||_month==3||_month==5||_month==7||_month==8||_month==10||_month==12)
        return 31;
    if(_month==4||_month==6||_month==9||_month==11)
        return 30;
    if(_month==2 && [self leap:_year] ==366 )
        return 29;
    else
        return 28;
}

//计算1900.1.1 到  输入年月的天数
-(unsigned int) get_solar_total:(unsigned int)_solar_year solar_month:(unsigned char)_solar_month
{
    unsigned int total;
    
    unsigned int temp_num;
    
    total=0;
    
    for(temp_num=1900;temp_num<_solar_year;temp_num++)
        
        total += [self leap:temp_num];
    
    for(temp_num=1;temp_num<_solar_month;temp_num++)
        
        total+=[self day:_solar_year month:temp_num];
    return total;
}
//根据 阳历 获得农历日期
-(NSString*) getLunarDateByKpDate:(unsigned int)kp_year kp_month:(unsigned int)kp_month kp_day:(unsigned int)kp_day  
{
    unsigned int total_day=0;/*记录农历1900.1.1日到今天相隔的天数 */
    unsigned char run_yue_flag=0,run_yue=0;//year_flag=0;
    int nongli_year = 0,nongli_month = 0,nongli_day = 0;
    if(kp_year<1900 || kp_year>2050 || kp_month>12 || kp_month==0 || (kp_year==1900 && kp_month==1) )
        return @"";
    if(kp_day>[self day:kp_year month:kp_month] || kp_day==0)
        return @"";
    
    total_day=[self get_solar_total:kp_year solar_month: kp_month]+kp_day-30; /* 阳历从1900.1.31(农历1900.1.1)到今天的总天数(减30 实际少了一天)。 */
    nongli_year=1900;
    while(total_day>385) //385大于一年 留出一年多的时间用于条件计算
    {
        total_day-=[self get_lunar_year_total:nongli_year]; //
        nongli_year++;
    }
    if(total_day>[self get_lunar_year_total:nongli_year]) //排除lunar_year有闰月的情况
    {
        total_day-=[self get_lunar_year_total:nongli_year];
        nongli_year++;
        
    }
    run_yue=[self get_leap_month:nongli_year]; //当前闰哪个月
    if(run_yue)
        run_yue_flag=1; //有闰月则一年为13个月
    else
        run_yue_flag=0; //没闰月则一年为12个月
    
    if(total_day==0)  //刚好一年
    {
        nongli_day=[self get_lunar_month_total:nongli_year lunar_month:12];
        nongli_month=12;
    }
    else
    {
        nongli_month=1;
        while(nongli_month<=12)
        {
            if( run_yue_flag==1 && nongli_month==(run_yue+1) ) //闰月处理
            {
                if(total_day>[self get_leap_month_day:nongli_year])
                {
                    total_day-=[self get_leap_month_day:nongli_year]; //该年闰月天数
                    
                }
                run_yue_flag=0;
                continue;
                
            }
            if( total_day> [ self get_lunar_month_total:nongli_year lunar_month:nongli_month] )
            {
                total_day=total_day-[self get_lunar_month_total:nongli_year lunar_month:nongli_month]; //该年该月天数
                nongli_month++;
            }
            else
            {
                nongli_day=total_day;
                break;
            }
        }
    }
    
    return [NSString stringWithFormat:@"%d|%d|%d",nongli_year,nongli_month,nongli_day];
    
}

-(NSString *)solar_lunar:(unsigned int)kp_year kp_month:(unsigned char)kp_month kp_day:(unsigned char) kp_day/*输入阳历时期年月 日 */
{
    unsigned int total_day=0;/*记录农历1900.1.1日到今天相隔的天数 */
    unsigned char run_yue_flag=0,run_yue=0;//year_flag=0;
    
    if(kp_year<1900 || kp_year>2050 || kp_month>12 || kp_month==0 || (kp_year==1900 && kp_month==1) )
        return 0;
    if(kp_day>[self day:kp_year month:kp_month] || kp_day==0)
        return 0;
    
    total_day=[self get_solar_total:kp_year solar_month: kp_month]+kp_day-30; /* 阳历从1900.1.31(农历1900.1.1)到今天的总天数(减30 实际少了一天)。 */
    lunar_year=1900;
    while(total_day>385) //385大于一年 留出一年多的时间用于条件计算
    {
        total_day-=[self get_lunar_year_total:lunar_year]; //
        lunar_year++;
    }
    if(total_day>[self get_lunar_year_total:lunar_year]) //排除lunar_year有闰月的情况
    {
        total_day-=[self get_lunar_year_total:lunar_year];
        lunar_year++;
        
    }
    run_yue=[self get_leap_month:lunar_year]; //当前闰哪个月
    if(run_yue)
        run_yue_flag=1; //有闰月则一年为13个月
    else
        run_yue_flag=0; //没闰月则一年为12个月
    
    if(total_day==0)  //刚好一年
    {
        lunar_day=[self get_lunar_month_total:lunar_year lunar_month:12];
        lunar_month=12;
    }
    else
    {
        lunar_month=1;
        while(lunar_month<=12)
        {
            if( run_yue_flag==1 && lunar_month==(run_yue+1) ) //闰月处理
            {
                if(total_day>[self get_leap_month_day:lunar_year])
                {
                    total_day-=[self get_leap_month_day:lunar_year]; //该年闰月天数
                    
                }
                //lunar_month--;
                run_yue_flag=0;
                continue;
                
            }
            if( total_day> [ self get_lunar_month_total:lunar_year lunar_month:lunar_month] )
            {
                total_day=total_day-[self get_lunar_month_total:lunar_year lunar_month:lunar_month]; //该年该月天数
                lunar_month++;
            }
            else
            {
                lunar_day=total_day;
                break;
            }
        }
    }
    selectmonth = kp_month;
    ndays = [[NSMutableString alloc]init];
    [ndays appendFormat:@"%d",kp_month];
    [ndays appendFormat:@"%d",kp_day];
    
    ydays = [[NSMutableString alloc]init];
    [ydays appendFormat:@"%d",lunar_month];
    [ydays appendFormat:@"%d",lunar_day];
    

//    NSString *years = [NSString stringWithFormat:@"%d",kp_year];
    NSString* temp_lunar_year = [NSString stringWithFormat:@"%d",lunar_year];//农历年份
    NSString* temp_lunar_month = [NSString stringWithFormat:@"%d",lunar_month];//农历yue份

    /*
    //以立春为临界点  划分农历生肖年份
    //小年->春节 这段时间
    //判断这天是在 本年（阳历）的立春的前后
    */
//    if (kp_month < 2) {
//        temp_lunar_year = [NSString stringWithFormat:@"%d",kp_year-1];
//    }
//    if (kp_month == 2) {
////        if (kp_day < [self GetLiChunDay:kp_year]) {
////            temp_lunar_year = [NSString stringWithFormat:@"%d",kp_year-1];
////        }
////        else
////            temp_lunar_year = [NSString stringWithFormat:@"%d",kp_year];
//    }
//    
//    if (kp_month > 2) {
//        temp_lunar_year = [NSString stringWithFormat:@"%d",kp_year];
//    }

    /*
     判断当前是否过了今年的立春,每年的立春都在二月份
     */
     
    //立春日期
    float D = 0.2422;
    int lichunDay = [self GetJieQiDay:kp_year D_:D C_:(kp_year <= 2000 ? 4.6295:3.87)];
    if ([self MaxDate:kp_month C_DAY:kp_day M_MONTH:2 M_Day:lichunDay]) {
        temp_lunar_year = [NSString stringWithFormat:@"%d",kp_year];
    }
    else
    {
        temp_lunar_year = [NSString stringWithFormat:@"%d",kp_year-1];
    }
    //干支纪月 月份
    temp_lunar_month = [self GetJQ:kp_year Month:kp_month Day:kp_day IADAY:YES];
    /*
    计算二十四节气的哪个节气之间
     */
    /*
     ;用来分隔开年 月日 :用于分隔开天干地支纪法
     
    "龙年:壬申年;
    腊月十四:壬子月 辛丑日;"
    */
 
    NSString *ss = [[[NSString alloc]initWithFormat:@"%@年:%@%@年;%@:%@月 %@日",[self GetAnimals:temp_lunar_year],[self GetGan:temp_lunar_year],[self GetZhi:temp_lunar_year],
                    [self GetDay:lunar_month d:lunar_day],
                    [self getMonth_GanZhi:[NSString stringWithFormat:@"%@",[self GetGan:temp_lunar_year/*[NSString stringWithFormat:@"%d",lunar_year]*/]] MONTH:/*lunar_month*/[temp_lunar_month intValue]],
                    
                    [self getDay_GanZhi:/*lunar_year*/kp_year MONTH:/*lunar_month*/kp_month DAY:/*lunar_day*/kp_day]] autorelease];
    return ss;
}
/*
 速查干支农历纪月法
 　　其方法为：若遇甲或己的年份 ，正月是丙寅；遇上乙或庚之年，正月为戊寅；遇上丙或辛之年，正月为庚寅；遇上丁或壬之年，正月为壬寅；遇上戊或癸之年，正月为甲寅。依照正月之干支，其余月份按干支推算即可。详见下表：
 年　份	一月	二月	三月	四月	五月	六月	七月	八月	九月	十月	十一月	十二月
 甲、巳	丙寅	丁卯	戊辰	己巳	庚午	辛未	壬申	癸酉	甲戌	乙亥	丙子      丁丑
 乙、庚	戊寅	己卯	庚辰	辛巳	壬午	癸未	甲申	乙酉 丙戌	丁亥	戊子      己丑
 丙、辛	庚寅	辛卯	壬辰	癸巳	甲午	乙未	丙申	丁酉	戊戌	己亥	庚子      辛丑
 丁、壬	壬寅	癸卯	甲辰	乙巳	丙午	丁未	戊申	己酉	庚戌	辛亥	壬子      癸丑
 戊、癸	甲寅	乙卯	丙辰	丁巳	戊午	己未	庚申	辛酉	壬戌	癸亥	甲子      乙丑
 　　由上可见，农历的月份，地支是固定的，天干却不固定，要经过推算才能排出。注意：农历的闰月是不记干支的。
 　　例如：2006年为‘丙戌’年，查天干年份为‘丙’子头，在上表的第三行，其正月为庚寅，二月为辛卯，三月为壬辰，余类推。
 */
-(NSString*)getMonth_GanZhi:(NSString*)year_zhi MONTH:(int)month_nongli //年，月
{
    NSMutableArray* array = [[[NSMutableArray alloc] initWithCapacity:5] autorelease];
    NSString* month = @"";
    if (month_nongli < 1 || month_nongli > 12) {
        return month;
    }
    BOOL has = NO;
    if ([year_zhi isEqualToString:@"甲"] || [year_zhi isEqualToString:@"己"]) {
        [array addObject:@"丙寅"];
        [array addObject:@"丁卯"];
        [array addObject:@"戊辰"];
        [array addObject:@"己巳"];
        [array addObject:@"庚午"];
        [array addObject:@"辛未"];
        [array addObject:@"壬申"];
        [array addObject:@"癸酉"];
        [array addObject:@"甲戌"];
        
        [array addObject:@"乙亥"];
        [array addObject:@"丙子"];
        [array addObject:@"丁丑"];
        has= YES;
    }
    else if([year_zhi isEqualToString:@"乙"] || [year_zhi isEqualToString:@"庚"])
    {
        [array addObject:@"戊寅"];
        [array addObject:@"己卯"];
        [array addObject:@"庚辰"];
        [array addObject:@"辛巳"];
        [array addObject:@"壬午"];
        [array addObject:@"癸未"];
        [array addObject:@"甲申"];
        [array addObject:@"乙酉"];
        [array addObject:@"丙戌"];
        [array addObject:@"丁亥"];
        [array addObject:@"戊子"];
        [array addObject:@"己丑"];
         has= YES;
    }
    else if([year_zhi isEqualToString:@"丙"] || [year_zhi isEqualToString:@"辛"])
    {
        [array addObject:@"庚寅"];
        [array addObject:@"辛卯"];
        [array addObject:@"壬辰"];
        [array addObject:@"癸巳"];
        [array addObject:@"甲午"];
        [array addObject:@"乙未"];
        [array addObject:@"丙申"];
        [array addObject:@"丁酉"];
        [array addObject:@"戊戌"];
        [array addObject:@"己亥"];
        [array addObject:@"庚子"];
        [array addObject:@"辛丑"];
         has= YES;
    }
    else if([year_zhi isEqualToString:@"丁"] || [year_zhi isEqualToString:@"壬"])
    {
        [array addObject:@"壬寅"];
        [array addObject:@"癸卯"];
        [array addObject:@"甲辰"];
        [array addObject:@"乙巳"];
        [array addObject:@"丙午"];
        [array addObject:@"丁未"];
        [array addObject:@"戊申"];
        [array addObject:@"己酉"];
        [array addObject:@"庚戌"];
        [array addObject:@"辛亥"];
        [array addObject:@"壬子"];
        [array addObject:@"癸丑"];
         has= YES;
    }
    else if([year_zhi isEqualToString:@"戊"] || [year_zhi isEqualToString:@"癸"])
    {
        [array addObject:@"甲寅"];
        [array addObject:@"乙卯"];
        [array addObject:@"丙辰"];
        [array addObject:@"丁巳"];
        [array addObject:@"戊午"];
        [array addObject:@"己未"];
        [array addObject:@"庚申"];
        [array addObject:@"辛酉"];
        [array addObject:@"壬戌"];
        [array addObject:@"癸亥"];
        [array addObject:@"甲子"];
        [array addObject:@"乙丑"];

         has= YES;
    }
 
    if (has && month_nongli <= [array count]) {
        month = (NSString*)[array objectAtIndex:month_nongli- 1];
    }
 
    return month;
}
/*
日天干地支
从已知日期计算干支纪日的公式为：
g=4C+[C/4]+[5y]+[y/4]+[3*(m+1)/5]+d-3
z=8C+[C/4]+[5y]+[y/4]+[3*(m+1)/5]+d+7+i
其中c是世纪数减1。奇数月 i=0，偶数月 i=6，年份前两位，y 是年份后两位，M 是月份，d 是日数。[ ] 表示取整数。
1月和 2月按上一年的 13月和 14月来算，因此C和y也要按上一年的年份来取值。
g 除以 10 的余数是天干，z 除以 12 的余数是地支。

如果先求得了g，那么
z=g+4C+10+i(奇数月i=0，偶数月i=6)

如：
2009年7月16日
G=80+5+45+2+4+16-3=149 余数为 9，天干是「壬」
Z=149+80+10+0=239       余数为11，地支是「戌」
 */
-(NSString*)getDay_GanZhi:(int)year_nongli MONTH:(int)month_nongli DAY:(int)day_nongli
{
    NSString* ganZhi = @"";
 
    if (month_nongli == 1 || month_nongli == 2) {
        year_nongli -= 1;
        month_nongli += 12;
    }
    int gan = 4 * (year_nongli/100) + (year_nongli/100)/4 + 5 * (year_nongli % 100)
    + (year_nongli % 100)/4 + 3 * (month_nongli + 1)/5 + day_nongli - 3;

    int zhi = gan + 4 * (year_nongli/100) + 10 + (month_nongli % 2 == 0 ? 6 : 0);
    
    NSArray* array_gan = [NSArray arrayWithObjects:@"癸",@"甲",@"乙",@"丙",@"丁",@"戊",@"己",@"庚",@"辛",@"壬", nil];
    NSArray* array_zhi = [NSArray arrayWithObjects:@"亥",@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌", nil];
    ganZhi = [NSString stringWithFormat:@"%@%@",[array_gan objectAtIndex:gan%10],[array_zhi objectAtIndex:zhi%12]];
    return ganZhi;
}
//阴历日期汉字输出
-(NSMutableString *)GetDay:(int)_m d:(int)_d
{
    
    NSArray *  ary1=[[[NSArray alloc] initWithObjects:[NSString stringWithFormat:@""],[NSString stringWithFormat:@"一"],[NSString stringWithFormat:@"二"],[NSString stringWithFormat:@"三"],[NSString stringWithFormat:@"四"],[NSString stringWithFormat:@"五"],[NSString stringWithFormat:@"六"],[NSString stringWithFormat:@"七"],[NSString stringWithFormat:@"八"],[NSString stringWithFormat:@"九"],[NSString stringWithFormat:@"十"],nil] autorelease];
    NSArray *  ary2=[[[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"初"],[NSString stringWithFormat:@"十"],[NSString stringWithFormat:@"廿"],[NSString stringWithFormat:@"卅"],nil] autorelease];
    NSMutableString *s = [[[NSMutableString alloc]init] autorelease];
    if (_m == 1) {
        [s  appendFormat:@"正"];
    }
    else if (_m > 10)
    {
        if (_m == 11) {
            [s  appendFormat:@"冬"];
        }
        if (_m == 12) {
            [s  appendFormat:@"腊"];
        }
    }
    else
        [s  appendFormat:@"%@",[ary1 objectAtIndex:_m]];
    [s  appendFormat:@"月"];
    
    switch (_d) {
        case 10:
            [s  appendFormat:@"初十"];
            break;
        case 20:
            [s  appendFormat:@"二十"];
            break;
        case 30:
            [s  appendFormat:@"三十"];
            break;
        default:[s  appendFormat:@"%@",[ary2 objectAtIndex:(int)(_d/10)]];
            break;
    }
    if(_d != 10 && _d != 20 && _d != 30)
    {
        [s  appendFormat:@"%@",[ary1 objectAtIndex:(_d%10)]];
    }
    return s;
}


-(NSMutableString *)GetHoliday:(NSString *)_yday nday:(NSString *)_nday
{
    NSMutableString *ss = [[[NSMutableString alloc]init] autorelease];
    int yaday = [_nday intValue];
    int yday = [_yday intValue];
    NSDictionary *mDay = [[[NSDictionary alloc] initWithObjectsAndKeys:@"59",@"2010", @"58",@"2011",@"513",@"2012",@"512",@"2013",@"511",@"2014",@"510",@"2015",@"58",@"2016",nil] autorelease];
    NSDictionary *fDay = [[[NSDictionary alloc] initWithObjectsAndKeys:@"620",@"2010", @"619",@"2011",@"617",@"2012",@"616",@"2013",@"615",@"2014",@"621",@"2015",@"619",@"2016",nil] autorelease];
    NSDictionary *ganENDay = [[[NSDictionary alloc] initWithObjectsAndKeys:@"1125",@"2010", @"1124",@"2011",@"1122",@"2012",@"1128",@"2013",@"1127",@"2014",@"1126",@"2015",@"1124",@"2016",nil] autorelease];
    int an[15] = {11,214,38,312,41,45,51,54,61,71,81,910,101,111,1225};//阳历节日
    int by[7] = {11,115,55,77,815,99,128};//阴历节日
    //阳历， 感恩节 父亲节 母亲节    11月的第四个星期四   6月的第三个星期日 5月第二个星期日
    NSArray *lFtvAry=[[[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"元旦"],[NSString stringWithFormat:@"情人节"],[NSString stringWithFormat:@"国际妇女节"],[NSString stringWithFormat:@"中国植树节"],[NSString stringWithFormat:@"愚人节"],[NSString stringWithFormat:@"清明节"],[NSString stringWithFormat:@"国际劳动节"],[NSString stringWithFormat:@"中国青年节"],[NSString stringWithFormat:@"国际儿童节"],[NSString stringWithFormat:@"中国共产党诞生纪念日"],[NSString stringWithFormat:@"中国解放军建军节"],[NSString stringWithFormat:@"教师节"],[NSString stringWithFormat:@"国庆节"],[NSString stringWithFormat:@"万圣节"],[NSString stringWithFormat:@"圣诞节"], nil] autorelease];
    //阴历
    NSArray *sFtvAry=[[[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"春节"],[NSString stringWithFormat:@"元宵节"],[NSString stringWithFormat:@"端午节"],[NSString stringWithFormat:@"七夕节"],[NSString stringWithFormat:@"中秋节"],[NSString stringWithFormat:@"重阳节"],[NSString stringWithFormat:@"腊八节"], Nil] autorelease];
    
    if(yaday == 11 )
    {
        int i = 0;
        [ss appendFormat:@" %@",[lFtvAry objectAtIndex:i]];
    }
    else if( yday == 11)
    {
        int j = 0;
        [ss appendFormat:@" %@",[sFtvAry objectAtIndex:j]];
    }
    else
    {
        int i = 1;
        while (yday != by[i] && i < 7)
            i++;
        if( i < 7 )
            [ss appendFormat:@" %@",[sFtvAry objectAtIndex:i]];
        
        int j = 1;
        while (yaday != an[j] && j < 15)
            j++;
        if(j < 15)
            [ss appendFormat:@" %@",[lFtvAry objectAtIndex:j]];
    }
    
    if(selectmonth == 5)
    {
        if( yaday-[[mDay objectForKey:[NSString stringWithFormat:@"%d",lunar_year]] intValue] == 0)
        {
            [ss appendFormat:@" 母亲节"];
        }
    }
    
    if(selectmonth == 6)
    {
        if( yaday-[[fDay objectForKey:[NSString stringWithFormat:@"%d",lunar_year]] intValue] == 0)
        {
            [ss appendFormat:@" 父亲节"];
        }
    }
    
    if(selectmonth == 11)
    {
        if( yaday-[[ganENDay objectForKey:[NSString stringWithFormat:@"%d",lunar_year]] intValue] == 0)
        {
            [ss appendFormat:@" 感恩节"];
        }
    }
    return ss;
}

-(NSString *)GetYinDate:(unsigned int)kp_year kp_month:(unsigned char)kp_month kp_day:(unsigned char) kp_day
{
    return [self solar_lunar:solar_year kp_month:kp_month kp_day:kp_day];
}
-(NSString *)GetSj
{
    NSString *ss = [NSString stringWithFormat:@"%@ %@",[self GetJQ:solar_year Month:solar_month Day:solar_day IADAY:NO],[self GetHoliday:ydays nday:ndays]];
    return ss;
}

 /*
    　　计算公式：[Y*D+C]-L
  只返回 天
  */
-(int)GetJieQiDay:(int)year_yang D_:(float)D C_:(float)C 
{
    if (year_yang < 1900) {
        return 4;//默认 2.4号
    }
    int end2 = year_yang % 100;
    //注：当年份在闰年的时候（ 如 2004 2008 2016、、）并且在一二月份
    //run = (end2 - 1)/4
    if (end2 % 4 == 0 && (selectmonth == 1 || selectmonth == 2)) {
        end2 -= 1;
    }
    int run = end2/4;
    int jieqiDate = (end2 * D + C) - run;
//    NSLog(@"节气：%d---------%d\n",year_yang,jieqiDate);
 
    return jieqiDate;
}

/*
 24节气    20世纪是1901年到2000年
 立春日期的计算
 　　计算公式：[Y*D+C]-L
 　　公式解读：年数的后2位乘0.2422加3.87取整数减闰年数。20世纪C值=4.6295 21世纪C值=3.87，22世纪C值=4.15。
 　　举例说明：2058年立春日期的计算步骤[58×.0.2422+3.87]-[(58-1)/4]=17-14=3，则2月3日立春。
 雨水日期的计算 [Y*D+C]-L
 　　公式解读：年数的后2位乘0.2422加18.74取整数减闰年数。21世纪雨水的C值18.73。??????20世纪
 　　举例说明：2008年雨水日期=[8×.0.2422+18.73]-[(8-1)/4]=20-1=19，2月19日雨水。
 　　例外：2026年计算得出的雨水日期应调减一天为18日。
 惊蛰日期的计算 [Y*D+C]-L
 　　公式解读：年数的后2位乘0.2422加5.63取整数减闰年数。21世纪惊蛰的C值=5.63。??????20世纪
 　　举例说明：2088年惊蛰日期=[88×.0.2422+5.63]-[88/4]=26-22=4，3月4日是惊蛰。
 　　例外：无。
 春分日期的计算 [Y*D+C]-L
 　　公式解读：年数的后2位乘0.2422加20.646取整数减闰年数。21世纪春分的C值=20.646。??????20世纪
 　　举例说明：2092年春分日期=[92×.0.2422+20.646]-[92/4]=42-23=19，3月19日是春分。
 　　例外：2084年的计算结果加1日。
 清明节日期的计算 [Y*D+C]-L
 　　公式解读：Y=年数后2位，D=0.2422，L=闰年数，21世纪C=4.81，20世纪=5.59。
 　　举例说明：2088年清明日期=[88×.0.2422+4.81]-[88/4]=26-22=4，4月4日是清明。
 　　例外：无。
 谷雨节日期的计算 [Y*D+C]-L
 　　公式解读：Y=年数后2位，D=0.2422，L=闰年数，21世纪C=20.1，20世纪=20.888。
 　　举例说明：2088年谷雨日期=[88×.0.2422+20.1]-[88/4]=41-22=19，4月19日是谷雨。
 　　例外：无。
 立夏日期的计算 [Y*D+C]-L
 　　公式解读：Y=年数后2位，D=0.2422，L=闰年数，21世纪C=5.52，20世纪=6.318。
 　　举例说明：2088年立夏日期=[88×.0.2422+5.52]-[88/4]=26-22=4，5月4日是立夏。
 　　例外：1911年的计算结果加1日。
 小满日期的计算 [Y*D+C]-L
 　　公式解读：Y=年数后2位，D=0.2422，L=闰年数，21世纪C=21.04，20世纪=21.86。
 　　举例说明：2088年小满日期=[88×.0.2422+21.04]-[88/4]=42-22=20，5月20日小满。
 　　例外：2008年的计算结果加1日。
 芒种日期的计算 [Y*D+C]-L
 　　公式解读：Y=年数后2位，D=0.2422，L=闰年数，21世纪C=5.678，20世纪=6.5。
 　　举例说明：2088年芒种日期=[88×.0.2422+5.678]-[88/4]=26-22=4，6月4日芒种。
 　　例外：1902年的计算结果加1日。
 夏至日期的计算 [Y*D+C]-L
 　　公式解读：Y=年数后2位，D=0.2422，L=闰年数，21世纪C=21.37，20世纪=22.20。
 　　举例说明：2088年夏至日期=[88×.0.2422+21.37]-[88/4]=42-22=20，6月20日夏至。
 　　例外：1928年的计算结果加1日。
 小暑日期的计算 [Y*D+C]-L
 　　公式解读：Y=年数后2位，D=0.2422，L=闰年数，21世纪C=7.108，20世纪=7.928。
 　　举例说明：2088年小暑日期= [88×0.2422+7.108]-[88/4]=28-22=6，7月6日是小暑。
 　　例外：1925年和2016年的计算结果加1日。
 大暑日期的计算 [Y*D+C]-L
 　　公式解读：Y=年数后2位，D=0.2422，L=闰年数，21世纪C=22.83，20世纪=23.65。
 　　举例说明：2088年大暑日期= [88×0.2422+22.83]-[88/4]=44-22=22，7月22日大暑。
 　　例外：1922年的计算结果加1日。
 立秋日期的计算 [Y*D+C]-L
 　　公式解读：Y=年数后2位，D=0.2422，L=闰年数，21世纪C=7.5，20世纪=8.35。
 　　举例说明：2088年立秋日期=[88×0.2422+7.5]-[88/4]=28-22=6，8月6日是立秋。
 　　例外：2002年的计算结果加1日。
 处暑日期的计算 [Y*D+C]-L
 　　公式解读：Y=年数后2位，D=0.2422，L=闰年数，21世纪C=23.13，20世纪=23.95。
 　　举例说明：2088年处暑日期=[88×0.2422+23.13]-[88/4]=44-22=22，8月22日处暑。
 　　例外：无。
 白露日期的计算 [Y*D+C]-L
 　　公式解读：Y=年数后2位，D=0.2422，L=闰年数，21世纪C=7.646，20世纪=8.44。
 　　举例说明：2088年白露日期=[88×0.2422+7.646]-[88/4]=28-22=6，9月6日是白露。
 　　例外：1927年的计算结果加1日。
 秋分日期的计算 [Y*D+C]-L
 　　公式解读：Y=年数后2位，D=0.2422，L=闰年数，21世纪C=23.042，20世纪=23.822。
 　　举例说明：2088年秋分日期=[8×.0.2422+23.042]-[88/4]=44-22=22，9月22日是秋分。
 　　例外：1942年的计算结果加1日。
 寒露日期的计算 [Y*D+C]-L
 　　公式解读：Y=年数后2位，D=0.2422，L=闰年数，21世纪C=8.318，20世纪=9.098。
 　　举例说明：2088年寒露日期=[88×0.2422+8.318]-[88/4]=29-22=7，10月7日是寒露。
 　　例外：无。
 霜降日期的计算 [Y*D+C]-L
 　　公式解读：Y=年数后2位，D=0.2422，L=闰年数，21世纪C=23.438，20世纪=24.218。
 　　举例说明：2088年霜降日期=[88×0.2422+23.438]-[88/4]=44-22=22，10月22日霜降。
 　　例外：2089年的计算结果加1日。
 立冬日期的计算 [Y*D+C]-L
 　　公式解读：Y=年数后2位，D=0.2422，L=闰年数，21世纪C=7.438，20世纪=8.218。
 　　举例说明：2088年立冬日期=[88×0.2422+7.438]-[88/4]=28-22=6，11月6日是立冬。
 　　例外：2089年的计算结果加1日。
 小雪日期的计算 [Y*D+C]-L
 　　公式解读：Y=年数后2位，D=0.2422，L=闰年数，21世纪C=22.36，20世纪=23.08。
 　　举例说明：2088年小雪日期=[88×0.2422+22.36]-[88/4]=43-22=21，11月21日小雪。
 　　例外：1978年的计算结果加1日。
 大雪日期的计算 [Y*D+C]-L
 　　公式解读：Y=年数后2位，D=0.2422，L=闰年数，21世纪C=7.18，20世纪=7.9。
 　　举例说明：2088年大雪日期=[88×0.2422+7.18]-[88/4]=28-22=6，12月6日大雪。
 　　例外：1954年的计算结果加1日。
 冬至日期的计算 [Y*D+C]-L
 　　公式解读：Y=年数后2位，D=0.2422，L=闰年数，21世纪C=21.94，20世纪=22.60。
 　　举例说明：2088年冬至日期=[88×0.2422+21.94]-[88/4]=43-22=21，12月21日冬至。
 　　例外：1918年和2021年的计算结果减1日。
 小寒日期的计算 [Y*D+C]-L
 　　公式解读：Y=年数后2位，D=0.2422，L=闰年数，21世纪C=5.4055，20世纪=6.11。
 　　举例说明：1988年小寒日期=[88×.0.2422+6.11]-[(88-1)/4]=27-21=6，1月6日小寒。
 　　例外：1982年计算结果加1日，2019年减1日。
 大寒日期的计算 [Y*D+C]-L
 　　公式解读：Y=年数的后2位，D=0.2422，L=闰年数，21世纪C=20.12，20世纪C=20.84。
 　　举例说明：2089年大寒日期=[89×0.2422+20.12]-[(89-1)/4]=41-22=19，1月19日大寒。
 　　例外：2082年的计算结果加1日，20世纪无。
 */
//isday == yes  代表获取的是农历月份
-(NSString *)GetJQ:(int)year Month:(int)month Day:(int)day IADAY:(BOOL)isday//二十四节气
{
    NSArray *jqary = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"立春"],[NSString stringWithFormat:@"雨水"],[NSString stringWithFormat:@"惊蛰"],[NSString stringWithFormat:@"春分"],[NSString stringWithFormat:@"清明"],[NSString stringWithFormat:@"谷雨"],[NSString stringWithFormat:@"立夏"],[NSString stringWithFormat:@"小满"],[NSString stringWithFormat:@"芒种"],[NSString stringWithFormat:@"夏至"],[NSString stringWithFormat:@"小暑"],[NSString stringWithFormat:@"大暑"],[NSString stringWithFormat:@"立秋"],[NSString stringWithFormat:@"处暑"],[NSString stringWithFormat:@"白露"],[NSString stringWithFormat:@"秋分"],[NSString stringWithFormat:@"寒露"],[NSString stringWithFormat:@"霜降"],[NSString stringWithFormat:@"立冬"],[NSString stringWithFormat:@"小雪"],[NSString stringWithFormat:@"大雪"],[NSString stringWithFormat:@"冬至"],[NSString stringWithFormat:@"小寒"],[NSString stringWithFormat:@"大寒"], nil];
    
    NSString *ss = @"";
    float D = 0.2422;
    //立春
    int lichunDay = [self GetJieQiDay:year D_:D C_:(year <= 2000 ? 4.6295:3.87)];
    
    //雨水 2026年计算得出的雨水日期应调减一天为18日。
    int yushuiDay = [self GetJieQiDay:year D_:D C_:18.73];
    yushuiDay = (year == 2026 ? yushuiDay + 1 : yushuiDay);
    
    //惊蛰
    int jingzheDay = [self GetJieQiDay:year D_:D C_:5.63];
    //春分 2084年的计算结果加1日。
    int chunfenDay = [self GetJieQiDay:year D_:D C_:20.646];
    chunfenDay = (year == 2084 ? chunfenDay + 1 : chunfenDay);
 
    //清明
    int qingmingDay = [self GetJieQiDay:year D_:D C_:(year <= 2000 ? 5.59:4.81)];
 
    //谷雨
    int guyuDay = [self GetJieQiDay:year D_:D C_:(year <= 2000 ? 20.888:20.1)];
    //立夏 1911年的计算结果加1日。
    int lixiaDay = [self GetJieQiDay:year D_:D C_:(year <= 2000 ? 6.318:5.52)];
    lixiaDay = (year == 1911 ? lixiaDay + 1 : lixiaDay);
    
    //小满 2008年的计算结果加1日。
    int xiaomanDay = [self GetJieQiDay:year D_:D C_:(year <= 2000 ? 21.86:21.04)];
    xiaomanDay = (year == 2008 ? xiaomanDay + 1 : xiaomanDay);
    
    //芒种
    int mangzhongDay = [self GetJieQiDay:year D_:D C_:(year <= 2000 ? 6.5:5.678)];
 
    //夏至 1928年的计算结果加1日
    int xiazhiDay = [self GetJieQiDay:year D_:D C_:(year <= 2000 ? 22.20:21.37)];
    xiazhiDay = (year == 1928 ? xiazhiDay + 1 : xiazhiDay);
    
    //小暑  1925年和2016年的计算结果加1日。
    int xiaoshuDay = [self GetJieQiDay:year D_:D C_:(year <= 2000 ? 7.928:7.108)];
    xiaoshuDay = (year == 1925 || year == 2016 ? xiaoshuDay + 1 : xiaoshuDay);
    
    //大暑
    int dashuDay = [self GetJieQiDay:year D_:D C_:(year <= 2000 ? 23.65:22.83)];
    dashuDay = (year == 1922  ? dashuDay + 1 : dashuDay);
    
    //立秋
    int liqiuDay = [self GetJieQiDay:year D_:D C_:(year <= 2000 ? 8.35:7.5)];
    liqiuDay = (year == 2002  ? liqiuDay + 1 : liqiuDay);
    
    //处暑
    int chushuDay = [self GetJieQiDay:year D_:D C_:(year <= 2000 ? 23.95:23.13)];
 
    //白露
    int bailuDay = [self GetJieQiDay:year D_:D C_:(year <= 2000 ? 8.44:7.646)];
    bailuDay = (year == 1927  ? bailuDay + 1 : bailuDay);
    
    //秋分
    int qiufenDay = [self GetJieQiDay:year D_:D C_:(year <= 2000 ? 23.822:23.042)];
    qiufenDay = (year == 1942  ? qiufenDay + 1 : qiufenDay);
    
    //寒露
    int hanluDay = [self GetJieQiDay:year D_:D C_:(year <= 2000 ? 9.098:8.318)];
    //霜降
    int shuangjiangDay = [self GetJieQiDay:year D_:D C_:(year <= 2000 ? 24.218:23.438)];
    shuangjiangDay = (year == 2089  ? shuangjiangDay + 1 : shuangjiangDay);
    //立冬
    int lidongDay = [self GetJieQiDay:year D_:D C_:(year <= 2000 ? 8.218:7.438)];
    lidongDay = (year == 2089  ? lidongDay + 1 : lidongDay);
 
    //小雪
    int xiaoxueDay = [self GetJieQiDay:year D_:D C_:(year <= 2000 ? 23.08:22.36)];
    xiaoxueDay = (year == 1978  ? xiaoxueDay + 1 : xiaoxueDay);
    //大雪
    int daxueDay = [self GetJieQiDay:year D_:D C_:(year <= 2000 ? 7.9:7.18)];
    daxueDay = (year == 1954  ? daxueDay + 1 : daxueDay);
    //冬至
    int dongzhiDay = [self GetJieQiDay:year D_:D C_:(year <= 2000 ? 22.60:21.94)];
    dongzhiDay = (year == 1918 || year == 2021 ? dongzhiDay - 1 : dongzhiDay);
    //小寒
    int xiaohanDay = [self GetJieQiDay:year D_:D C_:(year <= 2000 ? 6.11:5.4055)];
    if (year == 1982) {
        xiaohanDay +=  1;
    }
    if (year == 2019) {
        xiaohanDay -= 1;
    }
    //大寒
    int dahanDay = [self GetJieQiDay:year D_:D C_:(year <= 2000 ? 20.84:20.12)];
    dahanDay = (year == 2082 ? dahanDay + 1 : dahanDay);
 
 
    NSString*  dateString = [NSString stringWithFormat:@"%d%02d",month,day];
    NSString*  min_jiqiDateString = @"";
    NSString*  max_jiqiDateString = @"";
    if (isday) {
        if (month == 2 || month == 3) {
            min_jiqiDateString = [NSString stringWithFormat:@"%d%02d",2,lichunDay];
            max_jiqiDateString = [NSString stringWithFormat:@"%d%02d",3,jingzheDay];
            if ([self betweenDate:[min_jiqiDateString intValue] B_Date:[dateString intValue] MAX_DATE:[max_jiqiDateString intValue]]) {
                ss = @"1";//一月份
            }
        }
        if (month == 3 || month == 4) {
            min_jiqiDateString = [NSString stringWithFormat:@"%d%02d",3,jingzheDay];
            max_jiqiDateString = [NSString stringWithFormat:@"%d%02d",4,qingmingDay];
            if ([self betweenDate:[min_jiqiDateString intValue] B_Date:[dateString intValue] MAX_DATE:[max_jiqiDateString intValue]]) {
                ss = @"2";//2月份
            }
        }
        if (month == 4 || month == 5) {
            min_jiqiDateString = [NSString stringWithFormat:@"%d%02d",4,qingmingDay];
            max_jiqiDateString = [NSString stringWithFormat:@"%d%02d",5,lixiaDay];
            if ([self betweenDate:[min_jiqiDateString intValue] B_Date:[dateString intValue] MAX_DATE:[max_jiqiDateString intValue]]) {
                ss = @"3";//3月份
            }
        }
        if (month == 5 || month == 6) {
            min_jiqiDateString = [NSString stringWithFormat:@"%d%02d",5,lixiaDay];
            max_jiqiDateString = [NSString stringWithFormat:@"%d%02d",6,mangzhongDay];
            if ([self betweenDate:[min_jiqiDateString intValue] B_Date:[dateString intValue] MAX_DATE:[max_jiqiDateString intValue]]) {
                ss = @"4";//4月份
            }
        }
        if (month == 6 || month == 7) {
            min_jiqiDateString = [NSString stringWithFormat:@"%d%02d",6,mangzhongDay];
            max_jiqiDateString = [NSString stringWithFormat:@"%d%02d",7,xiaoshuDay];
            if ([self betweenDate:[min_jiqiDateString intValue] B_Date:[dateString intValue] MAX_DATE:[max_jiqiDateString intValue]]) {
                ss = @"5";//一月份
            }
        }
        if (month == 7 || month == 8) {
            min_jiqiDateString = [NSString stringWithFormat:@"%d%02d",7,xiaoshuDay];
            max_jiqiDateString = [NSString stringWithFormat:@"%d%02d",8,liqiuDay];
            if ([self betweenDate:[min_jiqiDateString intValue] B_Date:[dateString intValue] MAX_DATE:[max_jiqiDateString intValue]]) {
                ss = @"6";//一月份
            }
        }
        if (month == 8 || month == 9) {
            min_jiqiDateString = [NSString stringWithFormat:@"%d%02d",8,liqiuDay];
            max_jiqiDateString = [NSString stringWithFormat:@"%d%02d",9,bailuDay];
            if ([self betweenDate:[min_jiqiDateString intValue] B_Date:[dateString intValue] MAX_DATE:[max_jiqiDateString intValue]]) {
                ss = @"7";//一月份
            }
        }
        if (month == 9 || month == 10) {
            min_jiqiDateString = [NSString stringWithFormat:@"%d%02d",9,bailuDay];
            max_jiqiDateString = [NSString stringWithFormat:@"%d%02d",10,hanluDay];
            if ([self betweenDate:[min_jiqiDateString intValue] B_Date:[dateString intValue] MAX_DATE:[max_jiqiDateString intValue]]) {
                ss = @"8";//一月份
            }
        }
        if (month == 10 || month == 11) {
            min_jiqiDateString = [NSString stringWithFormat:@"%d%02d",10,hanluDay];
            max_jiqiDateString = [NSString stringWithFormat:@"%d%02d",11,lidongDay];
            if ([self betweenDate:[min_jiqiDateString intValue] B_Date:[dateString intValue] MAX_DATE:[max_jiqiDateString intValue]]) {
                ss = @"9";//一月份
            }
        }
        if (month == 11 || month == 12) {
            min_jiqiDateString = [NSString stringWithFormat:@"%d%02d",11,lidongDay];
            max_jiqiDateString = [NSString stringWithFormat:@"%d%02d",12,daxueDay];
            if ([self betweenDate:[min_jiqiDateString intValue] B_Date:[dateString intValue] MAX_DATE:[max_jiqiDateString intValue]]) {
                ss = @"10";//一月份
            }
        }
        if (month == 12 || month == 1) {
            min_jiqiDateString = [NSString stringWithFormat:@"%d%02d",12,daxueDay];
            if (month == 1) {
                dateString = [NSString stringWithFormat:@"%d%02d",13,day];
            }
            max_jiqiDateString = [NSString stringWithFormat:@"%d%02d",/*1注意*/13,xiaohanDay];
            if ([self betweenDate:[min_jiqiDateString intValue] B_Date:[dateString intValue] MAX_DATE:[max_jiqiDateString intValue]]) {
                ss = @"11";//一月份
            }
            //还原
            dateString = [NSString stringWithFormat:@"%d%02d",month,day];
        }
        if (month == 1 || month == 2) {
            min_jiqiDateString = [NSString stringWithFormat:@"%d%02d",1,xiaohanDay];
            max_jiqiDateString = [NSString stringWithFormat:@"%d%02d",2,lichunDay];
            if ([self betweenDate:[min_jiqiDateString intValue] B_Date:[dateString intValue] MAX_DATE:[max_jiqiDateString intValue]]) {
                ss = @"12";//一月份
            }
        }
    }
    else
    {
        if (month == 2 && day == lichunDay)
        {
            ss = [jqary objectAtIndex:0];
        }
        else if(month == 2 && day == yushuiDay)
        {
            ss = [jqary objectAtIndex:1];
        }
        else if(month == 3 && day == jingzheDay)
        {
            ss = [jqary objectAtIndex:2];
        }
        else if( month == 3 && day == chunfenDay)
        {
            ss = [jqary objectAtIndex:3];
        }
        else if(month == 4 && day == qingmingDay)
        {
            ss = [jqary objectAtIndex:4];
        }
        else if(month == 4 && day == guyuDay)
        {
            ss = [jqary objectAtIndex:5];
        }
        else if(month == 5 && day == lixiaDay)
        {
            ss = [jqary objectAtIndex:6];
        }
        else if(month == 5 && day == xiaomanDay)
        {
            ss = [jqary objectAtIndex:7];
        }
        else if(month == 6 && day == mangzhongDay)
        {
            ss = [jqary objectAtIndex:8];
        }
        else if(month == 6 && day == xiazhiDay)
        {
            ss = [jqary objectAtIndex:9];
        }
        else if(month == 7 && day == xiaoshuDay)
        {
            ss = [jqary objectAtIndex:10];
        }
        else if( month == 7 && day == dashuDay)
        {
            ss = [jqary objectAtIndex:11];
        }
        else if(month == 8 && day == liqiuDay)
        {
            ss = [jqary objectAtIndex:12];
        }
        else if(month == 8 && day == chushuDay)
        {
            ss = [jqary objectAtIndex:13];
        }
        else if(month == 9 && day == bailuDay)
        {
            ss = [jqary objectAtIndex:14];
        }
        else if( month == 9 && day == qiufenDay)
        {
            ss = [jqary objectAtIndex:15];
        }
        else if(month == 10 && day == hanluDay)
        {
            ss = [jqary objectAtIndex:16];
        }
        else if(month == 10 && day == shuangjiangDay)
        {
            ss = [jqary objectAtIndex:17];
        }
        else if(month == 11 && day == lidongDay)
        {
            ss = [jqary objectAtIndex:18];
        }
        else if(month == 11 && day == xiaoxueDay)
        {
            ss = [jqary objectAtIndex:19];
        }
        else if(month == 12 && day == daxueDay)
        {
            ss = [jqary objectAtIndex:20];
        }
        else if(month == 12 && day == dongzhiDay)
        {
            ss = [jqary objectAtIndex:21];
        }
        else if(month == 1 && day == xiaohanDay)
        {
            ss = [jqary objectAtIndex:22];
        }
        else if(month == 1 && day == dahanDay)
        {
            ss = [jqary objectAtIndex:23];
        }
    }

    [jqary release];
    return ss;
}
//比较的日期 大于等于当前日期 就返回true
-(BOOL)MaxDate:(int)c_month C_DAY:(int)c_day M_MONTH:(int)m_month M_Day:(int)m_day
{
    if (c_month > m_month) {
        return TRUE;
    }
    if (c_month == m_month) {
        if (c_day >= m_day) {
            return TRUE;
        }
        else
            return FALSE;
    }
    if (c_month < m_month) {
        return  FALSE;
    }
    return TRUE;
}

/*
 min<= b < max
 */
-(BOOL)betweenDate:(int)min_Date B_Date:(int)b_date MAX_DATE:(int)max_date
{
    if (b_date >= min_Date && b_date < max_date) {
        return TRUE;
    }
    
    return FALSE;
    
}
@end
