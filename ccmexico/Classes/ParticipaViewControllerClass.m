//
//  ParticipaViewControllerClass.m
//  ccmexico
//
//  Created by Pau Ochoa on 05/07/11.
//  Copyright 2011 AD. All rights reserved.
//

#import "ParticipaViewControllerClass.h"

@implementation ParticipaViewControllerClass

@synthesize fondo1, b;

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
  [fondo1 release];
  [b release];
  
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
  
  [self.fondo1.layer setCornerRadius:10.0f];
}

- (void)viewDidUnload
{
  self.fondo1 = nil;
  self.b = nil;
  
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
  return YES;
}


- (void) sendEmail:(id) sender
{
  if ([MFMailComposeViewController canSendMail]) 
  {
    NSString *subject = [NSString stringWithString:@"[CC México - Quiero participar]"];
    NSString *body = [NSString stringWithString:@"[Escribe tu propuesta]"];
    NSArray *toSend = [NSArray arrayWithObjects:@"pau8av@gmail.com",@"jorge.landa.b@gmail.com", nil];
    MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
    mailViewController.mailComposeDelegate = self;
    [mailViewController setSubject:subject];
    [mailViewController setMessageBody:body isHTML:YES];
    [mailViewController setToRecipients:toSend];
    
    [self presentModalViewController:mailViewController animated:YES];
    [mailViewController release];
  }
  else 
  {
    UIAlertView *av = [[[UIAlertView alloc] initWithTitle:@"No se puede enviar"
                                                  message:@"Tu dispositivo no puede enviar correos electrónicos en este momento"
                                                 delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
    [av show];
  }
}


// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{   
  //message.hidden = NO;
  // Notifies users about errors associated with the interface
  switch (result)
  {
    case MFMailComposeResultCancelled:
      NSLog(@"Result: canceled");
      break;
    case MFMailComposeResultSaved:
      NSLog(@"Result: saved");
      break;
    case MFMailComposeResultSent:
      NSLog(@"Result: sent");
      break;
    case MFMailComposeResultFailed:
      NSLog(@"Result: failed");
      break;
    default:
      NSLog(@"Result: not sent");
      break;
  }
  
  [self dismissModalViewControllerAnimated:YES];
}



@end
