//
//  ResultadoLicenciaViewController.h
//  ccmexico
//
//  Created by Pau Ochoa on 13/06/11.
//  Copyright 2011 AD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface SearchViewController : UIViewController <UIWebViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate>
{
  UIWebView *wv;
  UIToolbar *tb;
  
  UIBarButtonItem *back;
  UIBarButtonItem *fixedSpace1;
  UIBarButtonItem *forward;
  UIBarButtonItem *flexibleSpace;
  UIBarButtonItem *activity;
  UIBarButtonItem *fixedSpace2;
  UIBarButtonItem *reload;
  UIBarButtonItem *fixedSpace3;
  UIBarButtonItem *searchitem;
  
  UIActivityIndicatorView *ai;
  
  //UISearchBar *search;
  UISearchBar *searchController;
  UITableView *searchOptionsView;
  
  BOOL iEditing;
  
  NSArray *searchEngine;
  
  NSInteger currentEngine;
  NSInteger currentOpt1;
  NSInteger currentOpt2;
}

@property (nonatomic, retain) IBOutlet UIWebView *wv;
@property (nonatomic, retain) IBOutlet UIToolbar *tb;
@property (nonatomic, retain) IBOutlet UITableView *searchOptionsView;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *back;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *fixedSpace1;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *forward;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *flexibleSpace;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *activity;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *fixedSpace2;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *reload;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *fixedSpace3;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *searchitem;

@property (nonatomic, retain) UISearchBar *searchController;
@property (nonatomic, retain) UIActivityIndicatorView *ai;
@property (nonatomic, retain) NSArray *searchEngine;

- (IBAction) goBack:(id)sender;
- (IBAction) goForward:(id)sender;
- (IBAction) doReload:(id)sender;
- (void) setSizeSearchBar:(BOOL)hide;
- (BOOL) ifInternet;

@end
