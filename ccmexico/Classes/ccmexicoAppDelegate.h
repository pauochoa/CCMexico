//
//  ccmexicoAppDelegate.h
//  ccmexico
//
//  Created by Pau Ochoa on 26/05/11.
//  Copyright 2011 AD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ccmexicoAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
