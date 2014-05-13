//
//  CanlendarViewController.m
//  Canlendar
//
//  Created by xie mengyue on 11-7-15.
//  Copyright 2011年 beyondsoft. All rights reserved.
//

#import "CanlendarViewController.h"
#import "TdCalendarView.h"
#import "Cal.h"
#import "Common.h"
#import "SidebarViewController.h"
#import "CanlendarAppDelegate.h"
#import "yongshiyiji.h"

#define kDetailViewHeight (MY_IOS_VERSION_7 ? 150 - 10 : 150)

@interface CanlendarViewController (internal)

- (void)setupDetailView;
-(void)datePickerCancelClick:(id)sender;
-(void)datePickerDoneClick:(id)sender;

@end

@implementation CanlendarViewController

@synthesize tdCalendarView,detailView,selectedRow,backDate,startDate,dayArray,monthArray,yearArray,selectedYearRow,selectedMonthRow,seletdate;
 
- (void)dealloc
{
    [bannerAD release];
    [detailView release];
    [tdCalendarView release];
 
    [m_datePickerSheet release];
    [lable1_year_ganzhi release];
    [yearImage release];
    [lable1 release];
    [lable2 release];
    [lable3 release];
    [lable4 release];
    [m_yongshiyiji release];
    [super dealloc];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    //用事宜忌
	self.startDate = [self getCurrentDate];
	self.backDate = [self getDefaultBackDate];
	self.selectedYearRow = -1;
	self.selectedMonthRow = -1;
	self.selectedRow = @"1";
 
	[self setYearArray];
	[self setMonthArry];
	[self setDayArray];
 
    //背景
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mainbackground.jpg"]];
 
    //当前日期
    UIButton* todayButton = [[UIButton alloc] initWithFrame:CGRectMake(0, VIEW_TOP_MARGIN, 60, 30)];
    [todayButton addTarget:self action: @selector(SetTodayDate) forControlEvents:UIControlEventTouchUpInside];
    [todayButton setImage:[UIImage imageNamed:@"today.png"] forState:UIControlStateNormal];
    todayButton.showsTouchWhenHighlighted = TRUE;
    [self.view addSubview:todayButton];
    [todayButton release];
    //设置
    UIButton* setupButton = [[UIButton alloc] initWithFrame:CGRectMake(260, VIEW_TOP_MARGIN, 60, 30)];
    [setupButton addTarget:self action: @selector(SetSelectDate) forControlEvents:UIControlEventTouchUpInside];
    [setupButton setImage:[UIImage imageNamed:@"setupbutton.png"] forState:UIControlStateNormal];
    setupButton.showsTouchWhenHighlighted = TRUE;
    [self.view addSubview:setupButton];
    [setupButton release];
 
    NSLog(@"%@",self.view);
    detailView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - kDetailViewHeight, 320, kDetailViewHeight)];
    detailView.delegate = self;
    detailView.scrollEnabled = YES;
