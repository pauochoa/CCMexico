//
//  ResultadoLicenciaViewController.m
//  ccmexico
//
//  Created by Pau Ochoa on 13/06/11.
//  Copyright 2011 AD. All rights reserved.
//

#import "ResultadoLicenciaViewController.h"

@implementation ResultadoLicenciaViewController

@synthesize dataValue, iFrame, lics, titulolic, wv, tb, tools;

- (id) initWithDataAndFrame:(NSMutableDictionary *)data  andFrame:(CGRect)theFrame
{
    self = [super initWithNibName:@"ResultadoLicenciaViewController" bundle:nil];
    if (self)
    {
      self.dataValue = data;
      self.iFrame = theFrame;
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
  [dataValue release];
  iFrame = CGRectNull;
  [lics release];
  [titulolic release];
  [wv release];
  [tb release];
  [tools release];

  [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self.view setFrame:iFrame];
  self.wv.scalesPageToFit = YES;
  self.wv.delegate = self;
  
  [self getLicencia];
  [self startPage];
}


- (NSMutableString*) composeLic
{
  NSError *error = nil;
  NSString *path = [[NSBundle mainBundle] pathForResource:@"template" ofType:@"html"];
  NSMutableString *str = [[NSMutableString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
  
  
  NSString *licchicaentities = [NSString stringWithString:[[self.lics objectForKey:@"chica"] gtm_stringByEscapingForHTML] ];
  
  NSString *licgrandeentities = [NSString stringWithString:[[self.lics objectForKey:@"grande"] gtm_stringByEscapingForHTML] ];
  
  
  [str replaceOccurrencesOfString:@"__LICENCIA__" withString:self.titulolic options:NSLiteralSearch range:NSMakeRange(0, [str length])];
  [str replaceOccurrencesOfString:@"__LICCHICA__" withString:[self.lics objectForKey:@"chica"] options:NSLiteralSearch range:NSMakeRange(0, [str length])];
  //[str replaceOccurrencesOfString:@"__LICCHICATEXTO__" withString:[self.lics objectForKey:@"chica"] options:NSLiteralSearch range:NSMakeRange(0, [str length])];
  [str replaceOccurrencesOfString:@"__LICCHICATEXTO__" withString:licchicaentities options:NSLiteralSearch range:NSMakeRange(0, [str length])];
  [str replaceOccurrencesOfString:@"__LICGRANDE__" withString:[self.lics objectForKey:@"grande"] options:NSLiteralSearch range:NSMakeRange(0, [str length])];
  [str replaceOccurrencesOfString:@"__LICGRANDETEXTO__" withString:licgrandeentities options:NSLiteralSearch range:NSMakeRange(0, [str length])];
  [str replaceOccurrencesOfString:@"__HUMANO__" withString:[self.lics objectForKey:@"humano"] options:NSLiteralSearch range:NSMakeRange(0, [str length])];
  
  return [str autorelease];
}

- (void) startPage
{
  NSString *path = [[NSBundle mainBundle] pathForResource:@"template" ofType:@"html"];
  NSURL *baseURL = [NSURL fileURLWithPath:path];
  NSMutableString *str = [self composeLic];
  
  [self.wv loadHTMLString:str baseURL:baseURL];
}

- (void)viewDidUnload
{
  self.dataValue = nil;
  self.lics = nil;
  self.titulolic = nil;
  self.iFrame = CGRectNull;
  
  self.wv = nil;
  self.tb = nil;
  self.tools = nil;
  
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (void) viewWillAppear:(BOOL)animated
{
  /*
 NSLog(@"VIEW ANTES del setframe: %f, %f,%f,%f", self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
  
  CGRect frame = self.view.frame;
  frame.size.height += self.navigationController.tabBarController.tabBar.frame.size.height;
  //CGRect postab = self.navigationController.tabBarController.tabBar.frame;
  //NSLog(@"Frame tab bar: %f, %f,%f,%f", postab.origin.x, postab.origin.y, postab.size.width, postab.size.height);
  [self.view setFrame:frame];
  
  
  NSLog(@"VIEW despues del setframe: %f, %f,%f,%f", self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);

  [self.wv setFrame:frame];

   
  CGRect framesv = CGRectMake(0, frame.size.height, frame.size.width, 49);
  
  self.tb = [[UIToolbar alloc] initWithFrame:framesv];
  [self.view addSubview:self.tb];
  
  
  
  //[self.tb setFrame:framesv];
  
  
  NSLog(@"TOLBAR despues del setframe: %f, %f,%f,%f", self.tb.frame.origin.x, self.tb.frame.origin.y, self.tb.frame.size.width, self.tb.frame.size.height);

  
  
  //[self.view sizeThatFits:<#(CGSize)#>];
  */
  //[self.navigationController.tabBarController.tabBar setHidden:YES];
}

- (void) viewWillDisappear:(BOOL)animated
{
  //[self.navigationController.tabBarController.tabBar setHidden:NO];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return YES;
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) getLicencia
{
  NSString *path = [[NSBundle mainBundle] pathForResource:@"licencias" ofType:@"plist"];
  NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
  NSArray *secct = [dict objectForKey:@"Root"];

  // La que no tiene atributos
  NSString *HTML = [NSString stringWithString:@"<div style=\"text-align:center;\"><a rel=\"license\" href=\"__URLLICENCIA__\"><img alt=\"Licencia de Creative Commons\" style=\"border-width:0;\" src=\"__URLIMAGEN__\"/></a></div><br />Esta <span xmlns:dct=\"http://purl.org/dc/terms/\" href=\"http://purl.org/dc/dcmitype/StillImage\" rel=\"dct:type\">obra</span> está bajo una <a rel=\"license\" href=\"__URLLICENCIA__\">__NOMBRELICENCIA__</a>"];
  
  // La que tiene nombre y atributo by y link de atributo
  NSString *HTMLNOMBREATTRLINK = [NSString stringWithString:@"<div style=\"text-align:center;\"><a rel=\"license\" href=\"__URLLICENCIA__\"><img alt=\"Licencia de Creative Commons\" style=\"border-width:0;\" src=\"__URLIMAGEN__\"/></a></div><br /><span xmlns:dct=\"http://purl.org/dc/terms/\" href=\"http://purl.org/dc/dcmitype/StillImage\" rel=\"dct:type\">__NOMBRE__</span> by <a xmlns:cc=\"http://creativecommons.org/ns#\" href=\"__URLBY__\" property=\"cc:attributionName\" rel=\"cc:attributionURL\">__ATTR__</a> is licensed under a <a rel=\"license\" href=\"__URLLICENCIA__\">__NOMBRELICENCIA__</a>"];
  
  // La que tiene nombre solamente
  NSString *HTMLNOMBRE = [NSString stringWithString:@"<div style=\"text-align:center;\"><a rel=\"license\" href=\"__URLLICENCIA__\"><img alt=\"Licencia de Creative Commons\" style=\"border-width:0;\" src=\"__URLIMAGEN__\"/></a></div><br /><span xmlns:dct=\"http://purl.org/dc/terms/\" href=\"http://purl.org/dc/dcmitype/StillImage\" rel=\"dct:type\">__NOMBRE__</span> is licensed under a <a rel=\"license\" href=\"__URLLICENCIA__\">__NOMBRELICENCIA__</a>"];
  
  // La que tiene unicamente atributo
  NSString *HTMLATTR = [NSString stringWithString:@"<div style=\"text-align:center;\"><a rel=\"license\" href=\"__URLLICENCIA__\"><img alt=\"Licencia de Creative Commons\" style=\"border-width:0;\" src=\"__URLIMAGEN__\"/></a></div><br />This obra by <span xmlns:dct=\"http://purl.org/dc/terms/\" href=\"http://purl.org/dc/dcmitype/StillImage\" rel=\"dct:type\">__BY__</span> is licensed under a <a rel=\"license\" href=\"__URLLICENCIA__\">__NOMBRELICENCIA__</a>"];
  
  // La que tiene unicamente link de atributo
  NSString *HTMLLINKATTR = [NSString stringWithString:@"<div style=\"text-align:center;\"><a rel=\"license\" href=\"__URLLICENCIA__\"><img alt=\"Licencia de Creative Commons\" style=\"border-width:0;\" src=\"__URLIMAGEN__\"/></a></div><br />This obra by <a xmlns:cc=\"http://creativecommons.org/ns#\" href=\"__URLBY__\" property=\"cc:attributionName\" rel=\"cc:attributionURL\">__URLBY__</a> is licensed under a <a rel=\"license\" href=\"__URLLICENCIA__\">__NOMBRELICENCIA__</a>"];
  
  // La que tiene nombre y atributo by, SIN LINK
  NSString *HTMLNOMBREATTR = [NSString stringWithString:@"<div style=\"text-align:center;\"><a rel=\"license\" href=\"__URLLICENCIA__\"><img alt=\"Licencia de Creative Commons\" style=\"border-width:0;\" src=\"__URLIMAGEN__\"/></a></div><br /><span xmlns:dct=\"http://purl.org/dc/terms/\" href=\"http://purl.org/dc/dcmitype/StillImage\" rel=\"dct:type\">__NOMBRE__</span> by <span xmlns:dct=\"http://purl.org/dc/terms/\" href=\"http://purl.org/dc/dcmitype/StillImage\" rel=\"dct:type\">__ATTR__</span> is licensed under a <a rel=\"license\" href=\"__URLLICENCIA__\">__NOMBRELICENCIA__</a>"];
    
  // La que tiene nombre y link de atributo, SIN ATRIBUTO
  NSString *HTMLNOMBRELINK = [NSString stringWithString:@"<div style=\"text-align:center;\"><a rel=\"license\" href=\"__URLLICENCIA__\"><img alt=\"Licencia de Creative Commons\" style=\"border-width:0;\" src=\"__URLIMAGEN__\"/></a></div><br /><span xmlns:dct=\"http://purl.org/dc/terms/\" href=\"http://purl.org/dc/dcmitype/StillImage\" rel=\"dct:type\">__NOMBRE__</span> by <a xmlns:cc=\"http://creativecommons.org/ns#\" href=\"__URLBY__\" property=\"cc:attributionName\" rel=\"cc:attributionURL\">__URLBY__</a> is licensed under a <a rel=\"license\" href=\"__URLLICENCIA__\">__NOMBRELICENCIA__</a>"];

  // atributo y  link de atributo, SIN NOMBRE
  NSString *HTMLLINK = [NSString stringWithString:@"<div style=\"text-align:center;\"><a rel=\"license\" href=\"__URLLICENCIA__\"><img alt=\"Licencia de Creative Commons\" style=\"border-width:0;\" src=\"__URLIMAGEN__\"/></a></div><br />This obra by <a xmlns:cc=\"http://creativecommons.org/ns#\" href=\"__URLBY__\" property=\"cc:attributionName\" rel=\"cc:attributionURL\">__BY__</a> is licensed under a <a rel=\"license\" href=\"__URLLICENCIA__\">__NOMBRELICENCIA__</a>"];
  
  // Extra url fuente
  NSMutableString *HTMLEXTRA1 = [NSMutableString stringWithString:@"<br />Creado a partir de la obra en <a xmlns:dct=\"__URLFUENTE__\" href=\"dddd\" rel=\"dct:source\">__URLFUENTE__</a>."];
  
  // extra mas permisos
   NSMutableString *HTMLEXTRA2 = [NSMutableString stringWithString:@"<br />Permissions beyond the scope of this license may be available at <a xmlns:cc=\"http://creativecommons.org/ns#\" href=\"__URLPERMISOS__\" rel=\"cc:morePermissions\">__URLPERMISOS__</a>."];

  NSIndexPath *s0 = [dataValue objectForKey:@"s0"];
  NSIndexPath *s1 = [dataValue objectForKey:@"s1"];
  NSIndexPath *s2 = [dataValue objectForKey:@"s2"];
  
  NSDictionary* licdata;
  NSMutableString *licChica = [NSMutableString stringWithString:@""];
  NSMutableString *licGrande = [NSMutableString stringWithString:@""];
  
  // Seleccionó "Si" en "permite uso comercial"
  if(s0.row == 0)
  {
    // Seleccionó "Si" en "Permite hacer modificaciones"
    if(s1.row == 0)
    {
      // Lic = "By"
      licdata = [secct objectAtIndex:0];
    }
    // Seleccionó "Si, mientras se comparta de la misma" en "Permite hacer modificaciones"
    else if(s1.row == 1)
    {
      // Lic = "By-SA"
      licdata = [secct objectAtIndex:1];
    }
    // Seleccionó "No" en "Permite hacer modificaciones"
    else
    {
      // Lic = "By-ND"
      licdata = [secct objectAtIndex:2];
    }
  }
  // Selecciono "No" en "permite uso comercial"
  else
  {
    // Seleccionó "Si" en "Permite hacer modificaciones"
    if(s1.row == 0)
    {
      // Lic = "By-NC"
      licdata = [secct objectAtIndex:3];
    }
    // Seleccionó "Si, mientras se comparta de la misma" en "Permite hacer modificaciones"
    else if(s1.row == 1)
    {
      // Lic = "By-NC-SA"
      licdata = [secct objectAtIndex:4]; 
    }
    // Seleccionó "No" en "Permite hacer modificaciones"
    else
    {
      // Lic = "By-NC-ND"
     licdata = [secct objectAtIndex:5];
    }
  }
  
  if(licdata !=  nil)
  {
    // Todo nil
    if([dataValue objectForKey:@"titulo"] == nil && [dataValue objectForKey:@"nombre"] == nil && [dataValue objectForKey:@"url"] == nil)
    {
      licChica = [NSMutableString stringWithString:HTML];
      licGrande = [NSMutableString stringWithString:HTML];

      [licChica replaceOccurrencesOfString:@"__URLLICENCIA__" withString:([s2 row] == 0 ? [licdata objectForKey:@"urlint"] : [licdata objectForKey:@"urlmx"]) options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      [licChica replaceOccurrencesOfString:@"__URLIMAGEN__" withString:[licdata objectForKey:@"imgchica"] options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      [licChica replaceOccurrencesOfString:@"__NOMBRELICENCIA__" withString:([s2 row] == 0 ? [licdata objectForKey:@"nombreint"] : [licdata objectForKey:@"nombremx"]) options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      
      
      [licGrande replaceOccurrencesOfString:@"__URLLICENCIA__" withString:([s2 row] == 0 ? [licdata objectForKey:@"urlint"] : [licdata objectForKey:@"urlmx"]) options:NSLiteralSearch range:NSMakeRange(0, [licGrande length])];
      [licGrande replaceOccurrencesOfString:@"__URLIMAGEN__" withString:[licdata objectForKey:@"imggrande"] options:NSLiteralSearch range:NSMakeRange(0, [licGrande length])];
      [licGrande replaceOccurrencesOfString:@"__NOMBRELICENCIA__" withString:([s2 row] == 0 ? [licdata objectForKey:@"nombreint"] : [licdata objectForKey:@"nombremx"]) options:NSLiteralSearch range:NSMakeRange(0, [licGrande length])];
  
    }    
    // La que tiene nombre y atributo by y link de atributo
    else if([dataValue objectForKey:@"titulo"] != nil && [dataValue objectForKey:@"nombre"] != nil && [dataValue objectForKey:@"url"] != nil)
    {
      licChica = [NSMutableString stringWithString:HTMLNOMBREATTRLINK];
      licGrande = [NSMutableString stringWithString:HTMLNOMBREATTRLINK];
      
      /*
       
       // La que tiene nombre y atributo by y link de atributo
       NSString *HTMLNOMBREATTRLINK = [NSString stringWithString:@"<a rel=\"license\" href=\"__URLLICENCIA__\"><img alt=\"Licencia de Creative Commons\" style=\"border-width:0;\" src=\"__URLIMAGEN__\"/></a><br /><span xmlns:dct=\"http://purl.org/dc/terms/\" href=\"http://purl.org/dc/dcmitype/StillImage\" rel=\"dct:type\">__NOMBRE__</span> by <a xmlns:cc=\"http://creativecommons.org/ns#\" href=\"__URLBY__\" property=\"cc:attributionName\" rel=\"cc:attributionURL\">__ATTR__</a> is licensed under a <a rel=\"license\" href=\"__URLLICENCIA__\">__NOMBRELICENCIA__</a>"];
       */
      [licChica replaceOccurrencesOfString:@"__URLLICENCIA__" withString:([s2 row] == 0 ? [licdata objectForKey:@"urlint"] : [licdata objectForKey:@"urlmx"]) options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      [licChica replaceOccurrencesOfString:@"__URLIMAGEN__" withString:[licdata objectForKey:@"imgchica"] options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      [licChica replaceOccurrencesOfString:@"__NOMBRE__" withString:[dataValue objectForKey:@"titulo"] options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      [licChica replaceOccurrencesOfString:@"__URLBY__" withString:[dataValue objectForKey:@"url"] options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      [licChica replaceOccurrencesOfString:@"__ATTR__" withString:[dataValue objectForKey:@"nombre"] options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      [licChica replaceOccurrencesOfString:@"__NOMBRELICENCIA__" withString:([s2 row] == 0 ? [licdata objectForKey:@"nombreint"] : [licdata objectForKey:@"nombremx"]) options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      
      
      [licGrande replaceOccurrencesOfString:@"__URLLICENCIA__" withString:([s2 row] == 0 ? [licdata objectForKey:@"urlint"] : [licdata objectForKey:@"urlmx"]) options:NSLiteralSearch range:NSMakeRange(0, [licGrande length])];
      [licGrande replaceOccurrencesOfString:@"__URLIMAGEN__" withString:[licdata objectForKey:@"imggrande"] options:NSLiteralSearch range:NSMakeRange(0, [licGrande length])];
      [licGrande replaceOccurrencesOfString:@"__NOMBRE__" withString:[dataValue objectForKey:@"titulo"] options:NSLiteralSearch range:NSMakeRange(0, [licGrande length])];
      [licGrande replaceOccurrencesOfString:@"__URLBY__" withString:[dataValue objectForKey:@"url"] options:NSLiteralSearch range:NSMakeRange(0, [licGrande length])];
      [licGrande replaceOccurrencesOfString:@"__ATTR__" withString:[dataValue objectForKey:@"nombre"] options:NSLiteralSearch range:NSMakeRange(0, [licGrande length])];
      [licGrande replaceOccurrencesOfString:@"__NOMBRELICENCIA__" withString:([s2 row] == 0 ? [licdata objectForKey:@"nombreint"] : [licdata objectForKey:@"nombremx"]) options:NSLiteralSearch range:NSMakeRange(0, [licGrande length])];
    }
    
    // La que tiene nombre solamente
    else if([dataValue objectForKey:@"titulo"] != nil && [dataValue objectForKey:@"nombre"] == nil && [dataValue objectForKey:@"url"] == nil)
    {
      licChica = [NSMutableString stringWithString:HTMLNOMBRE];
      licGrande = [NSMutableString stringWithString:HTMLNOMBRE];
      
      
      /*
         NSString *HTMLNOMBRE = [NSString stringWithString:@"<a rel=\"license\" href=\"__URLLICENCIA__\"><img alt=\"Licencia de Creative Commons\" style=\"border-width:0;\" src=\"__URLIMAGEN__\"/></a><br /><span xmlns:dct=\"http://purl.org/dc/terms/\" href=\"http://purl.org/dc/dcmitype/StillImage\" rel=\"dct:type\">__NOMBRE__</span> is licensed under a <a rel=\"license\" href=\"__URLLICENCIA__\">__NOMBRELICENCIA__</a>"];
       
       */
      [licChica replaceOccurrencesOfString:@"__URLLICENCIA__" withString:([s2 row] == 0 ? [licdata objectForKey:@"urlint"] : [licdata objectForKey:@"urlmx"]) options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      [licChica replaceOccurrencesOfString:@"__URLIMAGEN__" withString:[licdata objectForKey:@"imgchica"] options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      [licChica replaceOccurrencesOfString:@"__NOMBRE__" withString:[dataValue objectForKey:@"titulo"] options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      [licChica replaceOccurrencesOfString:@"__NOMBRELICENCIA__" withString:([s2 row] == 0 ? [licdata objectForKey:@"nombreint"] : [licdata objectForKey:@"nombremx"]) options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];

      [licGrande replaceOccurrencesOfString:@"__URLLICENCIA__" withString:([s2 row] == 0 ? [licdata objectForKey:@"urlint"] : [licdata objectForKey:@"urlmx"]) options:NSLiteralSearch range:NSMakeRange(0, [licGrande length])];
      [licGrande replaceOccurrencesOfString:@"__URLIMAGEN__" withString:[licdata objectForKey:@"imggrande"] options:NSLiteralSearch range:NSMakeRange(0, [licGrande length])];
      [licGrande replaceOccurrencesOfString:@"__NOMBRE__" withString:[dataValue objectForKey:@"titulo"] options:NSLiteralSearch range:NSMakeRange(0, [licGrande length])];
      [licGrande replaceOccurrencesOfString:@"__NOMBRELICENCIA__" withString:([s2 row] == 0 ? [licdata objectForKey:@"nombreint"] : [licdata objectForKey:@"nombremx"]) options:NSLiteralSearch range:NSMakeRange(0, [licGrande length])];
    }
    // La que tiene unicamente  atributo
    else if([dataValue objectForKey:@"titulo"] == nil && [dataValue objectForKey:@"nombre"] != nil && [dataValue objectForKey:@"url"] == nil)
    {
      licChica = [NSMutableString stringWithString:HTMLATTR];
      licGrande = [NSMutableString stringWithString:HTMLATTR];
      
      [licChica replaceOccurrencesOfString:@"__URLLICENCIA__" withString:([s2 row] == 0 ? [licdata objectForKey:@"urlint"] : [licdata objectForKey:@"urlmx"]) options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      [licChica replaceOccurrencesOfString:@"__URLIMAGEN__" withString:[licdata objectForKey:@"imgchica"] options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      [licChica replaceOccurrencesOfString:@"__BY__" withString:[dataValue objectForKey:@"nombre"] options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      [licChica replaceOccurrencesOfString:@"__NOMBRELICENCIA__" withString:([s2 row] == 0 ? [licdata objectForKey:@"nombreint"] : [licdata objectForKey:@"nombremx"]) options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      
      
      [licGrande replaceOccurrencesOfString:@"__URLLICENCIA__" withString:([s2 row] == 0 ? [licdata objectForKey:@"urlint"] : [licdata objectForKey:@"urlmx"]) options:NSLiteralSearch range:NSMakeRange(0, [licGrande length])];
      [licGrande replaceOccurrencesOfString:@"__URLIMAGEN__" withString:[licdata objectForKey:@"imggrande"] options:NSLiteralSearch range:NSMakeRange(0, [licGrande length])];
      [licGrande replaceOccurrencesOfString:@"__BY__" withString:[dataValue objectForKey:@"nombre"] options:NSLiteralSearch range:NSMakeRange(0, [licGrande length])];
      [licGrande replaceOccurrencesOfString:@"__NOMBRELICENCIA__" withString:([s2 row] == 0 ? [licdata objectForKey:@"nombreint"] : [licdata objectForKey:@"nombremx"]) options:NSLiteralSearch range:NSMakeRange(0, [licGrande length])];
      
    }
    
    // link de atributo 
    else if([dataValue objectForKey:@"titulo"] == nil && [dataValue objectForKey:@"nombre"] == nil && [dataValue objectForKey:@"url"] != nil)
    {
      licChica = [NSMutableString stringWithString:HTMLLINKATTR];
      licGrande = [NSMutableString stringWithString:HTMLLINKATTR];
    
      [licChica replaceOccurrencesOfString:@"__URLLICENCIA__" withString:([s2 row] == 0 ? [licdata objectForKey:@"urlint"] : [licdata objectForKey:@"urlmx"]) options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      [licChica replaceOccurrencesOfString:@"__URLIMAGEN__" withString:[licdata objectForKey:@"imgchica"] options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      [licChica replaceOccurrencesOfString:@"__NOMBRE__" withString:[dataValue objectForKey:@"titulo"] options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      [licChica replaceOccurrencesOfString:@"__URLBY__" withString:[dataValue objectForKey:@"url"] options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      [licChica replaceOccurrencesOfString:@"__NOMBRELICENCIA__" withString:([s2 row] == 0 ? [licdata objectForKey:@"nombreint"] : [licdata objectForKey:@"nombremx"]) options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      
      [licGrande replaceOccurrencesOfString:@"__URLLICENCIA__" withString:([s2 row] == 0 ? [licdata objectForKey:@"urlint"] : [licdata objectForKey:@"urlmx"]) options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      [licGrande replaceOccurrencesOfString:@"__URLIMAGEN__" withString:[licdata objectForKey:@"imggrande"] options:NSLiteralSearch range:NSMakeRange(0, [licGrande length])];
      [licGrande replaceOccurrencesOfString:@"__URLBY__" withString:[dataValue objectForKey:@"url"] options:NSLiteralSearch range:NSMakeRange(0, [licGrande length])];
      [licGrande replaceOccurrencesOfString:@"__NOMBRELICENCIA__" withString:([s2 row] == 0 ? [licdata objectForKey:@"nombreint"] : [licdata objectForKey:@"nombremx"]) options:NSLiteralSearch range:NSMakeRange(0, [licGrande length])];
    }
    
    
    // La que tiene nombre y atributo by, sin link
    else if([dataValue objectForKey:@"titulo"] != nil && [dataValue objectForKey:@"nombre"] != nil && [dataValue objectForKey:@"url"] == nil)
    {
      licChica = [NSMutableString stringWithString:HTMLNOMBREATTR];
      licGrande = [NSMutableString stringWithString:HTMLNOMBREATTR];
    /*
     
     // La que tiene nombre y atributo by, SIN LINK
     NSString *HTMLNOMBREATTR = [NSString stringWithString:@"<div style=\"text-align:center;\"><a rel=\"license\" href=\"__URLLICENCIA__\"><img alt=\"Licencia de Creative Commons\" style=\"border-width:0;\" src=\"__URLIMAGEN__\"/></a></div><br /><span xmlns:dct=\"http://purl.org/dc/terms/\" href=\"http://purl.org/dc/dcmitype/StillImage\" rel=\"dct:type\">__NOMBRE__</span> by <span xmlns:dct=\"http://purl.org/dc/terms/\" href=\"http://purl.org/dc/dcmitype/StillImage\" rel=\"dct:type\">__ATTR__</span> is licensed under a <a rel=\"license\" href=\"__URLLICENCIA__\">__NOMBRELICENCIA__</a>"];
     
     */
      [licChica replaceOccurrencesOfString:@"__URLLICENCIA__" withString:([s2 row] == 0 ? [licdata objectForKey:@"urlint"] : [licdata objectForKey:@"urlmx"]) options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      [licChica replaceOccurrencesOfString:@"__URLIMAGEN__" withString:[licdata objectForKey:@"imgchica"] options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      [licChica replaceOccurrencesOfString:@"__NOMBRE__" withString:[dataValue objectForKey:@"titulo"] options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      [licChica replaceOccurrencesOfString:@"__ATTR__" withString:[dataValue objectForKey:@"nombre"] options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      [licChica replaceOccurrencesOfString:@"__NOMBRELICENCIA__" withString:([s2 row] == 0 ? [licdata objectForKey:@"nombreint"] : [licdata objectForKey:@"nombremx"]) options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      
      [licGrande replaceOccurrencesOfString:@"__URLLICENCIA__" withString:([s2 row] == 0 ? [licdata objectForKey:@"urlint"] : [licdata objectForKey:@"urlmx"]) options:NSLiteralSearch range:NSMakeRange(0, [licGrande length])];
      [licGrande replaceOccurrencesOfString:@"__URLIMAGEN__" withString:[licdata objectForKey:@"imggrande"] options:NSLiteralSearch range:NSMakeRange(0, [licGrande length])];
      [licGrande replaceOccurrencesOfString:@"__NOMBRE__" withString:[dataValue objectForKey:@"titulo"] options:NSLiteralSearch range:NSMakeRange(0, [licGrande length])];
      [licGrande replaceOccurrencesOfString:@"__ATTR__" withString:[dataValue objectForKey:@"nombre"] options:NSLiteralSearch range:NSMakeRange(0, [licGrande length])];
      [licGrande replaceOccurrencesOfString:@"__NOMBRELICENCIA__" withString:([s2 row] == 0 ? [licdata objectForKey:@"nombreint"] : [licdata objectForKey:@"nombremx"]) options:NSLiteralSearch range:NSMakeRange(0, [licGrande length])];
      
    }
       
    // La que tiene nombre y link de atributo
    else if([dataValue objectForKey:@"titulo"] != nil && [dataValue objectForKey:@"nombre"] == nil && [dataValue objectForKey:@"url"] != nil)
    {
      licChica = [NSMutableString stringWithString:HTMLNOMBRELINK];
      licGrande = [NSMutableString stringWithString:HTMLNOMBRELINK];
      
      [licChica replaceOccurrencesOfString:@"__URLLICENCIA__" withString:([s2 row] == 0 ? [licdata objectForKey:@"urlint"] : [licdata objectForKey:@"urlmx"]) options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      [licChica replaceOccurrencesOfString:@"__URLIMAGEN__" withString:[licdata objectForKey:@"imgchica"] options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      [licChica replaceOccurrencesOfString:@"__NOMBRE__" withString:[dataValue objectForKey:@"titulo"] options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      [licChica replaceOccurrencesOfString:@"__URLBY__" withString:[dataValue objectForKey:@"url"] options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      [licChica replaceOccurrencesOfString:@"__NOMBRELICENCIA__" withString:([s2 row] == 0 ? [licdata objectForKey:@"nombreint"] : [licdata objectForKey:@"nombremx"]) options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      
      
      [licGrande replaceOccurrencesOfString:@"__URLLICENCIA__" withString:([s2 row] == 0 ? [licdata objectForKey:@"urlint"] : [licdata objectForKey:@"urlmx"]) options:NSLiteralSearch range:NSMakeRange(0, [licGrande length])];
      [licGrande replaceOccurrencesOfString:@"__URLIMAGEN__" withString:[licdata objectForKey:@"imggrande"] options:NSLiteralSearch range:NSMakeRange(0, [licGrande length])];
      [licGrande replaceOccurrencesOfString:@"__NOMBRE__" withString:[dataValue objectForKey:@"titulo"] options:NSLiteralSearch range:NSMakeRange(0, [licGrande length])];
      [licGrande replaceOccurrencesOfString:@"__URLBY__" withString:[dataValue objectForKey:@"url"] options:NSLiteralSearch range:NSMakeRange(0, [licGrande length])];
      [licGrande replaceOccurrencesOfString:@"__NOMBRELICENCIA__" withString:([s2 row] == 0 ? [licdata objectForKey:@"nombreint"] : [licdata objectForKey:@"nombremx"]) options:NSLiteralSearch range:NSMakeRange(0, [licGrande length])];
    }
    // atributo y link
    else if([dataValue objectForKey:@"titulo"] == nil && [dataValue objectForKey:@"nombre"] != nil && [dataValue objectForKey:@"url"] != nil)
    {
      licChica = [NSMutableString stringWithString:HTMLLINK];
      licGrande = [NSMutableString stringWithString:HTMLLINK];
      
      [licChica replaceOccurrencesOfString:@"__URLLICENCIA__" withString:([s2 row] == 0 ? [licdata objectForKey:@"urlint"] : [licdata objectForKey:@"urlmx"]) options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      [licChica replaceOccurrencesOfString:@"__URLIMAGEN__" withString:[licdata objectForKey:@"imgchica"] options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      [licChica replaceOccurrencesOfString:@"__URLBY__" withString:[dataValue objectForKey:@"url"] options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      [licChica replaceOccurrencesOfString:@"__BY__" withString:[dataValue objectForKey:@"nombre"] options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      [licChica replaceOccurrencesOfString:@"__NOMBRELICENCIA__" withString:([s2 row] == 0 ? [licdata objectForKey:@"nombreint"] : [licdata objectForKey:@"nombremx"]) options:NSLiteralSearch range:NSMakeRange(0, [licChica length])];
      
      
      [licGrande replaceOccurrencesOfString:@"__URLLICENCIA__" withString:([s2 row] == 0 ? [licdata objectForKey:@"urlint"] : [licdata objectForKey:@"urlmx"]) options:NSLiteralSearch range:NSMakeRange(0, [licGrande length])];
      [licGrande replaceOccurrencesOfString:@"__URLIMAGEN__" withString:[licdata objectForKey:@"imggrande"] options:NSLiteralSearch range:NSMakeRange(0, [licGrande length])];
      [licGrande replaceOccurrencesOfString:@"__URLBY__" withString:[dataValue objectForKey:@"url"] options:NSLiteralSearch range:NSMakeRange(0, [licGrande length])];
      [licGrande replaceOccurrencesOfString:@"__BY__" withString:[dataValue objectForKey:@"nombre"] options:NSLiteralSearch range:NSMakeRange(0, [licGrande length])];
      [licGrande replaceOccurrencesOfString:@"__NOMBRELICENCIA__" withString:([s2 row] == 0 ? [licdata objectForKey:@"nombreint"] : [licdata objectForKey:@"nombremx"]) options:NSLiteralSearch range:NSMakeRange(0, [licGrande length])];
    }
    
    // Se agregan los extras...
    if(licChica != nil && licGrande != nil)
    {
      if([dataValue objectForKey:@"urlfuente"] != nil)
      {
        NSMutableString *HTMLEXTRA1_1 = [NSMutableString stringWithString:HTMLEXTRA1];
        
        [HTMLEXTRA1 replaceOccurrencesOfString:@"__URLFUENTE__" withString:[dataValue objectForKey:@"urlfuente"] options:NSLiteralSearch range:NSMakeRange(0, [HTMLEXTRA1 length])];

        [HTMLEXTRA1_1 replaceOccurrencesOfString:@"__URLFUENTE__" withString:[dataValue objectForKey:@"urlfuente"] options:NSLiteralSearch range:NSMakeRange(0, [HTMLEXTRA1_1 length])];

        [licChica appendString:HTMLEXTRA1];
        [licGrande appendString:HTMLEXTRA1_1];
      }
      
      if([dataValue objectForKey:@"permisos"] != nil)
      {
        
        NSMutableString *HTMLEXTRA2_1 = [NSMutableString stringWithString:HTMLEXTRA2];
        
        [HTMLEXTRA2 replaceOccurrencesOfString:@"__URLPERMISOS__" withString:[dataValue objectForKey:@"permisos"] options:NSLiteralSearch range:NSMakeRange(0, [HTMLEXTRA2 length])];
        
        [HTMLEXTRA2_1 replaceOccurrencesOfString:@"__URLPERMISOS__" withString:[dataValue objectForKey:@"permisos"] options:NSLiteralSearch range:NSMakeRange(0, [HTMLEXTRA2_1 length])];
        
        [licChica appendString:HTMLEXTRA2];
        [licGrande appendString:HTMLEXTRA2_1];
      }
    }
  }
  
  NSString *humano = [licdata objectForKey:@"humano"];
  
  NSDictionary *tlics = [[NSDictionary alloc] initWithObjectsAndKeys:licChica, @"chica", licGrande, @"grande", humano, @"humano", nil];
  self.lics = tlics;
  [tlics release];
  
  
  NSString *ttitulolic = [[NSString alloc] initWithString:([s2 row] == 0 ? [licdata objectForKey:@"nombreint"] : [licdata objectForKey:@"nombremx"])];
  self.titulolic = ttitulolic;
  [ttitulolic release];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType 
{
  if(navigationType == 5) 
    return YES;
  else
    return NO;
}

- (void) sendEmail:(id) sender
{
  if ([MFMailComposeViewController canSendMail]) 
  {
    NSString *subject = [NSString stringWithFormat:@"CC México - %@", self.titulolic];
    NSString *body = [NSString stringWithFormat:@"CC México - %@", [self composeLic]];
    
    MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
    mailViewController.mailComposeDelegate = self;
    [mailViewController setSubject:subject];
    [mailViewController setMessageBody:body isHTML:YES];
    
    [self presentModalViewController:mailViewController animated:YES];
    [mailViewController release];
  }
  else 
  {
    UIAlertView *av = [[[UIAlertView alloc] initWithTitle:@"No se puede enviar el correo"
                                                  message:@"Tu dispositivo no puede enviar correos electrónicos en este momento"
                                                 delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
    [av show];
  }
}


// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{   
  //message.hidden = NO;
  // Notifies users about errors associated with the interface
  switch (result)
  {
    case MFMailComposeResultCancelled:
      NSLog(@"Result: canceled");
      break;
    case MFMailComposeResultSaved:
       NSLog(@"Result: saved");
      break;
    case MFMailComposeResultSent:
      NSLog(@"Result: sent");
      break;
    case MFMailComposeResultFailed:
       NSLog(@"Result: failed");
      break;
    default:
       NSLog(@"Result: not sent");
      break;
  }
  
  [self dismissModalViewControllerAnimated:YES];
}

@end