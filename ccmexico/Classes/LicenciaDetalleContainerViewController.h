//
//  LicenciaDetalleContainerViewController.h
//  ccmexico
//
//  Created by Pau Ochoa on 15/06/11.
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
