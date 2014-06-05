//
//  AddEventViewController.m
//  Canlendar
//
//  Created by ruyicai on 13-1-11.
//  Copyright (c) 2013年 beyondsoft. All rights reserved.
//

#import "AddEventViewController.h"
#import "Common.h"
#import "UITextViewCell.h"
#import "AdviceCell_2.h"
#import "SetAdviceViewController.h"
#import "AHAlertView.h"
#import "CanlendarAppDelegate.h"
@interface AddEventViewController ()
-(void) cancelButtonPress;
-(void) finishButtonPress;
-(void) MODIFYADVICE_NOTIFICATION:(NSNotification*)notification;
-(void) ALERTVIEW_NOTIFACTION_OK:(NSNotification*)notification;

@end

@implementation AddEventViewController
@synthesize type = m_type;
@synthesize addIndex = m_addIndex;
@synthesize finishType = m_finishType;
@synthesize imageView;
@synthesize isAdvice = m_isAdvice;
@synthesize adviceDate = m_adviceDate;

@synthesize title_ = m_title;
//- (void)dealloc
//{
//    [m_tableView release], m_tableView = nil;
//    [imageView release];
//    [super dealloc];
//}
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
    
    //btn2.layer.borderColor = [UIColor grayColor].CGColor;
    UIButton* cancelButton = [[[UIButton alloc] initWithFrame:CGRectMake(10, 5+ (MY_IOS_VERSION_7 ? 10 : 0), 49, 29)] autorelease];
    //    cancelButton.adjustsImageWhenHighlighted = NO;
    //    cancelButton.layer. = 10.0;
    //    /* 下面的这个属性设置为yes的状态下，按钮按下会发光*/
    cancelButton.showsTouchWhenHighlighted = YES;
    
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"todocancelbutton.png"] forState:UIControlStateNormal];
    
    [cancelButton addTarget:self action:@selector(cancelButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    
    UIButton* finishButton = [[[UIButton alloc] initWithFrame:CGRectMake(250, 5 + (MY_IOS_VERSION_7 ? 10 : 0), 54, 29)] autorelease];
    [finishButton setBackgroundImage:[UIImage imageNamed:@"todofinishbutton.png"] forState:UIControlStateNormal];
    [finishButton addTarget:self action:@selector(finishButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finishButton];
    
    m_CellCount = 3;
    NSInteger heightIndex = 105;
    
    
    NSString* ToDoType = (m_finishType == FINISH ? KToDo_finishEvent : KToDo_unfinishEvent);
    NSMutableArray* userarray = (NSMutableArray*)[[NSUserDefaults standardUserDefaults] objectForKey:ToDoType];
    
    self.title_ = @"";
    self.isAdvice = NO;
    self.adviceDate = nil;
    if (m_type == MODIFY) {
        self.title_ = [(NSDictionary*)[userarray objectAtIndex:m_addIndex] objectForKey:KToDo_Title];
        if ([@"true" isEqualToString:[[userarray objectAtIndex:m_addIndex] objectForKey:KToDo_Notice]]) {
            self.isAdvice = YES;
            self.adviceDate = [NSDate dateWithTimeInterval:0 sinceDate:(NSDate*)[[userarray objectAtIndex:m_addIndex] objectForKey:KToDo_NoticeTime]];
        }
    }
    
    m_tableView = [[UITableView alloc] initWithFrame:CGRectMake(15, heightIndex, 290, 395  - 4 * 45 + 80 + (MY_IOS_VERSION_7 ? 20 : 0)) style:UITableViewStylePlain];
    m_tableView.delegate = self;
    m_tableView.dataSource = self;
    
    m_tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"kongbai.png"]];
    //如果不希望响应select，那么就可以用下面的代码设置属性：
    //    放在cellselect 内部控制
    //    if (self.finishType == FINISH) {
    //        m_tableView.allowsSelection=NO;//已完成事件只可以查看
    //    }
    //    else
    //        m_tableView.allowsSelection = YES;
    //    m_tableView.allowsSelection=NO;
    m_tableView.contentSize = CGSizeMake(290, (iPhone5 ? 500 : 200));
    [self.view addSubview:m_tableView];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MODIFYADVICE_NOTIFICATION" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ALERTVIEW_NOTIFACTION_OK" object:nil];
    [super viewWillDisappear:animated];
}

