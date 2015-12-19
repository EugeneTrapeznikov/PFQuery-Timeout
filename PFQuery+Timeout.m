//
//  PFQuery+Timeout.m
//  Trucker Path Pro
//
//  Created by Eugene Trapeznikov on 12/18/15.
//  Copyright © 2015 Mac. All rights reserved.
//

#import "PFQuery+Timeout.h"

//=== libs
#import <objc/runtime.h>

//===

static void *TimeoutIntervalKey;

//===

@implementation PFQuery (Timeout)

-(void)findObjectsInBackgroundWithTimeoutAndBlock:(PFArrayResultBlock)block {

	NSTimer *timeoutTimer;

	if (self.timeoutInterval > 0) {
		timeoutTimer = [NSTimer scheduledTimerWithTimeInterval:self.timeoutInterval target:self selector:@selector(timeout:) userInfo:block repeats:NO];
	}

	//===

	[self findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {

		[timeoutTimer invalidate];

		block(objects, error);
	}];
}

-(void)timeout:(NSTimer*)timeoutTimer {

	[self cancel];

	//===

	PFArrayResultBlock block = [timeoutTimer userInfo];
	block(nil, nil);

	//===

	[timeoutTimer invalidate];
}

#pragma mark - Properties

- (NSInteger)timeoutInterval {

	NSInteger result = 0;

	//===

	id interval =
	objc_getAssociatedObject(self, &TimeoutIntervalKey);

	result = ((NSNumber *)interval).integerValue;

	//===

	return result;
}

- (void)setTimeoutInterval:(NSInteger)timeoutInterval {

	objc_setAssociatedObject(self,
							 &TimeoutIntervalKey,
							 @(timeoutInterval),
							 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
