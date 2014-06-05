//
//  UITextViewCell.m
//  Canlendar
//
//  Created by ruyicai on 13-1-14.
//  Copyright (c) 2013年 beyondsoft. All rights reserved.
//

#import "UITextViewCell.h"


@implementation UITextViewCell
@synthesize textView = m_textView;
@synthesize textContent = m_textContent;
@synthesize noEditable = m_noEditable;

-(void)dealloc
{
    [m_textView release];
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        m_defaultText = @"事件";
        m_textView = [[[UITextView alloc] init] autorelease];
        [m_textView setTextColor:[UIColor blackColor]];
        [m_textView setFont:[UIFont systemFontOfSize:14.0f]];
        [m_textView setBackgroundColor:[UIColor clearColor]];
        m_textView.keyboardType = UIKeyboardTypeDefault;
        //        m_textView.returnKeyType = UIReturnKeyDone;
        
        m_textView.scrollEnabled = YES;
        m_textView.editable = YES;
        //        m_textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
        m_textView.delegate = self;
        [self addSubview:m_textView];
        
        //在弹出的键盘上面加一个view来放置退出键盘的Done按钮
        UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        [topView setBarStyle:UIBarStyleDefault];
        UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(endTextViewEditing)];
        NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace, doneButton, nil];
        [btnSpace release];
        [doneButton release];
        [topView setItems:buttonsArray];
        [m_textView setInputAccessoryView:topView];
        [topView release];
        
    }
    return self;
}

-(void) endTextViewEditing
{
    if (([self.textContent isEqualToString:@""] || self.textContent == nil) && [self.textView.text  isEqualToString:m_defaultText]) {
        self.textView.text = nil;
    }
    else
        self.textContent = self.textView.text;
    
    [m_textView resignFirstResponder];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    NSLog(@"%@ \n",self.textContent);
    if (self.textContent == nil || [self.textContent isEqualToString:@""]) {
        self.textView.text = nil;
    }
    self.textView.textColor = [UIColor blackColor];
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (m_textContent == nil  ||  [m_textContent isEqualToString:@""]) {
        //        self.textView.text = m_defaultText;
        self.textView.textColor = [UIColor lightGrayColor];
    }
    else
    {
        self.textContent = self.textView.text;
    }
    
}

////UITextView 消除键盘的方法
////返回键点击之后，会在字符串后添加换行符，因此通过检查换行符来判断是否点击了返回键
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if ([text isEqualToString:@"\n"]) {
//        [self endTextViewEditing];
//        [textView resignFirstResponder];
//        return NO;
//    }
//
//    return YES;
//}

-(void) refreshCell
{
    
    if (m_noEditable) {
        self.textView.editable = NO;
    }
    else
        self.textView.editable = YES;
    //根据文本 控制text的高度
    if ([self.textContent isEqualToString:@""] || self.textContent == nil) {
        self.textView.textColor = [UIColor lightGrayColor];
        [m_textView setText:m_defaultText];
        
    }
    else
    {
        self.textView.textColor = [UIColor blackColor];
        [m_textView setText:self.textContent];
    }
    [m_textView setFrame:CGRectMake(0, 0, 275, 100)];
    
    [self endTextViewEditing];
}
-(NSString*) getTextView
{
    if (![m_textView.text isEqualToString:m_defaultText]) {
        return m_textView.text;
    }
    return @"";
}

@end
