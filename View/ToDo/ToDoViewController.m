//
//  ToDoViewController.m
//  Canlendar
//
//  Created by ruyicai on 13-1-10.
//  Copyright (c) 2013年 beyondsoft. All rights reserved.
//

#import "ToDoViewController.h"
#import "Common.h"
#import "ToDoCell.h"
#import "AddEventViewController.h"
#import "FinishViewController.h"
@interface ToDoViewController (inter)
-(void) cancelButtonPress;
-(void) finishButtonPress;
-(void) addButtonPress;

-(void) hasfinishButtonPress;

@end

@implementation ToDoViewController
@synthesize imageView;
- (void)dealloc
{
    [m_tableView release], m_tableView = nil;
    [m_finishButton release];
    [super dealloc];
}
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
    UIButton* cancelButton = [[[UIButton alloc] initWithFrame:CGRectMake(10, 5, 54, 34)] autorelease];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"todocancelbutton.png"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
 
    UIButton* addButton = [[[UIButton alloc] initWithFrame:CGRectMake(260, 55, 38, 38)] autorelease];
    [addButton setBackgroundImage:[UIImage imageNamed:@"todoaddbutton.png"] forState:UIControlStateNormal];
    addButton.showsTouchWhenHighlighted = TRUE;
    [addButton addTarget:self action:@selector(addButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    
    UIButton* finishButton = [[[UIButton alloc] initWithFrame:CGRectMake(250, 5, 60, 35)] autorelease];
    [finishButton setBackgroundImage:[UIImage imageNamed:@"todofinishbutton.png"] forState:UIControlStateNormal];
    [finishButton addTarget:self action:@selector(finishButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finishButton];
    
    
    NSMutableArray* userarray = (NSMutableArray*)[[NSUserDefaults standardUserDefaults] objectForKey:KToDo_unfinishEvent];
    NSLog(@"提醒事件 数据：%@",userarray);
    
    m_unfinishCellCount = [userarray count];
    NSInteger heightIndex = 100;
 
    m_finishButton = [[FinishButton alloc] initWithFrame:CGRectMake(0, heightIndex, 320, 50)];
    [m_finishButton addTarget:self action:@selector(hasfinishButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:m_finishButton];
 
    m_tableView = [[UITableView alloc] initWithFrame:CGRectMake(15, heightIndex + 50, 290, (iPhone5 ? 345 : 250)) style:UITableViewStylePlain];
    m_tableView.delegate = self;
    m_tableView.dataSource = self;
    
    m_tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"kongbai.png"]];
    //如果不希望响应select，那么就可以用下面的代码设置属性：
//    m_tableView.allowsSelection=NO;
    m_tableView.contentSize = CGSizeMake(320, (m_unfinishCellCount > 6 ? m_unfinishCellCount * 45 + 45 : 350));
    [self.view addSubview:m_tableView];
}
 
-(void) viewWillAppear:(BOOL)animated
{
    NSMutableArray* userarray_unfinish = (NSMutableArray*)[[NSUserDefaults standardUserDefaults] objectForKey:KToDo_unfinishEvent];
    NSLog(@"提醒事件 未完成数据：%@",userarray_unfinish);
    m_unfinishCellCount = [userarray_unfinish count];
    //已完成
    [m_finishButton refreshButton];
 
    [m_tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
 
}

-(void) cancelButtonPress
{
    [self dismissModalViewControllerAnimated:YES];
}

-(void) finishButtonPress
{
    [self dismissModalViewControllerAnimated:YES];
}
-(void) addButtonPress
{
    AddEventViewController* addView = [[[AddEventViewController alloc] initWithNibName:@"AddEventViewController" bundle:nil] autorelease];
    addView.type = ADDEVENT;
    addView.finishType = UNFINISH;
    [self presentModalViewController:addView animated:YES];
 
}
-(void) hasfinishButtonPress
{
//    //已完成 页面FinishViewController
    FinishViewController* finishView = [[[FinishViewController alloc] initWithNibName:@"FinishViewController" bundle:nil] autorelease];
    [self presentModalViewController:finishView animated:YES];
 
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
    return m_unfinishCellCount;
    
}
 
//绘制cell
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray* userarray = (NSMutableArray*)[[NSUserDefaults standardUserDefaults] objectForKey:KToDo_unfinishEvent];
    
    static NSString *groupCell = @"groupCell";
    ToDoCell* cell = (ToDoCell*)[tableView dequeueReusableCellWithIdentifier:groupCell];
    if (cell == nil)
    {
        cell = [[[ToDoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:groupCell] autorelease];
    }
    cell.susperViewcontroller = self; 
    cell.userIndex = indexPath.row;
    if ([userarray count] > 0) {
        cell.data = ([userarray count] > indexPath.row ? [userarray objectAtIndex:indexPath.row] : nil);
    }

    cell.isFinish = NO;
    [cell refreshCell];
    return cell;
    
}
//改变行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    m_tableView.contentSize = CGSizeMake(320, (m_unfinishCellCount > 6 ? m_unfinishCellCount * 45 + 45 : 350));
    return 45;
}
 
//选中cell响应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//	[m_tableView deselectRowAtIndexPath:indexPath animated:NO];
    AddEventViewController* addView = [[[AddEventViewController alloc] initWithNibName:@"AddEventViewController" bundle:nil] autorelease];
    addView.type = MODIFY;
    addView.finishType = UNFINISH;
    addView.addIndex = indexPath.row;

    [self presentModalViewController:addView animated:YES];
 
}

-(void) finishButtonPress:(BOOL)select INDEX:(NSInteger)index DATA:(NSDictionary*)data
{
    NSMutableArray* userarrayUNFinish = (NSMutableArray*)[[NSUserDefaults standardUserDefaults] objectForKey:KToDo_unfinishEvent];
    
    NSMutableArray* userarrayFinish = (NSMutableArray*)[[NSUserDefaults standardUserDefaults] objectForKey:KToDo_finishEvent];
    
    if (select) {
        //未完成
        NSMutableArray* userarrayUNFinishCopy = [[[NSMutableArray alloc] initWithArray:userarrayUNFinish] autorelease];
        [userarrayUNFinishCopy removeObjectAtIndex:index];
        [[NSUserDefaults standardUserDefaults] setObject:userarrayUNFinishCopy forKey:KToDo_unfinishEvent];
        m_unfinishCellCount = [userarrayUNFinishCopy count];
        //已完成
        NSMutableArray* userarrayFinishCopy = [[[NSMutableArray alloc] initWithArray:userarrayFinish] autorelease];
        [userarrayFinishCopy addObject:data];
        [[NSUserDefaults standardUserDefaults] setObject:userarrayFinishCopy forKey:KToDo_finishEvent];
        
        [[NSUserDefaults standardUserDefaults] synchronize];//tongbu
    }
    
    [m_tableView reloadData];
    [m_finishButton refreshButton];
}

@end
