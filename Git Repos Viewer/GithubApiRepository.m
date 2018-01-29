//
//  GithubApiRepository.m
//  Git Repos Viewer
//
//  Created by Василий Анисимов on 28/01/2018.
//  Copyright © 2018 anivaros. All rights reserved.
//

#import "GithubApiRepository.h"
#import <DateTools/DateTools.h>
#import "Repository.h"


@implementation GithubApiRepository

- (instancetype)initWithData:(NSData *)aData {
	id jsonObject = [NSJSONSerialization JSONObjectWithData:aData options:kNilOptions error:nil];
	return [jsonObject isKindOfClass:[NSDictionary class]] ? jsonObject : nil;
}

- (instancetype)initWithJSON:(NSDictionary *)json {
	self = [super init];
	if (self) {
		_name = json[@"name"];
		_repoDescription = json[@"description"];
		_created_at = [NSDate dateWithString:json[@"created_at"] formatString:@"yyyy-MM-dd'T'HH:mm:ssZ"];
		_updated_at = [NSDate dateWithString:json[@"updated_at"] formatString:@"yyyy-MM-dd'T'HH:mm:ssZ"];
	}
	return self;
}

- (Repository *)repository {
	Repository *r = [[Repository alloc] init];
	r.name = self.name;
	r.repoDescription = self.repoDescription;
	r.updated = self.updated_at;
	return r;
}

@end
