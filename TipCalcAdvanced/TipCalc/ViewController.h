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
    IBOutlet UILabel* percentLabel;
    IBOutlet UILabel* totalLabel;
    IBOutlet UISlider* slider;
    IBOutlet UITextField* billAmountField;
}

-(IBAction)tipPressed:(id)sender;
-(IBAction)tipSlider:(id)sender;
-(float)calculateTip:(float)billAmount withTip:(float)tipPercent;
-(void)fixBillAmount;
-(IBAction)textFieldReturn:(id)sender;
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

@end
