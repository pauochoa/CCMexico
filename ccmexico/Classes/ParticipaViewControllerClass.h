//
//  ParticipaViewControllerClass.h
//  ccmexico
//
//  Created by Pau Ochoa on 05/07/11.
//  Copyright 2011 AD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface ParticipaViewControllerClass : UIViewController <MFMailComposeViewControllerDelegate>
{
  UIView *fondo1;  
  UIButton *b;
}


@property (nonatomic, retain) IBOutlet UIView *fondo1;
@property (nonatomic, retain) IBOutlet UIButton *b;

- (IBAction) sendEmail:(id) sender;
@end
