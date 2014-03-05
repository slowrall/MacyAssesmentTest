//
//  ProductSingletonClass.m
//  Product
//
//  Created by Ogechukwu Nwabuoku on 3/4/14.
//  Copyright (c) 2014 Ogechukwu Nwabuoku. All rights reserved.
//

#import "ProductSingletonClass.h"

@implementation ProductSingletonClass

+ (ProductSingletonClass *)singleObject
{
    static ProductSingletonClass *single = nil;
    @synchronized (self)
    {
        if (!single) {
            single = [[ProductSingletonClass alloc]init];
        }
    }
    return single;
}


@end
