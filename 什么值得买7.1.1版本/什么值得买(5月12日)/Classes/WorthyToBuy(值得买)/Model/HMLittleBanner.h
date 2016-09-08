//
//  HMLittleBanner.h
//  什么值得买
//
//  Created by Wang_ruzhou on 16/8/8.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMRedirectData.h"

@interface HMLittleBanner : NSObject
@property (nonatomic, copy) NSString *flag;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) HMRedirectData *redirectData;

@property (nonatomic, copy) NSString *link;
@end
