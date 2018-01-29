//
//  RepositoriesViewController.h
//  Git Repos Viewer
//
//  Created by Василий Анисимов on 28/01/2018.
//  Copyright © 2018 anivaros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RepositoriesPresenter.h"


@interface RepositoriesViewController : UIViewController <RepositoriesView> {
	__weak IBOutlet UISegmentedControl *_segmentedControl;
	__weak IBOutlet UITableView *_tableView;
	__weak IBOutlet UITextField *_usernameTextField;
	__weak IBOutlet UIActivityIndicatorView *_activityIndicatorView;
}

@property (nonatomic, strong) id <RepositoriesPresenter> presenter;

@end

