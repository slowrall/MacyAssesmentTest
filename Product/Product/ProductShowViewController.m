//
//  ProductShowViewController.m
//  Product
//
//  Created by Ogechukwu Nwabuoku on 3/4/14.
//  Copyright (c) 2014 Ogechukwu Nwabuoku. All rights reserved.
//

#import "ProductShowViewController.h"

@interface ProductShowViewController ()
@property (nonatomic) NSMutableArray *arrayFromDatabase;
@property (nonatomic)NSString *nameOfProductString;
@property(strong, nonatomic)NSString *databasePath;
@end

@implementation ProductShowViewController
@synthesize arrayFromDatabase, nameOfProductString;
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
    
    psvObject = [ProductSingletonClass singleObject];
    
   	// Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated
{
    [self.psvTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}
#pragma mark - TableView Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *totalNumberOfProducts = [psvObject.arrayFromDatabase objectAtIndex:0];
    return [totalNumberOfProducts count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSMutableArray *arrayOfObjectAtIndex = [psvObject.arrayFromDatabase objectAtIndex:0];
    cell.labelProductName.text = [arrayOfObjectAtIndex objectAtIndex:indexPath.row];
    
     [cell addSubview:[self drawSeparationView:(indexPath.row)]];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    psvObject.rowIndexCounter = indexPath.row;
    [self performSegueWithIdentifier:@"productPageSegue" sender:self];
    
}



- (UIView*)drawSeparationView:(NSInteger)itemNo {
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, self.psvTableView.frame.size.width, 78);
    
       UIView *upperStrip = [[UIView alloc]init];
        upperStrip.backgroundColor = [UIColor colorWithWhite:0.338 alpha:1.000];
        upperStrip.frame = CGRectMake(0, 0, view.frame.size.width, 0.5);
        [view addSubview:upperStrip];
    
    UIView *lowerStrip = [[UIView alloc]init];
    lowerStrip.backgroundColor = [UIColor colorWithWhite:0.338 alpha:1.000];
    lowerStrip.frame = CGRectMake(0, 78-1, view.frame.size.width, 0.5);
    
    [view addSubview:lowerStrip];
    return view;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
