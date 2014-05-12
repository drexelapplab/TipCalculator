//
//  ViewController.m
//  TipCalc
//
//  Created by Matthew Prockup on 5/12/14.
//  Copyright (c) 2014 Matthew Prockup. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)tipPressed:(id)sender
{
    [self.view endEditing:YES];
    int senderTipTag = ((UIButton*)sender).tag;
    float tempTip = 0;
    float billAmount = [billAmountField.text floatValue];
    if(senderTipTag==10)
    {
        tempTip = [self calculateTip:billAmount withTip:10];
    }
    if(senderTipTag==15)
    {
        tempTip = [self calculateTip:billAmount withTip:15];
    }
    if(senderTipTag==20)
    {
        tempTip = [self calculateTip:billAmount withTip:20];
    }
    if(senderTipTag==25)
    {
        tempTip = [self calculateTip:billAmount withTip:25];
    }
    
    float tempTotal = billAmount + tempTip;
    
    //Labels need string
    NSString* tempTipString = [NSString stringWithFormat:@"$%.02f",tempTip];
    NSString* totalString = [NSString stringWithFormat:@"$%.02f",tempTotal];
    
    [tipLabel setText:tempTipString];
    [totalLabel setText:totalString];
    
    
}

-(float)calculateTip:(float)billAmount withTip:(int)tipPercent
{
    float tip = 0;
    tip = billAmount*(tipPercent/100.0);
    return tip;
}


@end
