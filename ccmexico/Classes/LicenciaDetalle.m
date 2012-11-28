//
//  LicenciaDetalle.m
//  ccmexico
//
//  Created by Pau Ochoa on 26/05/11.
//  Copyright 2011 AD. All rights reserved.
//

#import "LicenciaDetalle.h"


@implementation LicenciaDetalle

@synthesize wView, fpath;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
      // Custom initialization
    }
    return self;
}

- (id)initWithFpath:(NSString *)filePath
{
  self = [super initWithNibName:@"LicenciaDetalle" bundle:nil];
  if (self) 
  {
    self.fpath = filePath;
  }
  
  [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(orientationChanged:)
                                               name:UIDeviceOrientationDidChangeNotification
                                             object:nil];
  
  return self;
}

- (void)dealloc
{
  [super dealloc];
  
  [wView release];
  [fpath release];
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
  [self.wView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:self.fpath ofType:@"html"] isDirectory:NO]]];
  //self.view.autoresizesSubviews = YES;
}

- (void)viewDidUnload
{    
  self.wView = nil;
  self.fpath = nil;
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  
  [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return YES;
  // Return YES for supported orientations
  //return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)orientationChanged:(UIInterfaceOrientation)fromInterfaceOrientation
{
    //NSLog(@"Lic detalle: %f, H: %f, X: %f, Y: %f", self.view.frame.size.width, self.view.frame.size.height, self.view.frame.origin.x, self.view.frame.origin.y);
}

@end
