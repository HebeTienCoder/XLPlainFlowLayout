//
//  ViewController.m
//  XLPlainFlowLayoutDemo
//
//  Created by hebe on 15/7/30.
//  Copyright (c) 2015年 ___ZhangXiaoLiang___. All rights reserved.
//

#import "ViewController.h"
#import "ReusableView.h"
#import "XLPlainFlowLayout.h"

@interface ViewController ()

@end

@implementation ViewController
static NSString *cellID = @"cellID";
static NSString *headerID = @"headerID";
static NSString *footerID = @"footerID";

-(instancetype)init
{
    XLPlainFlowLayout *layout = [XLPlainFlowLayout new];
    layout.itemSize = CGSizeMake(100, 100);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.naviHeight = 44.0;
    return [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"XLPlainFlowLayoutDemo";
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
    [self.collectionView registerClass:[ReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:headerID];
    [self.collectionView registerClass:[ReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter  withReuseIdentifier:footerID];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 10;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==2) {
        return 0;
    }
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = indexPath.section%2?[UIColor redColor]:[UIColor cyanColor];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind==UICollectionElementKindSectionFooter) {
        ReusableView *footer = [collectionView  dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerID forIndexPath:indexPath];
        footer.backgroundColor = [UIColor yellowColor];
        footer.text = [NSString stringWithFormat:@"第%ld个分区的footer",indexPath.section];
        return footer;
    }
    
    if (indexPath.section >0) {
        ReusableView *header = [collectionView  dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID forIndexPath:indexPath];
        header.backgroundColor = indexPath.section%2?[[UIColor blackColor] colorWithAlphaComponent:0.5] : [[UIColor blueColor] colorWithAlphaComponent:0.5];
        header.text = [NSString stringWithFormat:@"第%ld个分区的header",indexPath.section];
        return header;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section>0) {
        return CGSizeMake(0, 44);
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section==3) {
        return CGSizeZero;
    }
    return CGSizeMake(0, 20);
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}


@end
