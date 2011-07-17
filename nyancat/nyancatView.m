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
        NSString* envsPListPath = [bundle pathForResource:@"cat" ofType:@"gif"];
        displayImage = [[[NSImage alloc] initWithContentsOfFile:envsPListPath] autorelease];
        
        // Thanks to http://blog.pcitron.fr/2010/12/14/play-an-animated-gif-with-an-ikimageview/ 
        // for example code on how to do this
        NSArray * reps = [displayImage representations];
        for (NSImageRep * rep in reps)
        {
            // find the bitmap representation
            if ([rep isKindOfClass:[NSBitmapImageRep class]] == YES)
            {
                // get the bitmap representation
                NSBitmapImageRep * bitmapRep = (NSBitmapImageRep *)rep;
                int numFrame = [[bitmapRep valueForProperty:NSImageFrameCount] intValue];
                
                // create a value array which will contains the frames of the animation
                gifFrames = [NSMutableArray array];
                
                for (int i = 0; i < numFrame; ++i)
                {
                    // set the current frame
                    [bitmapRep setProperty:NSImageCurrentFrame withValue:[NSNumber numberWithInt:i]];
                    [gifFrames addObject:(id)[bitmapRep CGImage]];
                }
                
                // stops at the first valid representation
                break;
            }
        }
        
        nyanStars = [[NSMutableArray alloc] init];
        for(int x = 0; x < 6; x++) {
            NyanStarData* nyanStar = [[NyanStarData alloc] init];
            NSSize dotSize = NSMakeSize(6,6);
            // Calculate random origin point
            NSPoint nyanStarCenter = SSRandomPointForSizeWithinRect( dotSize, [self bounds] );
            [nyanStar setCenter:nyanStarCenter setFrameNumber:x];
        
            [nyanStars addObject:nyanStar];
        }
        gifFrameNumber = 0;
        shiftRainbow = 0;
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
    [super drawRect:rect];
    
    // Draw background
    [self drawBackground];

    // Draw stars
    NSEnumerator* enumerator = [nyanStars objectEnumerator];
    NyanStarData* element;
    while((element = [enumerator nextObject]))
    {
            [self drawNyanStar:element];
    }
    
    
    //Figure out where to draw nyancat 
    NSImage* currentFrame = [NSImage alloc];
    [currentFrame initWithCGImage:(CGImageRef)[gifFrames objectAtIndex:gifFrameNumber] size:NSZeroSize];
    NSSize viewSize  = [self bounds].size;
    NSSize imageSize = NSMakeSize(200, 140);
    
    NSPoint viewCenter;
    viewCenter.x = viewSize.width  * 0.50;
    viewCenter.y = viewSize.height * 0.50;
    
    NSPoint imageOrigin = viewCenter;
    imageOrigin.x -= imageSize.width  * 0.50;
    imageOrigin.y -= imageSize.height * 0.50;
    
    NSRect destRect;
    destRect.origin = imageOrigin;
    destRect.size = imageSize;
    
    // Use NyanCat position to figure out where to draw rainbow
    int lastNyanRainbowEndX = destRect.origin.x + 6;
    int shiftY = 5;
    BOOL shift = NO;
    if(shiftRainbow == 2 || shiftRainbow == 3) {
        shift = YES;
        
    }
    
    int nyanRainbowX = lastNyanRainbowEndX;
    int nyanRainBowY = destRect.origin.y + 22;
    shift = !shift;
    
    // draw rainbow
    while(nyanRainbowX + 46 > 0 ) {
        if(shift) {
           [self drawNyanRainbowSection:NSMakePoint(nyanRainbowX, nyanRainBowY + shiftY)]; 
        } else {
           [self drawNyanRainbowSection:NSMakePoint(nyanRainbowX, nyanRainBowY)];
        }
        shift = !shift;
        nyanRainbowX -= 46;
    }
    
    // draw kitty
    [currentFrame drawInRect: destRect
             fromRect: NSZeroRect
            operation: NSCompositeSourceOver
             fraction: 1.0];
    
}

- (void)drawBackground {
    
    // Background color
    float red = 0.0f;
    float green = 51.0/255.0f;
    float blue = 102.0/255.0f;
    float alpha = 1.0f;
    
    NSColor *color= [NSColor colorWithDeviceRed: red green: green blue: blue alpha: alpha];
    
    [color set];
    NSRectFill([self bounds]);
}


