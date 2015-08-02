接口代码：
。
<p>@property (nonatomic, strong) NSMutableArray *slideImagesArray; // 存储图片的地址</p>
<p>@property (nonatomic, copy) ianScrollViewSelectBlock ianEcrollViewSelectAction; // 图片点击事件</p>
<p>@property (nonatomic, copy) ianScrollViewCurrentIndex ianCurrentIndex;// 此时的幻灯片图片序号</p>
<p>@property (nonatomic) BOOL withoutPageControl; // 是否显示pageControl</p>
<p>@property (nonatomic) BOOL withoutAutoScroll; // 是否自动滚动</p>
<p>@property (nonatomic) NSNumber *autoTime; // 滚动时间</p>
<p>@property (nonatomic, strong) UIColor *pageControlCurrentPageIndicatorTintColor;</p>
<p>@property (nonatomic, strong) UIColor *PageControlPageIndicatorTintColor;</p>
<p>- (void)startLoading; // 加载初始化（必须实现）</p>

<p>// 或者 </p>
<p>- (void)startLoadingByIndex:(NSInteger)index; // 加 载初始化并制定初始图片 </p>