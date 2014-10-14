//
//  NSObject+SCHMapping.m
//  me
//
//  Created by 沈 晨豪 on 14-9-17.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "NSObject+SCHMapping.h"
#import <objc/runtime.h>





@interface NSString(JsonType)

/*
 *return 返回是什么类型的 名称 (NSString *)
 *
 *@param property : 属性的结构体
 *
 */
+ (NSString *)attributeNameByProperty: (objc_property_t) property;

@end
/*
 T@"NSValue",C,N,V_value_test
 T@"NSNumber",C,N,V_number_test
 T@"NSString",C,N,V_string_test
 T@"NSMutableString",C,N,V_m_string_test
 T@"NSArray",&,N,V_array_test
 T@"NSMutableArray",&,N,V_m_array_test
 T@"NSDictionary",&,N,V_dictionary_test
 T@"NSMutableDictionary",&,N,V_m_dictionary_test
 T@"NSSet",&,N,V_set_test
 T@"NSMutableSet",&,N,V_m_set_test
 T@"NSData",C,N,V_data_test
 T@"NSMutableData",C,N,V_m_data_test
 
 /--32 bit --/
 
 Tf,N,V_CGFloat_test
 Ti,N,V_NSInteger_test
 Tc,N,V_BOOL_test
 TB,N,V_bool_test
 Tc,N,V_char_test
 Ts,N,V_short_test
 Ti,N,V_int_test
 Tl,N,V_long_test
 Tl,N,V_int_long_test
 Tl,N,V_long_int_test
 Tq,N,V_long_long_test
 Tf,N,V_float_test
 Td,N,V_double_test
 TC,N,V_u_char_test
 TS,N,V_u_short_test
 TI,N,V_u_int_test
 TL,N,V_u_long_test
 TL,N,V_u_int_long_test
 TL,N,V_u_long_int_test
 TQ,N,V_u_long_long_test
 
 /--64 bit --/
 Td,N,V_CGFloat_test
 Tq,N,V_NSInteger_test
 TB,N,V_BOOL_test
 TB,N,V_bool_test
 Tc,N,V_char_test
 Ts,N,V_short_test
 Ti,N,V_int_test
 Tq,N,V_long_test
 Tq,N,V_int_long_test
 Tq,N,V_long_int_test
 Tq,N,V_long_long_test
 Tf,N,V_float_test
 Td,N,V_double_test
 TC,N,V_u_char_test
 TS,N,V_u_short_test
 TI,N,V_u_int_test
 TQ,N,V_u_long_test
 TQ,N,V_u_int_long_test
 TQ,N,V_u_long_int_test
 TQ,N,V_u_long_long_test
 
 */


typedef enum
{
    NSValueAttribute  = 0,
    NSNumberAttribute,
    
    NSStringAttribute,
    NSMutableStringAttribute,
    
    NSArrayAttribute,
    NSMutableArrayAttribute,
    
    NSDictionaryAttribute,
    NSMutableDictionaryAttribute,
    
    NSSetAttribute,
    NSMutableSetAttribute,
    
    NSDataAttribute,
    NSMutableDataAttribute,
    
    NSDateAttribute,
    
    
    
    CcharAttribute,
    CshortAttribute,
    CintAttribute,
    ClongAttribute,
    ClonglongAttribute,  //Tq
    CfloatAttribute,
    CdoubleAttribute,
    CboolAttribute,      //TB
    CulonglongAttribute, //TQ
    CucharAttribute,     //TC
    CushortAttribute,    //TS
    CuintAttribute,      //TI
    
    OtherAttribute
    
}AttributeType;

@implementation NSString (JsonType)

/*
 *return 返回是什么类型的 名称 (NSString *)
 *
 *@param property : 属性的结构体
 *
 */
+ (NSString *)attributeNameByProperty: (objc_property_t) property
{
    NSString *attribute_str = [NSString stringWithUTF8String:property_getAttributes(property)];
    
    NSString *attribute     = [[attribute_str componentsSeparatedByString:@","] objectAtIndex:0];
    
    return attribute;
}


