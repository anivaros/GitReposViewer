//
//  GitHubApiGatewayImplementation.m
//  Git Repos Viewer
//
//  Created by Василий Анисимов on 28/01/2018.
//  Copyright © 2018 anivaros. All rights reserved.
//

#import "GitHubApiGatewayImplementation.h"

#import <LinqToObjectiveC/LinqToObjectiveC.h>

#import "ApiClient.h"
#import "RepositoriesGithubApiRequest.h"
#import "User.h"
#import "GithubApiRepository.h"


@implementation GitHubApiGatewayImplementation

- (instancetype)initWithApiClient:(id <ApiClient>)apiClient {
	self = [super init];
	if (self) {
		_apiClient = apiClient;
	}
	
	return self;
}

- (void)fetchUserRepos:(User *_Nonnull)user withCompletionHandler:(FetchUserReposCompletionHandler _Nonnull)completionHandler {
	RepositoriesGithubApiRequest *apiRequest = [[RepositoriesGithubApiRequest alloc] initWithUsername:user.login];
	[_apiClient callServerMethod:apiRequest withCompletionHandler:^(ApiResponse *response, NSError *error) {
		NSArray *reposJson = [NSJSONSerialization JSONObjectWithData:response.data options:kNilOptions error:nil];
		NSArray *repos = [reposJson linq_select:^id(id item) {
			return [[GithubApiRepository alloc] initWithJSON:item].repository;
		}];
		completionHandler(repos, error);
	}];
}

@end
