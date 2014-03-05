//
//  ProductSingletonClass.h
//  Product
//
//  Created by Ogechukwu Nwabuoku on 3/4/14.
//  Copyright (c) 2014 Ogechukwu Nwabuoku. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductSingletonClass : NSObject
+ (ProductSingletonClass *)singleObject;
@property (nonatomic)NSArray *jsonMockDataArray;
@property (nonatomic)NSArray *arrayFromDatabase;
@property int rowIndexCounter;
@property (nonatomic)NSMutableArray *objectToBeUpdated;
@end
