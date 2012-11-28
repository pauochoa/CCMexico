//
//  InfoViewController.h
//  ccmexico
//
//  Created by Pau Ochoa on 08/06/11.
//  Copyright 2011 AD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface InfoViewController : UIViewController 
{
  UIView *mview;   
}

@property (nonatomic, retain) IBOutlet UIView *mview;

- (IBAction) hideInfo:(id)sender;
@end
