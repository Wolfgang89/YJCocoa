//
//  UIView+YJViewGeometry.h
//  YJViewGeometry
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/31.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** UIView(UIViewGeometry)扩展*/
@interface UIView (YJViewGeometry)

@property (nonatomic) CGFloat topFrame;      ///< .frame.origin.y
@property (nonatomic) CGFloat bottomFrame;   ///< .topFrame + .heightFrame
@property (nonatomic) CGFloat leadingFrame;  ///< .frame.origin.x
@property (nonatomic) CGFloat trailingFrame; ///< .leadingFrame + .widthFrame
@property (nonatomic) CGFloat widthFrame;    ///< .frame.size.width
@property (nonatomic) CGFloat heightFrame;   ///< .frame.size.height
@property (nonatomic) CGFloat centerXFrame;  ///< .center.x
@property (nonatomic) CGFloat centerYFrame;  ///< .center.y

@property (nonatomic) CGPoint originFrame; ///< .frame.origin
@property (nonatomic) CGSize sizeFrame;    ///< .frame.szie

@property (nonatomic, readonly) CGPoint originFrameInWindow; ///< .frame.origin in Window

@end

NS_ASSUME_NONNULL_END
