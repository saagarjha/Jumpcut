//
//  BezelWindow.h
//  Jumpcut
//
//  Created by Steve Cook on 4/3/06.
//  Copyright 2006 Steve Cook. All rights reserved.
//
//  This code is open-source software subject to the MIT License; see the homepage
//  at <http://jumpcut.sourceforge.net/> for details.

#import <Cocoa/Cocoa.h>
#import "RoundRecBezierPath.h"
#import "RoundRecTextField.h"


@interface BezelWindow : NSWindow {
	NSString			*stackString;
	NSString			*title;
	NSString			*bezelText;
//	NSImage				*icon;
	RoundRecTextField	*textField;
	RoundRecTextField	*stackField;
//	NSImageView			*iconView;
	id					delegate;
}

- (NSColor *)roundedBackgroundWithRect:(NSRect)bgRect withRadius:(float)radius withAlpha:(float)alpha;
- (NSColor *)sizedBezelBackgroundWithRadius:(float)radius withAlpha:(float)alpha;

- (NSString *)title;
- (void)setTitle:(NSString *)newTitle;
- (NSString *)text;
- (void)setText:(NSString *)newText;
- (void)setStackString:(NSString *)newChar;
- (void)setAlpha:(float)newValue;

- (id)delegate;
- (void)setDelegate:(id)newDelegate;

@end
