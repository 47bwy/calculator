//
//  LRViewController.m
//  Calculator
//
//  Created by Apri on 3/13/16.
//  Copyright © 2016 Apri. All rights reserved.
//

#import "LRViewController.h"

@interface LRViewController (){

    //标签
    UILabel * lrLabel;
    //按钮
    UIButton * lrButton;
    //保存标签中的文本
    NSString * lrLabelText;
    //点击运算符号临时的文本
    NSString * lrLabelTmpText;
    //运算符
    NSString * lrStrSign;
    //存放输入数值
    CGFloat preNum;
    CGFloat sufNum;
    CGFloat lastNum;
    
}

@end

@implementation LRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*
    //获取窗口大小数据
    CGRect screenRect = [UIScreen mainScreen].bounds;
    NSLog(@"%f, %f, %f,%f",screenRect.origin.x, screenRect.origin.y, screenRect.size.width,screenRect.size.height);
    //获取状态栏尺寸
    //NSLog(@"%@",NSStringFromCGRect([UIApplication sharedApplication].statusBarFrame));
    CGRect barRect = [UIApplication sharedApplication].statusBarFrame;
    NSLog(@"%f, %f, %f, %f", barRect.origin.x, barRect.origin.y, barRect.size.width, barRect.size.height);
    */
     
    //设置视图背景颜色
    self.view.backgroundColor = [UIColor grayColor];
    //计算标签的宽度和长度
    CGFloat labWidth = self.view.frame.size.width;
    CGFloat labHeight = self.view.frame.size.height/3.5;
    
    //计算按钮的宽度和长度
    CGFloat butWidth = (self.view.frame.size.width - 3)/4;
    CGFloat butHeight = labHeight/2;
    
#pragma mark - 显示器属性
    //添加计算器显示屏幕标签
    lrLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,labWidth, labHeight)];
    
    //设置屏幕显示属性

    lrLabel.text = @"0";
    lrLabel.adjustsFontSizeToFitWidth = YES;
    lrLabel.numberOfLines = 0;
    lrLabel.textColor = [UIColor whiteColor];
    lrLabel.font = [UIFont systemFontOfSize:72];
    lrLabel.textAlignment = NSTextAlignmentRight;
    lrLabel.backgroundColor = [UIColor blackColor];
    
    //放到视图上
    [self.view addSubview:lrLabel];
    
