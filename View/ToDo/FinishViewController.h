//
//  FinishViewController.h
//  Canlendar
//
//  Created by ruyicai on 13-1-15.
//  Copyright (c) 2013年 beyondsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinishViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UIImageView*                imageView;
    UITableView                *m_tableView;
    NSInteger                   m_CellCount;

}
 
-(void) finishButtonPress:(BOOL)select INDEX:(NSInteger)index DATA:(NSDictionary*)data;
@end