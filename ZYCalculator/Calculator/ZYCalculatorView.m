//
//  ZYCalculatorView.m
//  ZYCalculator
//
//  Created by youyun on 2018/7/3.
//  Copyright © 2018年 TaoSheng. All rights reserved.
//

#import "ZYCalculatorView.h"
#import "ZYCalculatorModel.h"

@interface ZYCalculatorView () {
    
    long double currentResult; // 当前数值
    int totalNumCount; // 总位数，规定不得超过16位
    BOOL isDecimal; // 是否是小数
    int decimalCount; // 小数位数
    
    CalculatorOperateType operateType; // 运算符类型
}

@property (nonatomic, strong) NSMutableString *recordStr;

@property (nonatomic, strong) ZYCalculatorModel *calculatorModel;

@end

@implementation ZYCalculatorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor cyanColor];
        
        currentResult = 0;
        isDecimal = NO;
        decimalCount = 0;
        
        self.calculatorModel = [[ZYCalculatorModel alloc] init];
        
        [self displayRecord:@"0" withMethod:DisplayMethodCover];
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    NSArray *titleArr = @[@"7", @"8", @"9", @"÷", @"4", @"5", @"6", @"×", @"1", @"2", @"3", @"-", @"0", @"·", @"=", @"+"];
    
    CGFloat buttonWidth = kScreenWidth * 0.9 / 4;
    
    for (int i = 0; i < 4; i ++) {
        
        for (int j = 0; j < 4; j ++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            NSString *title = [titleArr objectAtIndex:i * 4 + j];
            
            [button setTitle:title forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
            
            button.titleLabel.font = [UIFont boldSystemFontOfSize:26];
            
            button.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
            
            button.tag = 100 + (i * 4 + j);
            
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:button];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.top.equalTo(self.mas_top).offset(kWidth(15) + kWidth(63) * i);
                
                make.leading.equalTo(self.mas_leading).offset(buttonWidth * j + kScreenWidth * 0.05);
                
                make.width.mas_equalTo(buttonWidth - 1);
                
                make.height.mas_equalTo(kWidth(62));
                
            }];
        }
    }
}

#pragma mark - 按钮点击事件
- (void)buttonClick:(UIButton *)sender {
    
    switch (sender.tag - 100) {
        case 0:
        {
            totalNumCount ++;
            [self numKeyBoardDidSelected:@"7"];
        }
            break;
        case 1:
        {
            totalNumCount ++;
            [self numKeyBoardDidSelected:@"8"];
        }
            break;
        case 2:
        {
            totalNumCount ++;
            [self numKeyBoardDidSelected:@"9"];
        }
            break;
        case 3:
        {
            if (self.recordStr.length != 0) {
                
                if ([self operatorIsAlreadyExists] == NO) {
                    
                    [self displayRecord:@"÷" withMethod:DisplayMethodAdd];
                    
                    [self operateKeyBoardDidSelected:CalculatorOperateTypeDivide];
                }
            }
        }
            break;
        case 4:
        {
            totalNumCount ++;
            [self numKeyBoardDidSelected:@"4"];
        }
            break;
        case 5:
        {
            totalNumCount ++;
            [self numKeyBoardDidSelected:@"5"];
        }
            break;
        case 6:
        {
            totalNumCount ++;
            [self numKeyBoardDidSelected:@"6"];
        }
            break;
        case 7:
        {
            if (self.recordStr.length != 0) {
                
                if ([self operatorIsAlreadyExists] == NO) {
                    
                    [self displayRecord:@"x" withMethod:DisplayMethodAdd];
                    
                    [self operateKeyBoardDidSelected:CalculatorOperateTypeMultiply];
                }
            }
        }
            break;
        case 8:
        {
            totalNumCount ++;
            [self numKeyBoardDidSelected:@"1"];
        }
            break;
        case 9:
        {
            totalNumCount ++;
            [self numKeyBoardDidSelected:@"2"];
        }
            break;
        case 10:
        {
            totalNumCount ++;
            [self numKeyBoardDidSelected:@"3"];
        }
            break;
        case 11:
        {
            if (self.recordStr.length != 0) {
                
                if ([self operatorIsAlreadyExists] == NO) {
                    
                    [self displayRecord:@"-" withMethod:DisplayMethodAdd];
                    
                    [self operateKeyBoardDidSelected:CalculatorOperateTypeSubtract];
                }
            }
        }
            break;
        case 12:
        {
            totalNumCount ++;
            [self numKeyBoardDidSelected:@"0"];
        }
            break;
        case 13:
        {
            if (self.recordStr.length != 0) {
             
                if (isDecimal == NO && [self operatorIsAlreadyExists] == NO) {
                    
                    isDecimal = YES;
                    
                    [self displayRecord:@"." withMethod:DisplayMethodAdd];
                }
                
            }
        }
            break;
        case 14:
        {
            [self operateKeyBoardDidSelected:CalculatorOperateTypeEqual];
        }
            break;
        case 15:
        {
            if (self.recordStr.length != 0) {
                
                if ([self operatorIsAlreadyExists] == NO) {
                    
                    [self displayRecord:@"+" withMethod:DisplayMethodAdd];
                    
                    [self operateKeyBoardDidSelected:CalculatorOperateTypeAdd];
                }
                
            }
        }
            break;
            
        default:
            break;
    }
}


