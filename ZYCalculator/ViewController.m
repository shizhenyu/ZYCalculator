//
//  ViewController.m
//  ZYCalculator
//
//  Created by youyun on 2018/7/3.
//  Copyright © 2018年 TaoSheng. All rights reserved.
//

#import "ViewController.h"
#import "ZYCalculatorView.h"

@interface ViewController ()<ZYCalculatorViewDelegate>

@property (nonatomic, strong) UITextField *resultTextF;

@property (nonatomic, strong) UITextField *recordLabel;

@property (nonatomic, strong) ZYCalculatorView *calculatorView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
  
    self.resultTextF = [[UITextField alloc] init];
    self.resultTextF.text = @"0";
    self.resultTextF.textAlignment = NSTextAlignmentRight;
    self.resultTextF.backgroundColor = [UIColor orangeColor];
    self.resultTextF.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:self.resultTextF];
    
    self.recordLabel = [[UITextField alloc] init];
    self.recordLabel.text = @"0";
    self.recordLabel.textAlignment = NSTextAlignmentRight;
    self.recordLabel.backgroundColor = [UIColor cyanColor];
    self.recordLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:self.recordLabel];
    
    self.calculatorView = [[ZYCalculatorView alloc] init];
    self.calculatorView.delegate = self;
    [self.view addSubview:self.calculatorView];

    [self.resultTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(kWidth(100));
        
        make.leading.mas_equalTo(kWidth(15));
        
        make.trailing.mas_equalTo(kWidth(-15));
        
        make.height.mas_equalTo(kWidth(50));
        
    }];
    
    [self.recordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.resultTextF.mas_bottom).offset(kWidth(50));
        
        make.leading.mas_equalTo(kWidth(15));
        
        make.trailing.mas_equalTo(kWidth(-15));
        
        make.height.mas_equalTo(kWidth(50));
        
    }];
    
    [self.calculatorView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.trailing.mas_equalTo(0);
        
        make.bottom.mas_equalTo(0);
        
        make.height.mas_equalTo(kWidth(63) * 4 + kWidth(30));
        
    }];
}

#pragma mark - ZYCalculatorViewDelegate
- (void)keyBoardDidInputWithRecord:(NSMutableString *)record {
    
    self.recordLabel.text = record;
}
- (void)didCompleteCalculatorWithResult:(NSString *)result {
    
    self.resultTextF.text = result;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
