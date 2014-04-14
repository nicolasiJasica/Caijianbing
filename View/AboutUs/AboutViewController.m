//
//  AboutViewController.m
//  Canlendar
//
//  Created by ruyicai on 13-1-28.
//  Copyright (c) 2013年 beyondsoft. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController
@synthesize mainView;
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
    
    
    mainView.frame = CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height);
    mainView.delegate = self;
    mainView.scrollEnabled = YES;
    mainView.contentSize = CGSizeMake(320, 568);
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction) comeBack:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}
@end

  
//DelegateObject.m
@implementation DelegateObject
@synthesize delegate;
-(void)dealloc
{
    [self.delegate release];
    [super dealloc];
}
@end


@implementation DelegateInvoker
@synthesize delegateObject;
-(id)init
{
    if (self=[super init])
    {
        delegateObject=[[DelegateObject alloc]init];
        delegateObject.delegate=self;
    }
    return self;
}
-(void)dealloc
{
    [delegateObject release];
    [super dealloc];
}
-(void)print
{
    NSLog(@"Hello!");
 
}
@end
////在其他类中对DelegateInvoker的使用 #import "DelegateInvoker.h"
////其他未显示的相关代码。 -(void)printHello
//{
//    DelegateInvoker* invoker=[[DelegateInvoker alloc]init];
//    [invoker.delegateObject.delegate print];
//    [invoker release];
//} //其他未显示的相关代码。






