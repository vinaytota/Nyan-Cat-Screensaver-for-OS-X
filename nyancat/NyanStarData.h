//
//  NyanStarData.h
//  nyancat
//
//  Created by Vinay Tota on 7/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NyanStarData : NSObject {
    
    @private
    NSPoint center;
    int frameNumber;
}

-(void) setCenter:(NSPoint)myCenter setFrameNumber:(int)myFrameNumber;
-(NSPoint) getCenter;
-(int) getFrameNumber;

@end
