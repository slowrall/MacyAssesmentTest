//
//  ProductShowViewController.h
//  Product
//
//  Created by Ogechukwu Nwabuoku on 3/4/14.
//  Copyright (c) 2014 Ogechukwu Nwabuoku. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductCell.h"
#import <sqlite3.h>
#import "ProductSingletonClass.h"
@interface ProductShowViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    sqlite3 *productDB;
    ProductSingletonClass *psvObject;
}
@property (strong, nonatomic) IBOutlet UITableView *psvTableView;

@end
