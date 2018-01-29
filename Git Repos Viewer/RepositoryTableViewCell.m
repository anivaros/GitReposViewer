//
//  RepositoryTableViewCell.m
//  Git Repos Viewer
//
//  Created by Василий Анисимов on 29/01/2018.
//  Copyright © 2018 anivaros. All rights reserved.
//

#import "RepositoryTableViewCell.h"


@implementation RepositoryTableViewCell

- (void)displayName:(NSString *)name {
	_nameLabel.text = name;
}

- (void)displayDescription:(NSString *)description {
	_descriptionLabel.text = description;
}

- (void)displayLastUpdate:(NSString *)lastUpdate {
	_updateDate.text = lastUpdate;
}

@end
