//
//  ResultadoLicenciaViewController.m
//  ccmexico
//
//  Created by Pau Ochoa on 13/06/11.
//  Copyright 2011 AD. All rights reserved.
//

#import "SearchViewController.h"


@implementation SearchViewController

@synthesize wv, tb, back, fixedSpace1, forward, flexibleSpace, reload, fixedSpace2, activity, fixedSpace3, ai, searchitem, searchController,searchEngine, searchOptionsView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) 
  {
    // Custom initialization
  }
  return self;
}

- (void)dealloc
{
  wv.delegate = nil;
  searchOptionsView.delegate = nil;
  searchController.delegate = nil;
  
  [wv release];
  [tb release];
  [back release];
  [forward release];
  [reload release];
  [ai release];
  [searchController release];
  [searchitem release];
  [searchOptionsView release];
  [searchEngine release];
  [activity release];
  
  [flexibleSpace release];
  [fixedSpace1 release];
  [fixedSpace2 release];
  [fixedSpace3 release];
  
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
  self.wv.scalesPageToFit = YES;
  self.wv.delegate = self;
  
  NSString *localpath = [[NSBundle mainBundle] pathForResource:@"search" ofType:@"html"];
  NSURL *baseURL = [NSURL fileURLWithPath:localpath];
  NSURLRequest *rq = [NSURLRequest requestWithURL:baseURL];
  [self.wv loadRequest:rq];
  
  localpath = nil;
  baseURL = nil;
  rq = nil;
  
  iEditing = NO;

  //NSURL *url = [NSURL URLWithString:@"http://search.creativecommons.org/"];
  //NSURLRequest *rq = [NSURLRequest requestWithURL:url];
  //[self.wv loadRequest:rq];
  
  [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
  
  // Descargar activity, se carga desde el xib?
  //[self.activity release];
  
  UIActivityIndicatorView *tai = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
  self.ai = tai;
  [tai release];
  
  UIBarButtonItem *tactivity = [[UIBarButtonItem alloc] initWithCustomView:ai];
  self.activity = tactivity;
  [tactivity release];
  
  UISearchBar *tsearchController = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 110, self.tb.frame.size.height)];
  self.searchController = tsearchController;
  [tsearchController release];
  
  self.searchController.barStyle = UIBarStyleBlackTranslucent;
  self.searchController.delegate = self;
  self.searchController.placeholder = @"Buscar";
  self.searchController.keyboardType = UIKeyboardTypeDefault;
  //searchController.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  self.searchController.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
  // Hack to force uisearch bar to get toolbar style... 
  for (UIView *view in self.searchController.subviews)
  {
    if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
    {
      [view removeFromSuperview];
      break;
    }
  }
  
  //[self.searchitem setCustomView:searchController];
  UIBarButtonItem *tsearchitem = [[UIBarButtonItem alloc] initWithCustomView:searchController];
  self.searchitem = tsearchitem;
  [tsearchitem release];
  
  // Init search engines
  currentOpt1 = 0;
  currentOpt2 = 0;
  currentEngine = 0;
  
  NSString *path = [[NSBundle mainBundle] pathForResource:@"engines" ofType:@"plist"];
  NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
  NSArray *tsearchEngine = [[NSArray alloc] initWithArray:[dic objectForKey:@"Root"]];
  self.searchEngine = tsearchEngine;
  [tsearchEngine release];
  path = nil;
  dic = nil;

  UITableView *tsearchOptionsView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
  self.searchOptionsView = tsearchOptionsView;
  [tsearchOptionsView release];
  
  self.searchOptionsView.delegate = self;
  self.searchOptionsView.dataSource = self;
  self.searchOptionsView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  
  NSArray *items = [[NSArray alloc] initWithObjects:self.back, self.fixedSpace1, self.forward, self.flexibleSpace, self.activity, self.fixedSpace2, self.reload, self.fixedSpace3, self.searchitem, nil];
  //[self.activity setCustomView:ai];  
  [self.tb setItems:items animated:NO];
  [items release];
}