- (void) drawNyanRainbowSection: (NSPoint)origin {
    int rainbowSectionLength = 46;
    int rainbowSectionHeight = 17;
    
    [[NSColor colorWithDeviceRed: 102.0f/255.0f green: 51.0f/255.0f blue:1.0f alpha: 1.0f] set];
    NSRectFill(NSMakeRect(origin.x,origin.y + 0*rainbowSectionHeight,rainbowSectionLength,rainbowSectionHeight));
    
    [[NSColor colorWithDeviceRed: 0.0f green: 153.0f/255.0f blue:1.0f alpha: 1.0f] set];
    NSRectFill(NSMakeRect(origin.x,origin.y + 1*rainbowSectionHeight,rainbowSectionLength,rainbowSectionHeight));
    
    [[NSColor colorWithDeviceRed: 51.0f/255.0f green: 1.0f blue:0.0f alpha: 1.0f] set];
    NSRectFill(NSMakeRect(origin.x,origin.y + 2*rainbowSectionHeight,rainbowSectionLength,rainbowSectionHeight));

    [[NSColor colorWithDeviceRed: 1.0f green: 1.0f blue:0.0f alpha: 1.0f] set];
    NSRectFill(NSMakeRect(origin.x,origin.y + 3*rainbowSectionHeight,rainbowSectionLength,rainbowSectionHeight));
    
    [[NSColor colorWithDeviceRed: 1.0f green: 153.0f/255.0f blue:0.0f alpha: 1.0f] set];
    NSRectFill(NSMakeRect(origin.x,origin.y + 4*rainbowSectionHeight,rainbowSectionLength,rainbowSectionHeight));
    
    [[NSColor colorWithDeviceRed: 1.0f green: 0.0f blue:0.0f alpha: 1.0f] set];
    NSRectFill(NSMakeRect(origin.x,origin.y + 5*rainbowSectionHeight,rainbowSectionLength,rainbowSectionHeight));
}
- (void)drawNyanStar:(NyanStarData*)nyanStar {
    NSColor *white = [NSColor whiteColor];
    NSPoint center = [nyanStar getCenter];
    [white set];
    if([nyanStar getFrameNumber] == 0) {
        NSRectFill(NSMakeRect(center.x,center.y,6,6));    
    } else if([nyanStar getFrameNumber] == 1) {
        NSRectFill(NSMakeRect(center.x + 6,center.y,6,5));
        NSRectFill(NSMakeRect(center.x - 6,center.y,6,5));
        NSRectFill(NSMakeRect(center.x,center.y + 6,5,6));
        NSRectFill(NSMakeRect(center.x,center.y - 6,5,6));
    } else if([nyanStar getFrameNumber] == 2) {
        NSRectFill(NSMakeRect(center.x + 6,center.y,12,6));
        NSRectFill(NSMakeRect(center.x - 11,center.y,11,6));
        NSRectFill(NSMakeRect(center.x,center.y + 6,6,11));
        NSRectFill(NSMakeRect(center.x,center.y - 12,6,12));
    } else if([nyanStar getFrameNumber] == 3) {
        NSRectFill(NSMakeRect(center.x,center.y,6,6));
        
        NSRectFill(NSMakeRect(center.x + 12,center.y,11,6));
        NSRectFill(NSMakeRect(center.x - 17,center.y,11,6));
        NSRectFill(NSMakeRect(center.x,center.y + 12,6,11));
        NSRectFill(NSMakeRect(center.x,center.y - 17,6,11));
    } else if([nyanStar getFrameNumber] == 4) {
        NSRectFill(NSMakeRect(center.x + 17,center.y,6,6));
        NSRectFill(NSMakeRect(center.x - 17,center.y,6,6));
        NSRectFill(NSMakeRect(center.x,center.y + 17,6,6));
        NSRectFill(NSMakeRect(center.x,center.y - 17,6,6));
    
        NSRectFill(NSMakeRect(center.x + 12,center.y + 12,5,5));
        NSRectFill(NSMakeRect(center.x - 11,center.y + 12,5,5));
        NSRectFill(NSMakeRect(center.x + 12,center.y - 12,5,5));
        NSRectFill(NSMakeRect(center.x - 11,center.y - 12,5,5));
    } else if([nyanStar getFrameNumber] == 5) {
        NSRectFill(NSMakeRect(center.x + 17,center.y,6,6));
        NSRectFill(NSMakeRect(center.x - 17,center.y,6,6));
        NSRectFill(NSMakeRect(center.x,center.y + 17,6,6));
        NSRectFill(NSMakeRect(center.x,center.y - 17,6,6));
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
    gifFrameNumber = (gifFrameNumber + 1) % (int) [gifFrames count];
    [self setNeedsDisplay:YES];
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
