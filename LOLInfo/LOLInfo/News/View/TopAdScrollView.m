//
//  TopAdScrollView.m
//  LOLInfo
//
//  Created by qianfeng on 16/4/12.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "TopAdScrollView.h"
#import "RecommModel.h"
#import "NSString+URLEncoding.h"

//匿名类别(私有的属性和方法)

@interface TopAdScrollView ()

//将传入图片数组转化为全局变量
@property (nonatomic,strong) NSArray *picArr;
//页数标识
@property (nonatomic,assign) int page;

@end

@implementation TopAdScrollView

- (instancetype)initWithFrame:(CGRect)frame AndPicArr:(NSArray *)picArr {
    if (self = [super initWithFrame:frame]) {
        
        _picArr = picArr;
        
        //self宽高
        float width = self.frame.size.width;
        float height = self.frame.size.height;
        //滚动视图
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(width * picArr.count, height);
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
        //图片与标题
        for (int i = 0 ; i < picArr.count; i++) {
            //获取当前新闻数据
            RecommModel *model = picArr[i];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width * i, 0, width, height)];
            //解密之后的url
            NSString *imageUrl = [model.ban_img URLDecodedString];
            [imageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"top_page_view_default"]];
            //imageView.backgroundColor = [UIColor lightGrayColor];
            [_scrollView addSubview:imageView];
            //添加图片点击手势
            //用户交互开启
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
            [imageView addGestureRecognizer:tap];
            //tag值
            imageView.tag = 1000 + i;
            
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(width * i, height - 30, width, 30)];
            label.text = model.name;
            label.backgroundColor = [UIColor colorWithRed:231 / 255.0 green:231 / 255.0  blue:231 / 255.0  alpha:0.5];
            label.font = [UIFont boldSystemFontOfSize:15.0];
            [_scrollView addSubview:label];
        }
        //滑块小圆点
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(width - 150, height - 30 , 150, 30)];
        _pageControl.numberOfPages = picArr.count;
        _pageControl.currentPage = 0;
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        [self addSubview:_pageControl];
        
        _page = 0;
        //定时器
        [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timeRefresh) userInfo:nil repeats:YES];
        
    }
    return self;
}

- (void)timeRefresh {
    _page++;
    //判断
    if (_page == _picArr.count) {
        _page = 0;
    }
    //设置偏移量
    //_scrollView.contentOffset = CGPointMake(_page * self.frame.size.width, 0);
    [_scrollView scrollRectToVisible:CGRectMake(_page * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:YES];
    //设置小圆点
    _pageControl.currentPage = _page;
    
}

- (void)tapImageView:(UITapGestureRecognizer *)tap {
    //获取所点击的视图
    UIImageView *tapImageView = (UIImageView *)tap.view;
    NSLog(@"点击的图片tag____%ld",tapImageView.tag);
    //获取当前点击新闻的ID
    RecommModel *model = _picArr[tapImageView.tag - 1000];
    NSString *ID = model.article_id;
    //传递ID,跳转详情界面
    _block(ID);
    
}
@end
