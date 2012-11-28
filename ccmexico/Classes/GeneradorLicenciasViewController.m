//
//  GeneradorLicenciasViewController.m
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


#import "GeneradorLicenciasViewController.h"

static NSUInteger SECCION_USOCOMERCIAL = 0;
static NSUInteger SECCION_MODIFICACION = 1;
static NSUInteger SECCION_JURISDICCION = 2;
static NSUInteger SECCION_INFOADICIONAL = 3;
static NSUInteger SECCION_TIPOOBRA = 4;

@implementation GeneradorLicenciasViewController

@synthesize secc, secctitles, footerView4, dataValue, headerView1, headerView2, headerView3, headerView4, headerView5;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) 
  {
  }
  
  return self;
}

- (void)dealloc
{
  [secc release];
  [secctitles release];
  [dataValue release];
  //[footerView3 release];
  [footerView4 release];
  
  [headerView1 release];
  [headerView2 release];
  [headerView3 release];
  [headerView4 release];
  [headerView5 release];
  
  [super dealloc];
}

- (void)didReceiveMemoryWarning
{
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
  
  // Release any cached data, images, etc that aren't in use.
}

- (void) setRows
{
#pragma mark - View lifecycle
  
  // Set sections
  NSDictionary *sec1 = [NSDictionary dictionaryWithObjectsAndKeys: @"¿Permites el uso comercial de tu obra?", @"title", nil];
  NSDictionary *sec2 = [NSDictionary dictionaryWithObjectsAndKeys: @"¿Permites modificaciones de tu obra?", @"title", nil];
  NSDictionary *sec3 = [NSDictionary dictionaryWithObjectsAndKeys: @"Jurisdicción de tu licencia", @"title", nil];
  NSDictionary *sec4 = [NSDictionary dictionaryWithObjectsAndKeys: @"Información adicional", @"title", nil];
  NSDictionary *sec5 = [NSDictionary dictionaryWithObjectsAndKeys: @"Tipo de obra", @"title", nil];
  
  NSArray *tsectitles = [[NSArray alloc] initWithObjects:sec1, sec2, sec3, sec4, sec5, nil];
  self.secctitles = tsectitles;
  [tsectitles release];
  // necesary?
  
  // Set Rows for sections
  NSString *path = [[NSBundle mainBundle] pathForResource:@"glic" ofType:@"plist"];
  NSDictionary *secct = [[NSDictionary alloc] initWithContentsOfFile:path];
  NSArray *tsecc = [[NSArray alloc] initWithArray:[secct valueForKey:@"Root"]];
  [secct release];
  self.secc = tsecc;
  [tsecc release];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(orientationChanged:)
                                               name:UIDeviceOrientationDidChangeNotification
                                             object:nil];
}

