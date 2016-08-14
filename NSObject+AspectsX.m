//
//  NSObject+AspectsX.m
//  WachatOpenURLHacker
//
//  Created by Joey on 16/8/14.
//
//

#import "NSObject+AspectsX.h"
#import <objc/runtime.h>

@implementation NSObject (AspectsX)

+ (id<AspectToken>)aspect_hookClassSelector:(SEL)selector
                                withOptions:(AspectOptions)options
                                 usingBlock:(id)block
                                      error:(NSError **)error {
    Class metaClass = objc_getMetaClass(object_getClassName(self));
    return [metaClass aspect_hookSelector:selector withOptions:options usingBlock:block error:error];
}

- (NSArray<id<AspectToken>> *)aspect_hookMethodsWithFilter:(AspectsXFilterBlock)filter
                                                   options:(AspectOptions)options
                                                usingBlock:(id)block
                                                     error:(NSArray **)errors {
    return [NSObject aspect_hookInstance:self methodsFilter:filter options:options usingBlock:block error:errors];
}

+ (NSArray<id<AspectToken>> *)aspect_hookMethodsWithFilter:(AspectsXFilterBlock)filter
                                                   options:(AspectOptions)options
                                                usingBlock:(id)block
                                                     error:(NSArray **)errors {
    return [NSObject aspect_hookInstance:self methodsFilter:filter options:options usingBlock:block error:errors];
}

+ (NSArray<id<AspectToken>> *)aspect_hookClassMethodsWithFilter:(AspectsXFilterBlock)filter
                                                        options:(AspectOptions)options
                                                     usingBlock:(id)block
                                                          error:(NSArray **)errors {
    Class metaClass = objc_getMetaClass(object_getClassName(self));
    return [metaClass aspect_hookMethodsWithFilter:filter options:options usingBlock:block error:errors];
}

//private method
+ (NSArray<id<AspectToken>> *)aspect_hookInstance:(id)instance
                                    methodsFilter:(AspectsXFilterBlock)filter
                                          options:(AspectOptions)options
                                       usingBlock:(id)block
                                            error:(NSArray **)errors {
    NSMutableArray *tokens = [NSMutableArray array];
    NSMutableArray *errorsInner = errors ? [NSMutableArray array] : nil;
    
    unsigned int methodCount = 0;
    Method * mlist = class_copyMethodList([instance class], &methodCount);
    
    for (NSInteger index = 0; index < methodCount; index++) {
        NSString *selectorName = @(sel_getName(method_getName(mlist[index])));
        
        BOOL shouldHook = filter != nil && filter(selectorName);
        if (shouldHook) {
            NSError *error;
            id<AspectToken> token = [instance aspect_hookSelector:NSSelectorFromString(selectorName) withOptions:options usingBlock:block error:&error];
            [tokens addObject:token];
            if (error && errors) {
                [errorsInner addObject:error];
            }
        }
    }
    
    if (errors) {
        *errors = [errorsInner copy];
    }
    
    return [tokens copy];
}

@end