-(void) viewWillAppear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MODIFYADVICE_NOTIFICATION:) name:@"MODIFYADVICE_NOTIFICATION" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ALERTVIEW_NOTIFACTION_OK:) name:@"ALERTVIEW_NOTIFACTION_OK" object:nil];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
-(void) cancelButtonPress
{
    
    [self dismissModalViewControllerAnimated:YES];
    [super viewWillAppear:YES];
}

-(void) finishButtonPress
{
    NSString* ToDoType = (m_finishType == FINISH ? KToDo_finishEvent : KToDo_unfinishEvent);
    NSMutableArray* array = (NSMutableArray*)[[NSUserDefaults standardUserDefaults] objectForKey:ToDoType];
    NSMutableArray* finishEventArrayCopy = [[[NSMutableArray alloc] initWithArray:array] autorelease];
    NSMutableDictionary* dic = [[[NSMutableDictionary alloc] init] autorelease];
    
    UITextViewCell* cell = (UITextViewCell*)[m_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (cell) {
        if ([[cell getTextView] isEqualToString:@""]) {
            //提醒
            NSString *title = @"提示";
            NSString *message = @"请填写提醒事项内容";
            
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
            return;
        }
        
        [dic setValue:[cell getTextView] forKey:KToDo_Title];
    }
    else{
        return;
    }
    
    for (int j = 0; j < [[m_tableView subviews] count]; j++) {
        if ([[[m_tableView subviews] objectAtIndex:j] isKindOfClass:[UITextViewCell class]]) {
            if ([[(UITextViewCell*)[[m_tableView subviews] objectAtIndex:j] getTextView] isEqualToString:@""]) {
                //提醒
                NSString *title = @"提示";
                NSString *message = @"请填写提醒事项内容";
                
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
                [alertView release];
                return;
            }
            
            [dic setValue:[(UITextViewCell*)[[m_tableView subviews] objectAtIndex:j] getTextView] forKey:KToDo_Title];
            break;
        }
    }
    
    if (self.isAdvice) {
        [dic setValue:@"true" forKey:KToDo_Notice];
        [dic setValue:self.adviceDate forKey:KToDo_NoticeTime];
    }
    else
        [dic setValue:@"false" forKey:KToDo_Notice];
    
    if (m_type == MODIFY) {
        if ([finishEventArrayCopy count] > m_addIndex) {
            [finishEventArrayCopy replaceObjectAtIndex:m_addIndex withObject:dic];
        }
    }
    else
    {
        [finishEventArrayCopy addObject:dic];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:finishEventArrayCopy forKey:ToDoType];
    [[NSUserDefaults standardUserDefaults] synchronize];//tongbu
    
    //数据存储之后   设置 闹钟提醒
    NSLog(@"dic: %@",dic);
    if (self.isAdvice) {
        CanlendarAppDelegate *m_delegate = (CanlendarAppDelegate*)[[UIApplication sharedApplication] delegate];
        [m_delegate schedulNotificationWithYear:self.adviceDate andMsg:([dic objectForKey:KToDo_Title] == nil ? @"提醒" : [dic objectForKey:KToDo_Title])];
    }
    
    [self dismissModalViewControllerAnimated:YES];
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
    
    if (indexPath.row == 0) {
        static NSString *groupCell = @"groupCell0";
        UITextViewCell* cell = (UITextViewCell*)[tableView dequeueReusableCellWithIdentifier:groupCell];
        if (cell == nil)
        {
            cell = [[[UITextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:groupCell] autorelease];
            cell.textContent = self.title_;
        }
        if (self.finishType == FINISH) {
            cell.noEditable = YES;
        }
        else
            cell.noEditable = NO;
        
        [cell refreshCell];
        return cell;
    }
    else if(indexPath.row == 1)
    {
        static NSString *groupCell = @"groupCell1";
        AdviceCell_2* cell = (AdviceCell_2*)[tableView dequeueReusableCellWithIdentifier:groupCell];
        if (cell == nil)
        {
            cell = [[[AdviceCell_2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:groupCell] autorelease];
        }
        if (self.isAdvice) {
            cell.isAdvice = self.isAdvice;
            if (self.isAdvice) {
                cell.adviceDate = self.adviceDate;
            }
        }
        else
        {
            cell.isAdvice = NO;
        }
        
        (self.finishType == FINISH) ? (cell.selectionStyle = UITableViewCellSelectionStyleNone) : (cell.selectionStyle = UITableViewCellSelectionStyleGray);
        
        [cell refreshCell];
        return cell;
        
    }
    else
    {
        static NSString *groupCell = @"groupCell2";//删除 按钮
        UITableViewCell* cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:groupCell];
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:groupCell] autorelease];
        }
        cell.textLabel.text = @"删除";
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.textColor = [UIColor redColor];
        cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        return cell;
    }
    
    return Nil;
}
//改变行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    m_tableView.contentSize = CGSizeMake(290, (iPhone5 ? 500 : 200));
    if (indexPath.row == 0) {
        return 100;
    }
    return 45;
}

