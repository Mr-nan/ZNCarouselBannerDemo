//
//  ZNRotateBannerView.m
//  ZNRotateBannerDemo
//
//  Created by 郑南 on 16/7/5.
//  Copyright © 2016年 ZN. All rights reserved.
//

#import "ZNRotateBannerView.h"
#import "UIImageView+WebCache.h"

@interface ZNRotateBannerView ()<UIScrollViewDelegate>
{
    NSInteger   _currentIndex;
    
}
@property (nonatomic,strong) NSArray  *imageArray;        //  图片数组
@property (nonatomic,strong) NSArray  *imageURLArray;     //  图片URL数组
@property (nonatomic,strong) NSArray  *sourceArray;

@property (nonatomic,strong)    UIScrollView        *ZNRotateScrollView;
@property (nonatomic,strong)    NSMutableArray      *imageViewArray;
@property (nonatomic,assign)    ZNImageSourceType   sourceType;


@end

@implementation ZNRotateBannerView



-(instancetype)initWithFrame:(CGRect)frame ImageSource:(NSArray *)imageSource ImageSourceType:(ZNImageSourceType)imageSourceType
{
    self = [super initWithFrame:frame];
   if(self)
   {
       self.isAutoScroll = YES;
       _sourceType = imageSourceType;
       self.sourceArray = imageSource;
   }
    return self;

}


- (void)clickImage
{
   if([self.delegate respondsToSelector:@selector(ZNRotateBannerClickImageIndex:)])
   {
       [self.delegate ZNRotateBannerClickImageIndex:_currentIndex];
   
   }
}

#pragma mark - scrollViewDelegate

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    // 开始滑动关闭自动转动
    if(self.isAutoScroll)
    {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(autoScroll) object:nil];
    }

}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self changeOffset:scrollView];
    
    if(self.isAutoScroll)
    {
        [self performSelector:@selector(autoScroll) withObject:nil afterDelay:1];
    }
    
    if([self.delegate respondsToSelector:@selector(ZNRotatebannerCurrentImageIndex:)])
    {
        [self.delegate ZNRotatebannerCurrentImageIndex:_currentIndex];
    }

}

- (void)autoScroll
{
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(autoScroll) object:nil];
    if(self.sourceArray.count<2)
    {
        return;
    }
    CGFloat tmpX = self.ZNRotateScrollView.contentOffset.x + self.bounds.size.width;
    [self.ZNRotateScrollView setContentOffset:CGPointMake(tmpX, 0) animated:YES];
}

