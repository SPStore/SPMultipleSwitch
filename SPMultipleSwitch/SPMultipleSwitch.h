//
//  SPMultipleSwitch.h
//  SPSegment
//
//  Created by 乐升平 on 2018/12/29.
//  Copyright © 2018 乐升平. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SPMultipleSwitch : UIControl

- (instancetype)initWithItems:(NSArray *)items;

@property(nonatomic) NSInteger selectedSegmentIndex;

@property (nonatomic, strong) UIColor  *titleColor;
@property (nonatomic, strong) UIColor  *selectedTitleColor;

@property (nonatomic, strong) UIFont   *titleFont;

@property (nonatomic, assign) CGFloat  spacing; // label之间的间距
@property (nonatomic, assign) CGFloat  contentInset; // 内容内宿边距

@property (nonatomic, copy) UIColor *trackerColor; // 滑块的颜色
@property (nonatomic, copy) UIImage *trackerImage; // 滑块的图片

@end

NS_ASSUME_NONNULL_END
