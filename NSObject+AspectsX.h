//
//  NSObject+AspectsX.h
//  WachatOpenURLHacker
//
//  Created by Joey on 16/8/14.
//
//

#import <Foundation/Foundation.h>
#import "Aspects.h"

typedef BOOL(^AspectsXFilterBlock)(NSString *selectorString) ;

@interface NSObject (AspectsX)

/**
 *  Hook class method
 *  Hook 类方法
 *
 *  @param selector class method
 *  @param options
 *  @param block
 *  @param error
 *
 *  @return
 */
+ (id<AspectToken>)aspect_hookClassSelector:(SEL)selector
                                withOptions:(AspectOptions)options
                                 usingBlock:(id)block
                                      error:(NSError **)error;


/**
 *  Hook specific instance method with filter block
 *
 *  @param filter  hook the method if filter block return YES
 *  @param options
 *  @param block
 *  @param errors
 *
 *  @return return value description
 */
- (NSArray<id<AspectToken>> *)aspect_hookMethodsWithFilter:(AspectsXFilterBlock)filter
                                                   options:(AspectOptions)options
                                                usingBlock:(id)block
                                                     error:(NSArray **)errors;
/**
 *  Hook instance method with filter block
 *
 *  @param filter  hook the method if filter block return YES
 *  @param options
 *  @param block
 *  @param errors
 *
 *  @return return value description
 */
+ (NSArray<id<AspectToken>> *)aspect_hookMethodsWithFilter:(AspectsXFilterBlock)filter
                                                   options:(AspectOptions)options
                                                usingBlock:(id)block
                                                     error:(NSArray **)errors;

/**
 *  Hook class method with filter block
 *
 *  @param filter  hook the method if filter block return YES
 *  @param options
 *  @param block
 *  @param errors
 *
 *  @return return value description
 */
+ (NSArray<id<AspectToken>> *)aspect_hookClassMethodsWithFilter:(AspectsXFilterBlock)filter
                                                        options:(AspectOptions)options
                                                     usingBlock:(id)block
                                                          error:(NSArray **)errors;

@end
