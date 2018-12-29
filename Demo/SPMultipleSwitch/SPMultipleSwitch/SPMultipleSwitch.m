//
//  SPMultipleSwitch.m
//  SPSegment
//
//  Created by 乐升平 on 2018/12/28.
//  Copyright © 2018 乐升平. All rights reserved.
//

#import "SPMultipleSwitch.h"

@interface SPMultipleSwitchLayer : CALayer

@end

@implementation SPMultipleSwitchLayer
- (instancetype)init {
    if (self = [super init]) {
        self.masksToBounds = YES;
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.cornerRadius = frame.size.height/2.0;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    [super setCornerRadius:self.bounds.size.height/2.0];
}

+ (Class)layerClass{
    return [SPMultipleSwitchLayer class];
}

@end

@interface SPMultipleSwitch()
@property (nonatomic, strong) UIView *labelContentView;
@property (nonatomic, strong) UIView *selectedLabelContentView;
@property (nonatomic, strong) UIImageView *tracker;
@property (nonatomic, strong) NSMutableArray *labels;
@property (nonatomic, strong) NSMutableArray *selectedLabels;
@property (nonatomic, strong) UIView *maskTracker;
@property (nonatomic, assign) CGPoint beginPoint;
@end

@implementation SPMultipleSwitch

+ (Class)layerClass{
    return [SPMultipleSwitchLayer class];
}

- (instancetype)initWithItems:(NSArray *)items {
    if (self = [self init]) {
        
        // 创建子控件
        [self setupSubviewsWithItems:items];
        
        [self.tracker addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    return self;
}

- (instancetype)init {
    if (self = [super  init]) {
        _titleFont = [UIFont systemFontOfSize:17];
        _titleColor = [UIColor redColor];
        _selectedTitleColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.tracker) {
        if ([keyPath isEqualToString:@"frame"]) {
            self.maskTracker.frame = self.tracker.frame;
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - UIControl Override

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super beginTrackingWithTouch:touch withEvent:event];
    _beginPoint = [touch locationInView:self];
    NSInteger index = [self indexForPoint:_beginPoint];
    self.selectedSegmentIndex = index;
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super continueTrackingWithTouch:touch withEvent:event];
    
    CGRect contentRect = CGRectInset(self.bounds, self.contentInset, self.contentInset);
    
    CGPoint currentPoint = [touch locationInView:self];
    CGFloat diff = currentPoint.x - _beginPoint.x;
    CGRect trackerFrame = self.tracker.frame;
    trackerFrame.origin.x += diff;
    trackerFrame.origin.x = MAX(MIN(CGRectGetMinX(trackerFrame),contentRect.size.width - trackerFrame.size.width), 0);
    self.tracker.frame = trackerFrame;
    _beginPoint = currentPoint;
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super endTrackingWithTouch:touch withEvent:event];
    NSInteger index = [self indexForPoint:self.tracker.center];
    self.selectedSegmentIndex = index;
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
    [super cancelTrackingWithEvent:event];
    NSInteger index = [self indexForPoint:self.tracker.center];
    self.selectedSegmentIndex = index;
}

// 根据一个点，取出离该点最近的label对应的index
- (NSInteger)indexForPoint:(CGPoint)point {
    CGRect contentRect = CGRectInset(self.bounds, self.contentInset, self.contentInset);
    NSInteger index = MAX(0, MIN(_labels.count - 1, point.x / (contentRect.size.width / (CGFloat)(_labels.count))));
    return index;
}

#pragma mark - setter

- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex {
    _selectedSegmentIndex = MAX(0, MIN(selectedSegmentIndex, _labels.count-1));
    UILabel *label = _labels[_selectedSegmentIndex];
    CGPoint trackerCenter = self.tracker.center;
    trackerCenter.x = label.center.x;
    self.tracker.center = trackerCenter;
    // 这行代码主要是为了走一遍KVO监听的方法
    self.tracker.frame = self.tracker.frame;
}

- (void)setContentInset:(CGFloat)contentInset {
    _contentInset = contentInset;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setSpacing:(CGFloat)spacing {
    _spacing = spacing;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setTrackerColor:(UIColor *)trackerColor {
    _trackerColor = trackerColor;
    self.tracker.backgroundColor = _trackerColor;
}

- (void)setTrackerImage:(UIImage *)trackerImage {
    _trackerImage = trackerImage;
    self.tracker.image = _trackerImage;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    [_labels setValue:_titleColor forKeyPath:@"textColor"];
}

- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor {
    _selectedTitleColor = selectedTitleColor;
    [_selectedLabels setValue:_selectedTitleColor forKeyPath:@"textColor"];
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    [_labels setValue:_titleFont forKeyPath:@"font"];
    [_selectedLabels setValue:_titleFont forKeyPath:@"font"];
}

#pragma mark - 添加子控件

- (void)setupSubviewsWithItems:(NSArray *)items {
    
    self.labels = [NSMutableArray array];
    self.selectedLabels = [NSMutableArray array];
    
    // 第一层
    {
        UIView *labelContentView = [[UIView alloc] init];
        labelContentView.userInteractionEnabled = NO;
        labelContentView.layer.masksToBounds = YES;
        [self addSubview:labelContentView];
        _labelContentView = labelContentView;
        
        for (int i = 0; i < items.count; i++) {
            UILabel *label = [[UILabel alloc] init];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = items[i];
            label.textColor = [UIColor blackColor];
            [labelContentView addSubview:label];
            [self.labels addObject:label];
        }
        UIImageView *tracker = [[UIImageView alloc] init];
        tracker.userInteractionEnabled = NO;
        tracker.layer.masksToBounds = YES;
        tracker.backgroundColor = [UIColor redColor];
        [labelContentView addSubview:tracker];
        _tracker = tracker;
    }
    // 第二层
    {
        UIView *selectedLabelContentView = [[UIView alloc] init];
        selectedLabelContentView.userInteractionEnabled = NO;
        selectedLabelContentView.layer.masksToBounds = YES;
        [self addSubview:selectedLabelContentView];
        _selectedLabelContentView = selectedLabelContentView;
        
        for (int i = 0; i < items.count; i++) {
            UILabel *label = [[UILabel alloc] init];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = items[i];
            label.textColor = [UIColor whiteColor];
            [selectedLabelContentView addSubview:label];
            [self.selectedLabels addObject:label];
        }
        UIView *maskTracker = [[UIView alloc] init];
        maskTracker.userInteractionEnabled = NO;
        maskTracker.backgroundColor = [UIColor redColor];
        _maskTracker = maskTracker;
        
        // 设置selectedLabelContentView的maskView，stackView是UIView的非渲染型子类，它无法设置backgroundColor,maskView等属性
        _selectedLabelContentView.maskView = maskTracker;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect contentRect = CGRectInset(self.bounds, self.contentInset, self.contentInset);
    self.labelContentView.frame = contentRect;
    self.selectedLabelContentView.frame = contentRect;
    self.labelContentView.layer.cornerRadius = contentRect.size.height / 2.0;
    self.selectedLabelContentView.layer.cornerRadius = contentRect.size.height / 2.0;
    
    CGFloat labelW =  (contentRect.size.width - _spacing * self.labels.count) / self.labels.count;
    [self.labels enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL * _Nonnull stop) {
        label.frame = CGRectMake(self->_spacing * 0.5 + idx * (labelW + self->_spacing) , 0, labelW, contentRect.size.height);
    }];
    [self.selectedLabels enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL * _Nonnull stop) {
        label.frame = CGRectMake(self->_spacing * 0.5 + idx * (labelW + self->_spacing), 0, labelW, contentRect.size.height);
    }];
    
    CGFloat averageWidth = contentRect.size.width / self.labels.count;
    self.tracker.frame = CGRectMake(_selectedSegmentIndex * averageWidth, 0, averageWidth, contentRect.size.height);
    self.tracker.layer.cornerRadius = contentRect.size.height / 2.0;
    self.maskTracker.layer.cornerRadius = contentRect.size.height / 2.0;
}

- (void)dealloc {
    [self.tracker removeObserver:self forKeyPath:@"frame"];
}

@end
