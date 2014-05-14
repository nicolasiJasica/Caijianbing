//
//  ToDoViewController.h
//  Canlendar
//
//  Created by ruyicai on 13-1-10.
//  Copyright (c) 2013年 beyondsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FinishButton.h"
#import "Common.h"
@interface ToDoViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UIImageView*                imageView;
    UITableView                *m_tableView;
    FinishButton*               m_finishButton;
    NSInteger                   m_unfinishCellCount;

}
@property (strong,nonatomic)IBOutlet UIImageView *imageView;
//响应 完成按钮
-(void) finishButtonPress:(BOOL)select INDEX:(NSInteger)index DATA:(NSDictionary*)data;
 
@end