//选中cell响应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //隐藏 键盘
    for (int j = 0; j < [[m_tableView subviews] count]; j++) {
        if ([[[m_tableView subviews] objectAtIndex:j] isKindOfClass:[UITextViewCell class]]) {
            UITextViewCell* cell = (UITextViewCell*)[[m_tableView subviews] objectAtIndex:j];
            [cell endTextViewEditing];
            self.title_ = [cell getTextView];
            break;
        }
    }
    
    if (indexPath.row == 1 && self.finishType != FINISH) {
        SetAdviceViewController* addView = [[[SetAdviceViewController alloc] initWithNibName:@"SetAdviceViewController" bundle:nil] autorelease];
        addView.isAdvice = self.isAdvice;
        if (addView.isAdvice) {
            addView.currentSelectDate = self.adviceDate;
        }
        [self presentModalViewController:addView animated:YES];
        
    }
    if (indexPath.row == 2) {
        //删除事件
        NSString *title = @"删除提示";
        NSString *message = @"确定删除此提醒事项?";
        
        //ALERTVIEW_NOTIFACTION_OK 需要注册 确定按钮 消息 AHAlertView不要手动释放
        AHAlertView *alert = [[AHAlertView alloc] initWithTitle:title message:message];
        //注意 buttonWasPressed：
        [alert setCancelButtonTitle:@"Cancel" block:^{
            alert.dismissalStyle = AHAlertViewDismissalStyleTumble;
        }];
        [alert addButtonWithTitle:@"OK" block:nil];
        [alert show];
    }
}
////自动旋转
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return YES;
//}


#pragma mark 修改事件提醒
-(void) MODIFYADVICE_NOTIFICATION:(NSNotification*)notification
{
    NSDictionary* dict = (NSDictionary*)(notification.object);
    
    BOOL isAdvice = NO;
    if ([dict objectForKey:@"YES"] != nil) {
        isAdvice = YES;
    }
    if (isAdvice) {
        self.isAdvice = isAdvice;
        self.adviceDate = (NSDate*)[dict objectForKey:@"YES"];
    }
    else
    {
        self.isAdvice = isAdvice;
        self.adviceDate = nil;
    }
    [m_tableView reloadData];
    
}
//删除
-(void) ALERTVIEW_NOTIFACTION_OK:(NSNotification*)notification
{
    NSString* ToDoType = (m_finishType == FINISH ? KToDo_finishEvent : KToDo_unfinishEvent);
    NSArray* array = (NSArray*)[[NSUserDefaults standardUserDefaults] objectForKey:ToDoType];
    NSMutableArray* EventArrayCopy = [[[NSMutableArray alloc] initWithArray:array] autorelease];
    
    if (m_type == MODIFY) {
        if ([EventArrayCopy count] > m_addIndex) {
            [EventArrayCopy removeObjectAtIndex:m_addIndex];
        }
        [[NSUserDefaults standardUserDefaults] setObject:EventArrayCopy forKey:ToDoType];
        [[NSUserDefaults standardUserDefaults] synchronize];//tongbu
    }
    else
    {
        //数据还没有添加到 NSUserDefaults里，因此 不需要进行什么操作
    }
    
    [self dismissModalViewControllerAnimated:YES];
    [super viewWillAppear:YES];
}
@end
