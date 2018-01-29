//
//  RepositoriesPresenter.m
//  Git Repos Viewer
//
//  Created by Василий Анисимов on 29/01/2018.
//  Copyright © 2018 anivaros. All rights reserved.
//

#import "RepositoriesPresenter.h"
#import "RepositoriesList.h"
#import "Repository.h"
#import "User.h"
#import <DateTools/DateTools.h>
#import <LinqToObjectiveC/LinqToObjectiveC.h>


@implementation NSDate (Helper)

- (NSString *)toRelativeFormattedDateString {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	formatter.dateStyle = NSDateFormatterNoStyle;
	formatter.timeStyle = NSDateFormatterNoStyle;
	formatter.locale = NSLocale.currentLocale;
	formatter.doesRelativeDateFormatting = YES;
	
	if (self.isToday) {
		formatter.timeStyle = NSDateFormatterShortStyle;
		formatter.dateStyle = NSDateFormatterNoStyle;
	}
	else if (self.isYesterday) {
		formatter.timeStyle = NSDateFormatterNoStyle;
		formatter.dateStyle = NSDateFormatterMediumStyle;
	}
	else if (self.weeksAgo == 0) {
		return formatter.weekdaySymbols[self.weekday - 1];
	}
	else if (self.year == NSDate.date.year) {
		formatter.doesRelativeDateFormatting = NO;
		formatter.dateFormat = @"d MMM";
	}
	else {
		formatter.timeStyle = NSDateFormatterNoStyle;
		formatter.dateStyle = NSDateFormatterShortStyle;
	}
	return [formatter stringFromDate:self];
}

@end

@implementation RepositoriesPresenterImplementation

- (instancetype)initWithView:(id <RepositoriesView>)view displayRepositoriesUseCase:(id <DisplayRepositoriesUseCase>)displayRepositoriesUseCase {
	self = [super init];
	if (self) {
		_view = view;
		_displayRepositoriesUseCase = displayRepositoriesUseCase;
	}
	
	return self;
}

- (NSUInteger)repositoriesCount {
	switch (_currentHostingType) {
		case kGithubHostingType:
			return _githubRepositories.count;
		case kBitbucketHostingType:
			return _bitbucketRepositories.count;
	}
	return 0;
}

- (void)viewDidLoad {
	[_view hideActivityView];
	if ([self loadUser]) {
		[_view setUsername:_user.login];
		[self loadRepos:_currentHostingType];
	}
	else {
		[_view askUserEnterUsername];
	}
}

- (void)configureCell:(id <RepositoryCellView>)cell forRow:(NSUInteger)row {
	switch (_currentHostingType) {
		case kGithubHostingType:
			[cell displayName:_githubRepositories[row].name];
			[cell displayDescription:_githubRepositories[row].repoDescription];
			[cell displayLastUpdate:_githubRepositories[row].updated.toRelativeFormattedDateString];
			break;
		case kBitbucketHostingType:
			[cell displayName:_bitbucketRepositories[row].name];
			[cell displayDescription:_bitbucketRepositories[row].repoDescription];
			[cell displayLastUpdate:_bitbucketRepositories[row].updated.toRelativeFormattedDateString];
			break;
		default:
			break;
	}
}

- (void)showUsernameRepos:(NSString *)username {
	if ([self checkUsername:username]) {
		User *user = [[User alloc] init];
		user.login = username;
		_user = user;
		[self loadRepos:_currentHostingType];
	}
	else {
	}
}

- (BOOL)checkUsername:(NSString *)username {
	return username.length > 0;
}

- (void)selectHostingButtonPressed:(HostingType)hostingType {
	_currentHostingType = hostingType;
	[self loadRepos:_currentHostingType];
}

- (void)loadRepos:(HostingType)hostingType {
	NSParameterAssert(_user);
	
	[_view showActivityView];
	
	switch (hostingType) {
		case kGithubHostingType: {
			[_displayRepositoriesUseCase displayUserGithubRepositories:_user withCompletionHandler:^(NSArray<Repository *> *repositories, NSError *error) {
				if (error) {
					[self showError:error];
					return;
				}
				_githubRepositories = [repositories linq_sortDescending:^id(Repository *item) {
					return item.updated;
				}];
				dispatch_async(dispatch_get_main_queue(), ^{
					[_view hideActivityView];
					[_view refreshRepositoriesView];
				});
			}];
			break;
		}
		case kBitbucketHostingType: {
			[_displayRepositoriesUseCase displayUserBitbucketRepositories:_user withCompletionHandler:^(NSArray<Repository *> *repositories, NSError *error) {
				if (error) {
					[self showError:error];
					return;
				}
				_bitbucketRepositories = [repositories linq_sortDescending:^id(Repository *item) {
					return item.updated;
				}];
				dispatch_async(dispatch_get_main_queue(), ^{
					[_view hideActivityView];
					[_view refreshRepositoriesView];
				});
			}];
			break;
		}
		default:
			break;
	}
}

- (void)showError:(NSError *)error {
	dispatch_async(dispatch_get_main_queue(), ^{
		[_view displayRepositoriesRetrievalErrorWithTitle:@"Ошибка" message:error.localizedDescription];
	});
}

- (BOOL)loadUser {
//TODO: сохранять и загружать пользователя из локального хранилища
	return NO;
}

@end
