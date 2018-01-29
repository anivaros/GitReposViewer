//
//  RepositoriesBitbucketApiRequest.m
//  Git Repos Viewer
//
//  Created by Василий Анисимов on 30/01/2018.
//  Copyright © 2018 anivaros. All rights reserved.
//

#import "RepositoriesBitbucketApiRequest.h"


@implementation RepositoriesBitbucketApiRequest

- (instancetype)initWithUsername:(NSString *)username {
	self = [super init];
	if (self) {
		_username = username;
	}
	
	return self;
}

- (instancetype)initWithUrl:(NSString *)url {
	self = [super init];
	if (self) {
		_url = url;
	}
	
	return self;
}

- (NSURLRequest *)urlRequest {
	NSURL *url = [NSURL URLWithString:_url ?: [NSString stringWithFormat:@"https://api.bitbucket.org/2.0/repositories/%@", _username]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	request.HTTPMethod = @"GET";
	return request;
}

@end
