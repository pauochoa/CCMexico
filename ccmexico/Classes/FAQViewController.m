//
//  FAQViewController.m
//  ccmexico
//
//  Created by Pau Ochoa on 31/05/11.
//  Copyright 2011 AD. All rights reserved.
//

#import "FAQViewController.h"


@implementation FAQViewController

@synthesize faq;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
  [super dealloc];
  [faq release];
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
  [self.faq loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"faq" ofType:@"html"] isDirectory:NO]]];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
  self.faq = nil;

  [super viewDidUnload];
  // Release any retained subviews of the main view
  // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return YES;
  
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
