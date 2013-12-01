//
//  AVCaptureDevice+Availability.h
//  iOS7-NativeBarCodeScanning
//
//  Created by Thomas Keuleers on 01/12/13.
//  Copyright (c) 2013 Thomas Keuleers. All rights reserved.
//

@import AVFoundation;

@interface AVCaptureDevice (Availability)

+ (BOOL)hasVideo;

@end
