//
//  GitHostingGateway.h
//  Git Repos Viewer
//
//  Created by Василий Анисимов on 28/01/2018.
//  Copyright © 2018 anivaros. All rights reserved.
//

#import <Foundation/Foundation.h>


@class User, Repository;

typedef void (^FetchUserReposCompletionHandler)(NSArray *_Nullable repos, NSError *_Nullable error);

@protocol GitHostingGateway <NSObject>

- (void)fetchUserRepos:(User *_Nonnull)user withCompletionHandler:(FetchUserReposCompletionHandler _Nonnull)completionHandler;

@end
