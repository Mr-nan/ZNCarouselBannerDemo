//
//  ViewController.m
//  ZNRotateBannerDemo
//
//  Created by 郑南 on 16/7/5.
//  Copyright © 2016年 ZN. All rights reserved.
//

#import "ViewController.h"
#import "ZNRotateBannerView.h"

@interface ViewController ()<ZNRotateBannerViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray *imageArray = [[NSMutableArray alloc]init];
    
    for (int i=0; i<2; i++) {
        
        [imageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d",i]]];
        
    }
    
    ZNRotateBannerView *rotateBannerView = [[ZNRotateBannerView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200) ImageSource:imageArray ImageSourceType:1];
    rotateBannerView.delegate = self;
    [self.view addSubview:rotateBannerView];
    
}

- (void)ZNRotatebannerCurrentImageIndex:(NSInteger)imageIndex
{
    NSLog(@"%ld",imageIndex);

}

- (void)ZNRotateBannerClickImageIndex:(NSInteger)imageIndex
{
    NSLog(@"%ld",imageIndex);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
