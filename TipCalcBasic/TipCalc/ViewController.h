//
//  ViewController.h
//  TipCalc
//
//  Created by Matthew Prockup on 5/12/14.
//  Copyright (c) 2014 Matthew Prockup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    IBOutlet UILabel* tipLabel;
    IBOutlet UILabel* totalLabel;
    IBOutlet UITextField* billAmountField;
    
}

-(IBAction)tipPressed:(id)sender;
-(float)calculateTip:(float)billAmount withTip:(int)tipPercent;

@end
