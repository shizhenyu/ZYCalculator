//
//  ZYCalculatorView.h
//  ZYCalculator
//
//  Created by youyun on 2018/7/3.
//  Copyright © 2018年 TaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DisplayMethod) {
    DisplayMethodCover, // 覆盖逻辑
    DisplayMethodAdd, // 累加逻辑
};

@protocol ZYCalculatorViewDelegate <NSObject>

- (void)keyBoardDidInputWithRecord:(NSMutableString *)record;

- (void)didCompleteCalculatorWithResult:(NSString *)result;

@end

@interface ZYCalculatorView : UIView

@property (nonatomic, weak) id <ZYCalculatorViewDelegate> delegate;

@end
