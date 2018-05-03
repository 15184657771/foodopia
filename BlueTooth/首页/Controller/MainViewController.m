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
#import "RecordInfoTabController.h"
#import "InforViewController.h"
#import "GetToolViewController.h"
#import "LoginViewController.h"
#import "PetViewController.h"

@interface MainViewController ()<ChooseRecordDelegate,RecordTabDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) MainView *mainView;

/**菜单按钮*/
@property (nonatomic, strong) UIButton *menuBtn;
/**宠物按钮*/
@property (nonatomic, strong) UIButton *petBtn;
/**记录按钮*/
@property (nonatomic, strong) UIButton *recordBtn;

@property (nonatomic, strong) UIScrollView *scrollView;

/**记录按钮*/
@property (nonatomic, strong) UIButton *goBtn;
@property (nonatomic, strong) UIImageView *showImageView;//展示图片
@property (nonatomic, strong) UILabel *showNumLabel;//分数

@end

@implementation MainViewController

#pragma mark -- init methods

- (UIButton *)menuBtn {
    if (!_menuBtn) {
        _menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _menuBtn.backgroundColor = [UIColor whiteColor];
        [_menuBtn setImage:[UIImage imageNamed:@"goLeft"] forState:UIControlStateNormal];
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
        [_petBtn setImage:[UIImage imageNamed:@"bottom1"] forState:UIControlStateNormal];
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
        [_recordBtn setImage:[UIImage imageNamed:@"bottom2"] forState:UIControlStateNormal];
        [_recordBtn.layer setCornerRadius:20.0f];
        [_recordBtn.layer setMasksToBounds:YES];
        
    }
    [_recordBtn addTarget:self action:@selector(recordBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return _recordBtn;
}

- (UIButton *)goBtn {
    if (!_goBtn) {
        _goBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_goBtn setImage:[UIImage imageNamed:@"GO"] forState:UIControlStateNormal];
        [_goBtn.layer setCornerRadius:39.0f];
        [_goBtn.imageView setContentMode:UIViewContentModeScaleAspectFill];
        [_goBtn.layer setMasksToBounds:YES];
        
    }
    [_goBtn addTarget:self action:@selector(goAction:) forControlEvents:UIControlEventTouchUpInside];
    return _goBtn;
}

- (UILabel *)showNumLabel {
    if (!_showNumLabel) {
        _showNumLabel = [[UILabel alloc]init];
        _showNumLabel.textColor = RGB(184, 131, 214);
        _showNumLabel.font = [UIFont systemFontOfSize:12];
        _showNumLabel.textAlignment = NSTextAlignmentLeft;
        _showNumLabel.text = @"0";
    }
    return _showNumLabel;
}


#pragma mark -- lifeCycle methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:RGB(225, 239, 255)];
    self.view.layer.masksToBounds = YES;
    
    [self createView];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"]) {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"] isEqualToString:@"1"]) {

        }else {
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            loginVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
            self.definesPresentationContext = YES;
            [self presentViewController:loginVC animated:NO completion:^ {
                loginVC.view.superview.backgroundColor = [UIColor clearColor];
            }];
        }
    }
//    else {
//        LoginViewController *loginVC = [[LoginViewController alloc]init];
//        loginVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
//        self.definesPresentationContext = YES;
//        [self presentViewController:loginVC animated:NO completion:^ {
//            loginVC.view.superview.backgroundColor = [UIColor clearColor];
//        }];
//    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)createView {
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT + 20)];
    self.scrollView.backgroundColor = RGB(204, 225, 252);
    self.scrollView.contentSize = CGSizeMake(1550, 1500);
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    self.scrollView.maximumZoomScale = 2.0;
    self.scrollView.minimumZoomScale = 0.5;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