+ (AttributeType)getAttributeType: (NSString *) attribute_name
{
    /*NSValue*/
    if([attribute_name isEqualToString:@"T@\"NSValue\""])
        return NSValueAttribute;
    
    
    
    /*NSNumber*/
    if([attribute_name isEqualToString:@"T@\"NSNumber\""])
        return NSNumberAttribute;
    
    
    /*NSString*/
    if([attribute_name isEqualToString:@"T@\"NSString\""])
        return NSStringAttribute;
    /*NSMutableString*/
    if([attribute_name isEqualToString:@"T@\"NSMutableString\""])
        return NSMutableStringAttribute;
    
    
    /*NSArray*/
    if([attribute_name isEqualToString:@"T@\"NSArray\""])
        return NSArrayAttribute;
    /*NSMutableArray*/
    if([attribute_name isEqualToString:@"T@\"NSMutableArray\""])
        return NSMutableArrayAttribute;
    
    
    /*NSDictionary*/
    if([attribute_name isEqualToString:@"T@\"NSDictionary\""])
        return NSDictionaryAttribute;
    /*NSMutableDictionary*/
    if([attribute_name isEqualToString:@"T@\"NSMutableDictionary\""])
        return NSMutableDictionaryAttribute;
    
    
    /*NSSet*/
    if([attribute_name isEqualToString:@"T@\"NSSet\""])
        return NSSetAttribute;
    /*NSMutableSet*/
    if([attribute_name isEqualToString:@"T@\"NSMutableSet\""])
        return NSMutableSetAttribute;
    
    
    /*NSData*/
    if ([attribute_name isEqualToString:@"T@\"NSData\""])
        return NSDataAttribute;
    /*NSMutableData*/
    if([attribute_name isEqualToString:@"T@\"NSMutableData\""])
        return NSMutableDataAttribute;
    
    /*NSDate*/
    if ([attribute_name isEqualToString:@"T@\"NSDate\""])
        return NSDateAttribute;
    
    
    /*char bool*/
    if([attribute_name isEqualToString:@"Tc"])
        return CcharAttribute;
    
    /*short*/
    if ([attribute_name isEqualToString:@"Ts"])
        return CshortAttribute;
    
    /*long*/
    if([attribute_name isEqualToString:@"Tl"])
        return ClongAttribute;
    
    /*long long*/
    if ([attribute_name isEqualToString:@"Tq"])
        return ClonglongAttribute;
    
    /*BOOL */
    if ([attribute_name isEqualToString:@"TB"])
        return CboolAttribute;
    
    /*int*/
    if ([attribute_name isEqualToString:@"Ti"])
        return CintAttribute;
    
    /*float*/
    if ([attribute_name isEqualToString:@"Tf"])
        return CfloatAttribute;
    
    /*double*/
    if ([attribute_name isEqualToString:@"Td"])
        return CdoubleAttribute;
    
    /*u long long*/
    if ([attribute_name isEqualToString:@"TQ"])
        return CulonglongAttribute;
    
    /*u char*/
    if ([attribute_name isEqualToString:@"TC"])
        return CucharAttribute;
    
    /*u short*/
    if ([attribute_name isEqualToString:@"TS"])
        return CushortAttribute;
    
    /*u int*/
    if ([attribute_name isEqualToString:@"TI"])
        return CuintAttribute;
    
    return OtherAttribute;
}


@end


static const void *PropertyIndexKey = (void *)@"PropertyIndexKey";

@interface NSObject()

@property (nonatomic, copy) NSNumber *property_index;


@end

@implementation NSObject (SCHMapping)


- (void)setProperty_index:(NSNumber *)property_index
{
    [self willChangeValueForKey:@"property_index"];
    objc_setAssociatedObject(self, PropertyIndexKey, property_index, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"property_index"];
}


- (NSNumber *)property_index
{
    return objc_getAssociatedObject(self, PropertyIndexKey);
}

/*
 *return 返回属性的字典 (NSDictionary *)
 *
 */
+ (NSDictionary *)propertyDictionary;

