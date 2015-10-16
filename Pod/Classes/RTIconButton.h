//
//  GSIconButton.h
//  Storitaire
//
//  Created by ricky on 15/9/12.
//  Copyright (c) 2015年 杭州引晴网络科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GSIconPosition) {
    GSIconPositionTop       = 0,
    GSIconPositionLeft,
    GSIconPositionBottom,
    GSIconPositionRight
};

IB_DESIGNABLE
@interface RTIconButton : UIButton
@property (nonatomic, assign) IBInspectable CGFloat iconMargin;
@property (nonatomic, assign) IBInspectable NSInteger iconPosition;
@property (nonatomic, assign) IBInspectable CGSize iconSize;    // default is image size;
@end
