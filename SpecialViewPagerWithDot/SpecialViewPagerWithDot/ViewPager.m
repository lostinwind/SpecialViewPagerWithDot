//
//  ViewPager.m
//  TestSpecViewPager
//
//  Created by 史一峰 on 16/10/20.
//  Copyright © 2016年 史一峰. All rights reserved.
//

#import "ViewPager.h"
#import "CardView.h"
#import "DotView.h"

@interface ViewPager()<UIScrollViewDelegate>
@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong)NSArray *dotViewArray;
@end
@implementation ViewPager

// 卡片之间的间隔
int interval = 4;
// 卡片所占屏幕宽度比例
float cardWidthProportion = .7;
// 最小缩放比例
float minCardScale = .8;
// 圆点之间的间隔
int dotInterval = 4;
// 圆点半径
int dotRadius = 4;
// 未选中圆点透明度
float dotMinAlpha = .2;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(screenWidth*(1-cardWidthProportion)/2, 40, screenWidth*cardWidthProportion+interval, 200)];
        self.scrollView.delegate = self;
        self.scrollView.contentSize = CGSizeMake((interval+screenWidth*cardWidthProportion)*10, 200);
        self.scrollView.pagingEnabled = YES;
        self.scrollView.clipsToBounds = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        
        int firstDotX = screenWidth/2-(dotInterval+dotRadius*2)*5+dotInterval/2;
        for (int i = 0; i < 10; i++) {
            CardView *cardView = [[CardView alloc]initWithFrame:CGRectMake((interval+screenWidth*cardWidthProportion)*i, 0, screenWidth*cardWidthProportion, 200)];
            cardView.backgroundColor = [self randomColor];
            // 初始化时，第二张卡片要缩放一下
            if (i == 1) {
                cardView.transform = CGAffineTransformMakeScale(minCardScale, minCardScale);
            }
            [self.scrollView addSubview:cardView];
            
            
            DotView *dotView = [[DotView alloc]initWithFrame:CGRectMake(firstDotX+(dotRadius*2+dotInterval)*i, 250, dotRadius*2, dotRadius*2)];
            // 初始化时，除了第一个点，其余都要设淡
            if (i != 0) {
                dotView.alpha = dotMinAlpha;
            }
            [self addSubview:dotView];
        }
        
        [self addSubview:self.scrollView];
    }
    return self;
}

- (UIColor *)randomColor {
    return [UIColor colorWithRed:arc4random()%255*1.0/255 green:arc4random()%255*1.0/255 blue:arc4random()%255*1.0/255 alpha:1];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if ([view isEqual:self]){
        for (UIView *subview in self.scrollView.subviews){
            CGPoint offset = CGPointMake(point.x - self.scrollView.frame.origin.x + self.scrollView.contentOffset.x - subview.frame.origin.x, point.y - self.scrollView.frame.origin.y + self.scrollView.contentOffset.y - subview.frame.origin.y);
            
            if ((view = [subview hitTest:offset withEvent:event])){
                return view;
            }
        }
        return self.scrollView;
    }
    return view;
}

#pragma mark scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat value = ABS(scrollView.contentOffset.x/scrollView.frame.size.width);
    int leftIndex = (int)value;
    int midIndex = leftIndex + 1;
    int rightIndex = midIndex + 1;
    
//    NSLog(@"value = %f, leftIndex = %d, midIndex = %d, rightIndex = %d", value, leftIndex, midIndex, rightIndex);
    CGFloat midOffset = ABS(leftIndex-value);
    CGFloat leftRightOffset = 1-midOffset;
    
    UIView *leftView = scrollView.subviews[leftIndex];
    UIView *midView = scrollView.subviews[midIndex];
    
    CGFloat midScale = midOffset*(1-minCardScale) + minCardScale;
    CGFloat leftRightScale = leftRightOffset*(1-minCardScale) +minCardScale;
    
    // 右边卡片不一定有
    if (rightIndex < 10) {
        UIView *rightView = scrollView.subviews[rightIndex];
        rightView.transform = CGAffineTransformMakeScale(leftRightScale, leftRightScale);
    }
    
    midView.transform = CGAffineTransformMakeScale(midScale, midScale);
    leftView.transform = CGAffineTransformMakeScale(leftRightScale, leftRightScale);
    
    CGFloat selectDotAlpha = midOffset*(1-dotMinAlpha) + dotMinAlpha;
    CGFloat leftDotAlpha = leftRightOffset*(1-dotMinAlpha) + dotMinAlpha;
    
    DotView *leftDotView = self.subviews[leftIndex];
    DotView *selectDotView = self.subviews[midIndex];
    leftDotView.alpha = leftDotAlpha;
    selectDotView.alpha = selectDotAlpha;
    // 此处可以加其他特效，随意
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
}

@end
