//
//  ProductWebserviceClass.h
//  Product
//
//  Created by Ogechukwu Nwabuoku on 3/3/14.
//  Copyright (c) 2014 Ogechukwu Nwabuoku. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "ProductSingletonClass.h"
@interface ProductWebserviceClass : NSObject
{
    ProductSingletonClass *webServiceObject;
}
@property (nonatomic)NSData *myRequestData;
@property (nonatomic)NSOperationQueue *requestQueue;
- (void)getMockJsonData;

@end
