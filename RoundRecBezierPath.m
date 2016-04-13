//
//  RoundRecBezierPath.m
//  Jumpcut
//
//  Created by steve on Tue Dec 16 2003.
//  Copyright (c) 2003 Steve Cook. All rights reserved.
//
//  This code is open-source software subject to the MIT License; see the homepage
//  at <http://jumpcut.sourceforge.net/> for details.

#import "RoundRecBezierPath.h"

@implementation NSBezierPath (RoundRecBezierPath)

+ (NSBezierPath *)bezierPathWithRoundRectInRect:(NSRect)aRect radius:(CGFloat)radius corners:(NSArray *)corners {
    NSBezierPath *path = [NSBezierPath bezierPath];
    
    [path moveToPoint:NSMakePoint(0,  radius)];
    
    [path lineToPoint:NSMakePoint(0, aRect.size.height -  radius)];
    
    if ([corners count] < 4) {
        NSNumber *yes = [NSNumber numberWithBool:YES];
        corners = [corners arrayByAddingObjectsFromArray:@[yes, yes, yes, yes]];
    }
    
    if ([[corners objectAtIndex:0] boolValue]) {
        [path appendBezierPathWithArcWithCenter:NSMakePoint(radius, aRect.size.height -  radius) radius:radius startAngle:180 endAngle:90 clockwise:TRUE];
    } else {
        [path lineToPoint:NSMakePoint(0, aRect.size.height)];
    }
    
    [path lineToPoint:NSMakePoint(aRect.size.width -  radius, aRect.size.height)];
    
    if ([[ corners objectAtIndex:1] boolValue]) {
        [path appendBezierPathWithArcWithCenter:NSMakePoint(aRect.size.width -  radius, aRect.size.height -  radius) radius:radius startAngle:90 endAngle:0 clockwise:TRUE];
    } else {
        [path lineToPoint:NSMakePoint(aRect.size.width, aRect.size.height)];
    }
    
    [path lineToPoint:NSMakePoint(aRect.size.width,  radius)];
    
    if ([[ corners objectAtIndex:2] boolValue]) {
        [path appendBezierPathWithArcWithCenter:NSMakePoint(aRect.size.width -  radius,  radius) radius:radius startAngle:0 endAngle:270 clockwise:TRUE];
    } else {
        [path lineToPoint:NSMakePoint(aRect.size.width, 0)];
    }
    
    [path lineToPoint:NSMakePoint(radius, 0)];
    
    if ([[ corners objectAtIndex:3] boolValue]) {
        [path appendBezierPathWithArcWithCenter:NSMakePoint(radius,  radius) radius:radius startAngle:270 endAngle:180 clockwise:TRUE];
    } else {
        [path lineToPoint:NSMakePoint(0, 0)];
    }
    
    [path closePath];
    return path;
}

@end