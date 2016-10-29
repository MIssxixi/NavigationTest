//
//  ViewController.m
//  NavigationTest
//
//  Created by yongjie_zou on 16/10/27.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIBarButtonItem *theBarItem = [[UIBarButtonItem alloc] initWithTitle:@"1" style:UIBarButtonItemStylePlain target:self action:nil];
    theBarItem.imageInsets = UIEdgeInsetsMake(5, 0, 0, 0);
    self.navigationItem.rightBarButtonItem = theBarItem;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 50, 50)];
    [button setTitle:@"button" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:button];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.rightBarButtonItem = self.navigationItem.rightBarButtonItem;
    
    NSLog(@"%@", self.navigationItem.rightBarButtonItem);
    
    
    [self.navigationController.navigationBar layoutSubviews];
}

- (void)tap
{
    TestViewController *vc = [TestViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
