//
//  GeneradorLicenciasViewController.h
//  ccmexico
//
//  Created by Pau Ochoa on 08/06/11.
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
#import "ResultadoLicenciaViewController.h"

@interface GeneradorLicenciasViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
  // Number of sections
  NSArray *secctitles;
  NSArray *secc;
  //UIView *footerView3;
  UIView *footerView4;
  
  UIView *headerView1;
  UIView *headerView2;
  UIView *headerView3;
  UIView *headerView4;
  UIView *headerView5;
  
  NSMutableDictionary *dataValue;
}

@property (nonatomic, retain) NSArray *secc;
@property (nonatomic, retain) NSArray *secctitles;
//@property (nonatomic, retain) UIView *footerView3;
@property (nonatomic, retain) UIView *footerView4;

@property (nonatomic, retain) UIView *headerView1;
@property (nonatomic, retain) UIView *headerView2;
@property (nonatomic, retain) UIView *headerView3;
@property (nonatomic, retain) UIView *headerView4;
@property (nonatomic, retain) UIView *headerView5;
@property (nonatomic, retain) NSMutableDictionary *dataValue;
- (BOOL) checkUrl:(NSString*)candidato;
@end
