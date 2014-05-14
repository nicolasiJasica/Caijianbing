//
//  SetAdviceViewController.m
//  Canlendar
//
//  Created by ruyicai on 13-1-17.
//  Copyright (c) 2013年 beyondsoft. All rights reserved.
//

#import "SetAdviceViewController.h"
#import "Common.h"
#import "AdviceCell.h"
#import "CanlendarAppDelegate.h"
@interface SetAdviceViewController ()
-(void) cancelButtonPress;
-(void) finishButtonPress;
@end

@implementation SetAdviceViewController

@synthesize datePicker = m_datePicker;
@synthesize imageView;
@synthesize currentSelectDate = m_currentSelectDate;
@synthesize isAdvice = m_isAdvice;
 
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (iPhone5) {
        imageView.image = [UIImage imageNamed:@"todobackground_iphone5.png"];
    }
    else
        imageView.image = [UIImage imageNamed:@"todobackground_iphone4.png"];
    
    UIButton* cancelButton = [[[UIButton alloc] initWithFrame:CGRectMake(10, 5 + (MY_IOS_VERSION_7 ? 10 : 0), 54, 34 - (MY_IOS_VERSION_7 ? 5 : 0))] autorelease];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"todocancelbutton.png"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    
    UIButton* finishButton = [[[UIButton alloc] initWithFrame:CGRectMake(250, 5  + (MY_IOS_VERSION_7 ? 10 : 0), 60, 35 - (MY_IOS_VERSION_7 ? 5 : 0))] autorelease];
    [finishButton setBackgroundImage:[UIImage imageNamed:@"todofinishbutton.png"] forState:UIControlStateNormal];
    [finishButton addTarget:self action:@selector(finishButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finishButton];
    
    //挂接一个委托
    [m_datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
    m_datePicker.hidden = YES;
    self.datePickerView.hidden = YES;
    self.datePickerView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 216, 320, 216);
    
    [m_datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    //有的时候为了在系统中统一时间，需要在服务器和客户端统一交换的时间时区，比如都用GMT。转换为中国时区+8
    //NSTimeZoneNameStyleShortStandard
    m_datePicker.timeZone = /*[NSTimeZone timeZoneWithName:@"GMT"]*/[NSTimeZone timeZoneWithName:@"Asia/beijing"];
 
    if (!m_isAdvice) {
        m_CellCount = 1;
    }
    else
    {
        m_CellCount = 2;
        m_datePicker.date = self.currentSelectDate;
    }
    NSLog(@"PickerDefaultDate : %@",m_datePicker.date);
    
    [self setupTableView];
    
}

-(void) setupTableView
{
    [m_tableView release];
    [m_tableView removeFromSuperview];
    
    NSInteger heightIndex = 105;
    m_tableView = [[UITableView alloc] initWithFrame:CGRectMake(15, heightIndex, 290, (iPhone5 ? 395 - 4 * 45: 300  - 4 * 45)) style:UITableViewStylePlain];
    m_tableView.delegate = self;
    m_tableView.dataSource = self;
    
    m_tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"kongbai.png"]];
    //如果不希望响应select，那么就可以用下面的代码设置属性：
    //    m_tableView.allowsSelection=NO;
    m_tableView.contentSize = CGSizeMake(290, (iPhone5 ? 500 : 350));
    [self.view addSubview:m_tableView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) cancelButtonPress
{
    self.datePickerView.hidden = YES;
    m_datePicker.hidden = YES;
    [self dismissModalViewControllerAnimated:YES];
    [super viewWillAppear:YES];
}

-(void) finishButtonPress
{
    m_datePicker.hidden = YES;
    self.datePickerView.hidden = YES;
    [self dismissModalViewControllerAnimated:YES];
    
    NSMutableDictionary* adviceDict = [NSMutableDictionary dictionary];
    if (m_isAdvice) {
        [adviceDict setValue:self.currentSelectDate forKey:@"YES"];
    }
    else
    {
        [adviceDict setValue:nil forKey:@"NO"];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MODIFYADVICE_NOTIFICATION" object:adviceDict];
    [super viewWillAppear:YES];
}


#pragma mark table
//指定有多少个分区（section） 默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return m_CellCount;
    
}

