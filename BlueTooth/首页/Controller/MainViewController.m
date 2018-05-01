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
    [self.view setBackgroundColor:RGB(225, 239, 255)];
    self.view.layer.masksToBounds = YES;
    
    [self createView];
    LoginViewController *toolVC = [[LoginViewController alloc]init];
//    [toolVC setUpUI:Strawberry];
    toolVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    self.definesPresentationContext = YES;
    [self presentViewController:toolVC animated:NO completion:^ {
        toolVC.view.superview.backgroundColor = [UIColor clearColor];
    }];
    
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
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT + 20)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
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
