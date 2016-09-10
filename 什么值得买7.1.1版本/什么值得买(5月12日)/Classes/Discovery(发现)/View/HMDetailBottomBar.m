//
//  HMDetailBottomBar.m
//  什么值得买
//
//  Created by Wang_ruzhou on 16/9/9.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "HMDetailBottomBar.h"

@interface HMDetailBottomBar ()
@property (nonatomic, assign) DetailBottomBarStyle style;
@property (nonatomic, weak) CALayer *topLineLayer;
@property (nonatomic, strong) UIView *firstContainerView;
@property (nonatomic, strong) UIView *secondContainerView;
@end

@implementation HMDetailBottomBar

+ (instancetype)barWithStyle:(DetailBottomBarStyle)style{
    
    HMDetailBottomBar *bottomBar = [[HMDetailBottomBar alloc] init];
    bottomBar.style = style;
    return bottomBar;

}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenW;
        frame.size.height = 49;
    }
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CALayer *topLineLayer = [CALayer layer];
        topLineLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
        [self.layer addSublayer:topLineLayer];
        topLineLayer.height = 0.5;
        topLineLayer.width = self.width;
        
        NSInteger items = 4;
        CGFloat rightBtnW = 120;
        
        CGFloat itemLabelW = (kScreenW - rightBtnW) / items;
        
        _firstContainerView = [[UIView alloc] init];
        [self addSubview:_firstContainerView];
        _firstContainerView.frame = CGRectMake(0, 0, self.width - rightBtnW, self.height);
        
        _secondContainerView = [[UIView alloc] init];
        [self addSubview:_secondContainerView];
        _secondContainerView.frame = CGRectMake(0, self.height, self.width - rightBtnW, self.height);
        
        for (NSInteger i = 0; i < items; i++) {
            NSMutableAttributedString *text = [NSMutableAttributedString new];
            UIFont *font = [UIFont systemFontOfSize:10];

            UIImage *image = [UIImage imageNamed:@"IMG_BKDetail_Zhi"];
            NSMutableAttributedString *attachText = [NSMutableAttributedString attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:font alignment:YYTextVerticalAlignmentBottom];
            [text appendAttributedString:attachText];
            
            NSString *title = @" 76%";
            [text appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]}]];
            
            YYLabel *itemLabel = [YYLabel new];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemLabelDidClick)];
            [itemLabel addGestureRecognizer:tap];
            itemLabel.attributedText = text;
            itemLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
            itemLabel.textAlignment = NSTextAlignmentCenter;
            itemLabel.left = itemLabelW * i;
            itemLabel.height = self.height;
            itemLabel.centerY = self.height * 0.5;
            itemLabel.width = itemLabelW;
            [_firstContainerView addSubview:itemLabel];
        }
        
        
        UIButton *rightBtn = [[UIButton alloc] init];
        rightBtn.adjustsImageWhenHighlighted = NO;
        rightBtn.width = rightBtnW;
//        rightBtn.top = topLineLayer.height;
        rightBtn.right = self.right;
        rightBtn.height = self.height;
        [rightBtn setImage:[UIImage imageNamed:@"IMG_YHDetail_zdlj"] forState:UIControlStateNormal];
        [self addSubview:rightBtn];
        
        
    }
    return self;
}

- (void)itemLabelDidClick {
    
    
	
}

@end

@implementation HMFirstContainerView : UIView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


@end

@implementation HMSecondContainerView : UIView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

@end

