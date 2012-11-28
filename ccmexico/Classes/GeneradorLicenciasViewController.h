//
//  GeneradorLicenciasViewController.h
//  ccmexico
//
//  Created by Pau Ochoa on 08/06/11.
//  Copyright 2011 AD. All rights reserved.
//

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