//    detailView.contentSize = CGSizeMake(320, 250);
    detailView.backgroundColor = 
    [UIColor colorWithPatternImage:[UIImage imageNamed:@"showview.png"]];
    [self.view addSubview:detailView];
    if (iPhone5) {
        UIImageView* imageview = [[[UIImageView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - kDetailViewHeight - 77, 320, 77)] autorelease];
        imageview.image = [UIImage imageNamed:@"daybg.png"];
        [self.view addSubview:imageview];
        
        NSString* geyanjingju_text = [(CanlendarAppDelegate*)[[UIApplication sharedApplication] delegate] get_UMeng_geyanjingju];
 
        geyanjingjuView = [[UITextView alloc] initWithFrame:CGRectMake(90, [UIScreen mainScreen].bounds.size.height - kDetailViewHeight - 52, 220, 52)];
        geyanjingjuView.text = geyanjingju_text;
        [geyanjingjuView setTextColor:[UIColor colorWithRed:170.0/255.0 green:56.0/255.0 blue:9.0/255.0 alpha:1.0]];
        [geyanjingjuView setFont:[UIFont systemFontOfSize:12.0f]];
        [geyanjingjuView setBackgroundColor:[UIColor clearColor]];
        geyanjingjuView.scrollEnabled = YES;
        geyanjingjuView.editable = NO;
        [self.view addSubview:geyanjingjuView];
        [geyanjingjuView release];
    }
    
    /*
     ;用来分隔开年 月日 :用于分隔开天干地支纪法
     "龙年:壬申年;腊月十四:壬子月 辛丑日"
     */
    NSArray* dataStringArray = [self.startDate componentsSeparatedByString:@";"];
    NSString* year_animals = [[[dataStringArray objectAtIndex:0] componentsSeparatedByString:@":"] objectAtIndex:0];
    NSString* year_nongli = [[[dataStringArray objectAtIndex:0] componentsSeparatedByString:@":"] objectAtIndex:1];
    
    NSString* date_nongli = [[[dataStringArray objectAtIndex:1] componentsSeparatedByString:@":"] objectAtIndex:0];
    
    NSString* date_ganzhi = [[[dataStringArray objectAtIndex:1] componentsSeparatedByString:@":"] objectAtIndex:1];
    
    yearImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40,30)];
    yearImage.image = [UIImage imageNamed:@"yearbackground.png"];
    UILabel* yearLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    yearLable.text = year_animals;
    yearLable.textAlignment = UITextAlignmentCenter;
    yearLable.backgroundColor = [UIColor clearColor];
    yearLable.textColor = [UIColor whiteColor];
    yearLable.font = [UIFont systemFontOfSize:18];
    [yearImage addSubview:yearLable];
    [yearLable release];
    [detailView addSubview:yearImage];
    
    
    lable1_year_ganzhi = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, 60, 20)];
    lable1_year_ganzhi.textAlignment = UITextAlignmentLeft;
    lable1_year_ganzhi.backgroundColor = [UIColor clearColor];
    lable1_year_ganzhi.font = [UIFont systemFontOfSize:15];
    lable1_year_ganzhi.text = [NSString stringWithFormat:@"[%@]",year_nongli];
    [detailView addSubview:lable1_year_ganzhi];
    
    lable1 = [[UILabel alloc] initWithFrame:CGRectMake(120, 20, 200, 20)];
    lable1.textAlignment = UITextAlignmentLeft;
    lable1.backgroundColor = [UIColor clearColor];
    lable1.font = [UIFont systemFontOfSize:14];
    lable1.text = [NSString stringWithFormat:@"%@(%@)",date_nongli,date_ganzhi];
    [detailView addSubview:lable1];
    
    lable2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 35, 300, 30)];
    lable2.textAlignment = UITextAlignmentLeft;
    lable2.backgroundColor = [UIColor clearColor];
    lable2.font = [UIFont systemFontOfSize:14];
    lable2.textColor = [UIColor redColor];
    lable2.text = [NSString stringWithFormat:@"事件：%@",self.backDate];
//    [[self.backDate componentsSeparatedByString:@":"] objectAtIndex:0];
    [detailView addSubview:lable2];
 
    //用事 宜忌 用有盟的在线参数获得
    //宜
    lable3 = [[UITextView alloc] initWithFrame:CGRectMake(10, 55, 300, 40/*10,0,300,40*/)];
    lable3.backgroundColor = [UIColor clearColor];
    lable3.font = [UIFont systemFontOfSize:14];
    lable3.editable = NO;
    lable3.textColor = /*[UIColor colorWithRed:170.0/255.0 green:56.0/255.0 blue:9.0/255.0 alpha:1.0]*/
    [UIColor colorWithRed:47.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1.0];
    NSString* str_yi = @"宜：";
    NSArray* array_yi = [NSArray array];
    NSString* selectDate_yongshiyiji = [self getYongshiYiJi];
    NSArray* array_yongshiyiji = [selectDate_yongshiyiji componentsSeparatedByString:@";"];
    if ([[array_yongshiyiji objectAtIndex:0] length] > 0) {
        str_yi = [str_yi stringByAppendingString:[array_yongshiyiji objectAtIndex:0]];
    }
    else//如果在线参数 没获取到的话，调用本地计算
    {
        array_yi = [self getYongshi_tempArray];
        for (int i = 0; i < [array_yi count]; i++) {
            str_yi = [str_yi stringByAppendingFormat:@"%@ ",[array_yi objectAtIndex:i]];
        }
    }
 
    lable3.text = str_yi;
    [detailView addSubview:lable3];
    //忌
    lable4 = [[UITextView alloc] initWithFrame:CGRectMake(10, 95, 300, 40/*10,40,300,40*/)];
    lable4.backgroundColor = [UIColor clearColor];
    lable4.font = [UIFont systemFontOfSize:14];
    lable4.editable = NO;
    lable4.textColor = [UIColor colorWithRed:139.0/255.0 green:0.0 blue:0.0 alpha:1.0];
    NSString* str_Ji = @"忌：";
    NSArray* array_Ji = [NSArray array];
    if ([array_yongshiyiji count] == 2 && [[array_yongshiyiji objectAtIndex:1] length] > 0) {
        str_Ji = [str_Ji stringByAppendingString:[array_yongshiyiji objectAtIndex:1]];
    }
    else
    {
        array_Ji = [self getYongshi_Ji:array_yi];
        for (int i = 0; i < [array_Ji count]; i++) {
            str_Ji = [str_Ji stringByAppendingFormat:@"%@ ",[array_Ji objectAtIndex:i]];
        }
    }
 
    lable4.text = str_Ji;
    [detailView addSubview:lable4];
 
    self.tdCalendarView.calendarViewDelegate = self;
    if (VIEW_TOP_MARGIN) {
        self.tdCalendarView.frame = CGRectMake(0, VIEW_TOP_MARGIN, self.tdCalendarView.bounds.size.width, self.tdCalendarView.bounds.size.height);
    }
    ((CanlendarAppDelegate*)[[UIApplication sharedApplication] delegate]).canlendarViewController = self;
 
    //果盟 广告
    [self OnbannerAD];
    
}

