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

// Called after the controller’s view is loaded into memory.
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

// Called when the user clicks outside of the keyboard area.
// Closes the keyboard, calls update to fix bill amount.
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Gets the information of a user's touch.
    UITouch *touch = [[event allTouches] anyObject];
    
    // Checks to see if the keyboard is not being touched.
    if ([billAmountField isFirstResponder] && [touch view] != billAmountField)
    {
        // Closes the keyboard if it was not touched.
        [billAmountField resignFirstResponder];
    }
    
    // Calls the parent touch event.
    [super touchesBegan:touches withEvent:event];
    
    // Fix the bill amount and bill display.
    [self fixBillAmount];
}

// Called when the user presses the return key.
// Closes the keyboard, calls update to fix bill amount.
- (IBAction)textFieldReturn:(id)sender
{
    // Closes the keyboard.
    [sender resignFirstResponder];
    
    // Fix the bill amount and bill display.
    [self fixBillAmount];
}

// Checks to see if the bill amount typed is valid.
// If not, then defaults to $0.00
- (void)fixBillAmount
{
    // Start with the set of digits 0 through 9.
    NSMutableCharacterSet* digits = [NSMutableCharacterSet decimalDigitCharacterSet];
    
    // Add the period character.
    [digits addCharactersInString:@"."];
    
    // Get all characters that are not a digit or a period.
    NSCharacterSet* notDigits = [digits invertedSet];
    
    // Check if the input string has a character that is not a digit or period.
    if ([billAmountField.text rangeOfCharacterFromSet:notDigits].location == NSNotFound)
    {
        // The input string consists only of the digits 0 through 9 and the period.
        // Updating the input to end in two decimal places.
        [billAmountField setText:[NSString stringWithFormat:@"%.02f", [billAmountField.text floatValue]]];
    }
    else
    {
        // The input string contains an illegal character.
        // Setting the input to the default $0.00.
        [billAmountField setText:@"0.00"];
    }
    
    // Retrieve the input bill amount and the current tip percentage.
    float billAmount = [billAmountField.text floatValue];
    float tipPercent = [percentLabel.text floatValue];
    
    // Get the tip, based on input and percent.
    float tempTip = [self calculateTip:billAmount withTip:tipPercent];
    
    // Get the total cost by taking the sum of bill and tip.
    float tempTotal = billAmount + tempTip;
    
    // Convert the tip and total costs to strings.
    NSString* tempTipString = [NSString stringWithFormat:@"$%.02f",tempTip];
    NSString* totalString = [NSString stringWithFormat:@"$%.02f",tempTotal];
    
    // Update the labels to display the updated values.
    [tipLabel setText:tempTipString];
    [totalLabel setText:totalString];
}

// Called before an out-of-memory crash.
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Called when one of the tip buttons are pressed.
// Calls update to calculate tip based on inputs.
-(IBAction)tipPressed:(id)sender
{
    // Closes the keyboard if it is opened.
    [billAmountField resignFirstResponder];
    
    // Get the input from the button pressed.
    float senderTipTag = ((UIButton*)sender).tag;
    
    // Pre-set a default tip amount.
    float tempTip = 0;
    
    // Fix the bill amount and bill display.
    [self fixBillAmount];
    
    // Retrieve the input bill amount.
    float billAmount = [billAmountField.text floatValue];
    
    // Check to see which input was retrieved.
    // Get the tip, based on input and percent.
    // Set the slider settings to match the input.
    if(senderTipTag==10)
    {
        tempTip = [self calculateTip:billAmount withTip:10];
        [ slider setValue:(10) ];
    }
    if(senderTipTag==15)
    {
        tempTip = [self calculateTip:billAmount withTip:15];
        [ slider setValue:(15) ];
    }
    if(senderTipTag==20)
    {
        tempTip = [self calculateTip:billAmount withTip:20];
        [ slider setValue:(20) ];
    }
    if(senderTipTag==25)
    {
        tempTip = [self calculateTip:billAmount withTip:25];
        [ slider setValue:(25) ];
    }
    
    // Get the total cost by taking the sum of bill and tip.
    float tempTotal = billAmount + tempTip;
    
    // Convert the tip, percent, and total costs to strings.
    NSString* tipPercentString = [NSString stringWithFormat:@"%.02f%%", senderTipTag];
    NSString* tempTipString = [NSString stringWithFormat:@"$%.02f",tempTip];
    NSString* totalString = [NSString stringWithFormat:@"$%.02f",tempTotal];
    
    // Update the labels to display the updated values.
    [percentLabel setText:tipPercentString];
    [tipLabel setText:tempTipString];
    [totalLabel setText:totalString];
}

// Called when one of the tip buttons are pressed.
// Calls update to calculate tip based on inputs.
- (IBAction)tipSlider:(id)sender
{
    // Closes the keyboard if it is opened.
    [billAmountField resignFirstResponder];
    
    // Retrieve the current tip percentage.
    float senderVal = ((UISlider*)sender).value;
    
    // Fix the bill amount and bill display.
    [self fixBillAmount];
    
    // Retrieve the input bill amount.
    float billAmount = [billAmountField.text floatValue];
    
    // Get the tip, based on input and percent.
    float tempTip = [self calculateTip:billAmount withTip:senderVal];
    
    // Get the total cost by taking the sum of bill and tip.
    float tempTotal = billAmount + tempTip;
    
    // Convert the tip, percent, and total costs to strings.
    NSString* tipPercentString = [NSString stringWithFormat:@"%.02f%%", senderVal];
    NSString* tempTipString = [NSString stringWithFormat:@"$%.02f",tempTip];
    NSString* totalString = [NSString stringWithFormat:@"$%.02f",tempTotal];
    
    // Update the labels to display the updated values.
    [percentLabel setText:tipPercentString];
    [tipLabel setText:tempTipString];
    [totalLabel setText:totalString];
}

// Called when the tip must be calculated.
// Calculates tip based on bill amount and button input.
-(float)calculateTip:(float)billAmount withTip:(float)tipPercent
{ return billAmount*(tipPercent/100.0); }


@end
