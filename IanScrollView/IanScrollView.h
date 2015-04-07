//
//  IanScrollView.h
//  IanScrollView
//
//  Created by ian on 15/3/6.
//  Copyright (c) 2015年 ian. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^ianScrollViewSelectBlock)(NSInteger);
typedef void (^ianScrollViewCurrentIndex)(NSInteger);
@interface IanScrollView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *slideImagesArray; // 存储图片的地址
@property (nonatomic, copy) ianScrollViewSelectBlock ianEcrollViewSelectAction; // 图片点击事件
@property (nonatomic, copy) ianScrollViewCurrentIndex ianCurrentIndex;// 此时的幻灯片图片序号
@property (nonatomic) BOOL withoutPageControl; // 是否显示pageControl
@property (nonatomic) BOOL withoutAutoScroll; // 是否自动滚动
@property (nonatomic) NSNumber *autoTime; // 滚动时间
@property (nonatomic, strong) UIColor *pageControlCurrentPageIndicatorTintColor;
@property (nonatomic, strong) UIColor *PageControlPageIndicatorTintColor;

- (void)startLoading; // 加载初始化（必须实现）
// 或者
- (void)startLoadingByIndex:(NSInteger)index; // 加载初始化并制定初始图片
@end
