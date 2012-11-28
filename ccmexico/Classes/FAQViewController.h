//
//  FAQViewController.h
//  ccmexico
//
//  Created by Pau Ochoa on 31/05/11.
//  Copyright 2011 AD. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FAQViewController : UIViewController {
  UIWebView *faq;
}

@property (nonatomic, retain) IBOutlet UIWebView *faq;

@end
