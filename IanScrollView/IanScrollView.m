//
//  IanScrollView.m
//  IanScrollView
//
//  Created by ian on 15/3/6.
//  Copyright (c) 2015年 ian. All rights reserved.
//

#import "IanScrollView.h"
#import "UIImageView+WebCache.h"
#import "IanScrollImageView.h"

@interface IanScrollView()
{
    NSInteger _tempPage;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation IanScrollView

- (void)startLoading
{
    [self _initScrollView];
}

- (void)startLoadingByIndex:(NSInteger)index
{
    [self startLoading];
    _tempPage = index;
    [self.scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width * (index + 1), 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:YES];
}

#pragma mark -scrollView Delegate-
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWith = self.scrollView.frame.size.width;
    NSInteger page = floor((self.scrollView.contentOffset.x - pageWith/([_slideImagesArray count]+2))/pageWith) + 1;
    page --; //默认从第二页开始
    self.pageControl.currentPage = page;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWith = self.scrollView.frame.size.width;
    NSInteger currentPage = floor((self.scrollView.contentOffset.x - pageWith/ ([_slideImagesArray count]+2)) / pageWith) + 1;
    
    if (currentPage == 0) {
        if (self.ianCurrentIndex) {
            self.ianCurrentIndex(_slideImagesArray.count-1);
        }
        [self.scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width * _slideImagesArray.count, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:NO];
    }else if(currentPage == _slideImagesArray.count + 1){
        if (self.ianCurrentIndex){
            self.ianCurrentIndex(0);
        }
        [self.scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width, 0, _scrollView.frame.size.width,_scrollView.frame.size.height) animated:NO
         ];
    }else{
        if (self.ianCurrentIndex){
            self.ianCurrentIndex(currentPage-1);
        }
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (!self.withoutAutoScroll){
        if (_tempPage == 0) {
            [self.scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width * _slideImagesArray.count, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:NO];
        }else if(_tempPage == _slideImagesArray.count){
            [self.scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width, 0, _scrollView.frame.size.width,_scrollView.frame.size.height) animated:NO
             ];
        }
    }
}

#pragma mark -PageControl Method-
- (void)turnPage:(NSInteger)page
{
    _tempPage = page;
    [self.scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width * (page + 1), 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:YES];
}

#pragma mark -定时器 Method-
- (void)runTimePage
{
    NSInteger page = self.pageControl.currentPage;
    page ++;
    [self turnPage:page];
}


#pragma mark -private Methods-
- (void)_initScrollView
{
    if (_scrollView) {
        return;
    }
    _scrollView = ({
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        scrollView.bounces = YES;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        scrollView.userInteractionEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        if(self.slideImagesArray.count < 2){
            scrollView.scrollEnabled = NO;
        }
        [self addSubview:scrollView];
        scrollView;
    });
    
    if (!self.withoutPageControl) {
        _pageControl = ({
            UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((_scrollView.frame.size.width-100)/2,_scrollView.frame.size.height-18 , 100, 15)];
            
            [pageControl setCurrentPageIndicatorTintColor:self.pageControlCurrentPageIndicatorTintColor ? self.pageControlCurrentPageIndicatorTintColor : [UIColor purpleColor]];
            [pageControl setPageIndicatorTintColor:self.PageControlPageIndicatorTintColor ? self.PageControlPageIndicatorTintColor : [UIColor grayColor]];
            pageControl.numberOfPages = [_slideImagesArray count];
            pageControl.currentPage = 0;
            if(self.slideImagesArray.count < 2){
                pageControl.hidden = YES;
            }
            [self addSubview:pageControl];
            pageControl;
        });
    }
    for (NSInteger i = 0; i < _slideImagesArray.count; i++) {
        IanScrollImageView *slideImage = [[IanScrollImageView alloc] init];
        slideImage.contentMode = UIViewContentModeScaleAspectFit;
        [slideImage sd_setImageWithURL:[NSURL URLWithString:_slideImagesArray[i]] placeholderImage:[UIImage imageNamed:@"IanScrollViewDefault"]];
        slideImage.tag = i;
        slideImage.frame = CGRectMake(_scrollView.frame.size.width * i + _scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
        [slideImage addTarget:self action:@selector(ImageClick:)];
        [_scrollView addSubview:slideImage];// 首页是第0页,默认从第1页开始的。所以+_scrollView.frame.size.width
    }
    // 取数组最后一张图片 放在第0页
    IanScrollImageView *firstSlideImage = [[IanScrollImageView alloc] init];
    firstSlideImage.contentMode = UIViewContentModeScaleAspectFit;
    [firstSlideImage sd_setImageWithURL:[NSURL URLWithString:_slideImagesArray[_slideImagesArray.count - 1]] placeholderImage:[UIImage imageNamed:@"IanScrollViewDefault"]];
    firstSlideImage.frame = CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
    [_scrollView addSubview:firstSlideImage];
    // 取数组的第一张图片 放在最后1页
    IanScrollImageView *endSlideImage = [[IanScrollImageView alloc] init];
    endSlideImage.contentMode = UIViewContentModeScaleAspectFit;
    [endSlideImage sd_setImageWithURL:[NSURL URLWithString:_slideImagesArray[0]] placeholderImage:[UIImage imageNamed:@"IanScrollViewDefault"]];
    endSlideImage.frame = CGRectMake((_slideImagesArray.count + 1) * _scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
    [_scrollView addSubview:endSlideImage];
    
    [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width * (_slideImagesArray.count + 2), _scrollView.frame.size.height)]; //+上第1页和第4页  原理：4-[1-2-3-4]-1
    [_scrollView setContentOffset:CGPointMake(0, 0)];
    [_scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:NO];
    
    if (!self.withoutAutoScroll) {
        if (!self.autoTime) {
            self.autoTime = [NSNumber numberWithFloat:2.0f];
        }
        NSTimer *myTimer = [NSTimer timerWithTimeInterval:[self.autoTime floatValue] target:self selector:@selector(runTimePage)userInfo:nil repeats:YES];
        
        [[NSRunLoop  currentRunLoop] addTimer:myTimer forMode:NSDefaultRunLoopMode];
    }
}
- (void)ImageClick:(UIImageView *)sender
{
    if (self.ianEcrollViewSelectAction) {
        self.ianEcrollViewSelectAction(sender.tag);
    }
}

@end
