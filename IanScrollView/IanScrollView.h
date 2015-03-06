//
//  IanScrollView.h
//  IanScrollView
//
//  Created by ian on 15/3/6.
//  Copyright (c) 2015年 ian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IanScrollView : UIView<UIScrollViewDelegate>

@property (strong,nonatomic)NSMutableArray *slideImagesArray;
@property (strong,nonatomic)UIScrollView *scrollView;
@property (strong,nonatomic)UIPageControl *pageControl;
@property (strong, nonatomic)UITextField *text;



- (void)startLoading; //加载初始化（必须实现）
@end
