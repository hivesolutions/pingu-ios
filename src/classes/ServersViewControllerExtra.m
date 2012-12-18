// Hive Pingu Service
// Copyright (C) 2008-2012 Hive Solutions Lda.
//
// This file is part of Hive Pingu Service.
//
// Hive Pingu Service is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Hive Pingu Service is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Hive Pingu Service. If not, see <http://www.gnu.org/licenses/>.

// __author__    = João Magalhães <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision$
// __date__      = $LastChangedDate$
// __copyright__ = Copyright (c) 2008-2012 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "ServersViewControllerExtra.h"

@implementation ServersViewControllerExtra

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        self.title = @"Servers";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // creates the patter image to be used for the view background,
    // should be set as a pattern
    UIImage *patternImage = [UIImage imageNamed:@"main-background.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:patternImage];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    FlipView *flipView = [[FlipView alloc] initWithFrame:CGRectMake(0, 0, 100, 200)];
    FlipView *flipView2 = [[FlipView alloc] initWithFrame:CGRectMake(0, 0, 100, 200)];
    FlipView *flipView3 = [[FlipView alloc] initWithFrame:CGRectMake(0, 0, 100, 200)];
    FlipView *flipView4 = [[FlipView alloc] initWithFrame:CGRectMake(0, 0, 100, 200)];
    FlipView *flipView5 = [[FlipView alloc] initWithFrame:CGRectMake(0, 0, 100, 200)];
    FlipView *flipView6 = [[FlipView alloc] initWithFrame:CGRectMake(0, 0, 100, 200)];
    
    [self.flipContainer addFlipView:flipView];
    [self.flipContainer addFlipView:flipView2];
    [self.flipContainer addFlipView:flipView3];
    [self.flipContainer addFlipView:flipView4];
    [self.flipContainer addFlipView:flipView5];
    [self.flipContainer addFlipView:flipView6];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end