//
//  LoginClient.m
//  iOSTest
//
//  Created by D & A Technologies on 9/23/16.
//  Copyright © 2018 D & A Technologies. All rights reserved.
//

#import "LoginClient.h"

@interface LoginClient ()
@property (nonatomic, strong) NSURLSession *session;
@end

@implementation LoginClient

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request here to login.
 *
 * 2) Using the following endpoint, make a request to login
 *    URL: http://dev.datechnologies.co/Tests/scripts/login.php
 *
 * 3) Don't forget, the endpoint takes two parameters 'username' and 'password'
 *
 * 4) A valid email is 'info@datechnologies.co'
 *    A valid password is 'Test123'
 **/



- (void)loginWithUsername:(NSString *)username password:(NSString *)password completion:(void (^)(NSDictionary *response, NSError *error))completion
{
    NSString* serverURL =@"http://dev.datechnologies.co/Tests/scripts/login.php";
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSURL* completeURL = [NSURL URLWithString:serverURL];
    
    NSDictionary* userDetails = @{@"username":username, @"password":password};
    NSError* error = nil;
    NSData* jsonInfo = [NSJSONSerialization dataWithJSONObject:userDetails options:kNilOptions error:&error];
    
    if(!jsonInfo){
        NSLog(@"Problem with json %@", error.localizedDescription);
    }
    
    NSMutableURLRequest* request =[[NSMutableURLRequest alloc]initWithURL:completeURL];
    request.HTTPMethod = @"POST";
    [request setHTTPBody:jsonInfo];
    
    NSDate *startOfTheRequest = [NSDate date];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:completeURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDate *endOfTheRequest = [NSDate date];
        NSTimeInterval requestDuration = endOfTheRequest.timeIntervalSince1970 - startOfTheRequest.timeIntervalSince1970;
        
        NSError *parsingError;
        NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parsingError];
        if (responseJSON) {
            if ([responseJSON[@"code"] isEqualToString:@"Error"]) {
                NSError *responseError = [NSError errorWithDomain:responseJSON[@"message"] code:400 userInfo:nil];
                if (completion) {
                    completion(nil, responseError);
                    return;
                }
            } else {
                if (completion) {
                    completion(@{@"requestDuration" : @(requestDuration)}, nil);
                }
            }
                
        }
        
        NSLog(@"Response = %@", response);
        if (completion) {
            completion(responseJSON, error);
        }
    }];
    
    [dataTask resume];
}

@end