//刷新 友盟数据
-(void)UMENGConfigCall
{
    if (iPhone5) {
        NSString* geyanjingju_text = [(CanlendarAppDelegate*)[[UIApplication sharedApplication] delegate] get_UMeng_geyanjingju];
        geyanjingjuView.text = geyanjingju_text;
    }
 
//    NSString* str_yi = @"宜：";
//    NSArray* array_yi = [NSArray array];
//    if ([[(CanlendarAppDelegate*)[[UIApplication sharedApplication] delegate] get_UMeng_yongshiyiji_YI] length] > 0) {
//        str_yi = [str_yi stringByAppendingString:[(CanlendarAppDelegate*)[[UIApplication sharedApplication] delegate] get_UMeng_yongshiyiji_YI]];
//    }
//    else//如果在线参数 没获取到的话，调用本地计算
//    {
//        array_yi = [self getYongshi_tempArray];
//        for (int i = 0; i < [array_yi count]; i++) {
//            str_yi = [str_yi stringByAppendingFormat:@"%@ ",[array_yi objectAtIndex:i]];
//        }
//    }
//    lable3.text = str_yi;
//    
//    //忌
//    NSString* str_Ji = @"忌：";
//    NSArray* array_Ji = [NSArray array];
//    if ([[(CanlendarAppDelegate*)[[UIApplication sharedApplication] delegate] get_UMeng_yongshiyiji_JI] length] > 0) {
//        str_Ji = [str_Ji stringByAppendingString:[(CanlendarAppDelegate*)[[UIApplication sharedApplication] delegate] get_UMeng_yongshiyiji_JI]];
//    }
//    else
//    {
//        array_Ji = [self getYongshi_Ji:array_yi];
//        for (int i = 0; i < [array_Ji count]; i++) {
//            str_Ji = [str_Ji stringByAppendingFormat:@"%@ ",[array_Ji objectAtIndex:i]];
//        }
//    }
//    lable4.text = str_Ji;

}
#pragma mark  创建 日期选择器
-(void) setupDatePickerSheet
{
    //在iphone中没有点击弹出选择时间的控件，下面就利用ios的UIActionSheet + UIDatePicker + UIToolBar 来实现弹出时间选择控件。代码如下：
    m_datePickerSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    
    m_datePicker = [[[UIDatePicker alloc] initWithFrame:CGRectMake(0.0f, 44.0f, 0.0f, 0.0f)] autorelease];
    /*
     日期 1901 - 2049 
     */
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *tomorrow, *yesterday;
    //以1970年 作为 参考年
    tomorrow = [NSDate dateWithTimeIntervalSince1970:secondsPerDay * 365 * 79];
    yesterday =  [NSDate dateWithTimeIntervalSince1970: -(secondsPerDay * 365 * 69)];
 
    [m_datePicker setMaximumDate:tomorrow];
    [m_datePicker setMinimumDate:yesterday];
    
    
    [m_datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    m_datePicker.timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
    [m_datePicker setDate:[NSDate date]];    //显示当前时间
    [m_datePicker setUserInteractionEnabled:YES];  //
    m_datePicker.datePickerMode = UIDatePickerModeDate; //模式：显示时间
    
    UIToolbar *pickerDateToolBar = [[[UIToolbar alloc]  initWithFrame:CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, 44)] autorelease]; //创建工具条，用来设置或者退出actionsheet.
    pickerDateToolBar.barStyle = UIBarStyleBlackOpaque;
    [pickerDateToolBar sizeToFit];
    
    NSMutableArray *barItems = [[[NSMutableArray alloc] init] autorelease];
    
    UIBarButtonItem *flexSpace = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil] autorelease];
    [barItems addObject:flexSpace];
    UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"取消", nil) style:UIBarButtonSystemItemCancel target:self action:@selector(datePickerCancelClick:)] autorelease];
    [barItems addObject:cancelButton];
    UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"确定", nil) style:UIBarButtonItemStyleDone target:self action:@selector(datePickerDoneClick:)] autorelease];
    //    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(datePickerDoneClick:)];
    [barItems addObject:doneButton];
    
    [pickerDateToolBar setItems:barItems animated:YES]; //将按键加入toolbar
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 11.0f, 100.0f, 22.0f)];
    label.text = NSLocalizedString(@"查看日期", nil);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    [label sizeToFit];
    [pickerDateToolBar addSubview:label];
    
    [m_datePickerSheet addSubview:pickerDateToolBar];
    [m_datePickerSheet addSubview:m_datePicker];
    [m_datePickerSheet showInView: [UIApplication sharedApplication].keyWindow]; //这里使用全局的键盘的view，可以避免在有tabBar或者toolBar的页面，把actionSheet下方挡住。
    [m_datePickerSheet setFrame:CGRectMake(0.0f, [UIScreen mainScreen].bounds.size.height - 260, [UIScreen mainScreen].bounds.size.width, 260)];
