//
//  CardView.m
//  TestSpecViewPager
//
//  Created by 史一峰 on 16/10/20.
//  Copyright © 2016年 史一峰. All rights reserved.
//

#import "CardView.h"

@implementation CardView

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
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 16, 60, 20)];
        self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width-76, frame.size.height-36, 60, 20)];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.dateLabel.textColor = [UIColor whiteColor];
        [self.titleLabel setFont:[UIFont fontWithName:UIFontSlantTrait size:16]];
        [self.dateLabel setFont:[UIFont fontWithName:UIFontSlantTrait size:16]];
        self.titleLabel.text = @"Title";
        self.dateLabel.text = @"Date";
        [self addSubview:self.titleLabel];
        [self addSubview:self.dateLabel];
        
        self.layer.cornerRadius = 8;
    }
    return self;
}
@end
