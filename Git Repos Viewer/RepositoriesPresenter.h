//
//  RepositoriesPresenter.h
//  Git Repos Viewer
//
//  Created by Василий Анисимов on 29/01/2018.
//  Copyright © 2018 anivaros. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol DisplayRepositoriesUseCase;
@class Repository;
@class User;

typedef NS_ENUM(NSUInteger, HostingType) {
	kGithubHostingType = 0,
	kBitbucketHostingType = 1,
};

@protocol RepositoriesView <NSObject>

- (void)refreshRepositoriesView;

- (void)showActivityView;

- (void)hideActivityView;

- (void)askUserEnterUsername;

- (void)setUsername:(NSString *)username;

- (void)displayRepositoriesRetrievalErrorWithTitle:(NSString *)title message:(NSString *)message;

@end

@protocol RepositoryCellView <NSObject>

- (void)displayName:(NSString *)name;

- (void)displayDescription:(NSString *)description;

- (void)displayLastUpdate:(NSString *)lastUpdate;

@end

@protocol RepositoriesPresenter <NSObject>

@property (nonatomic, readonly) NSUInteger repositoriesCount;

- (void)viewDidLoad;

- (void)configureCell:(id <RepositoryCellView>)cell forRow:(NSUInteger)row;

- (void)showUsernameRepos:(NSString *)username;

- (void)selectHostingButtonPressed:(HostingType)hostingType;

@end

@interface RepositoriesPresenterImplementation : NSObject <RepositoriesPresenter> {
	__weak id <RepositoriesView> _view;
	id <DisplayRepositoriesUseCase> _displayRepositoriesUseCase;
	HostingType _currentHostingType;
	User *_user;
	__block NSArray <Repository *> *_githubRepositories;
	__block NSArray <Repository *> *_bitbucketRepositories;
}

- (instancetype)initWithView:(id <RepositoriesView>)view displayRepositoriesUseCase:(id <DisplayRepositoriesUseCase>)displayRepositoriesUseCase;


@end
