//
//  TXNavigationBar.m
//  NavigationTest
//
//  Created by yongjie_zou on 16/10/29.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "TXNavigationBar.h"

@implementation TXNavigationBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)pushNavigationItem:(UINavigationItem *)item animated:(BOOL)animated {
    [super pushNavigationItem:item animated:animated];
    
}

- (UINavigationItem *)popNavigationItemAnimated:(BOOL)animated {
    return [super popNavigationItemAnimated:animated];
}

- (void)didAddSubview:(UIView *)subview {
    [super didAddSubview:subview];
}

- (void)willRemoveSubview:(UIView *)subview {
    [super willRemoveSubview:subview];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
}

@end
