//
//  BitbucketApiRepository.m
//  Git Repos Viewer
//
//  Created by Василий Анисимов on 30/01/2018.
//  Copyright © 2018 anivaros. All rights reserved.
//

#import "BitbucketApiRepository.h"
#import <DateTools/DateTools.h>
#import "Repository.h"


@implementation BitbucketApiRepository

- (instancetype)initWithData:(NSData *)aData {
	id jsonObject = [NSJSONSerialization JSONObjectWithData:aData options:kNilOptions error:nil];
	return [jsonObject isKindOfClass:[NSDictionary class]] ? jsonObject : nil;
}

- (instancetype)initWithJSON:(NSDictionary *)json {
	self = [super init];
	if (self) {
		_name = json[@"name"];
		_repoDescription = json[@"description"];
		_created_on = [NSDate dateWithString:json[@"created_on"] formatString:@"yyyy-MM-dd'T'HH:mm:ss.SSS'+'SS:SS"];
		_updated_on = [NSDate dateWithString:json[@"updated_on"] formatString:@"yyyy-MM-dd'T'HH:mm:ss.SSS'+'SS:SS"];
	}
	return self;
}

- (Repository *)repository {
	Repository *r = [[Repository alloc] init];
	r.name = self.name;
	r.repoDescription = self.repoDescription;
	r.updated = self.updated_on;
	return r;
}

@end