//    [m_datePickerSheet setBounds:CGRectMake(0.0f, [UIScreen mainScreen].bounds.size.height - 260, [UIScreen mainScreen].bounds.size.width, 260)];
 
}
-(void)datePickerCancelClick:(id)sender
{
    if (m_datePickerSheet) {
        [m_datePickerSheet dismissWithClickedButtonIndex:0 animated:YES];
    }
}

-(void)datePickerDoneClick:(id)sender
{
    NSDate* date = [NSDate dateWithTimeInterval:0 sinceDate:m_datePicker.date];
    if (m_datePickerSheet) {
        [m_datePickerSheet dismissWithClickedButtonIndex:0 animated:YES];
    }
    
    //获取当前 日期
    NSUInteger unitFlags = NSYearCalendarUnit |NSMonthCalendarUnit|NSDayCalendarUnit;
    NSCalendar * calendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSDateComponents *now = [calendar components:unitFlags fromDate:date];
    int year = [now year];
    int month = [now month];
    int day = [now day];
 
    CFGregorianDate selectDate;
    selectDate.year = year;
    selectDate.month = month;
    selectDate.day = day;
    
    tdCalendarView.currentSelectDate = selectDate;
    tdCalendarView.currentMonthDate = selectDate;
    [self selectDateChanged:selectDate];
    [self.tdCalendarView setNeedsDisplay];

}
- (void) datePicker
{
    [self setupDatePickerSheet];
    m_datePicker.date = [NSDate date];
    
}
#pragma mark - View lifecycle

- (NSString *)getWeekDayFromDate:(NSInteger) date{
	NSString *result = @"";
	switch (date) {
		case 1:
			result = @"星期日";
			break;
		case 2:
			result = @"星期一";
			break;
		case 3:
			result = @"星期二";
			break;
		case 4:
			result = @"星期三";
			break;
		case 5:
			result = @"星期四";
			break;
		case 6:
			result = @"星期五";
			break;
		case 7:
			result = @"星期六";
			break;
		default:
			break;
	}
	return result;
}

- (NSString *) getCurrentDate{
//	NSCalendar *cal = [NSCalendar currentCalendar]; 
//	NSDate *date = [NSDate date];
//    NSDateComponents *components = [cal components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];
//	NSDate *calDate = [cal dateFromComponents:components];
	
//	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
//	[dateFormatter setDateFormat:@"YYYY-MM-dd"];
//	NSString * d1 = [dateFormatter stringFromDate:calDate];
//	[dateFormatter setDateFormat:@"YYYY年MM月dd日"];
//	NSString * d2 = [dateFormatter stringFromDate:calDate];
//	[dateFormatter release];
//	
//	int wd = [components weekday];
// 
//	NSLog(@"^^^^^^^^^^^^^^^^^^%@ %@ %@", d2, [self getWeekDayFromDate:wd], d1 );
 
    NSUInteger unitFlags = NSYearCalendarUnit |NSMonthCalendarUnit|NSDayCalendarUnit;
    NSCalendar * calendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSDate *dates = [NSDate date];
    NSDateComponents *now = [calendar components:unitFlags fromDate:dates];
    int year = [now year];
    int month = [now month];
    int day = [now day];
    Cal *cals = [[[Cal alloc]init] autorelease];
    NSString *ss = [cals solar_lunar:year kp_month:month kp_day:day];
    return ss;
}

-(NSString *) getDefaultBackDate{
	NSCalendar *cal = [NSCalendar currentCalendar]; 
	NSDate *date = [NSDate date];
	NSDateComponents *components = [cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:date];
	components = [cal components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];
	[components setDay:[components day] + 3];
	int wd = [components weekday] + 3;
	if (wd != 7) {
		wd = wd%7;
	}    
    
    NSUInteger unitFlags = NSYearCalendarUnit |NSMonthCalendarUnit|NSDayCalendarUnit;
    NSCalendar * calendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSDate *dates = [NSDate date];
    NSDateComponents *now = [calendar components:unitFlags fromDate:dates];
    int year = [now year];
    int month = [now month];
    int day = [now day];
    NSString *ss  = [self GetEvent:year kp_month:month kp_day:day];   
    NSLog(@"backdate ss ==== %@",ss);
    if( [ss isEqualToString:@""])
        ss = @"无";
    return ss;
}


-(NSString *) GetEvent:(unsigned int)kp_year kp_month:(unsigned char)kp_month kp_day:(unsigned char) kp_day
{
    Cal *cal = [[[Cal alloc]init] autorelease];
    [cal solar_lunar:kp_year kp_month:kp_month kp_day:kp_day];
    NSString *s1 = [cal GetJQ:kp_year Month:kp_month Day:kp_day IADAY:NO];
    NSString *s2 = [cal GetHoliday:cal.ydays nday:cal.ndays];
    return [NSString stringWithFormat:@"%@%@",s1,s2];
}

