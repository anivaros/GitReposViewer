//
//  Repository.h
//  Git Repos Viewer
//
//  Created by Василий Анисимов on 28/01/2018.
//  Copyright © 2018 anivaros. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Repository : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *repoDescription;
@property (nonatomic, strong) NSDate *updated;

@end
