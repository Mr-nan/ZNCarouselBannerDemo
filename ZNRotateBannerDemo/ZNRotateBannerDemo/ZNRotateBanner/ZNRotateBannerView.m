//
//  ZNRotateBannerView.m
//  ZNRotateBannerDemo
//
//  Created by 郑南 on 16/7/5.
//  Copyright © 2016年 ZN. All rights reserved.
//

#import "ZNRotateBannerView.h"

@interface ZNRotateBannerView ()
{
    NSInteger   _currentIndex;
    

}

@property (nonatomic,strong)    UIScrollView        *ZNRotateScrollView;
@property (nonatomic,copy)      NSArray             *sourceArray;
@property (nonatomic,assign)    ZNImageSourceType   sourceType;

@property (nonatomic,strong)    NSMutableArray      *imageViewArray;

@end

@implementation ZNRotateBannerView



-(instancetype)initWithFrame:(CGRect)frame ImageSource:(NSArray *)imageSource ImageSourceType:(ZNImageSourceType)imageSourceType
{
    self = [super initWithFrame:frame];
   if(self)
   {
       _sourceType = imageSourceType;
       self.sourceArray = imageSource;
   }
    return self;

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
    [self.ZNRotateScrollView setContentSize:CGSizeMake(number * self.frame.size.width, self.frame.size.height)];
    [self.ZNRotateScrollView setContentOffset:CGPointMake(self.frame.size.width, self.frame.size.height)];
    
    
    for (int i=0; i<self.imageViewArray.count; i++)
    {
        UIImageView *tmpImageView = [self.imageViewArray objectAtIndex:i];
        tmpImageView.image = i==0 ? [sourceArray lastObject] : [sourceArray objectAtIndex:--i];
    }
   
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
        _ZNRotateScrollView.showsHorizontalScrollIndicator = NO;
        _ZNRotateScrollView.showsVerticalScrollIndicator = NO;
    }
    return _ZNRotateScrollView;
}

@end