- (void)setupDetailView
{
    /*
     ;用来分隔开年 月日 :用于分隔开天干地支纪法
     
     "龙年:壬申年;腊月十四:壬子月 辛丑日"
     */
    NSArray* dataStringArray = [self.startDate componentsSeparatedByString:@";"];
    NSString* year_animals = [[[dataStringArray objectAtIndex:0] componentsSeparatedByString:@":"] objectAtIndex:0];
    NSString* year_nongli = [[[dataStringArray objectAtIndex:0] componentsSeparatedByString:@":"] objectAtIndex:1];
    
    NSString* date_nongli = [[[dataStringArray objectAtIndex:1] componentsSeparatedByString:@":"] objectAtIndex:0];
    
    NSString* date_ganzhi = [[[dataStringArray objectAtIndex:1] componentsSeparatedByString:@":"] objectAtIndex:1];
    
    if ([[[yearImage subviews] objectAtIndex:0] isKindOfClass:[UILabel class]]) {
        [(UILabel*)[[yearImage subviews] objectAtIndex:0] setText:year_animals];
    }
    lable1_year_ganzhi.text = [NSString stringWithFormat:@"[%@]",year_nongli];
    lable1.text = [NSString stringWithFormat:@"%@(%@)",date_nongli,date_ganzhi];
    lable2.text = [NSString stringWithFormat:@"事件：%@",self.backDate];
    
    NSString* str_yi = @"宜：";
    NSArray* array_yi = [NSArray array];
    NSString* selectDate_yongshiyiji = [self getYongshiYiJi];
    NSArray* array_yongshiyiji = [selectDate_yongshiyiji componentsSeparatedByString:@";"];
    
    if ([[array_yongshiyiji objectAtIndex:0] length] > 0) {
        str_yi = [str_yi stringByAppendingString:[array_yongshiyiji objectAtIndex:0]];
    }
    else//如果在线参数 没获取到的话，调用本地计算
    {
        array_yi = [self getYongshi_tempArray];
        for (int i = 0; i < [array_yi count]; i++) {
            str_yi = [str_yi stringByAppendingFormat:@"%@ ",[array_yi objectAtIndex:i]];
        }
    }
    lable3.text = str_yi;
    
    //忌
    NSString* str_Ji = @"忌：";
    NSArray* array_Ji = [NSArray array]; 
    if ([array_yongshiyiji count] == 2 && [[array_yongshiyiji objectAtIndex:1] length] > 0) {
        str_Ji = [str_Ji stringByAppendingString:[array_yongshiyiji objectAtIndex:1]];
    }
    else
    {
        array_Ji = [self getYongshi_Ji:array_yi];
        for (int i = 0; i < [array_Ji count]; i++) {
            str_Ji = [str_Ji stringByAppendingFormat:@"%@ ",[array_Ji objectAtIndex:i]];
        }
    }
    lable4.text = str_Ji;
}
 
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(NSString *)getWeekDayByDate:(NSDate *) date{
	NSCalendar *cal = [NSCalendar currentCalendar]; 
	NSDateComponents *comps = [cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:date];
	comps = [cal components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];
	int wd = [comps weekday];
	switch (wd) {
		case 1:
			return @"星期一";
		case 2:
			return@"星期二";
		case 3:
			return@"星期三";
		case 4:
			return@"星期四";
		case 5:
			return@"星期五";
		case 6:
			return@"星期六";
		default:
			return @"星期日";
	}
}

-(void)setDayArray{
	NSCalendar *cal = [NSCalendar currentCalendar]; 
	NSDate *date = [[[NSDate alloc] init] autorelease];
	NSDateComponents *components = [cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:date];
	components = [cal components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];
	
	NSDate *thisMonth = [cal dateFromComponents:components]; 
	[components setMonth:([components month] + 1)];  
	NSDate *nextMonth = [cal dateFromComponents:components]; 
	[components setMonth:([components month]) - 1];
	
	int count=([nextMonth timeIntervalSinceReferenceDate]-[thisMonth timeIntervalSinceReferenceDate])/86400;
	int remainDays = count + 1 - [components day];
	NSMutableArray *da = [[[NSMutableArray alloc] init] autorelease];
	for (int i = 0; i < remainDays; i++){
		int dateIndex = [components day] + i;
		NSDateComponents *comps = [cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:date];
		comps = [cal components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];
		[comps setDay:dateIndex];
		NSDate *cd = [cal dateFromComponents:comps];
		NSString *wd = [self getWeekDayByDate:cd];
		if(dateIndex < 10){
			NSString *d = [[NSString alloc] initWithFormat:@"0%d日 %@:0%d", dateIndex, wd, dateIndex];
			[da addObject:d];
			[d release];
		}else{
			NSString *d = [[NSString alloc] initWithFormat:@"%d日 %@:%d", dateIndex, wd, dateIndex];
			[da addObject:d];
			[d release];
		}
	}
	self.dayArray = da;
}

