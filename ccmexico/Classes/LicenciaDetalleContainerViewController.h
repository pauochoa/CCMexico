//
//  LicenciaDetalleContainerViewController.h
//  ccmexico
//
//  Created by Pau Ochoa on 15/06/11.
//  Copyright 2011 AD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LicenciaDetalle.h"

@interface LicenciaDetalleContainerViewController : UIViewController 
{
  NSString *fpath;
  
  // Human readable
  LicenciaDetalle *f1;
  // Legal! :D
  LicenciaDetalle *f2;
  
  UISegmentedControl *sc;
  NSInteger selectedSegment;
}

@property (nonatomic, retain) NSString *fpath;
@property (nonatomic, retain) UISegmentedControl *sc;
@property (nonatomic, retain) LicenciaDetalle* f1;
@property (nonatomic, retain) LicenciaDetalle* f2;

- (id)initWithFpathAndTitle:(NSString *)filePath andTitle:(NSString*)theTitle;
- (void)showHideView;
- (void)toggleMainViews;
@end