- (void)viewDidUnload
{
  self.wv = nil;
  self.tb = nil;
  self.searchOptionsView = nil;
  self.back = nil;
  self.fixedSpace1 = nil;
  self.forward = nil;
  self.flexibleSpace = nil;
  self.activity = nil;
  self.fixedSpace2 = nil;
  self.reload = nil;
  self.fixedSpace3 = nil;
  self.searchitem = nil;
  
  self.searchController = nil;
  self.ai = nil;
  self.searchEngine = nil;
  
  [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return YES;
}

- (IBAction) goBack:(id)sender
{ 
  if(self.wv.canGoBack)
  {
    [self.wv goBack];
  }
}

- (IBAction) goForward:(id)sender
{
  if(self.wv.canGoForward)
  {
    [self.wv goForward];
  }
}

- (IBAction) doReload:(id)sender
{
  // Hay internet?
  if([self ifInternet] == NO)
  {
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Sin servicio" message:@"No hay internet" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    [alert show];
  }
  else
    [self.wv reload];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
  self.wv.scalesPageToFit = YES;
  
  self.back.enabled = self.wv.canGoBack ? YES : NO;
  self.forward.enabled = self.wv.canGoForward ? YES : NO;  
  
  [self.ai stopAnimating];

  self.reload.enabled = YES;
  
  [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
  [self.ai stopAnimating];
  self.reload.enabled = YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
  [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
 
  [self.ai startAnimating];
  self.reload.enabled = NO;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType 
{
  // Hay internet?
  if([self ifInternet] == NO)
  {
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Sin servicio" message:@"No hay internet, es posible que únicamente veas resultados en cache" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    [alert show];
    
    return NO;
  }

  return YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
  if (self.wv.loading) 
    [self.wv stopLoading];
  
  if(self.reload.enabled == NO)
    self.reload.enabled = YES;
  
  [self.ai stopAnimating];
  
  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
  [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
  
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) viewWillAppear:(BOOL)animated
{
  [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
  // El teclado
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

/*
 Table view results options
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView 
{
	// Number of sections is the number of regions
  return 2;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section 
{  
  
  if(section == 0)
  {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"filteroptions" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *soptions= [NSArray arrayWithArray:[dic objectForKey:@"Root"]];
  
    return [soptions count];
  }
  
  if(section == 1)
  {
    return [self.searchEngine count];
  }
  
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) 
  {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
  }
  
  cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
  if(indexPath.section == 0)
  {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"filteroptions" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *soptions= [NSArray arrayWithArray:[dic objectForKey:@"Root"]];
    
    cell.textLabel.text = [soptions objectAtIndex:indexPath.row];
    cell.imageView.image = nil;
    
    // Mark
    if(indexPath.row == 0)
    {
      cell.accessoryType = (currentOpt1 == 0 ? UITableViewCellAccessoryNone : UITableViewCellAccessoryCheckmark);
    }
    if(indexPath.row == 1)
    {
      cell.accessoryType = (currentOpt2 == 0 ? UITableViewCellAccessoryNone : UITableViewCellAccessoryCheckmark);
    }
  }
  else
  {
    NSDictionary *und = [self.searchEngine objectAtIndex:indexPath.row];
    cell.textLabel.text = [und objectForKey:@"name"];
    
    NSString *pathimg = [[NSBundle mainBundle] pathForResource:[und objectForKey:@"logo"] ofType:@"png"];
    UIImage *img = [UIImage imageWithContentsOfFile:pathimg];
    
    cell.imageView.image = img;
    
    if(currentEngine == indexPath.row)
      cell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
      cell.accessoryType = UITableViewCellAccessoryNone;
  }
  
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 30.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
  
  UITableViewCell *newCell = (UITableViewCell*) [tableView cellForRowAtIndexPath:indexPath];
  
  if(indexPath.section == 0)
  {
    if(indexPath.row == 0)
    {
      if(newCell.accessoryType == UITableViewCellAccessoryCheckmark)
      {
        newCell.accessoryType = UITableViewCellAccessoryNone;
        currentOpt1 = 0;
      }
      else
      {
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        currentOpt1 = 1;
      }
    }
    
    if(indexPath.row == 1)
    {
      if(newCell.accessoryType == UITableViewCellAccessoryCheckmark)
      {
        newCell.accessoryType = UITableViewCellAccessoryNone;
        currentOpt2 = 0;
      }
      else
      {
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        currentOpt2 = 1;
      }
    }
  }
  
  if(indexPath.section == 1)
  {
    if(currentEngine == indexPath.row)
      return;
    
    UITableViewCell *oldCell = (UITableViewCell*)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentEngine inSection:1]];
    
    if(newCell.accessoryType == UITableViewCellAccessoryNone)
    {
      newCell.accessoryType = UITableViewCellAccessoryCheckmark;
      currentEngine = indexPath.row;
    }
    
    if(oldCell.accessoryType == UITableViewCellAccessoryCheckmark)
      oldCell.accessoryType = UITableViewCellAccessoryNone;
  }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	NSString *sectionHeader = nil;
	
	if(section == 0) 
  {
		sectionHeader = @"Quiero algo para...";
	}
	if(section == 1) 
  {
		sectionHeader = @"Buscar en...";
	}

	return sectionHeader;
}

/*
 Search bar delegate
 */

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
  // Para que no se active el teclado cuando se use en las páginas interiores
  iEditing = YES;

  // Ocultar los botones de atrás/adelante
  [self setSizeSearchBar:NO];


  return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
  iEditing = NO;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
  iEditing = NO;
  
  if(self.searchOptionsView.superview != nil)
    [self.searchOptionsView removeFromSuperview];
  
  [self.searchController resignFirstResponder];
  
  [self setSizeSearchBar:YES];
}

- (BOOL) ifInternet
{
  //return YES;
  
  //Is there internet connection? current host reachable?
  Reachability *reachIn = [Reachability reachabilityForInternetConnection];
  NetworkStatus statIn = [reachIn currentReachabilityStatus];

  return statIn != NotReachable;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
  iEditing = NO;
  [searchController resignFirstResponder];
  
  if(self.searchOptionsView.superview != nil)
    [self.searchOptionsView removeFromSuperview];
  
  [self setSizeSearchBar:YES];
  
  // Hay internet?
  if([self ifInternet] == NO)
  {
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Sin servicio" message:@"No hay internet" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    [alert show];
    
    return;
  }
  
  NSString *ent = self.searchController.text;
  ent = [ent stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
  
  if([ent length] > 0)
  {
    // Generar query
    NSDictionary *selectedEngine = [self.searchEngine objectAtIndex:currentEngine];
    NSArray *URLengine = [selectedEngine objectForKey:@"options"];
    

    // Por defecto, buscar TODO sin selección
    int indexURL = 0; 
    if(currentOpt1 == 1 && currentOpt2 == 1)
      indexURL = 1;
    else if(currentOpt1 == 1 && currentOpt2 == 0)
      indexURL = 2;      
    else if(currentOpt1 == 0 && currentOpt2 == 1)
      indexURL = 3;
    
    NSDictionary *rawURLDirDic = [NSDictionary dictionaryWithDictionary:[URLengine objectAtIndex:indexURL]];
    NSMutableString *rawURLDir = [NSMutableString stringWithString:[rawURLDirDic objectForKey:@"query"]];
    
    // Generar url...
    [rawURLDir replaceOccurrencesOfString:@"__SEARCHTERM__" withString:ent options:NSLiteralSearch range:NSMakeRange(0, [rawURLDir length])];
    
    NSString *urlPre = [NSString stringWithFormat:@"%@%@",[selectedEngine objectForKey:@"urlbase"], rawURLDir];
    
    // URL Encode
    CFStringRef preprocessedString =
    CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)urlPre, CFSTR(""), kCFStringEncodingUTF8);
    NSString *urlFinal = (NSString*)
    CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, preprocessedString, NULL, NULL, kCFStringEncodingUTF8);
        
    NSURL *url = [NSURL URLWithString:urlFinal];
    NSURLRequest *rq = [NSURLRequest requestWithURL:url];
    
    CFRelease(preprocessedString);
    CFRelease(urlFinal);
    
    [self.wv loadRequest:rq];
  }
}

- (void) setSizeSearchBar:(BOOL)hide
{
  //UIBarButtonItem *searchContainer = (UIBarButtonItem*) [tb.items objectAtIndex:8];
  if(hide)
  {    
    //UIDevice *dev = [UIDevice currentDevice];
    //UIInterfaceOrientation interfaceOrientation = dev.orientation;
    UIInterfaceOrientation interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
    float whi = 110.f;
    
    if(UIInterfaceOrientationIsLandscape(interfaceOrientation))
    {
      whi = 165.0f;
    }
    if(UIInterfaceOrientationIsPortrait(interfaceOrientation))
    {
      whi = 110.0f;
    }
    
    [[self.searchitem customView] setBounds:CGRectMake(5, 0, whi, tb.frame.size.height)];
    [self.searchController setShowsCancelButton:NO animated:NO];
    
    NSArray *items = [NSArray arrayWithObjects:self.back, self.fixedSpace1, self.forward, self.flexibleSpace, self.activity, self.fixedSpace2, self.reload, self.fixedSpace3, self.searchitem, nil];
    [self.tb setItems:items animated:NO];
    items = nil;
    
    //searchController.showsScopeBar = NO;
    [self.searchController setShowsCancelButton:NO animated:NO];
    //[searchController sizeToFit]; 
  }
  else
  {
    CGSize point = [self.tb sizeThatFits:CGSizeZero];
    [[self.searchitem customView] setFrame:CGRectMake(0, 0, point.width - 17, point.height)];
    [self.searchController setShowsCancelButton:YES animated:NO];
    NSArray *items = [NSArray arrayWithObjects:self.searchitem, nil];
    [self.tb setItems:items animated:NO];
    items = nil;
  }
  
  /*
  UIBarButtonItem *searchContainer = (UIBarButtonItem*) [tb.items objectAtIndex:8];

  if(hide)
  {    
    UIDevice *dev = [UIDevice currentDevice];
    UIInterfaceOrientation interfaceOrientation = dev.orientation;
    float whi = 0.0f;
    
    if(UIInterfaceOrientationIsLandscape(interfaceOrientation))
      whi = 165.0f;
    if(UIInterfaceOrientationIsPortrait(interfaceOrientation))
      whi = 110.0f;
    
    [[searchContainer customView] setBounds:CGRectMake(5, 0, whi, tb.frame.size.height)];
    [searchController setShowsCancelButton:NO animated:NO];
  }
  else
  {
    CGSize point = [tb sizeThatFits:CGSizeZero];
    [[searchContainer customView] setBounds:CGRectMake(5, 0, point.width - 5, point.height)];
    [searchController setShowsCancelButton:YES animated:NO];
  }
   */
}

- (void)keyboardWillShow:(NSNotification *)note 
{
  // Ojo que esta función se manda llamar incluso cuando el teclado se ve, y además se cambia la orientación
  // Si cambio orientación y el teclado es visible => se oculta y se vuelve a mostrar
  if(iEditing == YES)
  {
    //UIDevice *dev = [UIDevice currentDevice];
    //UIInterfaceOrientation interfaceOrientation = dev.orientation;
    
    UIInterfaceOrientation interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
    NSDictionary *info = [NSDictionary dictionaryWithDictionary:[note userInfo]];
    NSValue *keyBounds = [info objectForKey:UIKeyboardBoundsUserInfoKey];
    CGRect bndKey;
    [keyBounds getValue:&bndKey];
  
    
    float height = 0.0f;
    if(UIInterfaceOrientationIsLandscape(interfaceOrientation))
    {
      height = 320 - tb.frame.size.height - bndKey.size.height;
    }
    if(UIInterfaceOrientationIsPortrait(interfaceOrientation))
    {
      height = 480 - tb.frame.size.height - bndKey.size.height;       
    }
    
    if(self.searchOptionsView.superview == nil)
    {
      [self.searchOptionsView setFrame:CGRectMake(0, tb.frame.size.height, bndKey.size.width, height)];
      [self.view addSubview:self.searchOptionsView];
    }
  } 
}

- (void)keyboardDidHide:(NSNotification *)note 
{
  // Para recalcular el alto de la tabla de opciones
  if(self.searchOptionsView.superview != nil)
    [self.searchOptionsView removeFromSuperview];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
}

@end