//
//  RoundedTextField.m
//  Jumpcut
//
//  Created by steve on Wed Dec 17 2003.
//  Copyright (c) 2003 Steve Cook. All rights reserved.
//
//  This code is open-source software subject to the MIT License; see the homepage
//  at <http://jumpcut.sourceforge.net/> for details.

#import "RoundRecTextField.h"
#import "RoundRecBezierPath.h"

// Okay, on doing some reading, the -best- way to handle this is probably to cache
// an NSImage on the init and then (as needed) composite it to the back of the view.
// We can then turn the rectangles on and off by compositing or not compositing the
// images.

// This can wait for another time.

@implementation RoundRecTextField

// We may want to make this a more flexible class sometime by taking radius as an argument.
// Until then, this is kind of useless code.

/*
   - (id)initWithFrame:(NSRect)frame {
   self = [super initWithFrame:frame];
   if (self) {
   // Initialization code here.
   }
   return self;
   }
 */

@synthesize cornerRadius = _cornerRadius;
@synthesize corners = _corners;

- (BOOL)isOpaque {
    return NO;
}

- (void)drawRect:(NSRect)rect {
    // Oh, the hackishness.
    NSBezierPath *path;

    if (!self.cornerRadius || !self.corners) {
        path = [NSBezierPath bezierPathWithRoundRectInRect:rect radius:4 corners: @[]];
    } else {
        path = [NSBezierPath bezierPathWithRoundRectInRect:rect radius: self.cornerRadius corners: self.corners];
        }

    [[self backgroundColor] set];
    [path fill];
    [self setDrawsBackground:NO];
    // We might eventually want to pass [super drawRect] something smaller than rect, to ensure that we don't bleed over the corners
    [super drawRect:rect];
    [self setDrawsBackground:YES];
}

- (void)setCornerRadius:(CGFloat)cornerRadius andCorners:(NSArray *)corners {
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    [self setNeedsDisplay];
}

- (CGFloat)cornerRadius {
    return _cornerRadius;
}

- (void)setCorners:(NSArray *)corners {
    [corners retain];
    [_corners release];
    _corners = corners;
    [self setNeedsDisplay];
}

- (NSArray *)corners {
    return _corners;
}

@end