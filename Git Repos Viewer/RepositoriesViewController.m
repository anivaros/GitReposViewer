//
//  RepositoriesViewController.m
//  Git Repos Viewer
//
//  Created by Василий Анисимов on 28/01/2018.
//  Copyright © 2018 anivaros. All rights reserved.
//

#import "RepositoriesViewController.h"
#import "RepositoryTableViewCell.h"


@interface RepositoriesViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@end

@implementation RepositoriesViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	NSParameterAssert(self.presenter);
	
	[self.presenter viewDidLoad];
}


#pragma mark - UBActions


- (IBAction)segmentedControlValueChanged:(UISegmentedControl *)sender {
	[self.presenter selectHostingButtonPressed:(HostingType) sender.selectedSegmentIndex];
}


#pragma mark - UITextFieldDelegate


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if ([textField isEqual:_usernameTextField]) {
		[textField resignFirstResponder];
		return NO;
	}
	return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	[self.presenter showUsernameRepos:textField.text];
}


#pragma mark - RepositoriesView


- (void)refreshRepositoriesView {
	[_tableView reloadData];
}

- (void)showActivityView {
	[_activityIndicatorView startAnimating];
}

- (void)hideActivityView {
	[_activityIndicatorView stopAnimating];
}

- (void)askUserEnterUsername {
	[_usernameTextField becomeFirstResponder];
}

- (void)setUsername:(NSString *)username {
	_usernameTextField.text = username;
}

- (void)displayRepositoriesRetrievalErrorWithTitle:(NSString *)title message:(NSString *)message {
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
	[alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
	[self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - UITableViewDataSource, UITableViewDelegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.presenter.repositoriesCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	RepositoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RepositoryCell" forIndexPath:indexPath];
	[self.presenter configureCell:cell forRow:indexPath.row];
	return cell;
}

@end
