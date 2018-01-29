//
//  GithubApiRepository.h
//  Git Repos Viewer
//
//  Created by Василий Анисимов on 28/01/2018.
//  Copyright © 2018 anivaros. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Repository;

@interface GithubApiRepository : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *repoDescription;
@property (nonatomic, strong) NSDate *created_at;
@property (nonatomic, strong) NSDate *updated_at;

- (instancetype)initWithData:(NSData *)aData;

- (instancetype)initWithJSON:(NSDictionary *)json;

@property (nonatomic, strong, readonly) Repository *repository;

@end
