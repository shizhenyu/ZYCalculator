//
//  ZYCalculatorModel.h
//  ZYCalculator
//
//  Created by youyun on 2018/7/3.
//  Copyright © 2018年 TaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYCalculatorModel : NSObject

/** 第一个运算值 */
@property (nonatomic, assign) long double operand1;

/** 第二个运算值 */
@property (nonatomic, assign) long double operand2;

/** 运算结果 */
@property (nonatomic ,assign) long double result;

/**
 执行运算执行

 @param operateType 运算的指令
 @return 运算的结果
 */
- (long double)performOperation:(CalculatorOperateType)operateType;

/**
 clear指令，清除所有数据
 */
- (void)clear;

@end
