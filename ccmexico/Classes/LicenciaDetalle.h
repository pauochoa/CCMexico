//
//  LicenciaDetalle.h
//  ccmexico
//
//  Created by Pau Ochoa on 26/05/11.
//  Copyright 2011 AD. All rights reserved.
//

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
