//
//  RepositoriesList.m
//  Git Repos Viewer
//
//  Created by Василий Анисимов on 28/01/2018.
//  Copyright © 2018 anivaros. All rights reserved.
//

#import "RepositoriesList.h"
#import "GitHostingGateway.h"
#import "Repository.h"
#import "User.h"


@implementation DisplayRepositoriesUseCaseImplementation

- (instancetype)initWithGithubReposGateway:(id <GitHostingGateway>)githubReposGateway bitbucketReposGateway:(id <GitHostingGateway>)bitbucketReposGateway {
	self = [super init];
	if (self) {
		_githubReposGateway = githubReposGateway;
		_bitbucketReposGateway = bitbucketReposGateway;
	}
	
	return self;
}

- (void)displayUserGithubRepositories:(User *)user withCompletionHandler:(DisplayRepositoriesCompletionHandler)completionHandler {
	[_githubReposGateway fetchUserRepos:user withCompletionHandler:^(NSArray *repos, NSError *error) {
		completionHandler(repos, error);
	}];
}

- (void)displayUserBitbucketRepositories:(User *)user withCompletionHandler:(DisplayRepositoriesCompletionHandler)completionHandler {
	[_bitbucketReposGateway fetchUserRepos:user withCompletionHandler:^(NSArray *repos, NSError *error) {
		completionHandler(repos, error);
	}];
}

@end
