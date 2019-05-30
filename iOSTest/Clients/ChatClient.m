//
//  ChatClient.m
//  iOSTest
//
//  Created by D & A Technologies on 9/23/16.
//  Copyright © 2018 D & A Technologies. All rights reserved.
//

#import "ChatClient.h"

@interface ChatClient ()
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, weak) NSDictionary* messageData;
@end

@implementation ChatClient

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request to fetch chat data used in this app.
 *
 * 2) Using the following endpoint, make a request to fetch data
 *    URL: http://dev.datechnologies.co/Tests/scripts/chat_log.php
 **/

- (void)fetchChatData:(void (^)(NSArray<Message *> *))completion withError:(void (^)(NSString *error))errorBlock
{
}

-(void) getChatData: (void (^)(NSDictionary *))completion {
    NSString* url = [NSString stringWithFormat:@"%@",@"http://dev.datechnologies.co/Tests/scripts/chat_log.php"];
    NSURL* completeURL = [NSURL URLWithString:url];
    NSURLSessionDataTask        *task = [[NSURLSession sharedSession] dataTaskWithURL: completeURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        NSDictionary* unSerializedInfo = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        
        self.messageData = unSerializedInfo;
        
        NSLog(@"%@", unSerializedInfo);
        completion(self.messageData);
    }];
    
    [task resume];
    
}

@end
