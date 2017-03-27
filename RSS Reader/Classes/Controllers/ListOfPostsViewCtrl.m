//
//  ViewController.m
//  RSS Reader
//
//  Created by Grigoriy Zaliva on 26.03.17.
//  Copyright © 2017 Grigoriy Zaliva. All rights reserved.
//

#import "ListOfPostsViewCtrl.h"

#define CellIdentifier @"Cell"
#define DetailCtrl     @"DetailViewCtrl"


@interface ListOfPostsViewCtrl () <UITableViewDelegate, UITableViewDataSource, ParserDelegate>
{
    NSArray *feeds;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loader;

@end

@implementation ListOfPostsViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureView];
}

- (void) configureView
{
    if ([Manager checkInternetConnection])
    {
        [self startLoader:YES];
        
        [self performBlock:^{
            [[Parser instance] parseRss:self.rss delegate:self];
        } afterDelay:0.3];
    }
    else
        [self parserDidFinish];
}

#pragma mark - UITableViewDeleagte

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return feeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Item *itemMod = feeds[indexPath.row];
    
    cell.textLabel.text = itemMod.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Item *itemMod = feeds[indexPath.row];
    
    DetailViewCtrl *ctrl = [self.storyboard instantiateViewControllerWithIdentifier:DetailCtrl];
    ctrl.item = itemMod;
    [self.navigationController pushViewController:ctrl animated:YES];
}

#pragma mark - ParserDelegate

- (void) parserDidFinish
{
    feeds = [Item getAllItemByRss_Id:self.rss.rss_id];
    
    [self.tableView reloadData];
    
    [self startLoader:NO];
}

#pragma mark - loader

- (void) startLoader:(BOOL) start
{
    self.loader.alpha = start ? 1.0 : 0;
    
    if (start) [self.loader startAnimating];
    else [self.loader stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
