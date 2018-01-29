//
//  RepositoriesList.h
//  Git Repos Viewer
//
//  Created by Василий Анисимов on 28/01/2018.
//  Copyright © 2018 anivaros. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol GitHostingGateway;
@class Repository;
@class User;

typedef void (^DisplayRepositoriesCompletionHandler)(NSArray <Repository *> *repositories, NSError *error);

@protocol DisplayRepositoriesUseCase <NSObject>

- (void)displayUserGithubRepositories:(User *)user withCompletionHandler:(DisplayRepositoriesCompletionHandler)completionHandler;

- (void)displayUserBitbucketRepositories:(User *)user withCompletionHandler:(DisplayRepositoriesCompletionHandler)completionHandler;

@end

@interface DisplayRepositoriesUseCaseImplementation : NSObject <DisplayRepositoriesUseCase> {
	id <GitHostingGateway> _githubReposGateway;
	id <GitHostingGateway> _bitbucketReposGateway;
}

- (instancetype)initWithGithubReposGateway:(id <GitHostingGateway>)githubReposGateway bitbucketReposGateway:(id <GitHostingGateway>)bitbucketReposGateway;


@end