/**
 是否已经存在运算符，如果存在则不再累加运算符

 @return bool
 */
- (BOOL)operatorIsAlreadyExists {
    
    if (![[self.recordStr substringFromIndex:self.recordStr.length - 1] isEqualToString:@"+"]
        && ![[self.recordStr substringFromIndex:self.recordStr.length - 1] isEqualToString:@"-"]
        && ![[self.recordStr substringFromIndex:self.recordStr.length - 1] isEqualToString:@"x"]
        && ![[self.recordStr substringFromIndex:self.recordStr.length - 1] isEqualToString:@"÷"]
        && ![[self.recordStr substringFromIndex:self.recordStr.length - 1] isEqualToString:@"."]) {
        
        return NO;
    }
    
    return YES;
}

#pragma mark - 点击0-9数字和小数点
- (void)numKeyBoardDidSelected:(NSString *)num {
    
    if (currentResult == 0 && isDecimal == NO) {  // 如果数值为0并且没有小数点，则直接覆盖
        
        [self displayRecord:num withMethod:DisplayMethodAdd];
        
    }else {  // 直接拼接输入的内容
        
        [self displayRecord:num withMethod:DisplayMethodAdd];
    }
    
    if (isDecimal == NO) {  // 如果不包含小数
        
        if (currentResult >= 0) { // 如果之前数值就>=0, 就是累加 *10
            
            currentResult = currentResult * 10 + [num intValue];
            
        }else { // 数值<0， 则采用 -号 逻辑
            
            currentResult = currentResult * 10 - [num intValue];
        }
        
    }else {  // 包含小数
        
        decimalCount ++; // 小数位数+1
        
        if (currentResult >= 0) {
            
            currentResult = currentResult + [num intValue] * pow(10, (-1)*decimalCount);
            
        }else {
            
            currentResult = currentResult - [num intValue] * pow(10, (-1)*decimalCount);
        }
    }
    
    NSLog(@"%.6Lf", currentResult);
}

#pragma mark - 点击 +、 -、 *、 ÷、 =、五个运算符
- (void)operateKeyBoardDidSelected:(CalculatorOperateType)currentOperateType {
    
    switch (currentOperateType) {
            
        case CalculatorOperateTypeAdd:
        case CalculatorOperateTypeSubtract:
        case CalculatorOperateTypeMultiply:
        case CalculatorOperateTypeDivide:
            
            totalNumCount = 0;  // 先把总位数置于0
            
            isDecimal = NO;
            decimalCount = 0;
            
            if (operateType == CalculatorOperateTypeDefault) {  // 默认命令，把当前值赋给calculatorModel第一个运算值
                
                operateType = currentOperateType;
                
                self.calculatorModel.operand1 = currentResult;  // 把当前结果赋值给calculatorModel的第一个运算值
                
                currentResult = 0;  // 让当前结果 = 0
                
            }else {
                
                // 让当前currentResult赋予calculatorModel的第二个运算值，准备执行运算指令
                self.calculatorModel.operand2 = currentResult;
                
                currentResult = [self.calculatorModel performOperation:operateType];
                
                self.calculatorModel.operand1 = currentResult;
                
                currentResult = 0;
                
                operateType = currentOperateType;
            }
            
            break;
            
        case CalculatorOperateTypeEqual: { // 点击 = 号
            
            totalNumCount = 0;  // 先把总位数置于0
            
            // 让当前currentResult赋予calculatorModel的第二个运算值，准备执行=号
            self.calculatorModel.operand2 = currentResult;
            
            currentResult = [self.calculatorModel performOperation:operateType];  // 执行=号
            
            // 把运行结果展示出来
            [self displayCalculatorResult:[NSString stringWithFormat:@"%Lg", currentResult]];
            
            // 把计算结果赋给calculatorModel第一个运算值，方便下次运算
            self.calculatorModel.operand1 = self.calculatorModel.result;
            
            operateType = CalculatorOperateTypeDefault;
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 决定是覆盖原来结果还是新增
- (void)displayRecord:(NSString *)string withMethod:(DisplayMethod)method {
    
    switch (method) {
        case DisplayMethodCover:
        {
            self.recordStr = [[NSMutableString alloc] init];
        }
            break;
            
            case DisplayMethodAdd:
        {
            [self.recordStr appendString:string];
        }
            
        default:
            break;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(keyBoardDidInputWithRecord:)]) {
        
        [self.delegate keyBoardDidInputWithRecord:self.recordStr];
    }
}

#pragma mark - 点击=号展示的运算结果
- (void)displayCalculatorResult:(NSString *)result {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didCompleteCalculatorWithResult:)]) {
        
        [self.delegate didCompleteCalculatorWithResult:result];
    }
}

@end