-(void)setMonthArry{
	NSCalendar *cal = [NSCalendar currentCalendar]; 
	NSDate *date = [[NSDate alloc] init];
	NSDateComponents *components = [cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:date];
	components = [cal components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];
	NSMutableArray *ma = [[NSMutableArray alloc] init];
	for (int i = 0; i < 13 - [components month]; i++){
		if([components month] + i < 10){
			NSString *m = [[NSString alloc] initWithFormat:@"0%d月:0%d", [components month] + i,[components month] + i];
			[ma addObject:m];
			[m release];
		}else{
			NSString *m = [[NSString alloc] initWithFormat:@"%d月:%d", [components month] + i,[components month] + i];
			[ma addObject:m];
			[m release];
		}
		
	}
	self.monthArray = ma;
	[ma release];
	[date release];
}

-(void)setYearArray{
	NSCalendar *cal = [NSCalendar currentCalendar]; 
	NSDate *date = [[NSDate alloc] init];
	NSDateComponents *components = [cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:date];
	components = [cal components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];
	int cy = [components year];
	NSString *currentYear = [[NSString alloc] initWithFormat:@"%d年:%d", cy,cy];
	NSString *nextYear = [[NSString alloc] initWithFormat:@"%d年:%d", cy + 1, cy + 1];
	NSString *lastYear = [[NSString alloc] initWithFormat:@"%d年:%d", cy + 2, cy + 2];
	NSArray *ya = [[NSArray alloc] initWithObjects:currentYear,nextYear,lastYear,nil];
	self.yearArray = ya;
	[currentYear release];
	[nextYear release];
	[lastYear release];
	[ya release];
	[date release];
}

-(void) resetDay:(NSString *) selectedYear month:(NSString *) selectedMonth{
	NSCalendar *cal = [NSCalendar currentCalendar]; 
	NSDate *date = [[NSDate alloc] init];
	NSDateComponents *components = [cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:date];
	components = [cal components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];
	[components setMonth:[selectedMonth intValue]]; 
	[components setYear:[selectedYear intValue]];
	NSDate *thisMonth = [cal dateFromComponents:components]; 
	[components setMonth:[selectedMonth intValue] + 1];
	NSDate *nextMonth = [cal dateFromComponents:components];
	int count=([nextMonth timeIntervalSinceReferenceDate]-[thisMonth timeIntervalSinceReferenceDate])/86400;
	NSMutableArray *da = [[NSMutableArray alloc] init];
	for(int i = 1; i <= count; i++){
		[components setDay:i];
		[components setMonth:[selectedMonth intValue]]; 
		[components setYear:[selectedYear intValue]];
		NSDate *cd = [cal dateFromComponents:components];
		NSString *wd = [self getWeekDayByDate:cd];
		if(i < 10){
			NSString *d = [[NSString alloc] initWithFormat:@"0%d日 %@:0%d", i, wd, i];
			[da addObject:d];
			[d release];
		}else{
			NSString *d = [[NSString alloc] initWithFormat:@"%d日 %@:%d", i, wd, i];
			[da addObject:d];
			[d release];
		} 
	}
	self.dayArray = da;
	[da release];
	[date release];
}

-(void) resetMonth{
	NSMutableArray *ma = [[NSMutableArray alloc] init];
	for(int i = 1; i < 13; i++){
		if(i < 10){
			NSString *m = [[NSString alloc] initWithFormat:@"0%d月:0%d", i, i];
			[ma addObject:m];
			[m release];
		}else{
			NSString *m = [[NSString alloc] initWithFormat:@"%d月:%d", i, i];
			[ma addObject:m];
			[m release];
		}
	}
	self.monthArray = ma;
	[ma release];
}

-(void) yearChanged:(NSString *) selectedYear{
	NSCalendar *cal = [NSCalendar currentCalendar]; 
	NSDate *date = [[NSDate alloc] init];
	NSDateComponents *components = [cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:date];
	components = [cal components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];
	if([selectedYear intValue] == [components year]){
		[self setMonthArry];
		[self setDayArray];
	}else{
		[self resetMonth];
		[pick selectRow:0 inComponent:1 animated:YES];
		NSString *m = [[NSString alloc] initWithString:[[[self.monthArray objectAtIndex:[pick selectedRowInComponent:1]] componentsSeparatedByString:@":"] objectAtIndex:1]];
		[self resetDay:selectedYear month:m];
		[m release];
		[pick selectRow:0 inComponent:2 animated:YES];
	}
	[date release];
	[pick reloadComponent:1];
	[pick reloadComponent:2];
}