{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (unsigned i = 0; i < count; i++)
    {
        const char *property_name = property_getName(properties[i]);
        NSString   *key           = [NSString stringWithUTF8String:property_name];
        
        //  NSLog(@"%@",[NSString stringWithUTF8String:property_getAttributes(properties[i]) ]);
        key.property_index = [NSNumber numberWithInt:i];
        
        [dic setObject:key.property_index forKey:key];
        
        
    }
    
    free(properties);
    
    return dic;
}


/*
 *return 返回属性的字典 (NSDictionary *)
 *
 *@param leves : 层次
 *
 */
+ (NSDictionary *)propertyDictionaryAtSuperClassLeves: (NSInteger) leves
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    
    
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (unsigned i = 0; i < count; i++)
    {
        const char *property_name = property_getName(properties[i]);
        NSString   *key           = [NSString stringWithUTF8String:property_name];
        
        //  NSLog(@"%@",[NSString stringWithUTF8String:property_getAttributes(properties[i]) ]);
        key.property_index = [NSNumber numberWithInt:i];
        
        [dic setObject:key.property_index forKey:key];
        
        
    }
    
    free(properties);
    
    
    Class class_ = self;
    
    int i = (int)leves;
    
    while (i)
    {
        class_ = [class_ superclass];
        
        NSString *super_class_name = NSStringFromClass(class_);
        
        if (![super_class_name isEqualToString:NSStringFromClass([NSObject class])])
        {
            for (NSString *property in [[class_ propertyDictionary] allKeys])
            {
                [dic setObject:property forKey:property];
                
            }
        }
        
        --i;
    }
    
    
    return dic;
}


#pragma mark -
#pragma mark - json 转 model

/*
 *return 从json 数据转换为对应的model (instancetype)
 *
 *@param json_dic    : json的数据 字典类型
 *@param mapping_dic : 映射的的字典 (用于 json的 key 和 model 的属性 不对应相同 , 设为nil 则为model的属性和json的key对应相同) 如果mapping_dic有值 则model的属性设为key而json的key设为value
 *
 *
 */
+ (instancetype)objectFromJsonDic: (NSDictionary *) json_dic mappingDic: (NSDictionary *) mapping_dic
{
    id model = [[[self class] alloc] init];
    
    @try
    {
        NSDictionary *property_dic = [self propertyDictionary];
        
        for (NSString *property_name in [property_dic allKeys])
        {
            @autoreleasepool {
                
                
                NSString *json_key = nil;
                
                if(nil != mapping_dic)
                {
                    json_key = [mapping_dic objectForKey:property_name];
                }
                
                if(nil == json_key || 0 == json_key.length)
                    json_key = property_name;
                
                id value = [json_dic objectForKey:json_key];
                
                if(nil == value || [NSNull null] == value)
                    continue;
                
                
                /*设置属性*/
                objc_property_t property       = class_getProperty(self.class, [property_name UTF8String]);
                
                
                AttributeType   attribute_type = [NSString getAttributeType:[NSString attributeNameByProperty:property]];
                
                /*NSValue , NSNumber , NSString, NSMutableString*/
                if (NSValueAttribute == attribute_type || NSNumberAttribute == attribute_type || NSStringAttribute == attribute_type || NSMutableStringAttribute == attribute_type)
                {
                    if([NSNull null] != value)
                    {
                        [model setValue:value forKey:property_name];
                    }
                    else
                    {
                        [model setValue:nil forKey:property_name];
                    }
                    
                    continue;
                    
                }
                
                
                /*NSDictionary , NSMutableDictionary*/
                if(NSDictionaryAttribute == attribute_type || NSMutableDictionaryAttribute == attribute_type)
                {
                    if ([value isKindOfClass:[NSDictionary class]])
                    {
                        [model setValue:value forKey:property_name];
                    }
                    
                    continue;
                }
                
                /*NSArray , NSMutableArray*/
                if (NSArrayAttribute == attribute_type || NSMutableArrayAttribute == attribute_type)
                {
                    
                    
                    if([value isKindOfClass:[NSArray class]])
                    {
                        [model setValue:value forKey:property_name];
                    }
                    
                    continue;
                }
                
                
                /*char bool short int  long  float double longlong  uchar ushort uint ulong  ulonglong  */
                if (CcharAttribute == attribute_type || CshortAttribute == attribute_type || CintAttribute == attribute_type || ClongAttribute == attribute_type || CfloatAttribute == attribute_type || CdoubleAttribute == attribute_type || ClonglongAttribute == attribute_type || CboolAttribute == attribute_type || CulonglongAttribute == attribute_type || CucharAttribute == attribute_type || CushortAttribute == attribute_type || CuintAttribute == attribute_type)
                {
                    
                    [model setValue:value forKey:property_name];
                    continue;
                }
                
                
                /*NSDate*/
                if (NSDateAttribute == attribute_type)
                {
                    /*先不做处理*/
                }
                
                /*other*/
                if (OtherAttribute == attribute_type)
                {
                    /*先不做处理*/
                }
            }
            
        }
    }
    @catch (NSException *exception)
    {
        NSLog(@"%@",exception);
    }
    @finally
    {
        
        return model;
    }
    
    
    return nil;
    
}

