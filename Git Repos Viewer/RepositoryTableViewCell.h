//
//  RepositoryTableViewCell.h
//  Git Repos Viewer
//
//  Created by Василий Анисимов on 29/01/2018.
//  Copyright © 2018 anivaros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RepositoriesPresenter.h"


@interface RepositoryTableViewCell : UITableViewCell <RepositoryCellView> {
	__weak IBOutlet UILabel *_nameLabel;
	__weak IBOutlet UILabel *_updateDate;
	__weak IBOutlet UILabel *_descriptionLabel;
}

@end
