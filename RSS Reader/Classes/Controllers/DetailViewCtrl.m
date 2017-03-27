//
//  DetailViewCtrl.m
//  RSS Reader
//
//  Created by Grigoriy Zaliva on 27.03.17.
//  Copyright © 2017 Grigoriy Zaliva. All rights reserved.
//

#import "DetailViewCtrl.h"

@interface DetailViewCtrl ()

@property (weak, nonatomic) IBOutlet UILabel *titileLabel;

@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@end

@implementation DetailViewCtrl

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
    self.titileLabel.text = self.item.title;
    self.descriptionTextView.text = self.item.description_;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
