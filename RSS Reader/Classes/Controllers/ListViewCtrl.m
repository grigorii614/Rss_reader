//
//  ListViewCtrl.m
//  RSS Reader
//
//  Created by Grigoriy Zaliva on 27.03.17.
//  Copyright © 2017 Grigoriy Zaliva. All rights reserved.
//

#import "ListViewCtrl.h"

#define CellIdentifier @"ListCell"
#define PostsCtrl @"ListOfPostsViewCtrl"

@interface ListViewCtrl () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    NSArray *resources;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ListViewCtrl

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void) configureView
{
    resources = nil;
    resources = [Rss getAllRss];
    
    [self.tableView reloadData];
}

#pragma mark - IBAction

- (IBAction)addSubscription:(id)sender
{
    [self showAlert];
}

#pragma mark - UITableViewDeleagte

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return resources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Rss *rss = resources[indexPath.row];
    
    cell.textLabel.text = rss.link;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Rss *rss = resources[indexPath.row];
    
    ListOfPostsViewCtrl *ctrl = [self.storyboard instantiateViewControllerWithIdentifier:PostsCtrl];
    ctrl.rss = rss;
    [self.navigationController pushViewController:ctrl animated:YES];
}

#pragma mark - showAlert

- (void) showAlert
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Subscription"
                                                                   message:@"Paste the link"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK"
                                                 style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action) {
                                                   UITextField *textField = alert.textFields[0];
                                                   
                                                   if ([[textField.text lowercaseString] hasPrefix:@"http://"] ||
                                                       [[textField.text lowercaseString] hasPrefix:@"https://"])
                                                   {
                                                       [Rss saveRssByLink:textField.text];
                                                       [self configureView];
                                                   }
                                                   
                                               }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                   }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Link";
        textField.delegate = self;
    }];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
