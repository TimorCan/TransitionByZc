//
//  ViewController.m
//  TransitionZC
//
//  Created by juxi-ios on 16/1/11.
//  Copyright © 2016年 周灿. All rights reserved.
//

#import "ViewController.h"
#import "MyCell.h"
#import "SecViewController.h"
#import "JXTransitionToSecVC.h"
@interface ViewController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) NSArray *dataSoure;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"转场动画";
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UICollectionViewControllerDataSource methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSoure.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    
    cell.textLabels.text = [self.dataSoure objectAtIndex:indexPath.row];
    
    NSString * imageName = [NSString stringWithFormat:@"%ld.jpg",(long)indexPath.row+1];
    
    cell.imageView.image = [UIImage imageNamed:imageName];
    
    return cell;
}




#pragma mark UINavigationControllerDelegate methods

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    // Check if we're transitioning from this view controller to a DSLSecondViewController
    if (fromVC == self && [toVC isKindOfClass:[SecViewController class]]) {
        return [[JXTransitionToSecVC alloc] init];
    }
    else {
        return nil;
    }
}

-(NSArray *)dataSoure
{
    if(!_dataSoure)
    {
        _dataSoure = @[
                       @"图图",
                       @"宝强",
                       @"熊猫哥",
                       @"孙智",
                       @"🐴🐴"
                       
                       
                       ];
        
    }
    return _dataSoure;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[SecViewController class]]) {
        // Get the selected item index path
        NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
        
        // Set the thing on the view controller we're about to show
        if (selectedIndexPath != nil) {
            SecViewController *secondViewController = segue.destinationViewController;
            _currentIndexPath = selectedIndexPath;
            secondViewController.selectIndex = selectedIndexPath.row;
        }
    }
}
@end
