//
//  ProductViewController.m
//  Product
//
//  Created by Ogechukwu Nwabuoku on 3/3/14.
//  Copyright (c) 2014 Ogechukwu Nwabuoku. All rights reserved.
//

#import "ProductViewController.h"

@interface ProductViewController ()
@property (nonatomic)NSMutableArray *jsonDataArray;
@end

@implementation ProductViewController
@synthesize databasePath;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    pvcObject = [ProductSingletonClass singleObject];
    self.jsonDataArray = [[NSMutableArray alloc]init];
    ProductWebserviceClass *classObject = [[ProductWebserviceClass alloc]init];
    [classObject getMockJsonData];
    [self loadDatabase];
   // [self updateTable:@"2ab32110-442a-4219-8430-cb84f101ce1a"];
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)loadDatabase
{
    NSString *docsDirectory;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDirectory = [dirPaths objectAtIndex:0];
    self.databasePath = [[NSString alloc]initWithString:[docsDirectory stringByAppendingPathComponent:@"products4.db"]];
    
    //if i am able to create connection
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:self.databasePath] == NO)
    {
        const char *dbPath = [self.databasePath UTF8String];
        if (sqlite3_open(dbPath, &productDB)== SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS PRODUCTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, FIELD TEXT,  NAME TEXT, DESCRIPTION TEXT, REGULAR_PRICE TEXT, SALE_PRICE TEXT, PRODUCT_PHOTO TEXT, COLORS ARRAY, STORES TEXT)";
            if (sqlite3_exec(productDB, sql_stmt, NULL, NULL, &errMsg)!= SQLITE_OK)
            {
              NSLog(@"Failed to create table");
                
            }else{
                NSLog (@"TABLE CREATED SUCCESSFULLY");
            }
            sqlite3_close(productDB); //close connection
        }else{
           NSLog(@"Failed to open/create database");
        }
    }

}


