//
//  ApiResponse.m
//  Git Repos Viewer
//
//  Created by Василий Анисимов on 28/01/2018.
//  Copyright © 2018 anivaros. All rights reserved.
//

#import "ApiResponse.h"


@implementation ApiResponse

- (instancetype)initWithData:(NSData *)data httpUrlResponse:(NSHTTPURLResponse *)httpUrlResponse {
	self = [super init];
	if (self) {
		_httpUrlResponse = httpUrlResponse;
		_data = data;
	}
	
	return self;
}

@end
