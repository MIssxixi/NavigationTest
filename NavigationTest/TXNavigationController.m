//
//  BJTNavigationViewController.m
//  BJEducation
//
//  Created by yangjian on 15/11/28.
//  Copyright © 2015年 com.bjhl. All rights reserved.
//

#import "TXNavigationController.h"
#import "TXNavigationBar.h"

@interface TXNavigationController ()<UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@end

@implementation TXNavigationController

- (id)initWithRootViewController:(UIViewController *)rootViewController {
//    self = [super initWithRootViewController:rootViewController];
    self = [super initWithNavigationBarClass:[TXNavigationBar class] toolbarClass:nil];
    if (self) {
        NSParameterAssert(rootViewController);
        self.viewControllers = @[rootViewController];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
    }
    
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    [self.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationBar setTintColor:[UIColor greenColor]];
    NSDictionary *attr = @{NSForegroundColorAttributeName:[UIColor blueColor], NSFontAttributeName:[UIFont systemFontOfSize:14]};
    [self.navigationBar setTitleTextAttributes:attr];
    
    /* !!!: 解决 interactivePopGestureRecognizer-BUG
     *  iOS7以后 如果 navigationBar 被隐藏或使用自定义返回按钮，滑动返回会失效，
     *  see @http://keighl.com/post/ios7-interactive-pop-gesture-custom-back-button/
     */
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        __weak id <UIGestureRecognizerDelegate, UINavigationControllerDelegate> wself = self;
        self.interactivePopGestureRecognizer.delegate = wself;
        self.delegate = wself;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.topViewController) {
        UIViewController *viewController = self.topViewController;
        return [viewController preferredStatusBarStyle];
    } else {
        return UIStatusBarStyleDefault;
    }
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (void)skipViewControlersIfNeed
{
    NSMutableArray <UIViewController *> *viewControllers = [NSMutableArray arrayWithArray:self.viewControllers];
    NSMutableArray <UIViewController *> *deleteViewControllers = [NSMutableArray new];
    if (viewControllers.count > 2) {
        NSUInteger count = viewControllers.count;
        UIViewController *vc = nil;
        for (NSInteger i=(NSInteger)count-2; i>=0; i--) {
            vc = viewControllers[i];
            if ([vc isKindOfClass:[UIViewController class]]) {
                UIViewController *baseVC = (UIViewController *)vc;
                if (baseVC) {
                    [deleteViewControllers addObject:baseVC];
                    continue;
                }
            }
            break;
        }
        [viewControllers removeObjectsInArray:deleteViewControllers];
        self.viewControllers = viewControllers;
    }
}
// Hijack the push method to disable the gesture
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.interactivePopGestureRecognizer.enabled = NO;
    
    [super pushViewController:viewController animated:animated];
}


#pragma mark UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    //此方法在有些情况下不会调用，所有在初始化一个Navi的时候如果根视图不显示导航栏，则在创建的时候设置一下。
    if ([viewController respondsToSelector:@selector(hidesNavigationBarWhenPushed)]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        BOOL shouldHidden = [viewController performSelector:@selector(hidesNavigationBarWhenPushed)];
#pragma clang diagnostic pop
        [navigationController setNavigationBarHidden:shouldHidden animated:YES];
    }
}


- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate {
    // Enable the gesture again once the new controller is shown
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.interactivePopGestureRecognizer.enabled = YES;
}



- (UIViewController *)rootViewController {
    return [self.viewControllers firstObject];
}

#pragma mark UIGestureRecognizerDelegate

/* !!!: 解决 interactivePopGestureRecognizer-BUG
 *  原因：
 *      XXViewController 定制了返回按钮或隐藏了导航栏，导致从屏幕左侧的返回手势失效；
 *      清除默认 navigationController.interactivePopGestureRecognizer.delegate 可解决问题；
 *      @see http://stuartkhall.com/posts/ios-7-development-tips-tricks-hacks
 *  BUG：
 *      当 self.viewControllers 只有一个 rootViewController，此时从屏幕左侧滑入，然后快速点击控件 push 进新的 XXViewController；
 *      此时 rootViewController 页面不响应点击、拖动时间，再次从屏幕左侧滑入后显示新的 viewController，但点击返回按钮无响应、并可能发生崩溃；
 *  解决：
 *      navigationController.interactivePopGestureRecognizer.delegate 需实现此方法
 *          UIGestureRecognizerDelegate - gestureRecognizerShouldBegin:
 *      当 gestureRecognizer 是 navigationController.interactivePopGestureRecognizer、并且 [navigationController.viewControllers count] 小于等于 1 时返回 NO；
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        if (gestureRecognizer == self.interactivePopGestureRecognizer) {
            return [self.viewControllers count] > 1;
        }
    }
    return YES;
}



@end

@implementation UIViewController(TXNavigationController)

- (TXNavigationController *)wrapNavigationController {
    TXNavigationController *navigationController = (TXNavigationController *)self.navigationController;
    if (navigationController == nil) {
        navigationController = [[TXNavigationController alloc] initWithRootViewController:self];
    }
    return navigationController;
}

@end
