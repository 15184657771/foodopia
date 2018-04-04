//
//  WeightHighViewController.m
//  BlueTooth
//
//  Created by Chen on 2018/4/3.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "WeightHighViewController.h"

@interface WeightHighViewController ()
@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@end

@implementation WeightHighViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self creatView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)creatView {
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"日",@"月",@"年"]];
    _segmentedControl.backgroundColor = [UIColor clearColor];
    _segmentedControl.momentary = NO;
    _segmentedControl.tintColor = RGB(173, 119, 205);
    _segmentedControl.selectedSegmentIndex = 0;
    NSDictionary *selected = @{NSFontAttributeName :[UIFont systemFontOfSize:13],
                               NSForegroundColorAttributeName:[UIColor whiteColor]};
    NSDictionary *normal = @{NSFontAttributeName :[UIFont systemFontOfSize:13],
                             NSForegroundColorAttributeName:RGB(173, 119, 205)};
    [_segmentedControl setTitleTextAttributes:selected forState:UIControlStateSelected];
    [_segmentedControl setTitleTextAttributes:normal forState:UIControlStateNormal];
    [_segmentedControl addTarget:self action:@selector(changeTypeAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segmentedControl];
    [_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@(-15));
        make.top.equalTo(@30);
        make.height.equalTo(@28);
    }];
}
- (void)changeTypeAction:(UISegmentedControl *)sgc{
    switch (sgc.selectedSegmentIndex) {
        case 0:
            break;
        case 1:
            break;
        case 2:
            break;
        default:
            break;
    }
}


@end
