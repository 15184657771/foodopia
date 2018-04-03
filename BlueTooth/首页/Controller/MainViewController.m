//
//  MainViewController.m
//  BlueTooth
//
//  Created by Chen on 2018/3/9.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "MainViewController.h"
#import "MainView.h"
#import "TypeViewController.h"
#import "ChooseRecordController.h"
#import "UIViewController+XYSideCategory.h"
#import "RecordTabViewController.h"

@interface MainViewController ()<ChooseRecordDelegate>

@property (nonatomic, strong) MainView *mainView;

/**菜单按钮*/
@property (nonatomic, strong) UIButton *menuBtn;
/**宠物按钮*/
@property (nonatomic, strong) UIButton *petBtn;
/**记录按钮*/
@property (nonatomic, strong) UIButton *recordBtn;

@end

@implementation MainViewController

#pragma mark -- init methods

- (UIButton *)menuBtn {
    if (!_menuBtn) {
        _menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _menuBtn.backgroundColor = [UIColor whiteColor];
        [_menuBtn setImage:[UIImage imageNamed:@"grayCircle"] forState:UIControlStateNormal];
        [_menuBtn.layer setCornerRadius:20.0f];
        [_menuBtn.layer setMasksToBounds:YES];
    }
    [_menuBtn addTarget:self action:@selector(menuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return _menuBtn;
}

- (UIButton *)petBtn {
    if (!_petBtn) {
        _petBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _petBtn.backgroundColor = [UIColor whiteColor];
        [_petBtn setImage:[UIImage imageNamed:@"grayCircle"] forState:UIControlStateNormal];
        [_petBtn setTitle:@"宠物" forState:UIControlStateNormal];
        [_petBtn.layer setCornerRadius:20.0f];
        [_petBtn.layer setMasksToBounds:YES];
    }
    [_petBtn addTarget:self action:@selector(petBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return _petBtn;
}

- (UIButton *)recordBtn {
    if (!_recordBtn) {
        _recordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _recordBtn.backgroundColor = [UIColor whiteColor];
        [_recordBtn setImage:[UIImage imageNamed:@"grayCircle"] forState:UIControlStateNormal];
        [_recordBtn setTitle:@"记录" forState:UIControlStateNormal];
        [_recordBtn.layer setCornerRadius:20.0f];
        [_recordBtn.layer setMasksToBounds:YES];
        
    }
    [_recordBtn addTarget:self action:@selector(recordBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return _recordBtn;
}

#pragma mark -- lifeCycle methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.view.layer.masksToBounds = YES;
    
    [self createView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}

- (void)createView {
    WS(ws);
    self.mainView = [[MainView alloc]init];
    [self.view addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
    }];

    [self.view addSubview:self.menuBtn];
    [self.menuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(20));
        make.top.equalTo(@(20));
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.view addSubview:self.recordBtn];
    [self.recordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-20));
        make.bottom.equalTo(@(-20));
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.view addSubview:self.petBtn];
    [self.petBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.recordBtn.mas_left).with.offset(-20);
        make.bottom.equalTo(@(-20));
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    

}

#pragma mark -- button click methods
//菜单
- (void)menuBtnAction:(UIButton *)sender {
    [self XYSideOpenVC];
}
//宠物
- (void)petBtnAction:(UIButton *)sender {
    
}
//记录
- (void)recordBtnAction:(UIButton *)btn {
    ChooseRecordController *recordVC = [[ChooseRecordController alloc]init];
    recordVC.delegate = self;
    recordVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    self.definesPresentationContext = YES;
    [self presentViewController:recordVC animated:NO completion:^ {
        recordVC.view.superview.backgroundColor = [UIColor clearColor];
    }];
    
}

#pragma mark -- delegate methods
- (void)ChooseRecordBackIndex:(NSInteger)index {
    
    UIWindow *fK = [[UIApplication sharedApplication] keyWindow];
    RecordTabViewController *recordVC = [[RecordTabViewController alloc]init];
    [recordVC selectTab:index];
    recordVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    self.definesPresentationContext = YES;
    
    [fK.rootViewController presentViewController:recordVC animated:NO completion:^ {
        recordVC.view.superview.backgroundColor = [UIColor clearColor];
    }];
    
}

@end
