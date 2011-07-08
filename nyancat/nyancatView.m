//
//  nyancatView.m
//  nyancat
//
//  Created by Vinay Tota on 7/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "nyancatView.h"


@implementation nyancatView

- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1/30.0];
        
        NSBundle* bundle = [NSBundle bundleForClass:[self class]];
        NSString* envsPListPath = [bundle pathForResource:@"poptart1red1" ofType:@"gif"];
        displayImage = [[[NSImage alloc] initWithContentsOfFile:envsPListPath] autorelease];
        
        //NSSize imageSize = [displayImage size];
       // NSRect imageRect = NSMakeRect( 0, 0,
         //                             imageSize.width, imageSize.height );
        imageView = [[[NSImageView alloc] initWithFrame:[self frame]] autorelease];
        [imageView setImage: displayImage];
        [imageView setNeedsDisplay:YES];
        [self addSubview:imageView];
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
}

- (void)animateOneFrame
{
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
