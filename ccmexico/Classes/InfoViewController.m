//
//  InfoViewController.m
//  ccmexico
//
//  Created by Pau Ochoa on 08/06/11.
//  Copyright 2011 AD. All rights reserved.
//

#import "InfoViewController.h"


@implementation InfoViewController

@synthesize mview;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
  [mview release];
  
  [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  
  [self.mview.layer setCornerRadius:10.0f];
}

- (void)viewDidUnload
{
  self.mview = nil;
  
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  //return YES;
  UIInterfaceOrientation interfaceOrientationn = [UIApplication sharedApplication].statusBarOrientation;
  return UIDeviceOrientationIsPortrait(interfaceOrientationn);
  //return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) hideInfo:(id)sender
{
  [self dismissModalViewControllerAnimated:YES];
}

@end
