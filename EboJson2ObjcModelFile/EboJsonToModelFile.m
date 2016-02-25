//
//  EboJsonToModelFile.m
//  EboJson2ObjcModelFile
//
//  Created by Ebo on 16/1/14.
//  Copyright © 2016年 Ebo. All rights reserved.
//

#import "EboJsonToModelFile.h"

@interface EboJsonToModelFile () {

    
}

@end

@implementation EboJsonToModelFile

- (instancetype)init {

    if (self = [super init]) {
        
        _keyMapperDic = [[NSMutableDictionary alloc] initWithDictionary:@{@"id":@"theID",@"ID":@"theID",@"class":@"theClass",@"Class":@"theClass",@"description":@"theDescription"}];
        _keyMapperString = [[NSMutableString alloc] init];
        [_keyMapperString appendString:@"@{@\"id\":@\"theID\",@\"ID\":@\"theID\",@\"class\":@\"theClass\",@\"Class\":@\"theClass\",@\"description\":@\"theDescription\"}"];
    }
    
    return self;
}

- (void) setKeyMapperDictionaryWithDic:(NSDictionary *)keyMapperDic {

    [self.keyMapperDic removeAllObjects];
    [self.keyMapperDic setValuesForKeysWithDictionary:keyMapperDic];
    
    NSArray * keys = [self.keyMapperDic allKeys];
    NSArray * values = [self.keyMapperDic allValues];
    
    NSInteger count = keys.count;
    
    [self.keyMapperString setString:@""];
    [self.keyMapperString appendString:@"@{"];
    for (int i = 0; i < count; i++) {
        
        [self.keyMapperString appendFormat:@"@\"%@\":@\"%@\",", keys[i], values[i]];
    }
    [self.keyMapperString replaceCharactersInRange:NSMakeRange(self.keyMapperString.length - 1, 1) withString:@""];
    [self.keyMapperString appendString:@"}"];
    NSLog(@"%@",self.keyMapperString);
    
}

+ (void) parseWithURLString:(NSString *)urlStr andPrefix:(NSString *)prefix andFilePath:(NSString *)filePath andFileName:(NSString *)filename keyMapperDic:(NSDictionary *)keyMapperDic{
    
    EboJsonToModelFile * convertor = [[EboJsonToModelFile alloc] init];
    
    // 用keyMapperDic 替换系统默认的keyMapperDic替换规则
    if (keyMapperDic) {
        
        [convertor setKeyMapperDictionaryWithDic:keyMapperDic];
    }
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
    // 使用系统的Json解析引擎解析Json文件，因为JsonModel只支持字典类型，所以默认用字典接收解析出来的数据
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    [convertor convertWithObject:dic andPrefix:prefix protocalString:nil andFilePath:filePath fileName:filename];
}

+ (void) parseWithData:(NSData *)data andPrefix:(NSString *)prefix andFilePath:(NSString *)filePath andFileName:(NSString *)filename keyMapperDic:(NSDictionary *)keyMapperDic{
    
    EboJsonToModelFile * convertor = [[EboJsonToModelFile alloc] init];
    
    // 用keyMapperDic 替换系统默认的keyMapperDic替换规则
    if (keyMapperDic) {
        
        [convertor setKeyMapperDictionaryWithDic:keyMapperDic];
    }
    
    // 用keyMapperDic 替换系统默认的keyMapperDic替换规则
    if (keyMapperDic) {
        [convertor.keyMapperDic removeAllObjects];
        [convertor.keyMapperDic setValuesForKeysWithDictionary:keyMapperDic];
    }
    
    // 使用系统的Json解析引擎解析Json文件，因为JsonModel只支持字典类型，所以默认用字典接收解析出来的数据
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    [convertor convertWithObject:dic andPrefix:prefix  protocalString:nil andFilePath:filePath fileName:filename];
}

