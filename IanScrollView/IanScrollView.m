//
//  IanScrollView.m
//  IanScrollView
//
//  Created by ian on 15/3/6.
//  Copyright (c) 2015年 ian. All rights reserved.
//

#import "IanScrollView.h"
#import "UIImageView+WebCache.h"

@implementation IanScrollView

- (void)startLoading
{
    [self _initScrollView];
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
        [self.scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width * _slideImagesArray.count, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:NO];
    }else if(currentPage == _slideImagesArray.count + 1){
        [self.scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width, 0, _scrollView.frame.size.width,_scrollView.frame.size.height) animated:NO
         ];
    }
}

#pragma mark -PageControl Method-
- (void)turnPage
{
    NSInteger page = self.pageControl.currentPage;
    [self.scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width * (page + 1), 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:YES];
}

#pragma mark -定时器 Method-
- (void)runTimePage
{
    NSInteger page = self.pageControl.currentPage;
    page ++;
    page = page > self.slideImagesArray.count ? 0 : page;
    self.pageControl.currentPage = page;
    [self turnPage];
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
        [self addSubview:scrollView];
        scrollView;
    });
    
    _pageControl = ({
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((_scrollView.frame.size.width-100)/2,_scrollView.frame.size.height-23 , 100, 18)];
        [pageControl setCurrentPageIndicatorTintColor:[UIColor purpleColor]];
        [pageControl setPageIndicatorTintColor:[UIColor grayColor]];
        pageControl.numberOfPages = [_slideImagesArray count];
        pageControl.currentPage = 0;
        [pageControl addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged];
        [self addSubview:pageControl];
        pageControl;
    });
    
    for (NSInteger i = 0; i < _slideImagesArray.count; i++) {
        UIImageView *slideImage = [[UIImageView alloc] init];
        [slideImage sd_setImageWithURL:[NSURL URLWithString:_slideImagesArray[i]] placeholderImage:[UIImage imageNamed:@"IanScrollViewDefault"]];
        slideImage.frame = CGRectMake(_scrollView.frame.size.width * i + _scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
        [_scrollView addSubview:slideImage];// 首页是第0页,默认从第1页开始的。所以+_scrollView.frame.size.width
    }
    // 取数组最后一张图片 放在第0页
    UIImageView *firstSlideImage = [[UIImageView alloc] init];
    [firstSlideImage sd_setImageWithURL:[NSURL URLWithString:_slideImagesArray[_slideImagesArray.count - 1]] placeholderImage:[UIImage imageNamed:@"IanScrollViewDefault"]];
    firstSlideImage.frame = CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
    [_scrollView addSubview:firstSlideImage];
    // 取数组的第一张图片 放在最后1页
    UIImageView *endSlideImage = [[UIImageView alloc] init];
    [endSlideImage sd_setImageWithURL:[NSURL URLWithString:_slideImagesArray[0]] placeholderImage:[UIImage imageNamed:@"IanScrollViewDefault"]];
    endSlideImage.frame = CGRectMake((_slideImagesArray.count + 1) * _scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
    [_scrollView addSubview:endSlideImage];
    
    [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width * (_slideImagesArray.count + 2), _scrollView.frame.size.height)]; //+上第1页和第4页  原理：4-[1-2-3-4]-1
    [_scrollView setContentOffset:CGPointMake(0, 0)];
    [_scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:NO];
}


@end