/*
 *return 从json 数据转换为对应的model (instancetype)
 *
 *@param json_dic    : json的数据 字典类型
 *@param mapping_dic : 映射的的字典 (用于 json的 key 和 model 的属性 不对应相同 , 设为nil 则为model的属性和json的key对应相同) 如果mapping_dic 有值 则model的属性设为key而json的key设为value
 *@param leves       : model 继承的层数
 *
 *
 */
+ (instancetype)objectFromJsonDic: (NSDictionary *) json_dic mappingDic: (NSDictionary *) mapping_dic superClassLeves: (NSInteger) leves
{
    id model = [[[self class] alloc] init];
    
    @try
    {
        @autoreleasepool {
            
            
            NSDictionary *property_dic = [self propertyDictionaryAtSuperClassLeves:leves];
            
            
            for (NSString *property_name in [property_dic allKeys])
            {
                NSString *json_key = nil;
                
                if(nil != mapping_dic)
                {
                    json_key = [mapping_dic objectForKey:property_name];
                }
                
                if(nil == json_key || 0 == json_key.length)
                    json_key = property_name;
                
                id value = [json_dic objectForKey:json_key];
                
                if(nil == value || [NSNull null] == value)
                    continue;
                
                
                /*设置属性*/
                objc_property_t property       = class_getProperty(self.class, [property_name UTF8String]);
                
                
                AttributeType   attribute_type = [NSString getAttributeType:[NSString attributeNameByProperty:property]];
                
                
                /*NSValue , NSNumber , NSString, NSMutableString*/
                if (NSValueAttribute == attribute_type || NSNumberAttribute == attribute_type || NSStringAttribute == attribute_type || NSMutableStringAttribute == attribute_type)
                {
                    if([NSNull null] != value)
                    {
                        [model setValue:value forKey:property_name];
                    }
                    else
                    {
                        [model setValue:nil forKey:property_name];
                    }
                    
                    continue;
                    
                }
                
                
                /*NSDictionary , NSMutableDictionary*/
                if(NSDictionaryAttribute == attribute_type || NSMutableDictionaryAttribute == attribute_type)
                {
                    if ([value isKindOfClass:[NSDictionary class]])
                    {
                        [model setValue:value forKey:property_name];
                    }
                    
                    continue;
                }
                
                /*NSArray , NSMutableArray*/
                if (NSArrayAttribute == attribute_type || NSMutableArrayAttribute == attribute_type)
                {
                    if([value isKindOfClass:[NSArray class]])
                    {
                        [model setValue:value forKey:property_name];
                    }
                    continue;
                }
                
                /*char bool short int  long  float double longlong  uchar ushort uint ulong  ulonglong  */
                if (CcharAttribute == attribute_type || CshortAttribute == attribute_type || CintAttribute == attribute_type || ClongAttribute == attribute_type || CfloatAttribute == attribute_type || CdoubleAttribute == attribute_type || ClonglongAttribute == attribute_type || CboolAttribute == attribute_type || CulonglongAttribute == attribute_type || CucharAttribute == attribute_type || CushortAttribute == attribute_type || CuintAttribute == attribute_type)
                {
                    [model setValue:value forKey:property_name];
                    continue;
                }
                
                
                /*NSDate*/
                if (NSDateAttribute == attribute_type)
                {
                    /*先不做处理*/
                }
                
                /*other*/
                if (OtherAttribute == attribute_type)
                {
                    /*先不做处理*/
                }
            }
            
        }
    }
    @catch (NSException *exception)
    {
        NSLog(@"%@",exception);
    }
    @finally
    {
        
        return model;
    }
    
    
    return nil;
}


