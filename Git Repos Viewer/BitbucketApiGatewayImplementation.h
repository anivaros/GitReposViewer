//
//  BitbucketApiGatewayImplementation.h
//  Git Repos Viewer
//
//  Created by Василий Анисимов on 28/01/2018.
//  Copyright © 2018 anivaros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GitHostingGateway.h"


@protocol ApiClient;

@interface BitbucketApiGatewayImplementation : NSObject <GitHostingGateway> {
	id <ApiClient> _apiClient;
	NSMutableArray *_reposJson;
	FetchUserReposCompletionHandler _completionHandler;
}

- (instancetype)initWithApiClient:(id <ApiClient>)apiClient;

@end
