//
//  UIViewController+Extension.m
//  eFreshMall
//
//  Created by zlp on 15/12/22.
//  Copyright © 2015年 cnmobi. All rights reserved.
//

#import "UIViewController+Extension.h"
#import "LeftMenuController.h"
#import "YYWebImage.h"

@implementation UIViewController (Extension)



- (UIButton*)navigationLeftButtonWithTitle:(NSString*)title viewController:(UIViewController*)viewController
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 60, 30);
    [leftBtn setImage:[UIImage imageNamed:@"left_箭头"] forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"left_箭头"] forState:UIControlStateHighlighted];
    [leftBtn setTitle:title forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [leftBtn setTitleColor:FMBrownColor forState:UIControlStateNormal];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
    
    
    UIBarButtonItem *leftBarBtnItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    /* 调整位置 */
    [UIBarButtonItem adjustForLeftBarButtonItem:leftBarBtnItem andWidth:-15 viewController:viewController];
     
    return leftBtn;
}

- (UIButton*)navigationLeftButtonWithImage:(NSString*)image viewController:(UIViewController*)viewController
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:FMImage(image) forState:UIControlStateNormal];
    [leftBtn setImage:FMImage(image) forState:UIControlStateHighlighted];
    CGFloat leftBtn_W = leftBtn.currentImage.size.width;
    CGFloat leftBtn_H = leftBtn.currentImage.size.height;
    leftBtn.frame = CGRectMake(0, 0, leftBtn_W, leftBtn_H);
    UIBarButtonItem *leftBarBtnItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    viewController.navigationItem.leftBarButtonItem = leftBarBtnItem;
    
    /* 调整位置 */
    [UIBarButtonItem adjustForLeftBarButtonItem:leftBarBtnItem andWidth:-10 viewController:viewController];
    
    return leftBtn;

}


- (UIImageView*)navigationLeftLogoButtonWithViewController:(UIViewController*)viewController
{
    UIImageView *bgImage = [[UIImageView alloc] init];
    bgImage.frame = CGRectMake(0, 0, 32, 32);
    bgImage.userInteractionEnabled = YES;
    
    UIImageView *logoView = [[UIImageView alloc] init];
    logoView.frame = CGRectMake(0, 0, 31, 31);
    logoView.layer.cornerRadius = 15;
    logoView.layer.masksToBounds = YES;
    logoView.layer.borderWidth = 1.0;
    logoView.layer.borderColor = FMLogoBorderColor.CGColor;
    logoView.userInteractionEnabled = YES;
    logoView.tag = kLogoTag.integerValue;
    
    UIImageView *hotimage = [[UIImageView alloc]initWithFrame:CGRectMake(26, 0, 6, 6)];
    hotimage.layer.cornerRadius = 3;
    hotimage.layer.masksToBounds = YES;
    hotimage.backgroundColor = [UIColor redColor];
    hotimage.hidden = YES;
    hotimage.tag = kRedPointTag.integerValue;
    [bgImage addSubview:hotimage];
    
    [bgImage addSubview: logoView];
    UIBarButtonItem *leftBarBtnItem = [[UIBarButtonItem alloc]initWithCustomView:bgImage];
    
    [logoView yy_setImageWithURL:[NSURL URLWithString:kFMUser.userlogo] placeholder:FMImage(@"头像_logo")];
    
    viewController.navigationItem.leftBarButtonItem = leftBarBtnItem;
    
    /* 调整位置 */
    [UIBarButtonItem adjustForLeftBarButtonItem:leftBarBtnItem andWidth:-10 viewController:viewController];
   
    return bgImage;
    
}


-(UIImageView *)navigationhotImage:(UIViewController *)controller{
   UIImageView *hotimage = [[UIImageView alloc]initWithFrame:CGRectMake(26, 0, 6, 6)];
    hotimage.layer.cornerRadius = 3;
    hotimage.layer.masksToBounds = YES;
    hotimage.backgroundColor = [UIColor redColor];
    hotimage.hidden = YES;
    return hotimage;
}
- (void)addBackgroundImageView:(NSString*)image viewController:(UIViewController*)viewController
{
    UIImageView *bgView = [[UIImageView alloc]init];
    bgView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
    bgView.image = [UIImage imageNamed:image];
    [viewController.view addSubview:bgView];
}