/*
 *return 返回 从json 数据转换对应的array 取出的model 的array
 *
 *@param array       : json数据返回的array 内部的dic
 *@param mapping_dic : 映射的的字典 (用于 json的 key 和 model 的属性 不对应相同 , 设为nil 则为model的属性和json的key对应相同) 如果mapping_dic 有值 则model的属性设为key而json的key设为value
 *
 */
+ (NSArray *)objectArrayFromJsonArray: (NSArray *)array  modelClass:(Class) class_ mappingDic: (NSDictionary *) mapping_dic
{
    if (nil == array || [[NSNull null] isEqual:array])
    {
        return [NSArray array];
    }
    
    
    
    //    if (array.count <= 0)
    //    {
    //        return nil;
    //    }
    
    NSMutableArray *model_array = [NSMutableArray array];
    
    for (id object in array)
    {
        /*NSString NSMutableString*/
        if ([class_ isSubclassOfClass:[NSString class]] || [class_ isSubclassOfClass:[NSMutableString class]])
        {
            if ([object isKindOfClass:[NSString class]])
            {
                [model_array addObject:object];
            }
            
            continue;
        }
        
        /*NSNumber*/
        if ([class_ isSubclassOfClass:[NSNumber class]])
        {
            NSNumberFormatter *number_formatter = [[NSNumberFormatter alloc] init];
            [number_formatter setNumberStyle:NSNumberFormatterDecimalStyle];
            [number_formatter numberFromString:object];
            [model_array addObject:number_formatter];
            
            continue;
        }
        
        /*NSDate 以后处理*/
        if ([class_ isSubclassOfClass:[NSDate class]])
        {
            
        }
        
        /*NSArray NSMutableArrat*/
        if ([class_ isSubclassOfClass:[NSArray class]] || [class_ isSubclassOfClass:[NSMutableArray class]])
        {
            
            if ([object isKindOfClass:[NSArray class ]])
            {
                [model_array addObject:object];
            }
            
            continue;
        }
        
        /*NSDictionary NSMutableDictionary*/
        if ([class_ isSubclassOfClass:[NSDictionary class]] || [class_ isSubclassOfClass:[NSMutableDictionary class]])
        {
            if ([object isKindOfClass:[NSDictionary class]])
            {
                [model_array addObject:object];
            }
            
            continue;
        }
        
        
        /*model class*/
        if ([class_ isSubclassOfClass:[NSObject class]])
        {
            if ([object isKindOfClass:[NSDictionary class]])
            {
                
                id model = [class_ objectFromJsonDic:object mappingDic:mapping_dic];
                
                [model_array addObject:model];
            }
            
        }
        
    }
    
    
    return model_array;
    
}

/*
 *return 返回 从json 数据转换对应的array 取出的model 的array
 *
 *@param array       : json数据返回的array 内部的dic
 *@param mapping_dic : 映射的的字典 (用于 json的 key 和 model 的属性 不对应相同 , 设为nil 则为model的属性和json的key对应相同) 如果mapping_dic 有值 则model的属性设为key而json的key设为value
 *
 */