- (void)populateJsonModel:(int)randomIndexedNumberinArray
{

    NSMutableArray *tempNameArray = [pvcObject.jsonMockDataArray objectAtIndex:0];
    NSMutableArray *tempFieldArray = [pvcObject.jsonMockDataArray objectAtIndex:1];
    NSMutableArray *tempDescArray = [pvcObject.jsonMockDataArray objectAtIndex:2];
    NSMutableArray *tempRegPriceArray = [pvcObject.jsonMockDataArray objectAtIndex:3];
    NSMutableArray *tempSalePriceArray = [pvcObject.jsonMockDataArray objectAtIndex:4];
    NSMutableArray *tempProductPhoto = [pvcObject.jsonMockDataArray objectAtIndex:5];
    NSMutableArray *tempColorArray = [pvcObject.jsonMockDataArray objectAtIndex:6];
    NSMutableArray *tempStores = [pvcObject.jsonMockDataArray objectAtIndex:7];
    
    sqlite3_stmt *statement;
    const char *dbPath = [self.databasePath UTF8String];
    
    if (sqlite3_open(dbPath, &productDB)== SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO PRODUCTS (field,  name, description, regular_price, sale_price, product_photo, colors, stores) VALUES(\"%@\", \"%@\",  \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")",[NSString stringWithFormat:@"%@",[tempFieldArray objectAtIndex:randomIndexedNumberinArray]], [NSString stringWithFormat:@"%@",[tempNameArray objectAtIndex:randomIndexedNumberinArray]], [NSString stringWithFormat:@"%@",[tempDescArray objectAtIndex:randomIndexedNumberinArray]], [NSString stringWithFormat:@"%@",[tempRegPriceArray objectAtIndex:randomIndexedNumberinArray]], [NSString stringWithFormat:@"%@",[tempSalePriceArray objectAtIndex:randomIndexedNumberinArray]], [NSString stringWithFormat:@"%@",[tempProductPhoto objectAtIndex:randomIndexedNumberinArray]], [NSString stringWithFormat:@"%@",[tempColorArray objectAtIndex:randomIndexedNumberinArray]], [NSString stringWithFormat:@"%@",[tempStores objectAtIndex:randomIndexedNumberinArray]]];
        
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(productDB, insert_stmt, -1, &statement, NULL);
        if(sqlite3_step(statement)==SQLITE_DONE)
        {
            NSLog(@"Product Added");
           
        }else{
            
            NSLog(@"Failed to add PRODUCT");
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(productDB);
        
    }
    

}



//Get data in database
- (void)getDatabase
{
     // your background stuff here
    NSMutableArray *tempArrayforNames = [[NSMutableArray alloc]init];
    NSMutableArray *tempArrayforAbout = [[NSMutableArray alloc]init];
    NSMutableArray *tempArrayforRegPrice = [[NSMutableArray alloc]init];
    NSMutableArray *tempArrayforSalePrice = [[NSMutableArray alloc]init];
    NSMutableArray *tempArrayforProductPhoto = [[NSMutableArray alloc]init];
    NSMutableArray *tempStoreLocationArray = [[NSMutableArray alloc]init];
    NSMutableArray *field_guid = [[NSMutableArray alloc]init];
    
    pvcObject.arrayFromDatabase = [[NSArray alloc]init];
    sqlite3_stmt *statement;
    const char *dbPath = [self.databasePath UTF8String];
    if (sqlite3_open(dbPath, &productDB)== SQLITE_OK)
    {
        
        NSString *querySQl = @"SELECT name, description, regular_price, sale_price, product_photo, stores, field FROM products";
        const char *insert_stmt = [querySQl UTF8String];
        if (sqlite3_prepare_v2(productDB, insert_stmt, -1, &statement, NULL) ==SQLITE_OK )
        {
            while (sqlite3_step(statement)== SQLITE_ROW)
            {
            
                NSString *productName = [[NSString alloc]initWithUTF8String:(const char*)
                                         sqlite3_column_text(statement, 0)];
                NSString *description = [[NSString alloc]initWithUTF8String:(const char*)
                                         sqlite3_column_text(statement, 1)];
                NSString *regPrice = [[NSString alloc]initWithUTF8String:(const char*)
                                         sqlite3_column_text(statement, 2)];
                NSString *salePrice = [[NSString alloc]initWithUTF8String:(const char*)
                                      sqlite3_column_text(statement, 3)];
                NSString *productPhoto = [[NSString alloc]initWithUTF8String:(const char*)
                                       sqlite3_column_text(statement, 4)];
                NSString *stores = [[NSString alloc]initWithUTF8String:(const char*)
                                          sqlite3_column_text(statement, 5)];
                NSString *guid_field = [[NSString alloc]initWithUTF8String:(const char*)
                                    sqlite3_column_text(statement, 6)];
                
                [tempArrayforNames addObject:productName];
                [tempArrayforAbout addObject:description];
                [tempArrayforRegPrice addObject:regPrice];
                [tempArrayforSalePrice addObject:salePrice];
                [tempArrayforProductPhoto addObject:productPhoto];
                [tempStoreLocationArray addObject:stores];
                [field_guid addObject:guid_field];
                
        
            }
    
            pvcObject.arrayFromDatabase = @[tempArrayforNames,tempArrayforAbout,tempArrayforRegPrice, tempArrayforSalePrice,tempArrayforProductPhoto,tempStoreLocationArray, field_guid];
            sqlite3_finalize(statement);
            
        }
        sqlite3_close(productDB);
    }
    
}

//Update database with 3 specified fields
- (void)updateTable:(NSString *)guid_fieldString
{
    pvcObject = [ProductSingletonClass singleObject];
    sqlite3_stmt *updateStmt;
    const char *dbPath = [self.databasePath UTF8String];
    if (sqlite3_open(dbPath, &productDB)== SQLITE_OK)
   
    {
        NSString *querySql=[NSString stringWithFormat:@"Update products set name = \"%@\", regular_price = \"$%@\", sale_price = \"$%@\" where field=\"%@\"",[pvcObject.objectToBeUpdated objectAtIndex:0], [pvcObject.objectToBeUpdated objectAtIndex:1], [pvcObject.objectToBeUpdated objectAtIndex:2], guid_fieldString];
        
        const char*sql=[querySql UTF8String];
        if(sqlite3_prepare_v2(productDB,sql, -1, &updateStmt, NULL) == SQLITE_OK)
        {
            if(SQLITE_DONE != sqlite3_step(updateStmt))
            {
                NSAssert1(0, @"Error while updating. '%s'", sqlite3_errmsg(productDB));
            }
            else{
                sqlite3_reset(updateStmt);
                NSLog(@"Update done successfully!");
            }
        }
        
        
        
        sqlite3_finalize(updateStmt);
    }
    sqlite3_close(productDB);

}

//DELETE data from database
- (void)deleteTable:(NSString *)guid_fieldString {

    sqlite3_stmt *deleteStmt;
    const char *dbPath = [self.databasePath UTF8String];
    if (sqlite3_open(dbPath, &productDB)== SQLITE_OK)
        
    {
        NSString *querySql= [NSString stringWithFormat:@"delete from products where field=\"%@\"",guid_fieldString];
        
        const char*sql=[querySql UTF8String];
        if(sqlite3_prepare_v2(productDB,sql, -1, &deleteStmt, NULL) == SQLITE_OK)
        {
            if(SQLITE_DONE != sqlite3_step(deleteStmt))
            {
                NSAssert1(0, @"Error while Deleting. '%s'", sqlite3_errmsg(productDB));
            }
            else{
                sqlite3_reset(deleteStmt);
                NSLog(@"Delete done successfully!");
            }
        }
        
        
        
        sqlite3_finalize(deleteStmt);
    }
    sqlite3_close(productDB);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnShowProduct:(id)sender {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // your background stuff here
        [self getDatabase];
        dispatch_async(dispatch_get_main_queue(), ^{
            // perform UI updates on main thread
            [self performSegueWithIdentifier:@"showProductSegue" sender:self];
        });
    });
    
}

- (IBAction)btnCreateProduct:(id)sender {
    int num = arc4random_uniform(4);
    NSLog(@"Random is %i", num);
    [self populateJsonModel:num];
}
@end
