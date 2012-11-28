//
//  IndexLicencias.h
//  ccmexico
//
//  Created by Pau Ochoa on 03/06/11.
//  Copyright 2011 AD. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "CWebView.h"
#import "LicenciaDetalleContainerViewController.h"
#import "InfoViewController.h"

@interface IndexLicencias : UIViewController 
{
  UIView *l1;
  UIView *l2;
  UIView *l3;
  UIView *l4;
  UIView *l5;
  UIView *l6;
  UIScrollView *sv;
  
  UIBarButtonItem *infoButtom;
  
  CGRect landscapeSize;
  
  InfoViewController *infoView;
  
  //BOOL isShowingLandscapeView;
}

@property (nonatomic, retain) IBOutlet UIView *l1;
@property (nonatomic, retain) IBOutlet UIView *l2;
@property (nonatomic, retain) IBOutlet UIView *l3;
@property (nonatomic, retain) IBOutlet UIView *l4;
@property (nonatomic, retain) IBOutlet UIView *l5;
@property (nonatomic, retain) IBOutlet UIView *l6;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *infoButtom;
@property (nonatomic, retain) InfoViewController *infoView;

@property CGRect landscapeView;

@property (nonatomic, retain) IBOutlet UIScrollView *sv;

- (IBAction) showLic:(id)sender;
- (void) setViewFromOrientation;
- (IBAction) showAbout:(id)sender;

@end