+ (NSArray *)objectArrayFromJsonArray: (NSArray *)array  modelClass:(Class) class_ mappingDic: (NSDictionary *) mapping_dic superClassLeves: (NSInteger) leves
{
    if (nil == array || [[NSNull null] isEqual:array])
    {
        return [NSArray array];
    }
    
    
    NSMutableArray *model_array = [NSMutableArray array];
    
    for (id object in array)
    {
        /*NSString NSMutableString*/
        if ([class_ isSubclassOfClass:[NSString class]] || [class_ isSubclassOfClass:[NSMutableString class]])
        {
            if ([object isKindOfClass:[NSString class]])
            {
                [model_array addObject:object];
            }
            
            continue;
        }
        
        /*NSNumber*/
        if ([class_ isSubclassOfClass:[NSNumber class]])
        {
            NSNumberFormatter *number_formatter = [[NSNumberFormatter alloc] init];
            [number_formatter setNumberStyle:NSNumberFormatterDecimalStyle];
            [number_formatter numberFromString:object];
            [model_array addObject:number_formatter];
            
            continue;
        }
        
        /*NSDate 以后处理*/
        if ([class_ isSubclassOfClass:[NSDate class]])
        {
            
        }
        
        /*NSArray NSMutableArray*/
        if ([class_ isSubclassOfClass:[NSArray class]] || [class_ isSubclassOfClass:[NSMutableArray class]])
        {
            if ([object isKindOfClass:[NSArray class ]])
            {
                [model_array addObject:object];
            }
            
            continue;
        }
        
        /*NSDictionary NSMutableDictionary*/
        if ([class_ isSubclassOfClass:[NSDictionary class]] || [class_ isSubclassOfClass:[NSMutableDictionary class]])
        {
            if ([object isKindOfClass:[NSDictionary class]])
            {
                [model_array addObject:object];
            }
            
            continue;
        }
        
        
        /*model class*/
        if ([class_ isSubclassOfClass:[NSObject class]])
        {
            if ([object isKindOfClass:[NSDictionary class]])
            {
                id model = [class_ objectFromJsonDic:object mappingDic:mapping_dic superClassLeves:leves];
                
                [model_array addObject:model];
            }
            
        }
        
    }
    
    return model_array;
}


#pragma mark -
#pragma mark - model 转 json


/**
 * (此方法不可用于嵌套的model)
 *  @return 对象model 转行为 对应的字典
 */
- (NSDictionary *)jsonFromObject
{
    return [self jsonFromObject:0];
}
/**
 * (此方法不可用于嵌套的model)
 *  把model 转行为对应的字典
 *  @param leves model继承的层级
 *
 *  @return 对象model 转行为 对应的字典
 */
- (NSDictionary *)jsonFromObject:(NSInteger) leves
{
    return [self jsonFromObject:leves mappingDic:nil];
}

/**
 *
 *  把model 转行为对应的字典 (此方法不可用于嵌套的model)
 *  @param model       : 需要转行为字典的对象
 *  @param leves       : model继承的层级
 *  @param mapping_dic : 映射的字典 (用于 返回 的字典的 key 和 model 的属性名字 不相同是使用, 设置为nil 则model的属性名字和 字典的key的名字是一样的) 如果mapping_dic 有值  则model的属性名称设置key 而字典的key设置value
 *
 *  @return 对象model 转行为 对应的字典
 */