- (void) convertWithObject:(id)object  andPrefix:(NSString *)prefix protocalString:(NSString *)protocalString andFilePath:(NSString *)filePath fileName:(NSString *)fileName{
    
    
    
    NSMutableString * propertyStr = [[NSMutableString alloc] init];
    NSMutableString * resultStr = [[NSMutableString alloc] init];
    NSMutableArray * importList = [[NSMutableArray alloc] init];
    
    
    // 遍历目标数组或字典
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSArray * keys = [object allKeys];
        
        for (NSString * orginalKey in keys) {
            
            
            // 判断originalKey是否是关键字，如果是，则进行替换
            NSArray * mapperKeys = [_keyMapperDic allKeys];
            NSString * key = nil;
            NSInteger flag = 0;
            for (NSString * mapperKey in mapperKeys) {
                if ([mapperKey isEqualToString:orginalKey]) {
                    key = [_keyMapperDic valueForKey:orginalKey];
                    flag = 1;
                }
            }
            
            if (flag == 0) {
                key = orginalKey;
            }
            
            NSString * subModelName = [NSString stringWithFormat:@"%@%@",prefix, [key capitalizedString]];
            
            // 处理键值是字典
            if ([[object objectForKey:key] isKindOfClass:[NSDictionary class]]) {
                
                [propertyStr appendFormat:@"@property (nonatomic, strong) %@ <Optional> * %@;\n",subModelName, key];
                [importList addObject:[NSString stringWithFormat:@"%@%@",prefix, [key capitalizedString]]];
                //                NSLog(@"key:%@ type:%@",key, [NSDictionary class]);
                [self convertWithObject:[object objectForKey:key] andPrefix:prefix protocalString:nil andFilePath:filePath fileName:subModelName];
            }
            // 处理键值是数组
            else if ([[object objectForKey:key] isKindOfClass:[NSArray class]]) {
                
                [propertyStr appendFormat:@"@property (nonatomic, strong) NSArray <%@%@, Optional> * %@;\n", prefix, [key capitalizedString], key];
                
                [importList addObject:[NSString stringWithFormat:@"%@%@",prefix, [key capitalizedString]]];
                [self convertWithObject:[object objectForKey:key][0] andPrefix:prefix protocalString:subModelName andFilePath:filePath fileName:subModelName];
                
                
                //                NSLog(@"key:%@ type:%@",key, [NSArray class]);
            }
            // 处理键值是最后一层的情况
            else {
                [propertyStr appendFormat:@"@property (nonatomic, copy) NSString <Optional> * %@;\n", key];
            }
            
        }
        
    }
    
    // 拼接h头文件内容
    
    [resultStr appendFormat:@"#import \"JSONModel.h\"\n"];
    
    for (NSString * filename in importList) {
        [resultStr appendFormat:@"#import \"%@.h\"\n", filename];
    }
    
    if (protocalString) {
        [resultStr appendFormat:@"\n@protocol %@ <NSObject>\n@end\n", fileName];
    }
    
    [resultStr appendFormat:@"\n@interface %@ : JSONModel", fileName];
    
    [resultStr appendFormat:@"\n%@", propertyStr];
    [resultStr appendString:@"@end"];
    
    NSLog(@"\n%@", resultStr);
    
    // 拼接.m文件内容
    NSMutableString * mFileString = [[NSMutableString alloc] init];
    [mFileString appendFormat:@"#import \"%@.h\"\n",fileName];
    [mFileString appendFormat:@"\n@implementation %@\n", fileName];
    // 添加propertyIsOptional方法
    [mFileString appendFormat:@"+ (BOOL)propertyIsOptional:(NSString *)propertyName {\n\treturn YES;\n}\n\n"];
    // 添加方法
    [mFileString appendFormat:@"+ (JSONKeyMapper *)keyMapper {\n\treturn [[JSONKeyMapper alloc] initWithDictionary:%@];\n}\n@end\n", self.keyMapperString];
    NSLog(@"\n%@", mFileString);
    
    
    // 写文件
    
    [resultStr writeToFile:[NSString stringWithFormat:@"%@/%@.h",filePath,fileName] atomically:YES encoding:NSUTF8StringEncoding error:nil];
    [mFileString writeToFile:[NSString stringWithFormat:@"%@/%@.m",filePath,fileName] atomically:YES encoding:NSUTF8StringEncoding error:nil];
 
}



@end
