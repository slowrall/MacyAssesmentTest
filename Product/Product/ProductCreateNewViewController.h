//
//  ProductCreateNewViewController.h
//  Product
//
//  Created by Ogechukwu Nwabuoku on 3/4/14.
//  Copyright (c) 2014 Ogechukwu Nwabuoku. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductSingletonClass.h"
#import "ProductViewController.h"

@interface ProductCreateNewViewController : UIViewController<UITextFieldDelegate>
{
    ProductSingletonClass *pcnObject;
}

@property (strong, nonatomic) IBOutlet UILabel *labelProductName;

@property (strong, nonatomic) IBOutlet UILabel *labelRegPrice;
@property (strong, nonatomic) IBOutlet UILabel *labelSalePrice;
@property (strong, nonatomic) IBOutlet UILabel *labelStores;

@property (strong, nonatomic) IBOutlet UITextView *txtViewDescription;

@property (strong, nonatomic) IBOutlet UIImageView *productImage;

- (IBAction)btnUpdate:(id)sender;

- (IBAction)btnDelete:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *txtfieldProductName;
@property (strong, nonatomic) IBOutlet UITextField *txtfieldRegPrice;
@property (strong, nonatomic) IBOutlet UITextField *txtfieldSalePrice;


@end
