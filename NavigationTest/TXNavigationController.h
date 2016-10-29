//
//  BJTNavigationViewController.h
//  BJEducation
//
//  Created by yangjian on 15/11/28.
//  Copyright © 2015年 com.bjhl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXNavigationController : UINavigationController

@property (nonatomic, strong, readonly) UIViewController *rootViewController;

/**
 *  结合TXBaseViewController中的skipWhenPop属性使用
 *  根据viewController中skipWhenPop属性重置navigationControllers中的viewControllers堆栈。
 *  从viewControllers的倒数第二个viewController往前找，当skipWhenPop为真从viewContrllers中删除；否则停止
 */
- (void)skipViewControlersIfNeed;


@end


@interface UIViewController(TXNavigationController)

- (TXNavigationController *)wrapNavigationController;

@end
