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

#import "AppDelegate.h"

#import "StatusViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // initializes the default values in the preferences structure
    // in case they don't already exist (and are defined)
    [self setDefaults];
    
    // initializes the various layout relates structures, configuring
    // them to the expected behavior
    [self setLayout];
    
    // creates the status view controller as the "main" view controller
    // to be used by the application
    StatusViewController *statusViewController = [[StatusViewController alloc] initWithNibName:@"StatusViewController" bundle:nil];
    
    // creates the naviation controller to be used for the controll
    // of the various navigation controller
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:statusViewController];
    
    // creates the window object and sets its root view controller with the
    // created navigation controller the sets it as visible
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    // returns success, application started with success
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

- (void)setDefaults {
}

- (void)setLayout {
    // retrieves the header background image and sets it in the global reference
    // for the navigation bar (global update)
    UIImage *headerBackgroundImage = [UIImage imageNamed:@"header-background.png"];
    UIImage *headerBackgroundImageSmall = [UIImage imageNamed:@"header-background-small.png"];
    [[UINavigationBar appearance] setBackgroundImage:headerBackgroundImage forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBackgroundImage:headerBackgroundImageSmall forBarMetrics:UIBarMetricsLandscapePhone];
    
    // sets the bar style for the global appearence as black opaque so that the
    // characters are correctly rendered
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackOpaque];
}

@end
