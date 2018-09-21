//
//  UserDefine.h
//  ZYCalculator
//
//  Created by youyun on 2018/7/4.
//  Copyright © 2018年 TaoSheng. All rights reserved.
//

#ifndef UserDefine_h
#define UserDefine_h

typedef NS_ENUM(NSUInteger, CalculatorOperateType) {
    CalculatorOperateTypeDefault, // 默认命令，把当前值赋给calculatorModel第一个运算值
    CalculatorOperateTypeEqual,  // 等
    CalculatorOperateTypeAdd,     // 加
    CalculatorOperateTypeSubtract, // 减
    CalculatorOperateTypeMultiply, // 乘
    CalculatorOperateTypeDivide,  // 除
};

#endif /* UserDefine_h */
