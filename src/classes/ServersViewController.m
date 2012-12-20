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

#import "ServersViewController.h"

@implementation ServersViewController

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
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.overlay addGestureRecognizer:tapRecognizer];
    
    UITapGestureRecognizer *tapRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tobiasClick:)];
    self.tobiasImage.userInteractionEnabled = YES;
    [self.tobiasImage addGestureRecognizer:tapRecognizer2];
    
    [self.view bringSubviewToFront:self.overlay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)handleTap:(id)sender {
    [UIView beginAnimations:@"MoveAndRotateAnimation" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    
    float height = 280;
    float width = 280;
    
    self.tobias.frame = CGRectMake(20, 747, width, height);
    
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight
                           forView:self.tobias
                             cache:NO];
    
    self.overlay.alpha = 0.0;
    
    [UIView commitAnimations];
    
    self.statusViewController.view.hidden = YES;
    
    self.tobiasImage.hidden = NO;
    self.tobiasImage2.hidden = NO;
}

- (IBAction)tobiasClick:(id)sender {   
    [UIView beginAnimations:@"MoveAndRotateAnimation" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];

    float height = 640 * 1.20;
    float width = 640 * 1.20;
    
    float x = self.view.frame.size.width / 2.0f - width / 2.0f;
    float y = self.view.frame.size.height / 2.0f - height / 2.0f;
    self.tobias.frame = CGRectMake(x, y, width, height);
    
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft
                           forView:self.tobias
                             cache:YES];
    
    self.overlay.alpha = 0.4;
    
    [UIView commitAnimations];
    
    [self.view bringSubviewToFront:self.tobias];
    
    // removes the tobias view from the parent view not required anymore
    self.tobiasImage.hidden = YES;
    self.tobiasImage2.hidden = YES;
    
    self.statusViewController = [[StatusViewController alloc] initWithNibName:@"StatusViewControllerIpad" bundle:nil];
    float width_ = 640;
    float height_ = 640;
    float width__ = self.tobias.frame.size.width;
    float height__ = self.tobias.frame.size.height;
    
    float x_ = width__ / 2.0 - width_ / 2.0;
    float y_ = height__ / 2.0 - height_ / 2.0;
    
    self.statusViewController.view.frame = CGRectMake(x_, y_, width_, height_);

    [self.tobias addSubview:self.statusViewController.view];
}

@end
