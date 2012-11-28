//
//  main.m
//  ccmexico
//
//  Created by Pau Ochoa on 26/05/11.
//  Copyright 2011 AD. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[])
{
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
  /*
  if ( [[NSUserDefaults standardUserDefaults] objectForKey:@"language"] == nil ) 
  {
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObject:@"es"] forKey:@"AppleLanguages"];
  } 
  else
  {
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"language"]] forKey:@"AppleLanguages"];
  }
    */
  
    
  
  int retVal = UIApplicationMain(argc, argv, nil, nil);
  [pool release];

  
  return retVal;
}
