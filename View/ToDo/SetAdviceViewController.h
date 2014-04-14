//
//  SetAdviceViewController.h
//  Canlendar
//
//  Created by ruyicai on 13-1-17.
//  Copyright (c) 2013年 beyondsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddEventViewController.h"
@interface SetAdviceViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UIImageView*                imageView;
    UITableView                *m_tableView;
    NSInteger                   m_CellCount;
    UIDatePicker*               m_datePicker;
    
    BOOL                        m_isAdvice;
    NSDate*                     m_currentSelectDate;
}
@property(nonatomic,assign) BOOL isAdvice;
@property(nonatomic,retain) NSDate* currentSelectDate;
@property (strong,nonatomic)IBOutlet UIImageView *imageView;
@property (strong,nonatomic)IBOutlet UIDatePicker *datePicker;

-(void) adviceButtonPress:(BOOL)start;
@end
 