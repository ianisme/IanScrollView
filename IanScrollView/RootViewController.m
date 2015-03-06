//
//  RootViewController.m
//  IanScrollView
//
//  Created by ian on 15/3/6.
//  Copyright (c) 2015年 ian. All rights reserved.
//

#import "RootViewController.h"
#import "IanScrollView.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    IanScrollView *scrollView = [[IanScrollView alloc] initWithFrame:CGRectMake(0, 100, 320, 130)];
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 1; i < 7; i ++) {
        [array addObject:[NSString stringWithFormat:@"http://childmusic.qiniudn.com/huandeng/%ld.png", (long)i]];
    }
    scrollView.slideImagesArray = array;
    scrollView.withoutPageControl = NO;
    scrollView.ianEcrollViewSelectAction = ^(NSInteger i){
    
        NSLog(@"点击了%ld张图片",(long)i);
    
    };
    
    NSLog(@"%@",scrollView.slideImagesArray);
    [scrollView startLoading];
    [self.view addSubview:scrollView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
