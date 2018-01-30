//
//  RepositoriesPresenterTests.m
//  Git Repos Viewer Tests
//
//  Created by Василий Анисимов on 28/01/2018.
//  Copyright © 2018 anivaros. All rights reserved.
//

#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

#import "RepositoriesPresenter.h"
#import "RepositoriesList.h"
#import "BitbucketApiGatewayImplementation.h"
#import "GitHubApiGatewayImplementation.h"
#import "ApiClient.h"
#import "RepositoriesViewController.h"
#import "Repository.h"
#import "RepositoryTableViewCell.h"


#define EXP_SHORTHAND

SpecBegin(RepositoriesPresenter);
	describe(@"RepositoriesPresenter", ^{
		__block id viewController;
		__block id displayRepositoriesUseCase;
		__block RepositoriesPresenterImplementation *repositoriesPresenter;
		__block id cell;
		
		beforeEach(^{
			viewController = OCMClassMock([RepositoriesViewController class]);
			displayRepositoriesUseCase = OCMClassMock([DisplayRepositoriesUseCaseImplementation class]);
			repositoriesPresenter = [[RepositoriesPresenterImplementation alloc] initWithView:viewController
																				 displayRepositoriesUseCase:displayRepositoriesUseCase];
			cell = OCMClassMock([RepositoryTableViewCell class]);
		});
		
		it(@"should call askUserEnterUsername on viewDidLoad", ^{
			[repositoriesPresenter viewDidLoad];
			OCMVerify([viewController askUserEnterUsername]);
		});
		
		it(@"should have repositoriesCount when initialized", ^{
			Repository *r1 = [[Repository alloc] init];
			r1.name = @"test 1";
			Repository *r2 = [[Repository alloc] init];
			r1.name = @"test 2";
			Repository *r3 = [[Repository alloc] init];
			r1.name = @"test 3";
			
			OCMStub([displayRepositoriesUseCase displayUserGithubRepositories:[OCMArg any]
												withCompletionHandler:([OCMArg invokeBlockWithArgs:@[r1, r2, r3], [NSNull null], nil])]);
			[repositoriesPresenter showUsernameRepos:@"test"];
			expect(repositoriesPresenter.repositoriesCount).to.equal(3);
		});
		
		it(@"should show error on error", ^{
			NSError *error = OCMClassMock([NSError class]);
			OCMStub(error.localizedDescription).andReturn(@"Test");
			OCMStub([displayRepositoriesUseCase displayUserGithubRepositories:[OCMArg any]
														withCompletionHandler:([OCMArg invokeBlockWithArgs:[NSNull null], error, nil])]);
			[repositoriesPresenter showUsernameRepos:@"test"];
			
			OCMExpect([viewController displayRepositoriesRetrievalErrorWithTitle:@"Ошибка" message:@"Test"]);
			OCMVerifyAllWithDelay(viewController, 1.0f);
		});
		
		describe(@"cell", ^{
			it(@"should have description", ^{
				Repository *r1 = [[Repository alloc] init];
				r1.name = @"test 1";
				r1.repoDescription = @"test description 1";
				
				OCMStub([displayRepositoriesUseCase displayUserGithubRepositories:[OCMArg any]
													withCompletionHandler:([OCMArg invokeBlockWithArgs:@[r1], [NSNull null], nil])]);
				[repositoriesPresenter showUsernameRepos:@"test"];
				[repositoriesPresenter configureCell:cell forRow:0];
				
				OCMVerify([cell displayDescription:@"test description 1"]);
			});
		});
		
		afterEach(^{
		});
	});
SpecEnd
