//
//  ProductCreateNewViewController.m
//  Product
//
//  Created by Ogechukwu Nwabuoku on 3/4/14.
//  Copyright (c) 2014 Ogechukwu Nwabuoku. All rights reserved.
//

#import "ProductCreateNewViewController.h"

@interface ProductCreateNewViewController ()
@property (nonatomic)ProductViewController *instanceObject;
@end

@implementation ProductCreateNewViewController
@synthesize instanceObject;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    pcnObject = [ProductSingletonClass singleObject];
    [self loadProductDetails];
    
	// Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated
{
    self.txtfieldProductName.text = @"";
    self.txtfieldRegPrice.text = @"";
    self.txtfieldSalePrice.text = @"";
}

- (void)loadProductDetails{

    NSMutableArray *tempArrayforNames = [pcnObject.arrayFromDatabase objectAtIndex:0];
    NSMutableArray *tempArrayforAbout = [pcnObject.arrayFromDatabase objectAtIndex:1];
    NSMutableArray *tempArrayforRegPrice = [pcnObject.arrayFromDatabase objectAtIndex:2];
    NSMutableArray *tempArrayforSale = [pcnObject.arrayFromDatabase objectAtIndex:3];
    NSMutableArray *tempArrayProdPhoto = [pcnObject.arrayFromDatabase objectAtIndex:4];
    NSMutableArray *tempArrayforStores = [pcnObject.arrayFromDatabase objectAtIndex:5];
   
    
    self.labelProductName.text = [tempArrayforNames objectAtIndex:pcnObject.rowIndexCounter];
   self.labelRegPrice.text = [tempArrayforRegPrice objectAtIndex:pcnObject.rowIndexCounter];
    self.txtViewDescription.text = [tempArrayforAbout objectAtIndex:pcnObject.rowIndexCounter];
    self.productImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[tempArrayProdPhoto objectAtIndex:pcnObject.rowIndexCounter]]];
     self.labelSalePrice.text = [tempArrayforSale objectAtIndex:pcnObject.rowIndexCounter];
    self.labelStores.text = [tempArrayforStores objectAtIndex:pcnObject.rowIndexCounter];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnUpdate:(id)sender{
    instanceObject = [[ProductViewController alloc]init];
     NSMutableArray *field_guidArray = [pcnObject.arrayFromDatabase objectAtIndex:6];
    pcnObject.objectToBeUpdated = [[NSMutableArray alloc]init];
    [pcnObject.objectToBeUpdated addObject:self.txtfieldProductName.text];
    [pcnObject.objectToBeUpdated addObject:self.txtfieldRegPrice.text];
    [pcnObject.objectToBeUpdated addObject:self.txtfieldSalePrice.text];
    [instanceObject loadDatabase];
    [instanceObject updateTable:[field_guidArray objectAtIndex:pcnObject.rowIndexCounter]];
    [self closeView];

}

- (IBAction)btnDelete:(id)sender {
    
    instanceObject = [[ProductViewController alloc]init];
    NSMutableArray *field_guidArray = [pcnObject.arrayFromDatabase objectAtIndex:6];
    [instanceObject loadDatabase];
    [instanceObject deleteTable:[field_guidArray objectAtIndex:pcnObject.rowIndexCounter]];
    [self closeView];
    
}

- (void)closeView
{
    
    NSArray *controllersArray = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[controllersArray objectAtIndex:controllersArray.count - 3] animated:YES];
}

@end
