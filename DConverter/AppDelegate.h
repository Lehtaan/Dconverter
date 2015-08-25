//
//  AppDelegate.h
//  DConverter
//
//  Created by Janis Böhm on 23/08/15.
//  Copyright (c) 2015 Janis Böhm. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (weak) IBOutlet NSPopUpButton *pullMenu;
@property (unsafe_unretained) IBOutlet NSTextView *resultField;
@property (unsafe_unretained) IBOutlet NSTextField *textField;


- (IBAction)convert:(id)sender;
- (IBAction)onEnterTextField:(id)sender;
- (IBAction)swapInputAndOutput:(id)sender;

-(BOOL)ASCIIToDecimal;
-(BOOL)DecimalToASCII;
-(BOOL)ASCIIToHexadecimal;
-(BOOL)HexadecimalToASCII;
-(BOOL)ASCIIToBinary;
-(BOOL)BinaryToASCII;


@end

