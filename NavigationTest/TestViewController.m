//
//  TestViewController.m
//  NavigationTest
//
//  Created by yongjie_zou on 16/10/27.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];


    //是iOS系统自身的问题，经过测试，只要navigationControllers的栈中存在并自定义过navigationItem的viewController，在手势返回过程中设置navigationItem的相关属性，然后取消手势，就会出现导航栏错乱。根本原因是在pop的时候navigationBar没有调用willRemoveSubview移除相关navigationItem。
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self updateNavigationBar];
//        UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"txc_menu_down"] style:UIBarButtonItemStylePlain target:self action:nil];
//        self.navigationItem.rightBarButtonItems = @[barItem];
//        self.navigationController.navigationBar.tintColor = [UIColor redColor];
    });
}

- (void)updateNavigationBar{
    self.navigationItem.rightBarButtonItem = nil;
    {
//        WS(weakSelf);
        
        UIBarButtonItem *theBarItem = [[UIBarButtonItem alloc] initWithTitle:@"2" style:UIBarButtonItemStylePlain target:self action:nil];

//        if (self.navigationController.topViewController == self)
        {
            self.navigationItem.rightBarButtonItem = theBarItem;
 
        }
        
        
        NSLog(@"%@", self.navigationController);
        
        
//        [self.navigationController.navigationBar popNavigationItemAnimated:NO];
//        [self.navigationController.navigationBar pushNavigationItem:self.navigationItem animated:NO];
        
        
        //        [self setNaviRightButtonWithObjects:@[[UIImage txc_imageNamed:@"arrow_down"]] block:^(NSInteger index) {
        ////            [weakSelf showMoreActionPage:YES animated:YES];
        //        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
