//
//  TopAdScrollView.h
//  LOLInfo
//
//  Created by qianfeng on 16/4/12.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopAdScrollView : UIView<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;


//在原有基础上添加
- (instancetype)initWithFrame:(CGRect)frame AndPicArr:(NSArray *)picArr;


//声明Block
@property (nonatomic,copy) void (^block) (NSString *);
@end
