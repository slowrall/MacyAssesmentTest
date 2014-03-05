//
//  ProductViewController.h
//  Product
//
//  Created by Ogechukwu Nwabuoku on 3/3/14.
//  Copyright (c) 2014 Ogechukwu Nwabuoku. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductWebserviceClass.h"
#import <sqlite3.h>
#import "ProductSingletonClass.h"
@interface ProductViewController : UIViewController
{
    sqlite3 *productDB;
    ProductSingletonClass *pvcObject;
}

@property(strong, nonatomic)NSString *databasePath;

- (IBAction)btnShowProduct:(id)sender;
- (IBAction)btnCreateProduct:(id)sender;

- (void)loadDatabase;
- (void)updateTable:(NSString *)guid_fieldString;
- (void)deleteTable:(NSString *)guid_fieldString;


@end
