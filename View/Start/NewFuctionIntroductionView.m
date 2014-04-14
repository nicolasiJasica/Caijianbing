////
////  NewFuctionIntroductionView.m
////  RuYiCai
////
////  Created by ruyicai on 12-4-27.
///*  
//    weiliang   开机界面之后 新版本功能介绍
// */
//
//#import "NewFuctionIntroductionView.h"
//#import "RYCImageNamed.h"
//@interface NewFuctionIntroductionView (internal)
//-(void) startButtonClick;
//@end
//
//@implementation NewFuctionIntroductionView
//@synthesize scrollView = m_scrollView;
//@synthesize startButton = m_startButton;
//@synthesize delegate = m_delegate;
//- (void)viewDidAppear:(BOOL)animated
//{
//    
//}
//- (id)initWithFrame:(CGRect)frame 
//{
//    self = [super initWithFrame:frame];
//    if (self)
//    {	
//        //设置 scollview的 rect
//    	CGRect frame = CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height);
//        m_scrollView = [[UIScrollView alloc] initWithFrame:frame];
//        self.scrollView.pagingEnabled = YES;
//        self.scrollView.delegate = self;
//        self.scrollView.showsHorizontalScrollIndicator = YES;
//        self.scrollView.contentSize = CGSizeMake(320 * 5, [UIScreen mainScreen].bounds.size.height);
//        self.scrollView.scrollEnabled = YES;
//        
//        //用来调整 首页面位置
//        CGRect rect = CGRectMake(0, 0,   
//                                 self.scrollView.frame.size.width, self.scrollView.frame.size.height);
//        [self.scrollView scrollRectToVisible:rect animated:YES]; 
//        [self addSubview:self.scrollView];
//        
//        UIImageView* image1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height)];
//        image1.image = RYCImageNamed(@"thenew1.jpg");
//        [m_scrollView addSubview:image1];
//        [image1 release];
//        
//        UIImageView* image2 = [[UIImageView alloc] initWithFrame:CGRectMake(320, 0, 320, [UIScreen mainScreen].bounds.size.height)];
//        image2.image = RYCImageNamed(@"thenew2.jpg");
//        [m_scrollView addSubview:image2];
//        [image2 release];
//        
//        UIImageView* image3 = [[UIImageView alloc] initWithFrame:CGRectMake(320 * 2, 0, 320, [UIScreen mainScreen].bounds.size.height)];
//        image3.image = RYCImageNamed(@"thenew3.jpg");
//        [m_scrollView addSubview:image3];
//        [image3 release];
//        
//        UIImageView* image4 = [[UIImageView alloc] initWithFrame:CGRectMake(320 * 3, 0, 320, [UIScreen mainScreen].bounds.size.height)];
//        image4.image = RYCImageNamed(@"thenew4.jpg");
//        [m_scrollView addSubview:image4];
//        [image4 release];
//        
//        UIImageView* image5 = [[UIImageView alloc] initWithFrame:CGRectMake(320 * 4, 0, 320, [UIScreen mainScreen].bounds.size.height)];
//        image5.image = RYCImageNamed(@"thenew5.jpg");
//        [m_scrollView addSubview:image5];
//        [image5 release];
//        
//        //点击 按钮
//        m_startButton = [[UIButton alloc] initWithFrame:CGRectMake(320 * 4 + 60, 320, 200, 60)];
//        [m_startButton setBackgroundImage:RYCImageNamed(@"thenew_startBtn.png") forState:UIControlStateNormal];
//        
//        [m_startButton addTarget:self action:@selector(startButtonClick) forControlEvents:UIControlEventTouchUpInside];
//        [m_scrollView addSubview:m_startButton];
//    }
//    return self;
//
//}
//- (void)dealloc
//{
//    [m_scrollView release];
//    [m_startButton release];
//
//    [super dealloc];
//}
//// 点击按钮事件 
//-(void) startButtonClick
//{
//    [self release];
//    /*
//        ////////////////显示主页面\\\\\\\\\\\\\\\\\\\\\\\
//    */
//    //屏蔽掉 新版本介绍
//    [m_delegate saveUserPlist];
//    
//    [m_delegate showLoading:nil];
//}
//
//#pragma mark scrollView
///*
// scrollview  先是执行 (DidEndDragging)停止拖住的代理   然后在执行减速停止(scrollViewDidEndDecelerating)的代理
// */
////减速停止的时候开始执行
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView  
//{  
//	CGPoint offsetofScrollView = scrollView.contentOffset; 
//    
//	NSInteger page = offsetofScrollView.x / self.scrollView.frame.size.width;
//
//	CGRect rect = CGRectMake(page * self.scrollView.frame.size.width, 0,   
//                             self.scrollView.frame.size.width, self.scrollView.frame.size.height);
//    [self.scrollView scrollRectToVisible:rect animated:YES]; 
//} 
//
////每次scollview拖动都会调用
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGPoint offsetofScrollView = scrollView.contentOffset; 
//    
//    if (offsetofScrollView.x <= 0 )
//    {
//        [self.scrollView setContentOffset:CGPointMake(0, offsetofScrollView.y) animated:NO];
//    }
//    else if(offsetofScrollView.x >= 320 * 4) {
//        [self.scrollView setContentOffset:CGPointMake(320 * 4, offsetofScrollView.y) animated:NO];
//    }
//}
//
//@end
