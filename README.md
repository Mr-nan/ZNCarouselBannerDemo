# ZNCarouselBannerDemo

###实现图片循环滚动</br><\br>
###实现方法：</br>
>###参数说明: </br>
>>>frame - 控件大小</br>
>>>ImageSource - 图片数组</br>
>>>ImageSorceType - 图片源类型，0为图片URL类型、1为Image类型。</br>

ZNRotateBannerView *rotateBannerView = [[ZNRotateBannerView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200) ImageSource:imageArray ImageSourceType:1];
rotateBannerView.delegate = self;
[self.view addSubview:rotateBannerView];
