//
//  BitbucketApiGatewayImplementation.m
//  Git Repos Viewer
//
//  Created by Василий Анисимов on 28/01/2018.
//  Copyright © 2018 anivaros. All rights reserved.
//

#import "BitbucketApiGatewayImplementation.h"

#import <LinqToObjectiveC/LinqToObjectiveC.h>

#import "ApiClient.h"
#import "BitbucketApiRepository.h"
#import "RepositoriesBitbucketApiRequest.h"
#import "User.h"


@implementation BitbucketApiGatewayImplementation

- (instancetype)initWithApiClient:(id <ApiClient>)apiClient {
	self = [super init];
	if (self) {
		_apiClient = apiClient;
		_reposJson = [[NSMutableArray alloc] init];
	}
	
	return self;
}

- (void)fetchUserRepos:(User *_Nonnull)user withCompletionHandler:(FetchUserReposCompletionHandler _Nonnull)completionHandler {
	RepositoriesBitbucketApiRequest *apiRequest = [[RepositoriesBitbucketApiRequest alloc] initWithUsername:user.login];
	
	_completionHandler = [completionHandler copy];
	
	[_apiClient callServerMethod:apiRequest withCompletionHandler:^(ApiResponse *response, NSError *error) {
		[self processServerMethodResponce:response error:error];
	}];
}

- (void)precessFinalReposArray {
	NSArray *repos = [_reposJson linq_select:^id(id item) {
		return [[BitbucketApiRepository alloc] initWithJSON:item].repository;
	}];
	[_reposJson removeAllObjects];
	_completionHandler(repos, nil);
}

- (void)fetchNextUserRepos:(NSString *)nextPage {
	RepositoriesBitbucketApiRequest *apiRequest = [[RepositoriesBitbucketApiRequest alloc] initWithUrl:nextPage];
	[_apiClient callServerMethod:apiRequest withCompletionHandler:^(ApiResponse *response, NSError *error) {
		[self processServerMethodResponce:response error:error];
	}];
}

- (void)processServerMethodResponce:(ApiResponse *)response error:(NSError *)error {
	if (error) {
		_completionHandler(nil, error);
		return;
	}
	NSDictionary *responceJson = [NSJSONSerialization JSONObjectWithData:response.data options:kNilOptions error:nil];
	if (responceJson[@"values"]) {
		[_reposJson addObjectsFromArray:responceJson[@"values"]];
	}
	if (responceJson[@"next"]) {
		[self fetchNextUserRepos:responceJson[@"next"]];
	}
	else {
		[self precessFinalReposArray];
	}
}

@end