-(void) monthChanged:(NSString *) selectedYear month:(NSString *) selectedMonth{
	NSCalendar *cal = [NSCalendar currentCalendar]; 
	NSDate *date = [[NSDate alloc] init];
	NSDateComponents *components = [cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:date];
	components = [cal components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];
	if([selectedMonth intValue] == [components month] && [selectedYear intValue] == [components year]){
		[self setDayArray];
	}else{
		[self resetDay:selectedYear month:selectedMonth];
		[pick selectRow:0 inComponent:2 animated:YES];
	}
	[pick reloadComponent:2];
	[date release];
}
 
-(NSString *)getWeekDayByCFDate:(CFGregorianDate) cfdate
{
	CFTimeZoneRef tz = CFTimeZoneCopyDefault();
	CFGregorianDate month_date;
	month_date.year=cfdate.year;
	month_date.month=cfdate.month;
	month_date.day=cfdate.day;
	month_date.hour=0;
	month_date.minute=0;
	month_date.second=1;
	int wd = (int)CFAbsoluteTimeGetDayOfWeek(CFGregorianDateGetAbsoluteTime(month_date,tz), tz);
	
	switch (wd)
	{
		case 1:
			return @"星期一";
		case 2:
			return @"星期二";
		case 3:
			return @"星期三";
		case 4:
			return @"星期四";
		case 5:
			return @"星期五";
		case 6:
			return @"星期六";
		default:
			return @"星期日";
	}
    return @"星期八";
}


-(void)SetSelectDate//:(CFGregorianDate) selectDate
{
 
    if ([[SidebarViewController share] getSideBarShowing]) {
        [[SidebarViewController share] moveAnimationWithDirection:SideBarShowDirectionNone duration:MoveAnimationDuration];
    }
    else
    {
        [[SidebarViewController share] moveAnimationWithDirection:SideBarShowDirectionRight duration:MoveAnimationDuration];
    }
}
-(void)SetTodayDate//:(CFGregorianDate) selectDate
{
    //获取当前 日期
    NSUInteger unitFlags = NSYearCalendarUnit |NSMonthCalendarUnit|NSDayCalendarUnit;
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *dates = [NSDate date];
    NSDateComponents *now = [calendar components:unitFlags fromDate:dates];
    int year = [now year];
    int month = [now month];
    int day = [now day];
    [calendar release];
    
    CFGregorianDate selectDate;
    selectDate.year = year;
    selectDate.month = month;
    selectDate.day = day;

    tdCalendarView.currentSelectDate = selectDate;
    tdCalendarView.currentMonthDate = selectDate;
    [tdCalendarView setNeedsDisplay];
    
    Cal *cal = [[[Cal alloc]init] autorelease];
    NSString *dv = [[[NSString alloc] initWithFormat:@"%@", [cal solar_lunar:selectDate.year kp_month:selectDate.month kp_day:selectDate.day]] autorelease];
    NSString *dv3 = [[[NSString alloc] initWithFormat:@"%@", [self GetEvent:selectDate.year kp_month:selectDate.month kp_day:selectDate.day]] autorelease];
    if( [dv3 isEqualToString:@""])
    {
        dv3 = @"无";
    }
    self.startDate = dv;
    self.backDate = dv3;
    [self setupDetailView];
}
- (void) selectDateChanged:(CFGregorianDate) selectDate{
    
//    //星期
//    NSString *wd = [self getWeekDayByCFDate:selectDate];
 
	NSLog(@"gggggggggggggggg ===== %ld年%d月%d日", selectDate.year,selectDate.month,selectDate.day);
    Cal *cal = [[[Cal alloc]init] autorelease];
    NSString *dv = [[[NSString alloc] initWithFormat:@"%@", [cal solar_lunar:selectDate.year kp_month:selectDate.month kp_day:selectDate.day]] autorelease];
    NSString *dv3 = [[[NSString alloc] initWithFormat:@"%@", [self GetEvent:selectDate.year kp_month:selectDate.month kp_day:selectDate.day]] autorelease];
    if( [dv3 isEqualToString:@""])
    {
        dv3 = @"无";
    }
    self.startDate = dv;
    self.backDate = dv3;
    [self setupDetailView];
 
}
 
- (void) monthChanged:(CFGregorianDate) currentMonth viewLeftTop:(CGPoint)viewLeftTop height:(float)height{
}
- (void) beforeMonthChange:(TdCalendarView*) calendarView willto:(CFGregorianDate) currentMonth{
}