- (void)changeOffset:(UIScrollView *)scrollView
{
    if(scrollView.contentOffset.x <=0)
    {
        _currentIndex = (_currentIndex == 0) ?(_sourceArray.count -1):( _currentIndex -1);
        
        for (UIImageView *tmpImageView in self.imageViewArray)
        {
            
            CGRect tmpRect = tmpImageView.frame;
            tmpRect.origin.x += scrollView.frame.size.width;
            tmpImageView.frame = tmpRect;
            
            if(tmpRect.origin.x == scrollView.frame.size.width *3)
            {
                CGRect lastRect = tmpImageView.frame;
                lastRect.origin.x = 0;
                tmpImageView.frame = lastRect;
                
                NSInteger imageIndex = (_currentIndex == 0) ?(_sourceArray.count -1):( _currentIndex -1);

                if(_sourceType)
                {
                    tmpImageView.image = [_sourceArray objectAtIndex:imageIndex];
                    
                }else
                {
                    NSURL *URL = [NSURL URLWithString:[_sourceArray objectAtIndex:imageIndex]];
                    [tmpImageView sd_setImageWithURL:URL placeholderImage:nil];
                }
                
            }
        }
        
        if(self.imageViewArray.count >2)
        {
            [_imageViewArray exchangeObjectAtIndex:0 withObjectAtIndex:2];
            [_imageViewArray exchangeObjectAtIndex:2 withObjectAtIndex:1];
        }
    }
    else if(scrollView.contentOffset.x>=2*self.frame.size.width)
    {
        _currentIndex = (_currentIndex == _sourceArray.count -1) ?  0 :( _currentIndex +1);
        
        for (UIImageView *tmpImageView in self.imageViewArray)
        {
            
            CGRect tmpRect = tmpImageView.frame;
            tmpRect.origin.x -= scrollView.frame.size.width;
            tmpImageView.frame = tmpRect;
            
            if(tmpRect.origin.x == -scrollView.frame.size.width)
            {
                CGRect lastRect = tmpImageView.frame;
                lastRect.origin.x = scrollView.frame.size.width *2;
                tmpImageView.frame = lastRect;
                
                NSInteger imageIndex = (_currentIndex == _sourceArray.count -1) ?  0 :( _currentIndex +1);
                
                if(_sourceType)
                {
                    tmpImageView.image = [_sourceArray objectAtIndex:imageIndex];
                    
                }else
                {
                    NSURL *URL = [NSURL URLWithString:[_sourceArray objectAtIndex:imageIndex]];
                    [tmpImageView sd_setImageWithURL:URL placeholderImage:nil];
                }
                
            }
        }
        
        if(self.imageViewArray.count >2)
        {
            [_imageViewArray exchangeObjectAtIndex:0 withObjectAtIndex:2];
            [_imageViewArray exchangeObjectAtIndex:1 withObjectAtIndex:0];
        }

    }
    
    [scrollView setContentOffset:CGPointMake(self.imageViewArray.count / 3 *self.frame.size.width, 0)];

}

-(void)setIsAutoScroll:(BOOL)isAutoScroll
{
    _isAutoScroll = isAutoScroll;
    if(isAutoScroll)
    {
        [self performSelector:@selector(autoScroll) withObject:nil afterDelay:1];
    }
}

- (void)setSourceArray:(NSArray *)sourceArray
{
    _sourceArray = sourceArray;
    [self addSubview:self.ZNRotateScrollView];
    
    int number = sourceArray.count >1 ? 3:1;
    
    for (int i =0; i<number; i++)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        [self.imageViewArray addObject:imageView];
        [self.ZNRotateScrollView addSubview:imageView];
    }
    
    
    for (int i=0; i<self.imageViewArray.count; i++)
    {
        UIImageView *tmpImageView = [self.imageViewArray objectAtIndex:i];
        tmpImageView.image = i==0 ? [sourceArray lastObject] : [sourceArray objectAtIndex:i-1];
    }
    
    [self.ZNRotateScrollView setContentSize:CGSizeMake(number * self.frame.size.width, self.frame.size.height)];
    [self.ZNRotateScrollView setContentOffset:CGPointMake(number/3*self.frame.size.width, 0)];
    
}

- (void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    self.sourceArray = imageArray;
    _sourceType = 1;
}

- (void)setImageURLArray:(NSArray *)imageURLArray
{
    _imageURLArray = imageURLArray;
    self.sourceArray = imageURLArray;
    _sourceType = 0;
}

- (NSMutableArray *)imageViewArray
{
  if(!_imageViewArray)
  {
      _imageViewArray = [[NSMutableArray alloc]init];
  }
    return _imageViewArray;
}

- (UIScrollView *)ZNRotateScrollView
{
    if(!_ZNRotateScrollView)
    {
        _ZNRotateScrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _ZNRotateScrollView.bounces = NO;
        _ZNRotateScrollView.pagingEnabled = YES;
        _ZNRotateScrollView.scrollsToTop = NO;
        _ZNRotateScrollView.showsHorizontalScrollIndicator = NO;
        _ZNRotateScrollView.showsVerticalScrollIndicator = NO;
        _ZNRotateScrollView.delegate = self;
        [_ZNRotateScrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage)]];
    }
    return _ZNRotateScrollView;
}

@end
