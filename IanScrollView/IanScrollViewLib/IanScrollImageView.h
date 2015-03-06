//
//  IanScrollImageView.h
//  IanScrollView
//
//  Created by ian on 15/3/6.
//  Copyright (c) 2015年 ian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IanScrollImageView : UIImageView
@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL action;
-(void)addTarget:(id)target action:(SEL)action;
@end