//用事宜忌
-(NSString*)getYongshiYiJi
{
    /**
     * 暂时只有 2013 2014年
     */
    NSString* yongshiyiji = @"";
    int year = self.tdCalendarView.currentSelectDate.year;
    int month = 1;
    int day = 1;
    if (year == 0) {
        year = self.tdCalendarView.currentMonthDate.year;
        month = self.tdCalendarView.currentMonthDate.month;
        day = self.tdCalendarView.currentMonthDate.day;
    }
    else
    {
        month = self.tdCalendarView.currentSelectDate.month;
        day = self.tdCalendarView.currentSelectDate.day;
    }
    
    if (!m_yongshiyiji || [m_yongshiyiji count] == 0) {
        [m_yongshiyiji release];
        if (year == 2013) {
            m_yongshiyiji = [[NSArray alloc] initWithObjects:Kyongshiyiji_1,Kyongshiyiji_2,Kyongshiyiji_3,Kyongshiyiji_4,Kyongshiyiji_5,Kyongshiyiji_6,Kyongshiyiji_7,Kyongshiyiji_8,Kyongshiyiji_9,Kyongshiyiji_10,Kyongshiyiji_11,Kyongshiyiji_12,nil];
        }
        else if(year == 2014)
        {
            m_yongshiyiji = [[NSArray alloc] initWithObjects:Kyongshiyiji_2014_1,Kyongshiyiji_2014_2,Kyongshiyiji_2014_3,Kyongshiyiji_2014_4,Kyongshiyiji_2014_5,Kyongshiyiji_2014_6,Kyongshiyiji_2014_7,Kyongshiyiji_2014_8,Kyongshiyiji_2014_9,Kyongshiyiji_2014_10,Kyongshiyiji_2014_11,Kyongshiyiji_2014_12,nil];
        }
    }
    if ([m_yongshiyiji count] >= month) {
        NSArray* array = [m_yongshiyiji objectAtIndex:month-1];
        yongshiyiji = [array objectAtIndex:day];
    }
    return yongshiyiji;
}
-(NSMutableArray*) getYongshi_tempArray
{
//     获取1到x之间的整数的代码如下:
    NSArray* allArray = KYiJiArray;
    
    NSMutableArray* yi_array = [NSMutableArray arrayWithObjects:nil];
    int yiCount = arc4random() % 5 + 1;//1-5 个
    for (int i = 0; i < yiCount; i++) {
        int index = arc4random() % ([allArray count] == 0 ? 1 : [allArray count]);
        NSString* str = [allArray objectAtIndex:index];
        
        for (int j = 0; j < [yi_array count]; j++) {
            while ([str isEqualToString:[yi_array objectAtIndex:j]]) {
                str = [allArray objectAtIndex:(arc4random() % ([allArray count] == 0 ? 1 : [allArray count]))];
            }
        }
        //诸事不宜
        if ([str isEqualToString:[allArray objectAtIndex:([allArray count] - 1)]]) {
            [yi_array removeAllObjects];
            [yi_array addObject:str];
            break;
        }
        else
        {
            [yi_array addObject:str];
        }
        
    }
    return yi_array;
}
-(NSMutableArray*) getYongshi_Ji:(NSArray*)yi
{
    NSArray* allArray = KYiJiArray;
    NSMutableArray* Ji_Array = [NSMutableArray arrayWithObjects:nil];
    NSMutableArray* Array_temp = [NSMutableArray arrayWithArray:yi];
    
    int yiCount = arc4random() % 5 + 1;//1-5 个
    for (int i = 0; i < yiCount; i++) {
        int index = arc4random() % ([allArray count] == 0 ? 1 : [allArray count]);
        NSString* str = [allArray objectAtIndex:index];
 
        //排除 宜 及重复的数据
        for (int k = 0; k < [Array_temp count]; k++) {
            while ([str isEqualToString:[Array_temp objectAtIndex:k]]) {
                str = [allArray objectAtIndex:(arc4random() % ([allArray count] == 0 ? 1 : [allArray count]))];
            }
        }
        //诸事不宜
        if ([str isEqualToString:[allArray objectAtIndex:([allArray count] - 1)]]) {
            [Ji_Array removeAllObjects];
            [Ji_Array addObject:str];
            break;
        }
        else
        {
            [Ji_Array addObject:str];
            [Array_temp addObject:str];
        }
        
    }
    return Ji_Array;
}

//果盟 广告
//横幅(Banner)广告
- (void)OnbannerAD 
{
#if KGuoMengAdvertising
    //模拟器上现在不会显示了
    //创建横幅(Banner)广告实列 并用应用密钥初始化
    bannerAD=[[GuomobAdSDK alloc] initWithId:KGuoMengAppkey];
    bannerAD.delegate=self;
    
    //可以广告的位置,大小设屏幕即可以
    bannerAD.frame=CGRectMake(0, 285 + /*(iPhone5 ? 5 : 0)*/ (MY_IOS_VERSION_7 ? 15 : 0),320, /*[UIScreen mainScreen].bounds.size.height*/50);
    
    //加载广告 只需调用一次,不需要多次loadAd
    [bannerAD loadAd];
    [self.view addSubview:bannerAD];
#endif
}

//横幅(Banner)广告加载成功回调  success为yes
- (void)loadBannerAdSuccess:(BOOL)success
{
    NSLog(@"loadBannerAdSuccess====%d",success);
}
@end
