//
//  LicenciaDetalleContainerViewController.m
//  ccmexico
//
//  Created by Pau Ochoa on 15/06/11.
//  Copyright 2011 AD. All rights reserved.
//

#import "LicenciaDetalleContainerViewController.h"


@implementation LicenciaDetalleContainerViewController
@synthesize fpath, f1, f2, sc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithFpathAndTitle:(NSString *)filePath andTitle:(NSString*)theTitle
{
  self = [super initWithNibName:@"LicenciaDetalleContainerViewController" bundle:nil];
  
  if (self) 
  {
    //self.title = theTitle;
    self.fpath = filePath;
  }
  
  return self;
}

- (void)dealloc
{
  [fpath release];
  [f1 release];
  [f2 release];
  [sc release];
  
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
  
  selectedSegment = 0;
  [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(orientationChanged:)
                                               name:UIDeviceOrientationDidChangeNotification
                                             object:nil];
  
  LicenciaDetalle *tf1 = [[LicenciaDetalle alloc] initWithFpath:self.fpath];
  LicenciaDetalle *tf2 = [[LicenciaDetalle alloc] initWithFpath:[self.fpath stringByAppendingString:@"_legal"]];
  
  self.f1 = tf1;
  self.f2 = tf2;
  
  [tf1 release];
  [tf2 release];
  
  
  UISegmentedControl *tsc = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Resumen", @"Legal", nil]];
  self.sc = tsc;
  [tsc release];
  
  self.sc.autoresizingMask =  NO;
  self.sc.selectedSegmentIndex = selectedSegment;
  self.sc.segmentedControlStyle = UISegmentedControlStyleBar;
  //self.sc.tintColor = [UIColor ];
              
  [self.sc addTarget:self action:@selector(setLic:) forControlEvents:UIControlEventValueChanged];
  // Usada cuando se aplica el fade en el efecto
  f2.view.alpha = 0.0;
  [self.view addSubview:[f2 view]];
  [self.view addSubview:[f1 view]];
  
  self.navigationItem.titleView = sc;
}

- (void) setLic:(id)sender
{
  UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
  
  if(selectedSegment == segmentedControl.selectedSegmentIndex)
    return;
  
  selectedSegment = segmentedControl.selectedSegmentIndex;
  
  //[self toggleMainViews];
  [self showHideView];
}

- (void)showHideView
{
  if(selectedSegment == 0)
    self.f1.view.alpha = 0.0;
  else
    self.f2.view.alpha = 0.0;
  
  [UIView beginAnimations:@"ShowHideView" context:nil];
  [UIView setAnimationCurve:UIViewAnimationOptionCurveEaseInOut];
  [UIView setAnimationDuration:0.5];
  [UIView setAnimationDelegate:self];
  [UIView setAnimationDelay:0.0];
  [UIView setAnimationDidStopSelector:@selector(showHideDidStop:finished:context:)];
  
  // Make the animatable changes.
  if(selectedSegment == 0)
    self.f2.view.alpha = 0.0;
  else
    self.f1.view.alpha = 0.0;
    
  
  // Commit the changes and perform the animation.
  [UIView commitAnimations];
}

// Called at the end of the preceding animation.
- (void)showHideDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
  [UIView beginAnimations:@"ShowHideView2" context:nil];
  [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
  [UIView setAnimationDuration:0.5];
  [UIView setAnimationDelay:0.0];
  
  // Make the animatable changes.
  if(selectedSegment == 0)
    self.f1.view.alpha = 1.0;
  else
    self.f2.view.alpha = 1.0;
  
  [UIView commitAnimations];
}

- (void)toggleMainViews
{
  if(selectedSegment == 0)
    [self.f1.view setFrame:self.navigationController.visibleViewController.view.frame];
  else
    [self.f2.view setFrame:self.navigationController.visibleViewController.view.frame];
  
  [UIView transitionFromView:(selectedSegment == 0 ? self.f2.view : self.f1.view)
                      toView:(selectedSegment == 0 ? self.f1.view : self.f2.view)
                    duration:1.0
                     options:(selectedSegment == 0 ? UIViewAnimationOptionTransitionCurlUp :
                              UIViewAnimationOptionTransitionCurlDown)
                  completion:^(BOOL finished) {
                    if(finished){
                    }
                  }];
}

- (void)viewDidUnload
{
  self.fpath = nil;
  self.sc = nil;
  self.f1 = nil;
  self.f2 = nil;
  
  
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
  return YES;
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)orientationChanged:(NSNotification *)notification
{
}

@end
