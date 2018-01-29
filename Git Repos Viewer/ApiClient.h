//
//  ApiClient.h
//  Git Repos Viewer
//
//  Created by Василий Анисимов on 28/01/2018.
//  Copyright © 2018 anivaros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiResponse.h"


@protocol ApiRequest <NSObject>

@property (nonatomic, copy, readonly) NSURLRequest *urlRequest;

@end

typedef void (^CallServerMethodCompletionHandler)(ApiResponse *response, NSError *error);

@protocol ApiClient <NSObject>

- (void)callServerMethod:(id <ApiRequest>)request withCompletionHandler:(CallServerMethodCompletionHandler)completionHandler;

@end

@interface ApiClientImplementation : NSObject <ApiClient> {
	NSURLSession *_urlSession;
}

- (instancetype)initWithSession:(NSURLSession *)urlSession;

@end
