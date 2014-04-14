//
//  RuYiCaiStartView.m
//  RuYiCai
//
//  Created by LiTengjie on 11-8-3.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StartView.h"

@implementation StartView


- (id)initWithFrame:(CGRect)frame 
{    
    self = [super initWithFrame:frame];
    if (self) 
	{
 
		self.backgroundColor = [UIColor clearColor];
		self.hidden = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect 
{
	[super drawRect:rect];
    UIImage *image;
    /*
     服务器获取开机图片
     */
//    [[RuYiCaiNetworkManager sharedManager] readStartImgRecordPath];
//    if([CommonRecordStatus commonRecordStatusManager].useStartImage)
//    {
//        [[RuYiCaiNetworkManager sharedManager] readStartImagePath];
//        image = [UIImage imageWithData:[CommonRecordStatus commonRecordStatusManager].startImage];
//    }
//	else
//    {
	    image = [UIImage imageNamed:@"Default.png"];
//    }
	[image drawInRect:rect];
}

- (void)dealloc 
{
    [super dealloc];
}


@end
