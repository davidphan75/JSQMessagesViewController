//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "JSQMessagesToolbarContentView.h"
#import "UIView+JSQMessages.h"
#import "ImageCollectionViewCell.h"

const CGFloat kJSQMessagesToolbarContentViewHorizontalSpacingDefault = 8.0f;


@interface JSQMessagesToolbarContentView () <UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet JSQMessagesComposerTextView *textView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIView *leftBarButtonContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftBarButtonContainerViewWidthConstraint;

@property (weak, nonatomic) IBOutlet UIView *rightBarButtonContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightBarButtonContainerViewWidthConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftHorizontalSpacingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightHorizontalSpacingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeightConstraint;

@end



@implementation JSQMessagesToolbarContentView

#pragma mark - Class methods

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([JSQMessagesToolbarContentView class])
                          bundle:[NSBundle bundleForClass:[JSQMessagesToolbarContentView class]]];
}

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];

    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    //Make this dynamic based on device type
    self.collectionViewHeightConstraint.constant = 80.0f;
    
    self.leftHorizontalSpacingConstraint.constant = kJSQMessagesToolbarContentViewHorizontalSpacingDefault;
    self.rightHorizontalSpacingConstraint.constant = kJSQMessagesToolbarContentViewHorizontalSpacingDefault;
    
    _images = [[NSMutableArray alloc]init];
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"UICollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [_collectionView reloadData];

    self.backgroundColor = [UIColor clearColor];
}

#pragma mark - UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //Set dynamically
    return _images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCollectionViewCell *cell = (ImageCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    if ([_images count] > 0) {
        [cell.imageView setImage:_images[0]];
    }
    [cell setBackgroundColor:[UIColor blueColor]];
    
    return cell;
}

#pragma mark - Setters

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    self.leftBarButtonContainerView.backgroundColor = backgroundColor;
    self.rightBarButtonContainerView.backgroundColor = backgroundColor;
}

- (void)setLeftBarButtonItem:(UIButton *)leftBarButtonItem
{
    if (_leftBarButtonItem) {
        [_leftBarButtonItem removeFromSuperview];
    }

    if (!leftBarButtonItem) {
        _leftBarButtonItem = nil;
        self.leftHorizontalSpacingConstraint.constant = 0.0f;
        self.leftBarButtonItemWidth = 0.0f;
        self.leftBarButtonContainerView.hidden = YES;
        return;
    }

    if (CGRectEqualToRect(leftBarButtonItem.frame, CGRectZero)) {
        leftBarButtonItem.frame = self.leftBarButtonContainerView.bounds;
    }

    self.leftBarButtonContainerView.hidden = NO;
    self.leftHorizontalSpacingConstraint.constant = kJSQMessagesToolbarContentViewHorizontalSpacingDefault;
    self.leftBarButtonItemWidth = CGRectGetWidth(leftBarButtonItem.frame);

    [leftBarButtonItem setTranslatesAutoresizingMaskIntoConstraints:NO];

    [self.leftBarButtonContainerView addSubview:leftBarButtonItem];
    [self.leftBarButtonContainerView jsq_pinAllEdgesOfSubview:leftBarButtonItem];
    [self setNeedsUpdateConstraints];

    _leftBarButtonItem = leftBarButtonItem;
}

- (void)setLeftBarButtonItemWidth:(CGFloat)leftBarButtonItemWidth
{
    self.leftBarButtonContainerViewWidthConstraint.constant = leftBarButtonItemWidth;
    [self setNeedsUpdateConstraints];
}

- (void)setRightBarButtonItem:(UIButton *)rightBarButtonItem
{
    if (_rightBarButtonItem) {
        [_rightBarButtonItem removeFromSuperview];
    }

    if (!rightBarButtonItem) {
        _rightBarButtonItem = nil;
        self.rightHorizontalSpacingConstraint.constant = 0.0f;
        self.rightBarButtonItemWidth = 0.0f;
        self.rightBarButtonContainerView.hidden = YES;
        return;
    }

    if (CGRectEqualToRect(rightBarButtonItem.frame, CGRectZero)) {
        rightBarButtonItem.frame = self.rightBarButtonContainerView.bounds;
    }

    self.rightBarButtonContainerView.hidden = NO;
    self.rightHorizontalSpacingConstraint.constant = kJSQMessagesToolbarContentViewHorizontalSpacingDefault;
    self.rightBarButtonItemWidth = CGRectGetWidth(rightBarButtonItem.frame);

    [rightBarButtonItem setTranslatesAutoresizingMaskIntoConstraints:NO];

    [self.rightBarButtonContainerView addSubview:rightBarButtonItem];
    [self.rightBarButtonContainerView jsq_pinAllEdgesOfSubview:rightBarButtonItem];
    [self setNeedsUpdateConstraints];

    _rightBarButtonItem = rightBarButtonItem;
}

- (void)setRightBarButtonItemWidth:(CGFloat)rightBarButtonItemWidth
{
    self.rightBarButtonContainerViewWidthConstraint.constant = rightBarButtonItemWidth;
    [self setNeedsUpdateConstraints];
}

- (void)setRightContentPadding:(CGFloat)rightContentPadding
{
    self.rightHorizontalSpacingConstraint.constant = rightContentPadding;
    [self setNeedsUpdateConstraints];
}

- (void)setLeftContentPadding:(CGFloat)leftContentPadding
{
    self.leftHorizontalSpacingConstraint.constant = leftContentPadding;
    [self setNeedsUpdateConstraints];
}

#pragma mark - Getters

- (CGFloat)leftBarButtonItemWidth
{
    return self.leftBarButtonContainerViewWidthConstraint.constant;
}

- (CGFloat)rightBarButtonItemWidth
{
    return self.rightBarButtonContainerViewWidthConstraint.constant;
}

- (CGFloat)rightContentPadding
{
    return self.rightHorizontalSpacingConstraint.constant;
}

- (CGFloat)leftContentPadding
{
    return self.leftHorizontalSpacingConstraint.constant;
}

#pragma mark - UIView overrides

- (void)setNeedsDisplay
{
    [super setNeedsDisplay];
    [self.textView setNeedsDisplay];
}

@end
