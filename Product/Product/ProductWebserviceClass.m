//
//  ProductWebserviceClass.m
//  Product
//
//  Created by Ogechukwu Nwabuoku on 3/3/14.
//  Copyright (c) 2014 Ogechukwu Nwabuoku. All rights reserved.
//

#import "ProductWebserviceClass.h"

@implementation ProductWebserviceClass

@synthesize myRequestData;


- (void)getMockJsonData
{
    
     NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSString *url = @"http://json-generator.appspot.com/j/bVfLaCDuPS?indent=4";
    [self createRequestWithType:@"POST"
                        withUrl:url
                     withParams:dictionary];
}



-(void) createRequestWithType:(NSString *)requestType withUrl:(NSString *)url withParams:(NSDictionary *)params
{
    
    NSLog(@"OGE API - entering createRequestWithType");
    NSLog(@"OGE URL - %@", url);
    // Set up the request objects
    self.requestQueue = [[NSOperationQueue alloc] init];
    NSURL *requestUrl = [NSURL URLWithString:url];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL: requestUrl];
  
    // set the request method
    if ([requestType isEqualToString:@"POST"]) {
        [ theRequest setHTTPMethod: @"POST" ];
    }
    if ([requestType isEqualToString:@"GET"]) {
        [ theRequest setHTTPMethod: @"GET" ];
    }
    
    // set parameters if they have been passed
    NSError *error = nil;
    
//    if (params != nil)
//    {
    
        myRequestData = [NSJSONSerialization dataWithJSONObject:params options:0 error:&error];
        
        NSLog(@"OGE data contents: %@", [[NSString alloc] initWithData:myRequestData encoding:NSUTF8StringEncoding]);
        NSLog(@"OGE params are %@", params);
        NSLog(@"OGE The convert_from dict error is %@", error);
        [theRequest setHTTPBody: myRequestData];
        
        NSLog(@"OGE API - data contents: %@", [[NSString alloc] initWithData:myRequestData encoding:NSUTF8StringEncoding]);
        NSLog(@"OGE API - params are %@", params);
        NSLog(@"OGE API - The convert_from dict error is %@", error);
        [theRequest setHTTPBody: myRequestData];
   // }
    
    // set http header
    //[ theRequest setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    [NSURLConnection sendAsynchronousRequest:theRequest
                                       queue:self.requestQueue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         
         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
         myRequestData = data;
         NSLog(@"OGE Response status code %ld",(long)httpResponse.statusCode);
         
         //Get the Return Dictionary response from Webservice Call
         NSDictionary *returnDict;
         NSError *returnError;
         
         // convert the json to dictionary and return it
         if (error != nil) {
             returnDict = nil;
             returnError = error;
         }
         else {
             NSError *jsonError = nil;
             returnDict = [NSJSONSerialization JSONObjectWithData: data                                                         options: kNilOptions error: &jsonError];
             if (!returnDict) {
                 NSLog(@"OGE API - The convert_to JSON error is %@", jsonError);
                 returnDict = nil;
                 returnError = jsonError;
             }
             else {
                
                 NSLog(@"OGE API - data returned: %@", returnDict);
                 [self sortJsonDataDictionary:returnDict];
                 returnError = nil;
                 
             }
         }
         
         //NSLog(@"OGE Return Dict: \n%@", returnDict);
         
     }];
    
}


- (void)sortJsonDataDictionary:(NSDictionary *)retrunDictionary
{

    webServiceObject =[ProductSingletonClass singleObject];
    webServiceObject.jsonMockDataArray = [[NSArray alloc]init];
    NSString *name = [[NSString alloc]init];
    NSString *fields = [[NSString alloc]init];
    NSString *about = [[NSString alloc]init];
    NSString *regPrice = [[NSString alloc]init];
    NSString *salePrice = [[NSString alloc]init];
    NSString *productPhoto = [[NSString alloc]init];
    
    NSString *storeLocation = [[NSString alloc]init];
    NSString *storeName = [[NSString alloc]init];

    NSMutableArray *colorArray = [[NSMutableArray alloc]init];
    NSMutableArray *storeArray = [[NSMutableArray alloc]init];
    
    NSMutableArray *tempArrayforNames = [[NSMutableArray alloc]init];
    NSMutableArray *tempArrayforFields = [[NSMutableArray alloc]init];
    NSMutableArray *tempArrayforAbout = [[NSMutableArray alloc]init];
    NSMutableArray *tempArrayforRegPrice = [[NSMutableArray alloc]init];
    NSMutableArray *tempArrayforSalePrice = [[NSMutableArray alloc]init];
    NSMutableArray *tempArrayforProductPhoto = [[NSMutableArray alloc]init];
    NSMutableArray *tempColorArray = [[NSMutableArray alloc]init];
    NSMutableArray *tempStoreLocationArray = [[NSMutableArray alloc]init];
   
    
    for (NSDictionary *jsonDict in retrunDictionary){
    
        name = [jsonDict objectForKey:@"name"];
        fields = [jsonDict objectForKey:@"Fields"];
        about = [jsonDict objectForKey:@"about"];
        regPrice = [jsonDict objectForKey:@"regular_Price"];
        salePrice = [jsonDict objectForKey:@"sale_price"];
        productPhoto = [jsonDict objectForKey:@"Product_Photo"];
        colorArray = [jsonDict objectForKey:@"colors"];
        storeArray = [jsonDict objectForKey:@"Stores"];
//Traverse store dictionary for each store location
        for (NSDictionary *storeDict in storeArray) {
            storeLocation = [storeDict objectForKey:@"Store_Location"];
            storeName = [storeDict objectForKey:@"Store_name"];
            [tempStoreLocationArray addObject:storeLocation];
            
        }
        
        [tempArrayforNames addObject:name];
        [tempArrayforFields addObject:fields];
        [tempArrayforAbout addObject:about];
        [tempArrayforRegPrice addObject:regPrice];
        [tempArrayforSalePrice addObject:salePrice];
        [tempArrayforProductPhoto addObject:productPhoto];
        [tempColorArray addObject:colorArray];
    }
    
    webServiceObject.jsonMockDataArray = @[tempArrayforNames,tempArrayforFields,tempArrayforAbout,tempArrayforRegPrice,tempArrayforSalePrice,tempArrayforProductPhoto, tempColorArray, tempStoreLocationArray];
   // NSLog(@"The array for objects in first index are %@",[webServiceObject.jsonMockDataArray objectAtIndex:0]);
}

@end