//    scrollView.userInteractionEnabled = NO;
    [self.view addSubview:self.scrollView];
    
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDoubleTapped:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    doubleTapRecognizer.numberOfTouchesRequired = 1;
    [self.scrollView addGestureRecognizer:doubleTapRecognizer];
    //缩小
    UITapGestureRecognizer *twoFingerTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTwoFingerTapped:)];
    twoFingerTapRecognizer.numberOfTapsRequired = 1;
    twoFingerTapRecognizer.numberOfTouchesRequired = 2;
    [self.scrollView addGestureRecognizer:twoFingerTapRecognizer];
    
    
    self.mainView = [[MainView alloc]initWithFrame:CGRectMake(0, 0, 1550, 1500)];
    [self.scrollView addSubview:self.mainView];
    CGPoint movePoint = [self.mainView moveToPlace];
    [self.scrollView setContentOffset:CGPointMake(movePoint.x - SCREEN_WIDTH/2,movePoint.y - SCREEN_HEIGHT/2) animated:NO];

  
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
    
    WS(ws);
    UIImageView *backImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pro2"]];
    [self.view addSubview:backImageView];
    self.showImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pro3"]];
    self.showImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.showImageView.layer setMasksToBounds:YES];
    [self.showImageView.layer setCornerRadius:10];
    [self.view addSubview:self.showImageView];
    [self.view addSubview:self.showNumLabel];
    [self.view addSubview:self.goBtn];
    
    
    [self.goBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.bottom.equalTo(@(-15));
        make.size.mas_equalTo(CGSizeMake(78, 78));
    }];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.goBtn.mas_centerX).with.offset(-7);
        make.centerY.equalTo(ws.goBtn.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(192, 54));
    }];
    [self.showImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backImageView.mas_left).with.offset(11);
        make.bottom.equalTo(backImageView.mas_bottom).with.offset(-7);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    [self.showNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backImageView.mas_top).with.offset(4);
        make.left.equalTo(backImageView.mas_left).with.offset(59);
        make.height.equalTo(@17);
    }];

}

#pragma mark -- button click methods
//菜单
- (void)menuBtnAction:(UIButton *)sender {
    [self XYSideOpenVC];
}
//宠物
- (void)petBtnAction:(UIButton *)sender {
    PetViewController *petVC = [[PetViewController alloc]init];
    [self.navigationController pushViewController:petVC animated:YES];
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

- (void)goAction:(UIButton *)btn {
    [self.scrollView setZoomScale:1];
    CGPoint movePoint = [self.mainView moveToPlace];
    [self.scrollView setContentOffset:CGPointMake(movePoint.x - SCREEN_WIDTH/2,movePoint.y - SCREEN_HEIGHT/2) animated:YES];
    [self.mainView placeMove:100];
    
}

#pragma mark -- delegate methods
- (void)ChooseRecordBackIndex:(NSInteger)index {
    
    UIWindow *fK = [[UIApplication sharedApplication] keyWindow];
    RecordInfoTabController *recordVC = [[RecordInfoTabController alloc]init];
    recordVC.showTag = index - 100;
    recordVC.delegate = self;
    recordVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    self.definesPresentationContext = YES;
    
    [fK.rootViewController presentViewController:recordVC animated:NO completion:^ {
        recordVC.view.superview.backgroundColor = [UIColor clearColor];
    }];
    
}

- (void)RecordTabBackIndex:(NSInteger)index {
    InforViewController *inforViewController = [[InforViewController alloc]init];
    inforViewController.showTag = index;
    [self.navigationController pushViewController:inforViewController animated:YES];
}


- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer {
    // 1
    CGPoint pointInView = [recognizer locationInView:self.mainView];
    
    // 2
    CGFloat newZoomScale = self.scrollView.zoomScale * 1.5f;
    newZoomScale = MIN(newZoomScale, self.scrollView.maximumZoomScale);
    
    // 3
    CGSize scrollViewSize = self.scrollView.bounds.size;
    
    CGFloat w = scrollViewSize.width / newZoomScale;
    CGFloat h = scrollViewSize.height / newZoomScale;
    CGFloat x = pointInView.x - (w / 2.0f);
    CGFloat y = pointInView.y - (h / 2.0f);
    
    CGRect rectToZoomTo = CGRectMake(x, y, w, h);
    
    // 4
    [self.scrollView zoomToRect:rectToZoomTo animated:YES];
}

- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer {
    // Zoom out slightly, capping at the minimum zoom scale specified by the scroll view
    CGFloat newZoomScale = self.scrollView.zoomScale / 1.5f;
    newZoomScale = MAX(newZoomScale, self.scrollView.minimumZoomScale);
    [self.scrollView setZoomScale:newZoomScale animated:YES];
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    // Return the view that you want to zoom
    return self.mainView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // The scroll view has zoomed, so you need to re-center the contents
    [self centerScrollViewContents];
}

//使图片居中
- (void)centerScrollViewContents {
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = self.mainView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    self.mainView.frame = contentsFrame;
}


@end
