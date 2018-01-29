//
//  RepositoriesBitbucketApiRequest.h
//  Git Repos Viewer
//
//  Created by Василий Анисимов on 30/01/2018.
//  Copyright © 2018 anivaros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiClient.h"


@interface RepositoriesBitbucketApiRequest : NSObject <ApiRequest> {
	NSString *_username;
	NSString *_url;
}

- (instancetype)initWithUsername:(NSString *)username;

- (instancetype)initWithUrl:(NSString *)url;

@end
