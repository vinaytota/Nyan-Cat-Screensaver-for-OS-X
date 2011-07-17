//
//  NyanStarData.m
//  nyancat
//
//  Created by Vinay Tota on 7/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NyanStarData.h"


@implementation NyanStarData

-(void) setCenter:(NSPoint)myCenter setFrameNumber:(int)myFrameNumber {
    center = myCenter;
    frameNumber=myFrameNumber;
}

-(NSPoint) getCenter {
    return center;
}
-(int) getFrameNumber; {
    return frameNumber;
}

@end
