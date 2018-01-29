//
//  RepositoriesGithubApiRequest.h
//  Git Repos Viewer
//
//  Created by Василий Анисимов on 28/01/2018.
//  Copyright © 2018 anivaros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiClient.h"


@interface RepositoriesGithubApiRequest : NSObject <ApiRequest> {
	NSString *_username;
}

- (instancetype)initWithUsername:(NSString *)username;


@end
