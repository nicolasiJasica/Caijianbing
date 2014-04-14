//
//  UITextViewCell.h
//  Canlendar
//
//  Created by ruyicai on 13-1-14.
//  Copyright (c) 2013年 beyondsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextViewCell : UITableViewCell<UITextViewDelegate>
{
    UITextView*             m_textView;
    NSString*               m_defaultText;//默认文字
    NSString*               m_textContent;
 
    BOOL                    m_noEditable;//不响应点击

}

@property(nonatomic,retain) UITextView* textView;
@property(nonatomic,retain) NSString* textContent;
@property(nonatomic,assign) BOOL noEditable;
-(void) refreshCell;
-(NSString*) getTextView;
-(void) endTextViewEditing;
@end
