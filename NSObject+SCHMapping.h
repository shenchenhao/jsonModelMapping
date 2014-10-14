//
//  NSObject+SCHMapping.h
//  me
//
//  Created by 沈 晨豪 on 14-9-17.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SCHMapping)

/*
 *return 返回属性的字典 (NSDictionary *)
 *
 */
+ (NSDictionary *)propertyDictionary;

/*
 *return 返回属性的字典 (NSDictionary *)
 *
 *@param leves : 层级
 *
 */
+ (NSDictionary *)propertyDictionaryAtSuperClassLeves: (NSInteger) leves;


#pragma mark -
#pragma mark - json 转 model

/**
 *return 从json 数据转换为对应的model (instancetype)
 *
 *@param json_dic    : json的数据 字典类型
 *@param mapping_dic : 映射的的字典 (用于 json的 key 和 model 的属性 不对应相同 , 设为nil 则为model的属性和json的key对应相同) 如果mapping_dic 有值 则model的属性设为key而json的key设为value
 *
 *
 */
+ (instancetype)objectFromJsonDic: (NSDictionary *) json_dic mappingDic: (NSDictionary *) mapping_dic;

/**
 *return 从json 数据转换为对应的model (instancetype)
 *
 *@param json_dic    : json的数据 字典类型
 *@param mapping_dic : 映射的的字典 (用于 json的 key 和 model 的属性 不对应相同 , 设为nil 则为model的属性和json的key对应相同) 如果mapping_dic 有值 则model的属性设为key而json的key设为value
 *@param leves       : model 继承的层数
 *
 *
 */
+ (instancetype)objectFromJsonDic: (NSDictionary *) json_dic mappingDic: (NSDictionary *) mapping_dic superClassLeves: (NSInteger) leves;

/**
 *return 返回 从json 数据转换对应的array 取出的model 的array
 *
 *@param array       : json数据返回的array 内部的dic
 *@param mapping_dic : 映射的的字典 (用于 json的 key 和 model 的属性 不对应相同 , 设为nil 则为model的属性和json的key对应相同) 如果mapping_dic 有值 则model的属性设为key而json的key设为value
 *
 */
+ (NSArray *)objectArrayFromJsonArray: (NSArray *)array  modelClass:(Class) class_ mappingDic: (NSDictionary *) mapping_dic;

/**
 *return 返回 从json 数据转换对应的array 取出的model 的array
 *
 *@param array       : json数据返回的array 内部的dic
 *@param mapping_dic : 映射的的字典 (用于 json的 key 和 model 的属性 不对应相同 , 设为nil 则为model的属性和json的key对应相同) 如果mapping_dic 有值 则model的属性设为key而json的key设为value
 *
 */
+ (NSArray *)objectArrayFromJsonArray: (NSArray *)array  modelClass:(Class) class_ mappingDic: (NSDictionary *) mapping_dic superClassLeves: (NSInteger) leves;

#pragma mark -
#pragma mark - model 转 json

/**
 * 把model 转行为对应的字典 (此方法不可用于嵌套的model 暂时不处理NSValue)
 *
 *  @param model 需要转行为字典的对象

 */
- (NSDictionary *)jsonFromObject;

/**
 *
 *  把model 转行为对应的字典 (此方法不可用于嵌套的model 暂时不处理NSValue)
 *  @param model : 需要转行为字典的对象
 *  @param leves : model继承的层级
 *
 *  @return 对象model 转行为 对应的字典
 */
- (NSDictionary *)jsonFromObject: (NSInteger) leves;


/**
 *
 *  把model 转行为对应的字典 (此方法不可用于嵌套的model 暂时不处理NSValue)
 *  @param model       : 需要转行为字典的对象
 *  @param leves       : model继承的层级
 *  @param mapping_dic : 映射的字典 (用于 返回 的字典的 key 和 model 的属性名字 不相同是使用, 设置为nil 则model的属性名字和 字典的key的名字是一样的) 如果mapping_dic 有值  则model的属性名称设置key 而字典的key设置value
 *
 *  @return 对象model 转行为 对应的字典
 */
- (NSDictionary *)jsonFromObject: (NSInteger) leves mappingDic: (NSDictionary *) mapping_dic;

/**
 *  把model 转化为对应的字典(可作为深度 解析  所有的model 必须是 继承于 NSOjbect 的  暂时无法处理model属性名 和key不同的情况) (暂时不处理NSValue)
 *
 *  @return 对象model 转行为 对应的字典
 */
- (NSDictionary *)jsonFromDepthObject;


@end
