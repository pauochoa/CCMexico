//
//  IndexLicencias.h
//  ccmexico
//
//  Created by Pau Ochoa on 03/06/11.
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
