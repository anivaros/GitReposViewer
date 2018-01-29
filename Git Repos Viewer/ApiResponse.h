//
//  ApiResponse.h
//  Git Repos Viewer
//
//  Created by Василий Анисимов on 28/01/2018.
//  Copyright © 2018 anivaros. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ApiResponse : NSObject

@property (nonatomic) NSHTTPURLResponse *httpUrlResponse;
@property (nonatomic) NSData *data;

- (instancetype)initWithData:(NSData *)data httpUrlResponse:(NSHTTPURLResponse *)httpUrlResponse;

@end
