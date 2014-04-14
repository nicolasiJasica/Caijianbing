//
//  FinishViewController.m
//  Canlendar
//
//  Created by ruyicai on 13-1-15.
//  Copyright (c) 2013年 beyondsoft. All rights reserved.
//

#import "FinishViewController.h"
#import "Common.h"
#import "ToDoCell.h"
#import "AddEventViewController.h"

@interface FinishViewController ()
-(void) cancelButtonPress;
-(void) finishButtonPress;
@end

@implementation FinishViewController
 
 
- (void)dealloc
{
    [m_tableView release], m_tableView = nil;
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
    imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height - 20)] autorelease];
    [self.view addSubview:imageView];
    if (iPhone5) {
        imageView.image = [UIImage imageNamed:@"todobackground_iphone5.png"];
    }
    else
        imageView.image = [UIImage imageNamed:@"todobackground_iphone4.png"];
    UIButton* cancelButton = [[[UIButton alloc] initWithFrame:CGRectMake(10, 5, 54, 34)] autorelease];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"todocancelbutton.png"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
 
    UIButton* finishButton = [[[UIButton alloc] initWithFrame:CGRectMake(250, 5, 60, 35)] autorelease];
    [finishButton setBackgroundImage:[UIImage imageNamed:@"todofinishbutton.png"] forState:UIControlStateNormal];
    [finishButton addTarget:self action:@selector(finishButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finishButton];
    
    UILabel* titleLable = [[[UILabel alloc] initWithFrame:CGRectMake(20, 50, 200, 45)] autorelease];
    titleLable.textAlignment = UITextAlignmentLeft;
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.text = @"已完成事件";
    titleLable.font = [UIFont systemFontOfSize:28];
    titleLable.textColor = [UIColor colorWithRed:150.0/255.0 green:71.0/255.0 blue:93.0/255.0 alpha:1.0];
    [self.view addSubview:titleLable];
 
    
    NSMutableArray* userarray = (NSMutableArray*)[[NSUserDefaults standardUserDefaults] objectForKey:KToDo_finishEvent];
    NSLog(@"已完成 提醒事件 数据：%@",userarray);
    
    m_CellCount = [userarray count];
    NSInteger heightIndex = 100;
 
    
    m_tableView = [[UITableView alloc] initWithFrame:CGRectMake(15, heightIndex + 5, 290, (iPhone5 ? 345 + 45 : 250 + 45)) style:UITableViewStylePlain];
    m_tableView.delegate = self;
    m_tableView.dataSource = self;
    
    m_tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"kongbai.png"]];
    //如果不希望响应select，那么就可以用下面的代码设置属性：
//    m_tableView.allowsSelection=NO;
    m_tableView.contentSize = CGSizeMake(320, (m_CellCount > 6 ? m_CellCount * 45 + 45 : 350));
    [self.view addSubview:m_tableView];
}

-(void) viewWillAppear:(BOOL)animated
{
    NSMutableArray* userarray = (NSMutableArray*)[[NSUserDefaults standardUserDefaults] objectForKey:KToDo_finishEvent];
    NSLog(@"提醒事件 数据：%@",userarray);
    m_CellCount = [userarray count];
    [m_tableView reloadData];
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
    NSMutableArray* userarray = (NSMutableArray*)[[NSUserDefaults standardUserDefaults] objectForKey:KToDo_finishEvent];
    
    static NSString *groupCell = @"groupCell";
    ToDoCell* cell = (ToDoCell*)[tableView dequeueReusableCellWithIdentifier:groupCell];
    if (cell == nil)
    {
        cell = [[[ToDoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:groupCell] autorelease];
    }
    cell.susperFinishViewcontroller = self;
    cell.userIndex = indexPath.row;
    cell.data = ([userarray count] > indexPath.row ? [userarray objectAtIndex:indexPath.row] : @"");
    cell.isFinish = YES;
    cell.isFinishEvent = YES;
    [cell refreshCell];
    return cell;
    
}
//改变行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    m_tableView.contentSize = CGSizeMake(320, (m_CellCount > 6 ? m_CellCount * 45 + 45 : 350));
    return 45;
}

//选中cell响应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddEventViewController* addView = [[[AddEventViewController alloc] initWithNibName:@"AddEventViewController" bundle:nil] autorelease];
    addView.type = MODIFY;
    addView.finishType = FINISH;
    addView.addIndex = indexPath.row;
    
    [self presentModalViewController:addView animated:YES];
}

-(void) finishButtonPress:(BOOL)select INDEX:(NSInteger)index DATA:(NSDictionary*)data
{
    NSMutableArray* userarrayUNFinish = (NSMutableArray*)[[NSUserDefaults standardUserDefaults] objectForKey:KToDo_unfinishEvent];
    
    NSMutableArray* userarrayFinish = (NSMutableArray*)[[NSUserDefaults standardUserDefaults] objectForKey:KToDo_finishEvent];
    
    if (!select) {
        //未完成
        NSMutableArray* userarrayUNFinishCopy = [[[NSMutableArray alloc] initWithArray:userarrayUNFinish] autorelease];
        [userarrayUNFinishCopy addObject:data];
 
        [[NSUserDefaults standardUserDefaults] setObject:userarrayUNFinishCopy forKey:KToDo_unfinishEvent];
        
        //已完成
        NSMutableArray* userarrayFinishCopy = [[[NSMutableArray alloc] initWithArray:userarrayFinish] autorelease];
        [userarrayFinishCopy removeObjectAtIndex:index];
        [[NSUserDefaults standardUserDefaults] setObject:userarrayFinishCopy forKey:KToDo_finishEvent];
        m_CellCount = [userarrayFinishCopy count];
        [[NSUserDefaults standardUserDefaults] synchronize];//tongbu
    }
    
    [m_tableView reloadData];
}

@end
