//
//  AppDelegate.m
//  DConverter
//
//  Created by Janis Böhm on 23/08/15.
//  Copyright (c) 2015 Janis Böhm. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

@synthesize textField;
@synthesize pullMenu;
@synthesize resultField;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [pullMenu removeAllItems];
    [pullMenu addItemWithTitle:@"ASCII to Decimal"];
    [pullMenu addItemWithTitle:@"Decimal to ASCII"];
    [pullMenu addItemWithTitle:@"ASCII to Hexadecimal"];
    [pullMenu addItemWithTitle:@"Hexadecimal to ASCII"];
    [pullMenu addItemWithTitle:@"ASCII to Binary"];
    [pullMenu addItemWithTitle:@"Binary to ASCII"];
    
    [resultField setFont:[NSFont fontWithName:@"Menlo Regular" size:13.0f]];
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

-(BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return true;
}

-(BOOL)ASCIIToDecimal {
    
    NSString* msg = [[NSString alloc] initWithString:[textField stringValue]];
    NSString* result = [[NSString alloc] init];
    unsigned int c = [msg characterAtIndex:0];
    
    if (c < 99) result = [NSString stringWithFormat:@" %d", (char)[msg characterAtIndex:0]];
        else result = [NSString stringWithFormat:@"%d", (char)[msg characterAtIndex:0]];
    
    for (int i=1; i < [msg length]; i++) {
        c = [msg characterAtIndex:i];
        if (c < 100) result = [NSString stringWithFormat:@"%@  %u", result, c];
            else result = [NSString stringWithFormat:@"%@ %u", result, c];
    }
    
    [resultField setString:result];
    return true;
}

-(BOOL)DecimalToASCII {
    
    NSCharacterSet* whitespaces = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString* msg = [[NSString alloc] initWithString:[textField stringValue]];
    NSArray* msg_separated = [msg componentsSeparatedByCharactersInSet:whitespaces];
    NSString* result = @"";
    
    for (int i=0; i < [msg_separated count]; i++) result = [NSString stringWithFormat:@"%@%c",result ,[[msg_separated objectAtIndex:i] intValue]];

    [resultField setString:result];
    return true;
}

-(BOOL)ASCIIToHexadecimal {
    
    NSString* msg = [[NSString alloc] initWithString:[textField stringValue]];
    NSString* result = [[NSString alloc] init];
    
    result = [NSString stringWithFormat:@"%x", (char)[msg characterAtIndex:0]];
    
    for (int i=1; i < [msg length]; i++) {
        unsigned int c = [msg characterAtIndex:i];
        result = [NSString stringWithFormat:@"%@ ", result];
        
        
        
        if (c < 16) result = [NSString stringWithFormat:@"%@  %x", result, (char)[msg characterAtIndex:i]];
            else result = [NSString stringWithFormat:@"%@ %x", result, (char)[msg characterAtIndex:i]];
    }
    
    [resultField setString:result];
    return true;
}

-(BOOL)HexadecimalToASCII {
    
    NSCharacterSet* whitespaces = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString* msg = [[NSString alloc] initWithString:[textField stringValue]];
    NSArray* msg_separated = [msg componentsSeparatedByCharactersInSet:whitespaces];
    NSString* result = @"";
    unsigned long b;
    
    for (int i=0; i < [msg_separated count]; i++) {
        
        b = strtol([[msg_separated objectAtIndex:i] UTF8String], NULL, 16);
        result = [NSString stringWithFormat:@"%@%c",result ,(int)b];
        
    }
    
    [resultField setString:result];
    return true;
}

-(BOOL)ASCIIToBinary {
    
    NSString* msg = [[NSString alloc] initWithString:[textField stringValue]];
    NSString* result = @"";
    const char* c;
    
    for (int i=0; i < [msg length]; i++) {
        int k = 128;
        
        for (int j=0; j<8; j++)
        {
            c = (([msg characterAtIndex:i] & k) == k) ? "1" : "0";
            result = [NSString stringWithFormat:@"%@%s", result, c];
            k >>= 1;
        }
        
        result = [NSString stringWithFormat:@"%@ ", result];
        
    }
    
    [resultField setString:result];
    return true;
}

-(BOOL)BinaryToASCII {
    
    NSCharacterSet* whitespaces = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString* msg = [[NSString alloc] initWithString:[textField stringValue]];
    NSArray* msg_separated = [msg componentsSeparatedByCharactersInSet:whitespaces];
    NSString* result = @"";
    unsigned long b;
    
    for (int i=0; i < [msg_separated count]; i++) {
        
        const char* c = [[msg_separated objectAtIndex:i] UTF8String];
        char* p = NULL;
        b = strtol(c, &p, 2);
        
        if (p != c + strlen(c)) {
            NSLog(@"Error: string not a number");
            return false;
        }
        
        result = [NSString stringWithFormat:@"%@%c",result ,(int)b];
        
    }
    
    [resultField setString:result];
    return true;
}

- (IBAction)convert:(id)sender {
    
    if ([[pullMenu titleOfSelectedItem]  isEqual: @"ASCII to Decimal"]) [self ASCIIToDecimal];
    
    if ([[pullMenu titleOfSelectedItem]  isEqual: @"Decimal to ASCII"]) [self DecimalToASCII];
    
    if ([[pullMenu titleOfSelectedItem]  isEqual: @"ASCII to Hexadecimal"]) [self ASCIIToHexadecimal];
    
    if ([[pullMenu titleOfSelectedItem]  isEqual: @"Hexadecimal to ASCII"]) [self HexadecimalToASCII];
    
    if ([[pullMenu titleOfSelectedItem]  isEqual: @"ASCII to Binary"]) [self ASCIIToBinary];
    
    if ([[pullMenu titleOfSelectedItem]  isEqual: @"Binary to ASCII"]) [self BinaryToASCII];
    
}

- (IBAction)onEnterTextField:(id)sender {
    [self convert:sender];
}

- (IBAction)swapInputAndOutput:(id)sender {
    
    NSString* output = [resultField string];
    NSString* input = [textField stringValue];
    
    [textField setStringValue:output];
    [resultField setString:input];
}

@end
