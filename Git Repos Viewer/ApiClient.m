//
//  ApiClient.m
//  Git Repos Viewer
//
//  Created by Василий Анисимов on 28/01/2018.
//  Copyright © 2018 anivaros. All rights reserved.
//

#import "ApiClient.h"


@implementation ApiClientImplementation

- (instancetype)init {
	self = [super init];
	if (self) {
		_urlSession = [NSURLSession sessionWithConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration
									delegate:nil
									delegateQueue:[[NSOperationQueue alloc] init]];
	}
	return self;
}

- (instancetype)initWithSession:(NSURLSession *)urlSession {
	self = [super init];
	if (self) {
		_urlSession = urlSession;
	}
	return self;
}

- (void)callServerMethod:(id <ApiRequest>)request withCompletionHandler:(CallServerMethodCompletionHandler)completionHandler {
	NSURLSessionDataTask *dataTask = [_urlSession dataTaskWithRequest:request.urlRequest
												  completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error) {
													  NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
													  NSRange successRange = NSMakeRange(200, 99);
													  if (NSLocationInRange(httpResponse.statusCode, successRange)) {
														  ApiResponse *response = [[ApiResponse alloc] initWithData:data httpUrlResponse:httpResponse];
														  if (response) {
															  completionHandler(response, nil);
														  }
														  else {
															  completionHandler(nil, [NSError errorWithDomain:@"ApiClientDomain"
																							  code:-1
																							  userInfo:@{NSLocalizedDescriptionKey: @"Network request error"}]);
														  }
													  }
													  else {
														  completionHandler(nil, [NSError errorWithDomain:@"ApiClientDomain"
																						  code:-1
																						  userInfo:@{NSLocalizedDescriptionKey: @"Network request error"}]);
													  }
												  }];
	[dataTask resume];
}

@end
