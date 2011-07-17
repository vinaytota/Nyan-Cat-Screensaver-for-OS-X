//
//  nyancatView.h
//  nyancat
//
//  Created by Vinay Tota on 7/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <ScreenSaver/ScreenSaver.h>
#import "NyanStarData.h"

//#import <Cocoa/Cocoa.h>


@interface nyancatView : ScreenSaverView {
     NSImage *displayImage;
     NSImageView *imageView;
     NSMutableArray *nyanStars; 
     int shiftRainbow;
}

- (void)drawNyanStar:(NyanStarData*)nyanStar;
- (void) drawNyanRainbowSection: (NSPoint)origin;

@end
