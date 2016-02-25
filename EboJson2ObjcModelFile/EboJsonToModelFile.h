//
//  EboJsonToModelFile.h
//  EboJson2ObjcModelFile
//
//  Created by Ebo on 16/1/14.
//  Copyright © 2016年 Ebo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EboJsonToModelFile : NSObject

@property (nonatomic, strong) NSMutableDictionary * keyMapperDic;
@property (nonatomic, copy) NSMutableString * keyMapperString;

// 给定Json文件的url地址进行解析
/**
 *  给定Json文件的url地址进行解析
 *
 *  @param urlStr       url字符串
 *  @param prefix       要在文件名前添加的前缀，一般为个人名字拼音的大写字母
 *  @param filePath     生成的model文件存放路径
 *  @param filename     最外层model的文件名，包含前缀
 *  @param keyMapperDic 关键词替换的字典
 */
+ (void) parseWithURLString:(NSString *)urlStr andPrefix:(NSString *)prefix andFilePath:(NSString *)filePath andFileName:(NSString *)filename keyMapperDic:(NSDictionary *)keyMapperDic;

// 解析data类型的Json
/**
 *  解析data类型的Json
 *
 *  @param data         data类型的Json数据
 *  @param prefix       要在文件名前添加的前缀，一般为个人名字拼音的大写字母
 *  @param filePath     生成的model文件存放路径
 *  @param filename     最外层model的文件名，包含前缀
 *  @param keyMapperDic 关键词替换的字典
 */
+ (void) parseWithData:(NSData *)data andPrefix:(NSString *)prefix andFilePath:(NSString *)filePath andFileName:(NSString *)filename keyMapperDic:(NSDictionary *)keyMapperDic;

@end