#pragma mark - 按钮设置
    //初始化标签中的文本
    lrLabelText = @"";
    
    //创建按钮上的标签
    NSArray * lrTitles = [NSArray arrayWithObjects:@"AC,clear", @"+/-,sign", @"%,percent", @"÷,cal:", @"7,number:", @"8,number:", @"9,number:", @"×,cal:", @"4,number:", @"5,number:", @"6,number:", @"－,cal:",@"1,number:",@"2,number:",@"3,number:",@"+,cal:", @"0,zero", @"0,zero", @".,dot", @"=,equal", nil];
    for (NSInteger i = 0; i < 5; i++) {     //行
        for (NSInteger j = 0; j < 4; j++) {     //列
            if (i == 4 && j == 1) {
                lrButton = [[UIButton alloc] initWithFrame:CGRectMake(0, labHeight + (1 + butHeight)*4, butWidth*2 + 1, butHeight)];
                //设置该按钮数字对齐
                lrButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                lrButton.contentEdgeInsets = UIEdgeInsetsMake(0,34, 0, 0);
            }
            else
            lrButton = [[UIButton alloc] initWithFrame:CGRectMake(0 + (1 + butWidth)*j, labHeight + (1 + butHeight)*i, butWidth, butHeight)];
            
            //按钮背景颜色设置
            if (j == 3) {
                lrButton.backgroundColor = [UIColor orangeColor];
            }
            else
                lrButton.backgroundColor = [UIColor lightGrayColor];
            
            //给每个按钮添加相应的标签
            NSString * lrStr = lrTitles[4*i + j];
            NSArray * lrArr = [lrStr componentsSeparatedByString:@","];
            [lrButton setTitle:lrArr[0] forState:UIControlStateNormal];
            [lrButton addTarget:self action:NSSelectorFromString(lrArr[1]) forControlEvents:UIControlEventTouchUpInside];
            lrButton.titleLabel.font=[UIFont systemFontOfSize:32];
            
            //按钮字体颜色设置
            if (j == 3) {
                [lrButton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            }
            else
                [lrButton setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
            
            //显示按钮
            [self.view addSubview:lrButton];
        }
        
    }
    //初始化这些变量
    lrLabelTmpText = @"";
    lrStrSign = @"";
    lastNum = 0;
    preNum = 0;
    sufNum = 0;
}

#pragma mark - 状态栏的显示样式
- (UIStatusBarStyle)preferredStatusBarStyle{

    return UIStatusBarStyleLightContent;
}

#pragma mark - 显示器的动作
- (void)show{
    
    if ([lrLabelText isEqualToString:@""]) {
        lrLabel.text = @"0";
    }
    else
        lrLabel.text = lrLabelText;
}

#pragma mark - 处理"AC"的动作
-(void)clear{
    
    lrLabelText = @"";
    lrLabelTmpText = @"";
    lastNum = 0;
    lrStrSign = @"";
    [self show];
    
}

#pragma mark - 处理数字"0~9"的动作
- (void)number:(UIButton *)sender{
    
    if (lastNum != 0 ) {    //判断上次的计算结果，有的话需要清除，没有则正常计算
        
        [self clear];
        lrLabelText = [NSString stringWithFormat:@"%@%@", lrLabelText, sender.titleLabel.text];
        [self show];
    }
    else{
        
        lrLabelText = [NSString stringWithFormat:@"%@%@", lrLabelText, sender.titleLabel.text];
        [self show];
    }
}

#pragma mark - 处理数字"0"的动作
-(void)zero{

    if (lastNum != 0 ) {    //判断上次的计算结果，有的话需要清除，没有则正常计算
        [self clear];
            if ([lrLabelText isEqualToString:@""]) {
                [self show];
            }
            else
                lrLabelText = [NSString stringWithFormat:@"%@%@", lrLabelText, @"0"];
    }
    else{
        if ([lrLabelText isEqualToString:@""]) {
            [self show];
        }
        else
            lrLabelText = [NSString stringWithFormat:@"%@%@", lrLabelText, @"0"];
    }
        //lrLabelText = [NSString stringWithFormat:@"%@%@", lrLabelText, @"0"];
    [self show];
}

#pragma mark - 处理"."的动作
- (void)dot{

    
    if (lrLabelText.length == 0) {
        lrLabelText = @"0.";
    }
    else if ([lrLabelText containsString:@"."] == NO){
        if (lastNum != 0) {     //判断上次的计算结果，有的话需要清除，没有则正常计算
            [self clear];
            lrLabelText = @"0";
            lrLabelText = [NSString stringWithFormat:@"%@%@", lrLabelText, @"."];
        }
        else
        lrLabelText = [NSString stringWithFormat:@"%@%@", lrLabelText, @"."];
    }
    else
        return;
    
    [self show];
}

#pragma mark - 处理"+-×÷"的动作
- (void)cal:(UIButton *)sender{

    lrStrSign = sender.titleLabel.text;
    
    //判断是否为 Not a number, 如果是 则一直返回这个值， 不是则进行运算
    if ([lrLabel.text isEqualToString:@"nan"]) {
        return;
    }
    else{
    
        //第一次输入，只赋值不计算
        if ([lrLabelTmpText isEqualToString:@""]) {
            lrLabelTmpText = [lrLabelText copy];
            [self show];
            lrLabelText = @"";
            
        }
        
        //否则为第二次输入，则带有计算功能
        else{
            if ([lrStrSign isEqualToString:@"+"]) {
                if (lastNum != 0) {     //判断上次的计算结果，有的话直接清除，结束判断，以便下次输入正常计算
                    lastNum = 0;
                    lrLabelText = @"";
                }
                else{
                    preNum = [lrLabelTmpText doubleValue];
                    sufNum = [lrLabelText doubleValue];
                    preNum = preNum + sufNum;
                    lrLabelText = [NSString stringWithFormat:@"%g", preNum];
                    [self show];
                    lrLabelTmpText = [NSString stringWithFormat:@"%g", preNum];
                    lrLabelText = @"";
                }
            }
            
            else if ([lrStrSign isEqualToString:@"-"]) {
                if (lastNum != 0) {     //判断上次的计算结果，有的话直接清除，结束判断，以便下次输入正常计算
                    lastNum = 0;
                    lrLabelText = @"";
                }
                else{
                    preNum = [lrLabelTmpText doubleValue];
                    sufNum = [lrLabelText doubleValue];
                    preNum = preNum - sufNum;
                    lrLabelText = [NSString stringWithFormat:@"%g", preNum];
                    [self show];
                    lrLabelTmpText = [NSString stringWithFormat:@"%g", preNum];
                    lrLabelText = @"";
                }
            }
            
            else if ([lrStrSign isEqualToString:@"×"]) {
                if (lastNum != 0) {     //判断上次的计算结果，有的话直接清除，结束判断，以便下次输入正常计算
                    lastNum = 0;
                    lrLabelText = @"";
                }
                else{
                    preNum = [lrLabelTmpText doubleValue];
                    sufNum = [lrLabelText doubleValue];
                    preNum = preNum * sufNum;
                    lrLabelText = [NSString stringWithFormat:@"%g", preNum];
                    [self show];
                    lrLabelTmpText = [NSString stringWithFormat:@"%g", preNum];
                    lrLabelText = @"";
                }
            }
            else {
                if (lastNum != 0) {     //判断上次的计算结果，有的话直接清除，结束判断，以便下次输入正常计算
                    lastNum = 0;
                    lrLabelText = @"";
                }
                else{
                    preNum = [lrLabelTmpText doubleValue];
                    sufNum = [lrLabelText doubleValue];
                    preNum = preNum / sufNum;
                    lrLabelText = [NSString stringWithFormat:@"%g", preNum];
                    [self show];
                    lrLabelTmpText = [NSString stringWithFormat:@"%g", preNum];
                    lrLabelText = @"";
                }
            }
        }
    }
}

#pragma mark - 处理"+/-"的动作
- (void)sign{

    if (lastNum != 0) {
        if ([[lrLabelTmpText substringToIndex:1] isEqualToString:@"-"]) {
            lrLabelTmpText = [lrLabel.text substringFromIndex:1];
        }
        else
           lrLabelTmpText = [NSString stringWithFormat:@"%@%@", @"-", lrLabel.text];
        lrLabel.text = lrLabelTmpText;
    }
    else{
        if (lrLabelText.length == 0) {
            return;
        }
        else if ([[lrLabelText substringToIndex:1] isEqualToString:@"-"]){
            lrLabelText = [lrLabelText substringFromIndex:1];
        }
        else
            lrLabelText = [NSString stringWithFormat:@"%@%@", @"-", lrLabelText];
        [self show];
    }
}

#pragma mark - 处理"%"的动作
- (void)percent{

    if (lastNum != 0) {
        lrLabelTmpText = [NSString stringWithFormat:@"%g", [lrLabelTmpText doubleValue]/100];
        lrLabel.text = lrLabelTmpText;
    }
    else{
        if (lrLabelText.length == 0) {
            return;
        }
        else
            lrLabelText = [NSString stringWithFormat:@"%g", [lrLabelText doubleValue]/100];
        [self show];
    }
}

#pragma mark - 处理"="的动作
- (void)equal{
    
    //同样的，做一次非法数值判断
    if ([lrLabel.text isEqualToString:@"nan"]) {
        return;
    }
    else{
        if ([lrStrSign isEqualToString:@""]) {
            [self show];
        }
        
        else if ([lrStrSign isEqualToString:@"+"]) {
            
            preNum = [lrLabelTmpText doubleValue];
            sufNum = [lrLabelText doubleValue];
            preNum = preNum + sufNum;
            lrLabel.text = [NSString stringWithFormat:@"%g", preNum];
            lrLabelTmpText = [NSString stringWithFormat:@"%g", preNum];
            lastNum = preNum;   //把计算结果记录下来，以便后面输入前做判断
        }
        
        else if ([lrStrSign isEqualToString:@"－"]) {
            
            preNum = [lrLabelTmpText doubleValue];
            sufNum = [lrLabelText doubleValue];
            preNum = preNum - sufNum;
            lrLabel.text = [NSString stringWithFormat:@"%g", preNum];
            lrLabelTmpText = [NSString stringWithFormat:@"%g", preNum];
            lastNum = preNum;
        }
        
        else if ([lrStrSign isEqualToString:@"×"]) {
            
            preNum = [lrLabelTmpText doubleValue];
            sufNum = [lrLabelText doubleValue];
            preNum = preNum * sufNum;
            lrLabel.text = [NSString stringWithFormat:@"%g", preNum];
            lrLabelTmpText = [NSString stringWithFormat:@"%g", preNum];
            lastNum = preNum;
        }
        
        else if ([lrStrSign isEqualToString:@"÷"]) {
            
            preNum = [lrLabelTmpText doubleValue];
            sufNum = [lrLabelText doubleValue];
            preNum = preNum / sufNum;
            lrLabel.text = [NSString stringWithFormat:@"%g", preNum];
            lrLabelTmpText = [NSString stringWithFormat:@"%g", preNum];
            lastNum = preNum;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