- (NSDictionary *)jsonFromObject: (NSInteger) leves mappingDic: (NSDictionary *) mapping_dic
{
    NSDictionary        *property_dic = [[self class] propertyDictionaryAtSuperClassLeves:leves];
    
    NSMutableDictionary *json_dic     = [[NSMutableDictionary alloc] init];
    
    for (NSString *property_name in [property_dic allKeys])
    {
        
        /*设置属性*/
        objc_property_t property       = class_getProperty(self.class, [property_name UTF8String]);
        
        
        AttributeType   attribute_type = [NSString getAttributeType:[NSString attributeNameByProperty:property]];
        
        NSString *json_key;
        
        if (nil != mapping_dic || ![[NSNull null] isEqual:mapping_dic])
        {
            json_key = [mapping_dic objectForKey:property_name];
        }
        
        if (nil == json_key || [[NSNull null] isEqual:json_key])
        {
            json_key = property_name;
        }
        
        /*值*/
        id value = [self valueForKey:property_name];
        
        if (nil == value || [[NSNull null] isEqual:value])
        {
            [json_dic setValue:[NSNull null] forKey:json_key];
            
            continue;
        }
        
        
        /*NSArray , NSMutableArray, NSDictionary , NSMutableDictionary, NSSet NSMutableSet*/
        if (NSArrayAttribute == attribute_type || NSMutableArrayAttribute == attribute_type || NSSetAttribute == attribute_type || NSMutableSetAttribute == attribute_type || NSDictionaryAttribute == attribute_type || NSMutableDictionaryAttribute == attribute_type)
        {
            id value = [self valueForKey:property_name];
            
            [json_dic setValue:value forKey:json_key];
            
            continue;
        }

        
        /*NSDate*/
        if (NSDateAttribute == attribute_type)
        {
            NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
            [date_formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *date_string = [date_formatter stringFromDate:value];
            
            [json_dic setValue:date_string forKey:json_key];
            
            continue;
            
        }
        
        
        if (OtherAttribute == attribute_type)
        {
            /*暂不处理*/
        }
   
        
    }
    
    return json_dic;
}


#pragma mark -
#pragma mark - 深度解析 model 为json

/**
 *  返回字典的属性 直到到了NSObjct为止
 *
 *  @return 返回典的属性
 */
+ (NSDictionary *)propertyDictionaryUntilNSOjbect
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    
    
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (unsigned i = 0; i < count; i++)
    {
        const char *property_name = property_getName(properties[i]);
        NSString   *key           = [NSString stringWithUTF8String:property_name];
        
        //  NSLog(@"%@",[NSString stringWithUTF8String:property_getAttributes(properties[i]) ]);
        key.property_index = [NSNumber numberWithInt:i];
        
        [dic setObject:key.property_index forKey:key];
        
        
    }
    
    free(properties);
    
    
    Class class_ = [self class];

    while(![NSStringFromClass([class_ superclass]) isEqualToString:@"NSObject"])
    {
        class_ = [class_ superclass];
        
        NSString *super_class_name = NSStringFromClass(class_);
        
        if (![super_class_name isEqualToString:NSStringFromClass([NSObject class])])
        {
            for (NSString *property in [[class_ propertyDictionary] allKeys])
            {
                [dic setObject:property forKey:property];
                
            }
        }
    }
    
    
    return dic;
}

/**
 *  对传入的value进行 类型选择后在做处理
 *
 *  @param value 传入对象
 *
 *  @return
 */
- (id)dealWithValue: (id)value
{

    @autoreleasepool
    {
        if (nil == value || [[NSNull null] isEqual:value])
        {
            return [NSNull null];
        }
    }
    
    /*NSArray , NSMutableArray*/
    if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSMutableArray class]])
    {
        
      return [self jsonFromArray:value];
        

    }
    
    /*NSDictionary ,NSMutableDictionary*/
    if ([value isKindOfClass:[NSDictionary class]] || [value isKindOfClass:[NSMutableDictionary class]])
    {
       return [self jsonFromDictionary:value];

    }
    
    /*NSSet, NSMutableSet*/
    if ([value isKindOfClass:[NSSet class]] || [value isKindOfClass:[NSMutableSet class]])
    {
        return [self jsonFromSet:value];

    }
    
    /*NSDate*/
    if ([value isKindOfClass:[NSDate class]])
    {
        NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
        [date_formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *date_string = [date_formatter stringFromDate:value];

        return date_string;
    }
    
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSMutableString class]])
    {
        return value;
    }
    
    return [(NSObject *)value jsonFromDepthObject];
    
}


/**
 *  返回 字典 model来自于字典
 *
 *  @param dic 包含model的字典
 *
 *  @return 字典
 */
