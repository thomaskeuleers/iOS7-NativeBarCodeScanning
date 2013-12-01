//
//  ViewController.h
//  iOS7-NativeBarCodeScanning
//
//  Created by Thomas Keuleers on 01/12/13.
//  Copyright (c) 2013 Thomas Keuleers. All rights reserved.
//

#import <UIKit/UIKit.h>
@import AVFoundation;

@class TKScanView;
@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet TKScanView *scanView;
@end
