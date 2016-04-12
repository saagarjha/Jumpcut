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
        path = [NSBezierPath bezierPathWithRoundRectInRect:rect radius:4];
    } else {
        if ([self.corners count] < 4) {
            NSNumber *no = [NSNumber numberWithBool:NO];
            self.corners = [self.corners arrayByAddingObject:@[no, no, no, no]];
        }

        NSRect frame = rect;
        path = [NSBezierPath bezierPath];
        [path moveToPoint:NSMakePoint(0, self.cornerRadius)];

        [path lineToPoint:NSMakePoint(0, frame.size.height - self.cornerRadius)];

        if ([[self.corners objectAtIndex:0] boolValue]) {
            [path appendBezierPathWithArcWithCenter:NSMakePoint(self.cornerRadius, frame.size.height - self.cornerRadius) radius:self.cornerRadius startAngle:180 endAngle:90 clockwise:TRUE];
        } else {
            [path lineToPoint:NSMakePoint(0, frame.size.height)];
        }

        [path lineToPoint:NSMakePoint(frame.size.width - self.cornerRadius, frame.size.height)];

        if ([[self.corners objectAtIndex:1] boolValue]) {
            [path appendBezierPathWithArcWithCenter:NSMakePoint(frame.size.width - self.cornerRadius, frame.size.height - self.cornerRadius) radius:self.cornerRadius startAngle:90 endAngle:0 clockwise:TRUE];
        } else {
            [path lineToPoint:NSMakePoint(frame.size.width, frame.size.height)];
        }

        [path lineToPoint:NSMakePoint(frame.size.width, self.cornerRadius)];

        if ([[self.corners objectAtIndex:2] boolValue]) {
            [path appendBezierPathWithArcWithCenter:NSMakePoint(frame.size.width - self.cornerRadius, self.cornerRadius) radius:self.cornerRadius startAngle:0 endAngle:270 clockwise:TRUE];
        } else {
            [path lineToPoint:NSMakePoint(frame.size.width, 0)];
        }

        [path lineToPoint:NSMakePoint(self.cornerRadius, 0)];

        if ([[self.corners objectAtIndex:3] boolValue]) {
            [path appendBezierPathWithArcWithCenter:NSMakePoint(self.cornerRadius, self.cornerRadius) radius:self.cornerRadius startAngle:270 endAngle:180 clockwise:TRUE];
        } else {
            [path lineToPoint:NSMakePoint(0, 0)];
        }

        [path closePath];
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