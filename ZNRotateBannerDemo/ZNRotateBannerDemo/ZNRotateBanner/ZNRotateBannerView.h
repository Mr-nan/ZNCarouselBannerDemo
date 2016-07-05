//
//  ZNRotateBannerView.h
//  ZNRotateBannerDemo
//
//  Created by 郑南 on 16/7/5.
//  Copyright © 2016年 ZN. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    imageURLType =  0,
    imageType = 1,
  


}ZNImageSourceType;

@interface ZNRotateBannerView : UIView



@property (nonatomic,copy) NSArray  *imageArray;        //  图片数组
@property (nonatomic,copy) NSArray  *imageURLArray;     //  图片URL数组

@property (nonatomic,assign) BOOL   isAutoScroll;       //  是否自动滚动

-(instancetype)initWithFrame:(CGRect)frame ImageSource:(NSArray *)imageSource ImageSourceType:(ZNImageSourceType)imageSourceType;

@end
