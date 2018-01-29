//
//  RepositoriesGithubApiRequest.m
//  Git Repos Viewer
//
//  Created by Василий Анисимов on 28/01/2018.
//  Copyright © 2018 anivaros. All rights reserved.
//

#import "RepositoriesGithubApiRequest.h"


@implementation RepositoriesGithubApiRequest

- (instancetype)initWithUsername:(NSString *)username {
	self = [super init];
	if (self) {
		_username = username;
	}
	
	return self;
}

- (NSURLRequest *)urlRequest {
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.github.com/users/%@/repos", _username]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	request.HTTPMethod = @"GET";
	return request;
}

@end
