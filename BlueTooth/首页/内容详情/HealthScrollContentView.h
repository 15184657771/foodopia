//
//  HealthScrollContentView.h
//  AkesoChild
//
//  Created by Chen on 2017/6/19.
//  Copyright © 2017年 Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HealthScrollContentView;

@protocol HealthScrollContentViewDelegate <NSObject>

@optional

- (void)contentViewDidScroll:(HealthScrollContentView *)contentView fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(float)progress;

- (void)contentViewDidEndDecelerating:(HealthScrollContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex;

@end

@interface HealthScrollContentView : UIView

- (void)reloadViewWithChildVcs:(NSArray<UIViewController *> *)childVcs parentVC:(UIViewController *)parentVC;

@property (nonatomic, weak) id<HealthScrollContentViewDelegate> delegate;

/**
 设置当前滚动到第几个页面，默认为第0页
 */
@property (nonatomic, assign) NSInteger currentIndex;


@end
