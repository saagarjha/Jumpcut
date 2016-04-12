//
//  RoundedTextField.h
//  Jumpcut
//
//  Created by steve on Wed Dec 17 2003.
//  Copyright (c) 2003 Steve Cook. All rights reserved.
//
//  This code is open-source software subject to the MIT License; see the homepage
//  at <http://jumpcut.sourceforge.net/> for details.

#import <AppKit/AppKit.h>


@interface RoundRecTextField : NSTextField {
    IBOutlet RoundRecTextField *characterBackground;
    IBOutlet RoundRecTextField *textBackground;
    CGFloat _cornerRadius;
    NSArray *_corners;
}

@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic, copy) NSArray *corners;

//- (void)setCornerRadius:(CGFloat)cornerRadius andCorners:(NSArray *)corners;

@end
