//
//  DotView.m
//  TestSpecViewPager
//
//  Created by 史一峰 on 16/10/21.
//  Copyright © 2016年 史一峰. All rights reserved.
//

#import "DotView.h"

@implementation DotView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.layer.cornerRadius = self.bounds.size.width/2;
    self.backgroundColor = [UIColor darkGrayColor];
}

@end
