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


@protocol  ZNRotateBannerViewDelegate<NSObject>

- (void)ZNRotateBannerClickImageIndex:(NSInteger)imageIndex;

- (void)ZNRotatebannerCurrentImageIndex:(NSInteger)imageIndex;

@end

@interface ZNRotateBannerView : UIView

@property (nonatomic,assign) BOOL   isAutoScroll;       //  是否自动滚动  默认是自动
@property (nonatomic,weak) id<ZNRotateBannerViewDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame ImageSource:(NSArray *)imageSource ImageSourceType:(ZNImageSourceType)imageSourceType;


@end
