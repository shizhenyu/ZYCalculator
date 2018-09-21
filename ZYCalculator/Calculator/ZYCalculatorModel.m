//
//  ZYCalculatorModel.m
//  ZYCalculator
//
//  Created by youyun on 2018/7/3.
//  Copyright © 2018年 TaoSheng. All rights reserved.
//

#import "ZYCalculatorModel.h"

@implementation ZYCalculatorModel

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        self.operand1 = 0;
        
        self.operand2 = 0;
        
        self.result = 0;
    }
    
    return self;
}

- (long double)performOperation:(CalculatorOperateType)operateType {
    
    switch (operateType) {
        case CalculatorOperateTypeAdd:
        {
            self.result = self.operand1 + self.operand2;
        }
            break;
            
        case CalculatorOperateTypeSubtract:
        {
            self.result = self.operand1 - self.operand2;
        }
            break;
            
        case CalculatorOperateTypeMultiply:
        {
            self.result = self.operand1 * self.operand2;
        }
            break;
            
        case CalculatorOperateTypeDivide:
        {
            if (self.operand2 != 0) {
                
                self.result = self.operand1 / self.operand2;
            }
        }
            break;
            
        default:
            break;
    }
    
    return self.result;
}

- (void)clear {
    
    self.operand1 = 0;
    
    self.operand2 = 0;
    
    self.result = 0;
}

@end
