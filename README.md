1.本库实现了炫酷的菜单选择功能
2.接口代码：
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