//绘制cell
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (m_CellCount == 1) {
        NSString *groupCell = @"groupCell0";
        AdviceCell* cell = (AdviceCell*)[tableView dequeueReusableCellWithIdentifier:groupCell];
        if (cell == nil)
        {
            cell = [[[AdviceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:groupCell] autorelease];
        }
        if (m_isAdvice) {
            cell.isAdvice = m_isAdvice;
            cell.adviceDate = self.currentSelectDate;
        }
        else
        {
            cell.isAdvice = NO;
        }
        cell.susperViewController = self;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        [cell refreshCell];
        return cell;
    }
    else
    {
        if (indexPath.row == 0) {
            NSString *groupCell = @"groupCell1";
            AdviceCell* cell = (AdviceCell*)[tableView dequeueReusableCellWithIdentifier:groupCell];
            if (cell == nil)
            {
                cell = [[[AdviceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:groupCell] autorelease];
            }
            if (m_isAdvice) {
                cell.isAdvice = m_isAdvice;
                NSLog(@"%@",self.currentSelectDate);
                cell.adviceDate = self.currentSelectDate; 
            }
            else
            {
                cell.isAdvice = NO;
            }
            cell.susperViewController = self;
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            [cell refreshCell];
            return cell;
        }
        else
        {
            NSString *groupCell = @"groupCell2";
            UITableViewCell* cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:groupCell];
            if (cell == nil)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:groupCell] autorelease];
            }
            cell.textLabel.text = [(CanlendarAppDelegate*)[[UIApplication sharedApplication] delegate] getTime_byNSdate:self.currentSelectDate];
            cell.textLabel.textAlignment = UITextAlignmentCenter;
            cell.textLabel.textColor = [UIColor grayColor];
            cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            return cell;
        }
    }
    return Nil;
}
//改变行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    m_tableView.contentSize = CGSizeMake(290, (iPhone5 ? 500 : 350));
    return 45;
}

//选中cell响应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        
//        for (int j = 0; j < [[m_tableView subviews] count]; j++) {
//            
//            if ([[[m_tableView subviews] objectAtIndex:j] isKindOfClass:[AdviceCell class]]) {
//                AdviceCell* cell = (AdviceCell*)[[m_tableView subviews] objectAtIndex:j];
//                if (cell.isAdvice) {
//                    m_datePicker.hidden = NO;
//                }
//            }
//        }
        AdviceCell* cell = (AdviceCell*)[m_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        if (cell && cell.isAdvice) {
            self.datePickerView.hidden = NO;
            m_datePicker.hidden = NO;
        }
    }
}

-(void)dateChanged:(id)sender{
    UIDatePicker* control = (UIDatePicker*)sender;

    NSDate* _date = control.date;
    /*添加你自己响应代码*/
    
    AdviceCell* cell = (AdviceCell*)[m_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    if (cell) {
        self.datePickerView.hidden = NO;
        m_datePicker.hidden = NO;
        self.currentSelectDate = _date;
        cell.textLabel.text = [(CanlendarAppDelegate*)[[UIApplication sharedApplication] delegate] getTime_byNSdate:_date];
    }
}

-(void) adviceButtonPress:(BOOL)start
{
    if (start) {
        m_CellCount = 2;
        m_isAdvice = YES;
        NSDate* _date = [m_datePicker date];
        NSLog(@"%@",_date);
        
        self.currentSelectDate = _date;
    }
    else
    {
        m_CellCount = 1;
        m_isAdvice = NO;
        self.currentSelectDate = nil;
        m_datePicker.hidden = YES;
        self.datePickerView.hidden = YES;
    }
    [self setupTableView];
    
    [m_tableView reloadData];
}

@end

