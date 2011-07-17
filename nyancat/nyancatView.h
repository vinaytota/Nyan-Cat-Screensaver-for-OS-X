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
     NSMutableArray *nyanStars; 
     int shiftRainbow;
     int gifFrameNumber;
     NSMutableArray * gifFrames;
}

- (void)drawNyanStar:(NyanStarData*)nyanStar;
- (void) drawNyanRainbowSection: (NSPoint)origin;
- (void)drawBackground;

@end
