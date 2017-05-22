//
//  WBTabBarController.m
//  Wolf Beacon
//
//  Created by Avikant Saini on 2/25/17.
//  Copyright © 2017 Wolf Beacon. All rights reserved.
//

#import "WBTabBarController.h"

@interface WBTabBarController ()

@end

@implementation WBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
	[super viewWillLayoutSubviews];
	CGRect frame = self.tabBar.frame;
	frame.size.height = 40;
	frame.origin.y = self.view.bounds.size.height - 40;
	self.tabBar.frame = frame;
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
