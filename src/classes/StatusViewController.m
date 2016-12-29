// Hive Pingu Service
// Copyright (c) 2008-2017 Hive Solutions Lda.
//
// This file is part of Hive Pingu Service.
//
// Hive Pingu Service is free software: you can redistribute it and/or modify
// it under the terms of the Apache License as published by the Apache
// Foundation, either version 2.0 of the License, or (at your option) any
// later version.
//
// Hive Pingu Service is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// Apache License for more details.
//
// You should have received a copy of the Apache License along with
// Hive Pingu Service. If not, see <http://www.apache.org/licenses/>.

// __author__    = João Magalhães <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision$
// __date__      = $LastChangedDate$
// __copyright__ = Copyright (c) 2008-2017 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

#import "StatusViewController.h"

@implementation StatusViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo-menu.png"]];
        self.navigationItem.titleView = titleView;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // creates the patter image to be used for the view background,
    // should be set as a pattern
    UIImage *patternImage = [UIImage imageNamed:@"main-background.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:patternImage];

    UIImage *greenImage = [UIImage imageNamed:@"green-background.png"];
    self.topPanel.backgroundColor = [UIColor colorWithPatternImage:greenImage];

    UIImage *leftImage = [UIImage imageNamed:@"right-background.png"];
    self.leftPanel.backgroundColor = [UIColor colorWithPatternImage:leftImage];

    UIImage *rightImage = [UIImage imageNamed:@"right-background.png"];
    self.rightPanel.backgroundColor = [UIColor colorWithPatternImage:rightImage];

    UIImage *chartImage = [UIImage imageNamed:@"chart-ipad.png"];
    self.chart.backgroundColor = [UIColor colorWithPatternImage:chartImage];

    UIImage *shadowUp = [UIImage imageNamed:@"shadow-up.png"];
    self.shadowTop.backgroundColor = [UIColor colorWithPatternImage:shadowUp];

    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"LogoutButtonTitle", @"Logout")
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(logoutClick:)];
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-refresh.png"]
                                                        landscapeImagePhone:[UIImage imageNamed:@"icon-refresh-small.png"]
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(refreshClick:)];
    self.navigationItem.leftBarButtonItem = logoutButton;
    self.navigationItem.rightBarButtonItem = refreshButton;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

  //  HMProxyRequest *_proxyRequest = [[HMProxyRequest alloc] initWithPath:self path:@"sets.json"];
//    _proxyRequest.delegate = self;
  //  _proxyRequest.parameters = [NSArray arrayWithObjects: nil];
  //  [_proxyRequest load];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
