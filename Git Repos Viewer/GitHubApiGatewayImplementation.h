//
//  GitHubApiGatewayImplementation.h
//  Git Repos Viewer
//
//  Created by Василий Анисимов on 28/01/2018.
//  Copyright © 2018 anivaros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GitHostingGateway.h"


@protocol ApiClient;

@interface GitHubApiGatewayImplementation : NSObject <GitHostingGateway> {
	id <ApiClient> _apiClient;
}

- (instancetype)initWithApiClient:(id <ApiClient>)apiClient;


@end
