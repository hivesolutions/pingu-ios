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
#import "ServersViewController.h"




#import "ServersViewControllerExtra.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // initializes the default values in the preferences structure
    // in case they don't already exist (and are defined)
    [self setDefaults];
    
    // initializes the various layout relates structures, configuring
    // them to the expected behavior
    [self setLayout];
    
    // creates a new window to hold the various views that will compose
    // the complete application, this is the many entry point for them
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // checks if the current device is of type phone and in such case starts
    // the required structures for it
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        // creates the status view controller as the "main" view controller
        // to be used by the application
        StatusViewController *statusViewController = [[StatusViewController alloc] initWithNibName:@"StatusViewController" bundle:nil];
    
        // creates the naviation controller to be used for the controll
        // of the various navigation controller and sets it as the root
        // view controller for the current main window
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:statusViewController];
        self.window.rootViewController = navigationController;
    } else {
        // creates the servers view controller as the "main" view controller
        // to be used by the application
        //ServersViewController *serversViewController = [[ServersViewController alloc] initWithNibName:@"ServersViewController" bundle:nil];
        
        // creates the servers view controller as the "main" view controller
        // to be used by the application
        ServersViewControllerExtra *serversViewController = [[ServersViewControllerExtra alloc] initWithNibName:@"ServersViewControllerExtra" bundle:nil];
    
        // creates the naviation controller to be used for the controll
        // of the various navigation controller and sets it as the root
        // view controller for the current main window
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:serversViewController];
        self.window.rootViewController = navigationController;
    }

    // makes the just created window as the top level element for the current device
    // this should bring the interface up to the screen
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
    // sets the logo in the proxy request so that all the components
    // to generated from it use this logo
    [HMProxyRequest setLogo:[UIImage imageNamed:@"logo.png"]];
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
    
    // retrieves the various button related images for the button and the
    // back button and sets them in the global appearence object so that
    // the naviation controller's buttons are affected by the behavior
    UIImage *buttonImage = [[UIImage imageNamed:@"button-blue.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 6, 0, 6)];
    UIImage *buttonImagePressed = [[UIImage imageNamed:@"button-blue-pressed.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 6, 0, 6)];
    UIImage *buttonImageSmall = [[UIImage imageNamed:@"button-blue-small.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 6, 0, 6)];
    UIImage *buttonImageSmallPressed = [[UIImage imageNamed:@"button-blue-small-pressed.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 6, 0, 6)];
    UIImage *backImage = [[UIImage imageNamed:@"button-back-blue.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 16, 0, 6)];
    UIImage *backImagePressed = [[UIImage imageNamed:@"button-back-blue-pressed.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 16, 0, 6)];
    UIImage *backImageSmall = [[UIImage imageNamed:@"button-back-blue-small.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 16, 0, 6)];
    UIImage *backImageSmallPressed = [[UIImage imageNamed:@"button-back-blue-small-pressed.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 16, 0, 6)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backImagePressed forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backImageSmall forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backImageSmallPressed forState:UIControlStateHighlighted barMetrics:UIBarMetricsLandscapePhone];
    [[UIBarButtonItem appearance] setBackgroundImage:buttonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackgroundImage:buttonImagePressed forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackgroundImage:buttonImageSmall forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
    [[UIBarButtonItem appearance] setBackgroundImage:buttonImageSmallPressed forState:UIControlStateHighlighted barMetrics:UIBarMetricsLandscapePhone];

    // creates an attributes dictionary and populates it with both the text shadow
    // color and the the offset for it then sets in the gobal appearence map for
    // the control state normal (should apply to all the navigation bars)
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setValue:[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0] forKey:UITextAttributeTextShadowColor];
    [attributes setValue:[NSValue valueWithUIOffset:UIOffsetMake(-1.0, -1.0)] forKey:UITextAttributeTextShadowOffset];
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
    
    // creates an attributes dictionary and populates it with both the text shadow
    // color and the the offset for it then sets in the gobal appearence map for
    // the control state normal (should apply to all the bar buttons)
    attributes = [NSMutableDictionary dictionary];
    [attributes setValue:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0] forKey:UITextAttributeTextShadowColor];
    [attributes setValue:[NSValue valueWithUIOffset:UIOffsetMake(1.0, 1.0)] forKey:UITextAttributeTextShadowOffset];
    [[UIBarButtonItem appearance] setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    // creates an attributes dictionary and populates it with both the text colloer
    // for it then sets in the gobal appearence map for the control state normal
    // (should apply to all the tab bar items)
    attributes = [NSMutableDictionary dictionary];
    [attributes setValue:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    [[UITabBarItem appearance] setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

@end
