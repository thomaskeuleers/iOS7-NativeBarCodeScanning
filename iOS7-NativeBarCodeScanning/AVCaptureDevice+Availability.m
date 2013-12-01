//
//  AVCaptureDevice+Availability.m
//  iOS7-NativeBarCodeScanning
//
//  Created by Thomas Keuleers on 01/12/13.
//  Copyright (c) 2013 Thomas Keuleers. All rights reserved.
//

#import "AVCaptureDevice+Availability.h"

@implementation AVCaptureDevice (Availability)

+ (BOOL)hasVideo {
    return nil != [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
}

@end
