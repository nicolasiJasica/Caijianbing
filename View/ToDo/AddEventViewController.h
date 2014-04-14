//
//  AddEventViewController.h
//  Canlendar
//
//  Created by ruyicai on 13-1-11.
//  Copyright (c) 2013年 beyondsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum EVENTtYPE
{
    MODIFY = 0,
    ADDEVENT = 1
}event;

typedef enum FINISH
{
    FINISH = 0,
    UNFINISH = 1
}finish;
 
@interface AddEventViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>
{
    UIImageView*                imageView;
    UITableView                *m_tableView;
    NSInteger                   m_CellCount;
    
    NSInteger                   m_type;//修改 还是 添加
    NSInteger                   m_addIndex;
 
    NSInteger                   m_finishType;//完成事件 还是 未完成事件
    
    BOOL                        m_isAdvice;
    NSDate*                     m_adviceDate;
    NSString*                   m_title;
}
@property(nonatomic,assign) NSInteger type;
@property(nonatomic,assign) NSInteger addIndex;
@property(nonatomic,assign) NSInteger finishType;
@property (strong,nonatomic)IBOutlet UIImageView *imageView;

@property(nonatomic,assign) BOOL isAdvice;
@property(nonatomic,retain) NSDate* adviceDate;
@property(nonatomic,retain) NSString* title_;
@end