- (UIButton*)navigationRightButtonWithImage:(NSString*)image viewController:(UIViewController*)viewController
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:FMImage(image) forState:UIControlStateNormal];
    [rightBtn setImage:FMImage(image) forState:UIControlStateHighlighted];
    CGFloat rightBtn_W = rightBtn.currentImage.size.width;
    CGFloat rightBtn_H = rightBtn.currentImage.size.height;
    rightBtn.frame = CGRectMake(0, 0, rightBtn_W, rightBtn_H);
    UIBarButtonItem *rightBarBtnItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    viewController.navigationItem.rightBarButtonItem = rightBarBtnItem;
    
    /* 调整位置 */
    [UIBarButtonItem adjustForRightBarButtonItem:rightBarBtnItem andWidth:0 viewController:viewController];
    
    return rightBtn;

}

- (UIButton*)navigationRightButtonWithTitle:(NSString*)title viewController:(UIViewController*)viewController
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat rightBtn_W = 60;
    CGFloat rightBtn_H = 30;
    rightBtn.frame = CGRectMake(0, 0, rightBtn_W, rightBtn_H);
    [rightBtn setTitle:title forState:UIControlStateNormal];
    rightBtn.titleLabel.font = kFont_15;
    [rightBtn setTitleColor:FMBrownColor forState:UIControlStateNormal];
    [rightBtn setTitleColor:FMGreyColor forState:UIControlStateDisabled];
    UIBarButtonItem *rightBarBtnItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    viewController.navigationItem.rightBarButtonItem = rightBarBtnItem;
    
    /* 调整位置 */
    [UIBarButtonItem adjustForRightBarButtonItem:rightBarBtnItem andWidth:-15 viewController:viewController];
    
    return rightBtn;
    
}

- (UISearchBar*)navigationSearchBarWithViewController:(UIViewController*)viewController
{
    UISearchBar *searchBar = [[UISearchBar alloc]init];
    searchBar.frame = CGRectMake(0, 0, 0, 30);
    searchBar.searchBarStyle = UISearchBarStyleDefault;
    searchBar.placeholder = @"请输入搜索关键字";
    searchBar.layer.cornerRadius = 25;
    searchBar.layer.masksToBounds = YES;
    searchBar.barTintColor = FMNavigationBarColor;
    
    /* 设置占位符属性 */
    UITextField *textField = [searchBar valueForKey:@"_searchField"];
    textField.font = kFont_12;
    [textField setValue:FMBrownColor
             forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:FMSearchBarColor forKey:@"backgroundColor"];
    
    
    //搜索图标
    UIImageView *imageView = [[UIImageView alloc]initWithImage:FMImage(@"首页_搜索")];
    imageView.frame = CGRectMake(0, 0, 15, 15);
    textField.leftView = imageView;

    
    viewController.navigationItem.titleView = searchBar;
    
    return searchBar;
}

/* 设置标题 */
- (UILabel*)navigationTitleViewWithTitle:(NSString*)title fontSize:(CGFloat)size viewController:(UIViewController*)viewController
{
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(0, 0, 0, 30);
    label.font = [UIFont systemFontOfSize:size];
    label.text = title;
    label.textColor = FMBrownColor;
    label.textAlignment = NSTextAlignmentCenter;
    
    viewController.navigationItem.titleView = label;
    
    return label;
}

/* 设置标题 */
- (UILabel*)navigationTitleViewWithTitle:(NSString*)title fontSize:(CGFloat)size titleColor:(UIColor*)color viewController:(UIViewController*)viewController
{
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(0, 0, 0, 30);
    label.font = [UIFont systemFontOfSize:size];
    label.text = title;
    label.textColor = color;
    label.textAlignment = NSTextAlignmentCenter;
    
    viewController.navigationItem.titleView = label;
    
    return label;
}

//取消searchbar背景色
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (void)setRedPoint:(UIImageView*)leftBtn
{
    UIImageView *redPoint = [leftBtn viewWithTag:kRedPointTag.integerValue];
    
    NSInteger messageCount = [[kUserDefaults valueForKey:kMessageCount] integerValue];
    
    if (messageCount > 0) {
        
        redPoint.hidden = NO;
    }
    else
    {
        redPoint.hidden = YES;
    }
}

- (void)reSetLogo:(UIImageView*)leftBtn
{
    UIImageView *logoView = [leftBtn viewWithTag:kLogoTag.integerValue];
    logoView.image = FMImage(@"logo");
    [logoView yy_setImageWithURL:[NSURL URLWithString:kFMUser.userlogo] placeholder:FMImage(@"头像_logo")];
}


@end
