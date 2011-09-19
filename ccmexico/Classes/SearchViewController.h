//
//  ResultadoLicenciaViewController.h
//  ccmexico
//
//  Created by Pau Ochoa on 13/06/11.
//  
//  Copyright (C) 2011  Paulino Ochoa/Alternativa Digital
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
//  Contact:
//  paulino@adigital.com.mx
//  @pau_ochoa


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
