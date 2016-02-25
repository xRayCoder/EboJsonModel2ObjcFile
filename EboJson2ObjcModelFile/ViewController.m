//
//  ViewController.m
//  EboJson2ObjcModelFile
//
//  Created by Ebo on 16/1/14.
//  Copyright © 2016年 Ebo. All rights reserved.
//

#import "ViewController.h"
#import "EboJsonToModelFile.h"
//#import "EBBOtestModel.h"
#import "EboSubjectModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    
//    NSDictionary * dic = @{@"name":@[@{@"Tom":@"Jerry"}],@"age":@"18", @"scoer":@{@"English":@"100"}};
    
    
    NSString * urlstr = @"http://m2.qiushibaike.com/article/list/day?count=10&page=1";
//
//    NSURL * url = [NSURL URLWithString:urlstr];
//    
//    NSData * data = [NSData dataWithContentsOfURL:url];
//    
    [EboJsonToModelFile parseWithURLString:urlstr andPrefix:@"ZHHModelDay" andFilePath:@"/Users/Ebo/Desktop/model" andFileName:@"ZHHModelDayRoot" keyMapperDic:nil];
    
//    EBBOtestModel * model = [[EBBOtestModel alloc] initWithData:data error:nil];
    
//    NSLog(@"");
    
//    NSString * str = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://10.0.8.10/app/qfts/iappfree/api/topic.php?page=%d&number=20"] encoding:NSUTF8StringEncoding error:nil];
    
    

   // 通过本地Json文件生成
//    NSString * str = [NSString stringWithContentsOfFile:@"/Users/Ebo/Desktop/test.txt" encoding:NSUTF8StringEncoding error:nil];
//    
//    NSLog(@"%@",str);
//    
//    NSString * jsonString = [NSString stringWithFormat:@"{\"homepage\":%@}", str];
//    
//    NSData * data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
//    
//    [EboJsonToModelFile parseWithData:data andPrefix:@"LPModel" andFilePath:@"/Users/Ebo/Desktop/test" andFileName:@"LPModelRoot" keyMapperDic:nil];
//    EboSubjectModel * model = [[EboSubjectModel alloc] initWithData:data error:nil];
    

    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
