//
//  AppDelegate.m
//  Git Repos Viewer
//
//  Created by Василий Анисимов on 28/01/2018.
//  Copyright © 2018 anivaros. All rights reserved.
//

#import "AppDelegate.h"
#import "RepositoriesViewController.h"
#import "RepositoriesList.h"
#import "GitHubApiGatewayImplementation.h"
#import "ApiClient.h"
#import "BitbucketApiGatewayImplementation.h"
#import "RepositoriesPresenter.h"


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[self configureRepositoriesViewController:(RepositoriesViewController *) self.window.rootViewController.childViewControllers.firstObject];
	return YES;
}

- (void)configureRepositoriesViewController:(RepositoriesViewController *)viewController {
	ApiClientImplementation *apiClient = [[ApiClientImplementation alloc] init];
	GitHubApiGatewayImplementation *gitHubApiGateway = [[GitHubApiGatewayImplementation alloc] initWithApiClient:apiClient];
	BitbucketApiGatewayImplementation *bitbucketApiGateway = [[BitbucketApiGatewayImplementation alloc] initWithApiClient:apiClient];
	DisplayRepositoriesUseCaseImplementation *displayRepositoriesUseCase = [[DisplayRepositoriesUseCaseImplementation alloc] initWithGithubReposGateway:gitHubApiGateway
																															 bitbucketReposGateway:bitbucketApiGateway];
	RepositoriesPresenterImplementation *repositoriesPresenter = [[RepositoriesPresenterImplementation alloc] initWithView:viewController
																											  displayRepositoriesUseCase:displayRepositoriesUseCase];
	viewController.presenter = repositoriesPresenter;
}

@end
