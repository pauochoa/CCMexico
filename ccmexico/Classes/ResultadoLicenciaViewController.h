//
//  ResultadoLicenciaViewController.h
//  ccmexico
//
//  Created by Pau Ochoa on 13/06/11.
//  Copyright 2011 AD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "GTMNSString+HTML.h"

@interface ResultadoLicenciaViewController : UIViewController <UIWebViewDelegate,MFMailComposeViewControllerDelegate>
{
  NSMutableDictionary *dataValue; 
  CGRect iFrame;
  NSDictionary *lics;
  NSString *titulolic;

  UIToolbar *tb;
  UIBarButtonItem *tools;
}

@property (nonatomic, retain) NSMutableDictionary *dataValue;
@property (nonatomic, retain) NSDictionary *lics;
@property (nonatomic, retain) NSString *titulolic;
@property (nonatomic) CGRect iFrame;


@property (nonatomic, retain) IBOutlet UIWebView *wv;
@property (nonatomic, retain) IBOutlet UIToolbar *tb;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *tools;


- (id) initWithDataAndFrame:(NSMutableDictionary *)data  andFrame:(CGRect)theFrame;
- (void) getLicencia;
- (void) startPage;
- (IBAction) sendEmail:(id) sender;

@end
