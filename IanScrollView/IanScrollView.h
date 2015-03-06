//
//  IanScrollView.h
//  IanScrollView
//
//  Created by ian on 15/3/6.
//  Copyright (c) 2015年 ian. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^ianScrollViewSelectBlock)(NSInteger);
@interface IanScrollView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *slideImagesArray;
@property (nonatomic, copy) ianScrollViewSelectBlock ianEcrollViewSelectAction;
@property (nonatomic) BOOL withoutPageControl;

- (void)startLoading; //加载初始化（必须实现）
@end
