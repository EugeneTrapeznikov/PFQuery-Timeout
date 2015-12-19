//
//  PFQuery+Timeout.h
//  Trucker Path Pro
//
//  Created by Eugene Trapeznikov on 12/18/15.
//  Copyright © 2015 Mac. All rights reserved.
//

#import <Parse/Parse.h>

@interface PFQuery (Timeout)

-(void)findObjectsInBackgroundWithTimeoutAndBlock:(PFArrayResultBlock)block;

@property NSInteger timeoutInterval;

@end