- (NSDictionary *)jsonFromDictionary: (NSDictionary *) dic
{
    NSMutableDictionary *json_dic = [[NSMutableDictionary alloc] init];
    
    for (NSString *key in [dic allKeys])
    {
        id value = [dic objectForKey:key];
        
        [json_dic setValue:[self dealWithValue:value] forKey:key];
        
    }
    
    return json_dic;
}

/**
 *  返回 NSArray model来自于数组
 *
 *  @param dic 包含model的数组
 *
 *  @return NSArray
 */
- (NSArray *)jsonFromArray: (NSArray *) array
{
    NSMutableArray *json_array = [[NSMutableArray alloc] init];
    
    for (id object in array)
    {
        [json_array addObject:[self dealWithValue:object]];
    }
    
    return json_array;
}

- (NSArray *)jsonFromSet: (NSSet *)set
{
    __block NSMutableArray *json_array = [[NSMutableArray alloc] init];
    
    __weak typeof(&*self) weak_self = self;
    
    [set enumerateObjectsUsingBlock:^(id obj, BOOL *stop)
    {
        __strong typeof(&*weak_self) strong_self = weak_self;
        
        [json_array addObject:[strong_self dealWithValue:obj]];
    }];
    
    return json_array;
}

/**
 *  把model 转化为对应的字典(可作为深度解析 , 所有的model 必须是 继承于 NSOjbect 的)
 *
 *  @return 对象model 转行为 对应的字典
 */
- (NSDictionary *)jsonFromDepthObject
{
    NSDictionary        *property_dic = [[self class] propertyDictionaryUntilNSOjbect];
    
    NSMutableDictionary *json_dic     = [[NSMutableDictionary alloc] init];
    
    
    for (NSString *property_name in [property_dic allKeys])
    {
        
        /*设置属性*/
        objc_property_t property       = class_getProperty(self.class, [property_name UTF8String]);
        
        
        AttributeType   attribute_type = [NSString getAttributeType:[NSString attributeNameByProperty:property]];
        
        /*值*/
        id value = [self valueForKey:property_name];
        
        if (nil == value || [[NSNull null] isEqual:value])
        {
            [json_dic setValue:[NSNull null] forKey:property_name];
            
            continue;
        }
        
        if (NSNumberAttribute == attribute_type || NSStringAttribute == attribute_type || NSMutableStringAttribute == attribute_type ||CcharAttribute == attribute_type || CshortAttribute == attribute_type || CintAttribute == attribute_type || ClongAttribute == attribute_type || CfloatAttribute == attribute_type || CdoubleAttribute == attribute_type || ClonglongAttribute == attribute_type || CboolAttribute == attribute_type || CulonglongAttribute == attribute_type || CucharAttribute == attribute_type || CushortAttribute == attribute_type || CuintAttribute == attribute_type)
        {
            [json_dic setValue:value forKey:property_name];
            continue;
        }
        
        /*NSArray , NSMutableArray*/
        if (NSArrayAttribute == attribute_type || NSMutableArrayAttribute == attribute_type)
        {
            [json_dic setValue:[self jsonFromArray:value] forKey:property_name];
            
            continue;
        }
        
        /*NSDictionary , NSMutableDictionary*/
        if (NSDictionaryAttribute == attribute_type || NSMutableDictionaryAttribute == attribute_type)
        {
            [json_dic setValue:[self jsonFromDictionary:value] forKey:property_name];
            
            continue;
        }
        
        /*NSSet NSMutableSet */
        if ( NSSetAttribute == attribute_type || NSMutableSetAttribute == attribute_type)
        {
            [json_dic setValue:[self jsonFromArray:value] forKey:property_name];
            
            continue;
        }
        
        /*NSDate*/
        if (NSDateAttribute == attribute_type)
        {
            NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
            [date_formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *date_string = [date_formatter stringFromDate:value];
            
            [json_dic setValue:date_string forKey:property_name];
            
            continue;
            
        }
        
        
        /**
         *  其他的model
         */
        if (OtherAttribute == attribute_type)
        {
            [json_dic setValue:[(NSObject *)value jsonFromDepthObject] forKey:property_name];
        }
        
        
    }
    
    return json_dic;

}

@end





