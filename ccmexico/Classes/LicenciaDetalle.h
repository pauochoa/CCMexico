//
//  LicenciaDetalle.h
//  ccmexico
//
//  Created by Pau Ochoa on 26/05/11.
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


@interface LicenciaDetalle : UIViewController  <UIScrollViewDelegate>
{
  UIWebView *wView;
  NSString *fpath;
}

@property (nonatomic, retain) IBOutlet UIWebView *wView;
@property (nonatomic, retain) NSString *fpath;

- (id)initWithFpath:(NSString *)filePath;

@end