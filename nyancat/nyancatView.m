//
//  nyancatView.m
//  nyancat
//
//  Created by Vinay Tota on 7/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "nyancatView.h"
#import "NyanStarData.h"

@implementation nyancatView

- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:0.07F];
        
        NSBundle* bundle = [NSBundle bundleForClass:[self class]];
        NSString* envsPListPath = [bundle pathForResource:@"poptart1red1" ofType:@"gif"];
        displayImage = [[[NSImage alloc] initWithContentsOfFile:envsPListPath] autorelease];
        
        //NSSize imageSize = [displayImage size];
       // NSRect imageRect = NSMakeRect( 0, 0,
         //                             imageSize.width, imageSize.height );
        imageView = [[[NSImageView alloc] initWithFrame:[self frame]] autorelease];
        [imageView setImage: displayImage];
        [self addSubview:imageView];
        
        nyanStars = [[NSMutableArray alloc] init];
        for(int x = 0; x < 6; x++) {
            NyanStarData* nyanStar = [[NyanStarData alloc] init];
            NSSize dotSize = NSMakeSize(6,6);
            // Calculate random origin point
            NSPoint nyanStarCenter = SSRandomPointForSizeWithinRect( dotSize, [self bounds] );
            [nyanStar setCenter:nyanStarCenter setFrameNumber:x];
        
            [nyanStars addObject:nyanStar];
        }
        
        shiftRainbow = 3;
    }
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    
    float red = 0.0f;
    float green = 51.0/255.0f;
    float blue = 102.0/255.0f;
    float alpha = 1.0f;
    
    NSColor *color= [NSColor colorWithDeviceRed: red green: green blue: blue alpha: alpha];
    
    [super drawRect:rect];
    NSSize size = [self bounds].size;
    NSRect r = NSMakeRect(0, 0, size.width, size.height);
    [color set];
    NSRectFill(r);
    
    NSEnumerator* enumerator = [nyanStars objectEnumerator];
    NyanStarData* element;
    while((element = [enumerator nextObject]))
    {
            [self drawNyanStar:element];
    }
    
    // 26px of ranbow drawn already
    int lastNyanRainbowEndX = ([self bounds].size.width - 400)/2 - 46 + 26 - 27;
    int shiftX = 0;
    if(shiftRainbow == 2 || shiftRainbow == 3) {
        shiftX = 5;
    }
    int lastNyanRainbowEndY = ([self bounds].size.height - 400)/2 + 143 + shiftX;
    //int nyanRainbow = 
    [self drawNyanRainbowSection:NSMakePoint(lastNyanRainbowEndX, lastNyanRainbowEndY)];
    
}
- (void) drawNyanRainbowSection: (NSPoint)origin {
    // 46 x 17
    
    [[NSColor colorWithDeviceRed: 102.0f/255.0f green: 51.0f/255.0f blue:1.0f alpha: 1.0f] set];
    NSRectFill(NSMakeRect(origin.x,origin.y + 0*17,46,17));
    
    [[NSColor colorWithDeviceRed: 0.0f green: 153.0f/255.0f blue:1.0f alpha: 1.0f] set];
    NSRectFill(NSMakeRect(origin.x,origin.y + 1*17,46,17));
    
    [[NSColor colorWithDeviceRed: 51.0f/255.0f green: 1.0f blue:0.0f alpha: 1.0f] set];
    NSRectFill(NSMakeRect(origin.x,origin.y + 2*17,46,17));

    [[NSColor colorWithDeviceRed: 1.0f green: 1.0f blue:0.0f alpha: 1.0f] set];
    NSRectFill(NSMakeRect(origin.x,origin.y + 3*17,46,17));
    
    [[NSColor colorWithDeviceRed: 1.0f green: 153.0f/255.0f blue:0.0f alpha: 1.0f] set];
    NSRectFill(NSMakeRect(origin.x,origin.y + 4*17,46,17));
    
    [[NSColor colorWithDeviceRed: 1.0f green: 0.0f blue:0.0f alpha: 1.0f] set];
    NSRectFill(NSMakeRect(origin.x,origin.y + 5*17,46,17));
}
- (void)drawNyanStar:(NyanStarData*)nyanStar {
    NSColor *white = [NSColor whiteColor];
    NSPoint center = [nyanStar getCenter];
    if([nyanStar getFrameNumber] == 0) {
        NSRect r = NSMakeRect(center.x,center.y,6,6);
        [white set];
        NSRectFill(r);
    } else if([nyanStar getFrameNumber] == 1) {
        NSRect r1 = NSMakeRect(center.x + 6,center.y,6,5);
        NSRect r2 = NSMakeRect(center.x - 6,center.y,6,5);
        NSRect r3 = NSMakeRect(center.x,center.y + 6,5,6);
        NSRect r4 = NSMakeRect(center.x,center.y - 6,5,6);
        
        [white set];
        
        NSRectFill(r1);
        NSRectFill(r2);
        NSRectFill(r3);
        NSRectFill(r4);
    } else if([nyanStar getFrameNumber] == 2) {
        NSRect r1 = NSMakeRect(center.x + 6,center.y,12,6);
        NSRect r2 = NSMakeRect(center.x - 11,center.y,11,6);
        NSRect r3 = NSMakeRect(center.x,center.y + 6,6,11);
        NSRect r4 = NSMakeRect(center.x,center.y - 12,6,12);
        
        [white set];
        
        NSRectFill(r1);
        NSRectFill(r2);
        NSRectFill(r3);
        NSRectFill(r4);
    } else if([nyanStar getFrameNumber] == 3) {
        NSRect r0 = NSMakeRect(center.x,center.y,6,6);
        
        NSRect r1 = NSMakeRect(center.x + 12,center.y,11,6);
        NSRect r2 = NSMakeRect(center.x - 17,center.y,11,6);
        NSRect r3 = NSMakeRect(center.x,center.y + 12,6,11);
        NSRect r4 = NSMakeRect(center.x,center.y - 17,6,11);
        
        [white set];
        
        NSRectFill(r0);
        NSRectFill(r1);
        NSRectFill(r2);
        NSRectFill(r3);
        NSRectFill(r4);
        
    } else if([nyanStar getFrameNumber] == 4) {
        
        NSRect r1 = NSMakeRect(center.x + 17,center.y,6,6);
        NSRect r2 = NSMakeRect(center.x - 17,center.y,6,6);
        NSRect r3 = NSMakeRect(center.x,center.y + 17,6,6);
        NSRect r4 = NSMakeRect(center.x,center.y - 17,6,6);
    
        NSRect r5 = NSMakeRect(center.x + 12,center.y + 12,5,5);
        NSRect r6 = NSMakeRect(center.x - 11,center.y + 12,5,5);
        NSRect r7 = NSMakeRect(center.x + 12,center.y - 12,5,5);
        NSRect r8 = NSMakeRect(center.x - 11,center.y - 12,5,5);
        
        [white set];
        
        NSRectFill(r1);
        NSRectFill(r2);
        NSRectFill(r3);
        NSRectFill(r4);
        NSRectFill(r5);
        NSRectFill(r6);
        NSRectFill(r7);
        NSRectFill(r8);
        
    } else if([nyanStar getFrameNumber] == 5) {
        NSRect r1 = NSMakeRect(center.x + 17,center.y,6,6);
        NSRect r2 = NSMakeRect(center.x - 17,center.y,6,6);
        NSRect r3 = NSMakeRect(center.x,center.y + 17,6,6);
        NSRect r4 = NSMakeRect(center.x,center.y - 17,6,6);
        
        [white set];
        
        NSRectFill(r1);
        NSRectFill(r2);
        NSRectFill(r3);
        NSRectFill(r4);
    }
}

- (void)animateOneFrame
{
    NSEnumerator* enumerator = [nyanStars objectEnumerator];
    NyanStarData* element;
    while((element = [enumerator nextObject]))
    {
        int newFrameNumber = ([element getFrameNumber] + 1) % 6;
        NSPoint newCenter = [element getCenter];
        newCenter.x = newCenter.x - 46;
        if(newCenter.x < 0) {
            newCenter.x += [self bounds].size.width;
        }
        [element setCenter:newCenter setFrameNumber:newFrameNumber];
    }
    shiftRainbow = (shiftRainbow + 1) % 4;
    [self setNeedsDisplay:YES];
    [imageView setNeedsDisplay:YES];
    return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
