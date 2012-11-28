//
//  IndexLicencias.m
//  ccmexico
//
//  Created by Pau Ochoa on 03/06/11.
//  Copyright 2011 AD. All rights reserved.
//

#import "IndexLicencias.h"


@implementation IndexLicencias

@synthesize l1,l2,l3,l4,l5,l6,sv,landscapeView,infoButtom, infoView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) 
    {
      //Custom initialization
    }
    
    return self;
}

- (void)dealloc
{
  [super dealloc];
  [l1 release];
  [l2 release];
  [l3 release];
  [l4 release];
  [l5 release];
  [l6 release];
  [sv release];
  
  [infoButtom release];
  [infoView release];
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
  
  self.landscapeView = CGRectNull;
  
  [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(orientationChanged:)
                                               name:UIDeviceOrientationDidChangeNotification
                                             object:nil];
  [self setViewFromOrientation];
}

- (void) setViewFromOrientation
{
  UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;  
  /*
  int porw = 320;
  int lanw = 480;
  int lanh = 320 - 49 - 32;
  */
  int porh = 480 - 49 - 44;
  if(UIDeviceOrientationIsLandscape(deviceOrientation))
  {
    //[self.view setBounds:CGRectMake(0, 0, lanw, lanh)];  
    //[self.sv setBounds:self.view.bounds];
    /*
    if(CGRectIsNull(self.landscapeView))
    {
      CGRect contentRect = CGRectZero;
      for (UIView *view in self.sv.subviews)
      {
          contentRect = CGRectUnion(contentRect, view.frame);
          NSLog(@"FOR: %@", view);
      }
      self.landscapeView = contentRect;
    }
    
    self.sv.contentSize = self.landscapeView.size;    
    */
    self.sv.contentSize = CGSizeMake(480, 440);
    self.sv.showsHorizontalScrollIndicator = NO;
        self.sv.showsVerticalScrollIndicator = YES;
    self.sv.clipsToBounds = YES;
    self.sv.scrollEnabled = YES;
    self.sv.bounces = YES;
  }
  
  if(UIDeviceOrientationIsPortrait(deviceOrientation))
  {
    //[self.view setBounds:CGRectMake(0, 0, porw, porh)];
    //[self.sv setBounds:self.view.bounds];
    
    //[self.view setFrame:self.navigationController.visibleViewController.view.frame];
    //NSLog(@"El ancho del nav controller: %f", self.navigationController.view.frame.size.width);
    //[self.view setBounds:self.navigationController.view.bounds];
    //self.sv.contentSize = self.view.frame.size;
    self.sv.contentSize = CGSizeMake(320, porh);
    self.sv.showsHorizontalScrollIndicator = NO;
    self.sv.showsVerticalScrollIndicator = NO;
        self.sv.clipsToBounds = NO;
    self.sv.scrollEnabled = NO;
        self.sv.bounces = YES;
  }
  
   //NSLog(@"IndexLicencias scrolview: W: %f, H: %f, X: %f, Y: %f", self.sv.frame.size.width, self.sv.frame.size.height, self.sv.frame.origin.x, self.sv.frame.origin.y);
}

- (void)orientationChanged:(NSNotification *)notification
{
  [self setViewFromOrientation];
}

- (void)viewDidUnload
{
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
  self.l1 = nil;
  self.l2 = nil;
  self.l3 = nil;
  self.l4 = nil;
  self.l5 = nil;
  self.l6 = nil;
  self.infoButtom = nil;
  self.infoView = nil;
  self.sv = nil;
  self.landscapeView = CGRectNull;
  
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  
  [super viewDidUnload];
}

- (void) showLic:(id)sender
{
  UIButton *button = (UIButton *)sender;
  //NSString *buttonTitle = button.currentTitle;
  
  NSString *filePath = @"l1";
  NSString *theTitle = @"CC By 2.5";

  if([button isEqual:self.l1])
  {
    filePath = @"l1";
    theTitle = @"CC By 2.5";
  }
  if([button isEqual:self.l2])
  {
    filePath = @"l2";    
    theTitle = @"CC By-ND 2.5";
  }
  if([button isEqual:self.l3])
  {
    filePath = @"l3";
    theTitle = @"CC By-NC-ND 2.5";
  }
  if([button isEqual:self.l4])
  {
    filePath = @"l4";
    theTitle = @"CC By-NC 2.5";
  }
  if([button isEqual:self.l5])
  {
    filePath = @"l5";
    theTitle = @"CC By-NC-SA 2.5";
  }
  if([button isEqual:self.l6])
  {
    filePath = @"l6";
    theTitle = @"CC By-SA 2.5";
  }
  
  LicenciaDetalleContainerViewController *wb = [[LicenciaDetalleContainerViewController alloc] initWithFpathAndTitle:filePath andTitle:theTitle];
  
  [self.navigationController pushViewController:wb animated:YES];
  [wb release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return YES;
  //Return YES for supported orientations
  //return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction) showAbout:(id)sender
{
  NSLog(@"Show info");
  
  if(self.infoView == nil)
  {
    InfoViewController *tinfoView = [[InfoViewController alloc] initWithNibName:(@"InfoViewController") bundle:nil];
    self.infoView = tinfoView;
    [tinfoView release];
  }
  
  [self.navigationController presentModalViewController:self.infoView animated:YES];
}

@end