- (void)viewDidUnload
{
  
  self.secc = nil;
  self.secctitles = nil;
  self.footerView4 = nil;
  
  self.headerView1 = nil;
  self.headerView2 = nil;
  self.headerView3 = nil;
  self.headerView4 = nil;
  self.headerView5 = nil;
  self.dataValue = nil;
  
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  // Return YES for supported orientations
  return YES;
  //return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView 
{
	// Number of sections is the number of regions
  return [self.secc count];
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section 
{  
  return [[self.secc objectAtIndex:section] count];
 	// Number of rows is the number of time zones in the region for the specified section
}
     
     - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
    {
      NSString *keyValue = [NSString stringWithFormat:@"s%u", [indexPath section]];
      NSIndexPath *storedIndex = [self.dataValue valueForKey:keyValue];
      
      NSArray *currentSectionData = [NSArray arrayWithArray:[self.secc objectAtIndex:indexPath.section]];
      NSDictionary *current = [NSDictionary dictionaryWithDictionary:[currentSectionData objectAtIndex:indexPath.row]];
      
      UIColor *colorBlack = [UIColor blackColor];
      UIColor *colorGray = [UIColor darkGrayColor];  
      
      /*
       static NSString *CellIdentifier = @"OpcionTableCellClassId";
       OpcionTableCellClass *cell = (OpcionTableCellClass *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
       if(cell == nil)
       {
       NSArray* topL = [[NSBundle mainBundle] loadNibNamed:@"OpcionTableCellClass" owner:self options:nil];
       for(id cObject in topL)
       {
       if([cObject isKindOfClass:[OpcionTableCellClass class]])
       {
       cell = (OpcionTableCellClass *) cObject;
       break;
       }
       }
       }
       */
      
      // -------
      static NSString *CellIdentifier = @"Cell";
      
      UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
      if (cell == nil) 
      {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
      }
      // -------
      for (UIView *tv in [cell subviews])
      {
        if([tv isKindOfClass:[UITextField class]])
        {
          [tv removeFromSuperview];
        }
      }
      
      if(indexPath.section == SECCION_INFOADICIONAL)
      {
        //[cell.descOption setFrame:CGRectZero];
        //[cell.titleOption setFrame:CGRectZero];
        //[cell.imgOption setFrame:CGRectZero];
        //cell.descOption.hidden = YES;
        //cell.titleOption.hidden = YES;
        //cell.imgOption.hidden = YES;
        //----
        cell.textLabel.hidden = YES;
        cell.detailTextLabel.hidden = YES;
        cell.imageView.hidden = YES;
        //----
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.userInteractionEnabled = YES;
        
        cell.textLabel.textColor = colorBlack;
        cell.detailTextLabel.textColor = colorBlack;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGRect ft = CGRectMake(15,5,cell.frame.size.width - 20 - 10, 30);
        UITextField *tf = [[UITextField alloc]  initWithFrame:ft];
        //UITextField *tf = [[UITextField alloc] init];
        
        tf.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        tf.adjustsFontSizeToFitWidth = YES;
        tf.textColor = [UIColor blackColor];
        
        tf.delegate = self;
        tf.backgroundColor = [UIColor whiteColor];
        tf.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
        tf.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support
        tf.textAlignment = UITextAlignmentLeft;
        
        tf.adjustsFontSizeToFitWidth = YES;
        tf.minimumFontSize = 6;
        tf.clearButtonMode = UITextFieldViewModeWhileEditing;//  UITextFieldViewModeNever; // no clear 'x' button to the right
        [tf setEnabled: YES];
        
        if(indexPath.row == 0)
        {
          tf.tag = indexPath.row + 1;
          tf.placeholder = [current objectForKey:@"title"];
          tf.text = [self.dataValue valueForKey:@"titulo"];
          tf.keyboardType = UIKeyboardTypeDefault;
          tf.returnKeyType = UIReturnKeyDefault;
        }
        // nombre
        if(indexPath.row == 1)
        {
          tf.tag = indexPath.row + 1;
          tf.placeholder = [current objectForKey:@"title"];
          tf.text = [self.dataValue valueForKey:@"nombre"];
          tf.keyboardType = UIKeyboardTypeDefault;
          tf.returnKeyType = UIReturnKeyDefault;
        }
        // url
        if(indexPath.row == 2)
        {
          tf.tag = indexPath.row + 1;
          tf.placeholder = [current objectForKey:@"title"];
          tf.text = [self.dataValue valueForKey:@"url"];
          tf.keyboardType = UIKeyboardTypeURL;
          tf.returnKeyType = UIReturnKeyDefault;
        }
        // urladicional
        if(indexPath.row == 3)
        {
          tf.tag = indexPath.row + 1;
          tf.placeholder = [current objectForKey:@"title"];
          tf.text = [self.dataValue valueForKey:@"urlfuente"];
          tf.keyboardType = UIKeyboardTypeURL;
          tf.returnKeyType = UIReturnKeyDefault;
        }
        // permisos
        if(indexPath.row == 4)
        {
          tf.tag = indexPath.row + 1;
          tf.placeholder = [current objectForKey:@"title"];
          tf.text = [self.dataValue valueForKey:@"permisos"];
          tf.keyboardType = UIKeyboardTypeURL;
          tf.returnKeyType = UIReturnKeyDefault;
        }
        
        [cell addSubview:tf];
        [tf release];
      }
      else
      {
        //cell.descOption.hidden = NO;
        //cell.titleOption.hidden = NO;
        //cell.imgOption.hidden = NO;
        //------
        cell.textLabel.hidden = NO;
        cell.detailTextLabel.hidden = NO;
        cell.imageView.hidden = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        
        //[cell setSelected:YES animated:YES];
        //cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        cell.textLabel.numberOfLines = 2;
        
        cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:9];
        cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
        //cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
        cell.detailTextLabel.numberOfLines = 4;
        
        //------
        cell.userInteractionEnabled = YES;
        
        // Stay in sync!
        if(storedIndex != nil)
        {
          if(indexPath.section == storedIndex.section && indexPath.row == storedIndex.row)
          {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            cell.textLabel.textColor = colorBlack;
            cell.detailTextLabel.textColor = colorBlack;
          }
          else
          {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.textColor = colorGray;
            cell.detailTextLabel.textColor = colorGray;
          }
        }
        else
        {
          cell.accessoryType = UITableViewCellAccessoryNone;
          cell.textLabel.textColor = colorGray;
          cell.detailTextLabel.textColor = colorGray;
        }
        
        // Sólo la sección 4 tiene "altos" distintos (tipo obra: video, imagen, texto, etc.)
        /*if(indexPath.section == SECCION_TIPOOBRA)
         {
         //[cell.descOption setFrame:CGRectZero];
         //[cell.titleOption setFrame:CGRectMake(40,1,217,38)];
         //[cell.imgOption setFrame:CGRectMake(3,5,30,30)];
         
         //cell.titleOption.text = [current objectForKey:@"title"];
         //cell.descOption.text = [current objectForKey:@"desc"];
         NSString *path = [[NSBundle mainBundle] pathForResource:[current objectForKey:@"img"] ofType:@"png"];
         UIImage *theImage = [UIImage imageWithContentsOfFile:path];
         //cell.imgOption.image = theImage;
         
         //------
         cell.textLabel.text = [current objectForKey:@"title"];
         cell.detailTextLabel.text = [current objectForKey:@"desc"];
         cell.imageView.image = theImage;
         //------
         }
         else
         {*/
        //[cell.descOption setFrame:CGRectMake(47, 19, 245, 38)];
        //[cell.titleOption setFrame:CGRectMake(47,2,245,16)];
        //[cell.imgOption setFrame:CGRectMake(3,10,40,40)];
        
        //cell.titleOption.text = [current objectForKey:@"title"];
        //cell.descOption.text = [current objectForKey:@"desc"];
        NSString *path = [[NSBundle mainBundle] pathForResource:[current objectForKey:@"img"] ofType:@"png"];
        UIImage *theImage = [UIImage imageWithContentsOfFile:path];
        //cell.imgOption.image = theImage;
        
        //------
        cell.textLabel.text = [current objectForKey:@"title"];
        cell.detailTextLabel.text = [current objectForKey:@"desc"];
        cell.imageView.image = theImage;
        //------
        
        //}
      }
      
      return cell;
    }
     
     - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
    {
      if(indexPath.section == SECCION_TIPOOBRA || indexPath.section == SECCION_INFOADICIONAL)
        return 40.0;
      else
        return 60.0;
    }
     
     - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
    {
      [tableView deselectRowAtIndexPath:indexPath animated:NO];
      
      NSString *keyValue = [NSString stringWithFormat:@"s%u", [indexPath section]];
      UIColor *colorBlack = [UIColor blackColor];
      UIColor *colorGray = [UIColor darkGrayColor];  
      
      /*
       Sólo aplica el mark selection cuando la sección no es info adicional
       */
      if([indexPath section] != SECCION_INFOADICIONAL)
      {
        /* 
         Es la primer selección sobre la sección/row?
         */
        if([self.dataValue valueForKey:keyValue] == nil)
        { 
          UITableViewCell *newCell = (UITableViewCell*) [tableView cellForRowAtIndexPath:indexPath];
          if(newCell.accessoryType == UITableViewCellAccessoryNone) 
          {
            newCell.accessoryType = UITableViewCellAccessoryCheckmark;
            newCell.textLabel.textColor = colorBlack;
            newCell.detailTextLabel.textColor = colorBlack;
            /*
             NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
             [self.dataValue setObject:(NSIndexPath *)oldIndexPath forKey:keyValue];
             */
            [self.dataValue setObject:(NSIndexPath *)indexPath forKey:keyValue];
          }
          
          return;
        }
        
        /*
         Es la misma selección sobre la sección/row
         */
        
        NSIndexPath *storedIndexTemp = [self.dataValue valueForKey:keyValue];
        NSIndexPath *storedIndex = [NSIndexPath indexPathForRow:storedIndexTemp.row inSection:storedIndexTemp.section];
        //NSIndexPath *storedIndex = [self.dataValue valueForKey:keyValue];
        
        if(storedIndex.section == indexPath.section && storedIndex.row == indexPath.row)
          return;
        /*
         Es una selección distinta
         */
        UITableViewCell *newCell = (UITableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        
        if(newCell.accessoryType == UITableViewCellAccessoryNone) 
        {
          newCell.accessoryType = UITableViewCellAccessoryCheckmark;
          newCell.textLabel.textColor = colorBlack;
          newCell.detailTextLabel.textColor = colorBlack;
          
          [self.dataValue setObject:(NSIndexPath *)indexPath forKey:keyValue];
        }
        
        UITableViewCell *oldCell = (UITableViewCell*)[tableView cellForRowAtIndexPath:storedIndex];
        
        if (oldCell.accessoryType == UITableViewCellAccessoryCheckmark) 
        {
          oldCell.accessoryType = UITableViewCellAccessoryNone;
          oldCell.textLabel.textColor = colorGray;
          oldCell.detailTextLabel.textColor = colorGray;
        }
      }
      
      /*
       Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'Invalid index path for use with UITableView.  Index paths passed to table view must contain exactly two indices specifying the section and row.  Please use the category on NSIndexPath in UITableView.h if possible.
       */
      return;
    }
    /*
     - (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section 
     {
     NSDictionary *td = [secctitles objectAtIndex:section];
     
     return [td valueForKey:@"title"];
     }
     */
     
     -(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
    {
      if(section == SECCION_USOCOMERCIAL)
        return 55.0f;
      return 45.0f;
    }
     
     
     - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
    {
      NSDictionary *td = [self.secctitles objectAtIndex:section];
      
      UIColor *ui = [UIColor colorWithRed:0.0f green:0.451f blue:0.0f alpha:1.0f];
      
      if(section == SECCION_USOCOMERCIAL)
      {
        if(self.headerView1 == nil)
        {
          UIView *theaderView1 = [[UIView alloc] initWithFrame:CGRectMake(10,5,300,55)];
          self.headerView1 = theaderView1;
          [theaderView1 release];
          
          self.headerView1.autoresizingMask = UIViewAutoresizingFlexibleWidth;
          self.headerView1.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
          
          UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(10,10,300,20)];
          lab1.autoresizingMask = UIViewAutoresizingFlexibleWidth;
          lab1.font = [UIFont systemFontOfSize:17];
          lab1.numberOfLines = 1;
          [lab1 setLineBreakMode:UILineBreakModeWordWrap];
          lab1.textAlignment = UITextAlignmentLeft;
          lab1.textColor = ui;
          lab1.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
          [lab1 setText:[td valueForKey:@"title"]];
          
          UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(10,35,300,15)];
          lab2.autoresizingMask = UIViewAutoresizingFlexibleWidth;
          lab2.font = [UIFont systemFontOfSize:12];
          lab2.numberOfLines = 1;
          [lab2 setLineBreakMode:UILineBreakModeWordWrap];
          lab2.textAlignment = UITextAlignmentLeft;
          lab2.textColor = ui;
          lab2.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
          [lab2 setText:@"Selecciona una opción"];
          
          [self.headerView1 addSubview:lab1];
          [self.headerView1 addSubview:lab2];
          
          [lab1 release];
          [lab2 release];
        }
        
        return self.headerView1;
      }
      
      if(section == SECCION_MODIFICACION)
      {
        if(self.headerView2 == nil)
        {
          UIView *theaderView2 = [[UIView alloc] initWithFrame:CGRectMake(10,5,300,45)];
          self.headerView2 = theaderView2;
          [theaderView2 release];
          self.headerView2.autoresizingMask = UIViewAutoresizingFlexibleWidth;
          self.headerView2.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
          
          UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,300,20)];
          lab1.autoresizingMask = UIViewAutoresizingFlexibleWidth;
          lab1.font = [UIFont systemFontOfSize:17];
          lab1.numberOfLines = 1;
          [lab1 setLineBreakMode:UILineBreakModeWordWrap];
          lab1.textAlignment = UITextAlignmentLeft;
          lab1.textColor = ui;
          lab1.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
          [lab1 setText:[td valueForKey:@"title"]];
          
          UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(10,25,300,15)];
          lab2.autoresizingMask = UIViewAutoresizingFlexibleWidth;
          lab2.font = [UIFont systemFontOfSize:12];
          lab2.numberOfLines = 1;
          [lab2 setLineBreakMode:UILineBreakModeWordWrap];
          lab2.textAlignment = UITextAlignmentLeft;
          lab2.textColor = ui;
          lab2.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
          [lab2 setText:@"Selecciona una opción"];
          
          [self.headerView2 addSubview:lab1];
          [self.headerView2 addSubview:lab2];
          
          [lab1 release];
          [lab2 release];
        }
        
        return self.headerView2;
      }
      
      if(section == SECCION_JURISDICCION)
      {
        if(self.headerView3 == nil)
        {
          UIView *theaderView3 = [[UIView alloc] initWithFrame:CGRectMake(10,5,300,45)];
          self.headerView3 = theaderView3;
          [theaderView3 release];
          
          self.headerView3.autoresizingMask = UIViewAutoresizingFlexibleWidth;
          self.headerView3.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
          
          UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,300,20)];
          lab1.autoresizingMask = UIViewAutoresizingFlexibleWidth;
          lab1.font = [UIFont systemFontOfSize:17];
          lab1.numberOfLines = 1;
          [lab1 setLineBreakMode:UILineBreakModeWordWrap];
          lab1.textAlignment = UITextAlignmentLeft;
          lab1.textColor = ui;
          lab1.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
          [lab1 setText:[td valueForKey:@"title"]];
          
          UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(10,25,300,15)];
          lab2.autoresizingMask = UIViewAutoresizingFlexibleWidth;
          lab2.font = [UIFont systemFontOfSize:12];
          lab2.numberOfLines = 1;
          [lab2 setLineBreakMode:UILineBreakModeWordWrap];
          lab2.textAlignment = UITextAlignmentLeft;
          lab2.textColor = ui;
          lab2.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
          [lab2 setText:@"Selecciona una opción"];
          
          [self.headerView3 addSubview:lab1];
          [self.headerView3 addSubview:lab2];
          
          [lab1 release];
          [lab2 release];
        }
        
        
        return self.headerView3;
      }
      
      if(section == SECCION_INFOADICIONAL)
      {
        if(self.headerView4 == nil)
        {
          UIView *theaderView4 = [[UIView alloc] initWithFrame:CGRectMake(10,5,300,45)];
          self.headerView4 = theaderView4;
          [theaderView4 release];
          self.headerView4.autoresizingMask = UIViewAutoresizingFlexibleWidth;
          self.headerView4.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
          
          UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,300,20)];
          lab1.autoresizingMask = UIViewAutoresizingFlexibleWidth;
          lab1.font = [UIFont systemFontOfSize:17];
          lab1.numberOfLines = 1;
          [lab1 setLineBreakMode:UILineBreakModeWordWrap];
          lab1.textAlignment = UITextAlignmentLeft;
          lab1.textColor = ui;
          lab1.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
          [lab1 setText:[td valueForKey:@"title"]];
          
          UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(10,25,300,15)];
          lab2.autoresizingMask = UIViewAutoresizingFlexibleWidth;
          lab2.font = [UIFont systemFontOfSize:12];
          lab2.numberOfLines = 2;
          [lab2 setLineBreakMode:UILineBreakModeWordWrap];
          lab2.textAlignment = UITextAlignmentLeft;
          lab2.textColor = ui;
          lab2.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
          [lab2 setText:@"Esta información es opcional."];
          
          [self.headerView4 addSubview:lab1];
          [self.headerView4 addSubview:lab2];
          
          [lab1 release];
          [lab2 release];
        }
        
        return self.headerView4;
      }
      
      if(section == SECCION_TIPOOBRA)
      {
        if(self.headerView5 == nil)
        {
          UIView *theaderView5 = [[UIView alloc] initWithFrame:CGRectMake(10,5,300,45)];
          self.headerView5 = theaderView5;
          [theaderView5 release];
          self.headerView5.autoresizingMask = UIViewAutoresizingFlexibleWidth;
          self.headerView5.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
          
          UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,300,20)];
          lab1.autoresizingMask = UIViewAutoresizingFlexibleWidth;
          lab1.font = [UIFont systemFontOfSize:17];
          lab1.numberOfLines = 1;
          [lab1 setLineBreakMode:UILineBreakModeWordWrap];
          lab1.textAlignment = UITextAlignmentLeft;
          lab1.textColor = ui;
          lab1.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
          [lab1 setText:[td valueForKey:@"title"]];
          
          UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(10,25,300,15)];
          lab2.autoresizingMask = UIViewAutoresizingFlexibleWidth;
          lab2.font = [UIFont systemFontOfSize:12];
          lab2.numberOfLines = 2;
          [lab2 setLineBreakMode:UILineBreakModeWordWrap];
          lab2.textAlignment = UITextAlignmentLeft;
          lab2.textColor = ui;
          lab2.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
          [lab2 setText:@"Esta información es opcional."];
          
          [self.headerView5 addSubview:lab1];
          [self.headerView5 addSubview:lab2];
          
          [lab1 release];
          [lab2 release];
        }
        
        return self.headerView5;
      }
      
      return nil;
    }
     
     - (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
    {
      /*
       if(section == SECCION_INFOADICIONAL)
       {
       footerView3 = [[UIView alloc] initWithFrame:CGRectMake(10,5,300,20)];
       footerView3.autoresizingMask = UIViewAutoresizingFlexibleWidth;
       UILabel *lab3 = [[UILabel alloc] initWithFrame:footerView3.frame];
       lab3.autoresizingMask = UIViewAutoresizingFlexibleWidth;
       lab3.font = [UIFont systemFontOfSize:11];
       lab3.numberOfLines = 1;
       lab3.textAlignment = UITextAlignmentCenter;
       lab3.textColor = [UIColor darkTextColor];
       lab3.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
       [lab3 setText:@"La información adicional es opcional"];
       
       [footerView3 addSubview:lab3];
       [lab3 release];
       
       return footerView3;
       }
       */
      if(section == SECCION_TIPOOBRA)
      {
        UIView *tfooterView4 = [[UIView alloc] initWithFrame:CGRectMake(5, 10, 300, 60)];
        self.footerView4 = tfooterView4;
        [tfooterView4 release];
        
        self.footerView4.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.footerView4.autoresizesSubviews = YES;
        /*
         UILabel *lab4 = [[UILabel alloc] initWithFrame:CGRectMake(10,3,300,20)];
         lab4.autoresizingMask = UIViewAutoresizingFlexibleWidth;
         lab4.font = [UIFont systemFontOfSize:11];
         lab4.numberOfLines = 1;
         lab4.textAlignment = UITextAlignmentCenter;
         lab4.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
         lab4.textColor = [UIColor darkTextColor];
         //lab4.backgroundColor = [UIColor yellowColor];
         [lab4 setText:@"Tipo de obra es opcional"];
         //UIButton *gLic = [[UIButton alloc] initWithFrame:CGRectMake(10,28,300,37)];
         */
        UIButton *gLic = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
        gLic.frame = CGRectMake(10,10,280,38);
        gLic.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        //[gLic setTitle:@"Generar" forState:UIControlStateNormal];
        [gLic setTitle:@"Generar" forState:UIControlStateNormal];
        [gLic.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [gLic setTitleColor: [UIColor colorWithRed:0.0f green:0.451f blue:0.0f alpha:1.0f] forState:UIControlStateNormal];
        [gLic setBackgroundColor:[UIColor colorWithRed:0.92f green:0.92f blue:0.92f alpha:1.0f]];
        [gLic setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        //[gLic setBackgroundColor:[UIColor blueColor]];
        //gLic.backgroundColor = [UIColor greenColor];
        //gLic.buttonType = [UIButton UIButtonTypeRoundedRect];
        
        //set action of the button
        [gLic addTarget:self action:@selector(doCon:) forControlEvents:UIControlEventTouchUpInside];
        
        //[footerView4 addSubview:lab4];
        [self.footerView4 addSubview:gLic];
        
        //NSLog(@"Boton frame log: %f, %f", gLic.frame.size.width, gLic.frame.size.height);
        
        //[lab4 release];
        [gLic release];
        
        return self.footerView4;
      }
      
      return nil;
    }
     
     - (void) doCon:(id)sender
    {
      // Revisamos valores
      
      NSMutableArray *err = [[NSMutableArray alloc] init];
      if([self.dataValue objectForKey:@"s0"] == nil)
      {
        NSDictionary *td = [self.secctitles objectAtIndex:SECCION_USOCOMERCIAL];
        [err addObject:[td valueForKey:@"title"]];
      }
      
      if([self.dataValue objectForKey:@"s1"] == nil)
      {
        NSDictionary *td = [self.secctitles objectAtIndex:SECCION_MODIFICACION];
        [err addObject:[td valueForKey:@"title"]];
      }
      
      if([self.dataValue objectForKey:@"s2"] == nil)
      {
        NSDictionary *td = [self.secctitles objectAtIndex:SECCION_JURISDICCION];
        [err addObject:[td valueForKey:@"title"]];
      }
      
      NSMutableString *errtxt = [NSMutableString stringWithString:@""];
      
      int i = 0;
      int j = 0;
      
      for(i = 0; i < [err count]; i++)
      {
        if([err objectAtIndex:i] == nil)
          continue;
        
        [errtxt appendString:(j++ > 0 ? @"," : @"")];
        [errtxt appendString:[err objectAtIndex:i]];
      }
      
      [err release];
      
      if([errtxt isEqualToString:@""])
      {
        ResultadoLicenciaViewController *rl = [[ResultadoLicenciaViewController alloc] initWithDataAndFrame:self.dataValue andFrame:[self.navigationController.visibleViewController.view frame]];
        
        rl.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:rl animated:YES];
        [rl release];
      }
      else
      {
        NSMutableString *mensaje = [NSMutableString stringWithString:@"Debes seleccionar una opción en "];
        [mensaje appendString:errtxt];
        
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Te faltan datos" message:mensaje delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        [alert show];
      }
      //OpcionTableCellClass *c = [tb cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:SECCION_INFOADICIONAL]];
      //NSLog(@"Generando: %@", dataValue);
      
      // Verificar que ya están los datos
      //NSLog(@"Go! s0: %@", [dataValue objectForKey:@"s0"]);
      //NSLog(@"Go! s1: %@", [dataValue objectForKey:@"s1"]);
      //NSLog(@"Go! s2: %@", [dataValue objectForKey:@"s2"]);
      //NSLog(@"Go! s4: %@", [dataValue objectForKey:@"s4"]);
      //NSLog(@"Para s3:");
      //NSLog(@"Titulo de la obra: %@", [dataValue objectForKey:@"titulo"]);
      //NSLog(@"Atributo: %@", [dataValue objectForKey:@"nombre"]);
      //NSLog(@"url: %@", [dataValue objectForKey:@"url"]);
      //NSLog(@"urlfuente: %@", [dataValue objectForKey:@"urlfuente"]);
      //NSLog(@"permisos: %@", [dataValue objectForKey:@"permisos"]);
    }
     
     -(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
    {
      
      if(section == SECCION_TIPOOBRA)
        return 90;
      /*
       if(section == SECCION_INFOADICIONAL)
       return 30;
       */
      return 0;
    }
     
     - (void)loadView
    {
      // Avoid memory leak
      NSMutableDictionary *tdataValue = [[NSMutableDictionary alloc] initWithObjectsAndKeys:nil, @"s0", nil, @"s1", nil, @"s2", nil, @"s3", @"", @"titulo",@"", @"nombre",@"", @"url",@"", @"urlfuente",@"", @"permisos", nil];
      self.dataValue = tdataValue;
      [tdataValue release];
      
      [self setRows];
      
      UITableView *tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]
                                                            style:UITableViewStyleGrouped];
      tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
      tableView.delegate = self;
      tableView.dataSource = self;
      tableView.backgroundColor = [UIColor colorWithRed:0.92f green:0.92f blue:0.92f alpha:1.0f];
      [tableView reloadData];
      
      self.view = tableView;
      
      [tableView release];
    }
     
     - (void)orientationChanged:(UIInterfaceOrientation)fromInterfaceOrientation
    {
    }
     
     - (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
    {
      
      UITableViewCell *textFieldCell = (UITableViewCell*)textField.superview;
      UITableView *tb =  (UITableView*) textFieldCell.superview;
      
      [tb scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(textField.tag - 1) inSection:SECCION_INFOADICIONAL] atScrollPosition: UITableViewScrollPositionTop  animated:YES];
      
      return YES;
    }
     
     - (BOOL)textFieldShouldEndEditing:(UITextField *)textField
    {
      NSString *ent4 = [NSString stringWithString:textField.text];  
      NSString *ent5 = [ent4 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
      
      if(textField.tag == 1)
      {
        if([ent5 length] > 0)
          [self.dataValue setObject:ent5 forKey:@"titulo"];
        else
          [self.dataValue removeObjectForKey:@"titulo"];
      }
      if(textField.tag == 2)
      {
        if([ent5 length] > 0)
          [self.dataValue setObject:ent5 forKey:@"nombre"];
        else
          [self.dataValue removeObjectForKey:@"nombre"];
      }
      if(textField.tag == 3)
      {
        if([ent5 length] > 0)
        {
          if([self checkUrl:ent5])
            [self.dataValue setObject:ent5 forKey:@"url"];
          else
          {
            UIAlertView *av = [[[UIAlertView alloc] initWithTitle:@"Error de captura"
                                                          message:@"Captura una URL válida, recuerda comenzar con http:// o https://"
                                                         delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
            [av show];
            
            
            ent4 = nil;
            ent5 = nil;
            
            return NO;
          }
        }
        else
          [self.dataValue removeObjectForKey:@"url"];
      }
      if(textField.tag == 4)
      {
        if([ent5 length] > 0)
        {
          if([self checkUrl:ent5])
            [self.dataValue setObject:ent5 forKey:@"urlfuente"];
          else
          {
            UIAlertView *av = [[[UIAlertView alloc] initWithTitle:@"Error de captura"
                                                          message:@"Captura una URL válida, recuerda comenzar con http:// o https://"
                                                         delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
            
            [av show];
            
            ent4 = nil;
            ent5 = nil;
            
            return NO;
          }
        }
        else
          [self.dataValue removeObjectForKey:@"urlfuente"];
      }
      if(textField.tag == 5)
      {
        if([ent5 length] > 0)
        {
          if([self checkUrl:ent5])
            [self.dataValue setObject:ent5 forKey:@"permisos"];
          else
          {
            UIAlertView *av = [[[UIAlertView alloc] initWithTitle:@"Error de captura"
                                                          message:@"Captura una URL válida, recuerda comenzar con http:// o https://"
                                                         delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
            
            [av show];
            
            ent4 = nil;
            ent5 = nil;
            
            return NO;
          }
        }
        else
          [self.dataValue removeObjectForKey:@"permisos"];
      }
      
      ent4 = nil;
      ent5 = nil;
      
      return YES;
    }
     
     - (BOOL)textFieldShouldReturn:(UITextField *)textField 
    {
      bool fDidResign = [textField resignFirstResponder];
      
      NSString *ent3 = [NSString stringWithString:textField.text];  
      NSString *ent2 = [ent3 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
      
      if(textField.tag == 1)
      {
        if([ent2 length] > 0)
          [self.dataValue setObject:ent2 forKey:@"titulo"];
        else
          [self.dataValue removeObjectForKey:@"titulo"];
      }
      if(textField.tag == 2)
      {
        if([ent2 length] > 0)
          [self.dataValue setObject:ent2 forKey:@"nombre"];
        else
          [self.dataValue removeObjectForKey:@"nombre"];
      }
      if(textField.tag == 3)
      {
        if([ent2 length] > 0)
          [self.dataValue setObject:ent2 forKey:@"url"];
        else
          [self.dataValue removeObjectForKey:@"url"];
      }
      if(textField.tag == 4)
      {
        if([ent2 length] > 0)
          [self.dataValue setObject:ent2 forKey:@"urlfuente"];
        else
          [self.dataValue removeObjectForKey:@"urlfuente"];
      }
      if(textField.tag == 5)
      {
        if([ent2 length] > 0)
          [self.dataValue setObject:ent2 forKey:@"permisos"];
        else
          [self.dataValue removeObjectForKey:@"permisos"];
      }
      
      ent2 = nil;
      ent3 = nil;
      
      return fDidResign;
    }
     
     - (BOOL) checkUrl:(NSString*)candidato
    {
      NSURL *candidateURL = [NSURL URLWithString:candidato];
      
      return candidateURL && candidateURL.scheme && candidateURL.host; 
    }
     
     @end