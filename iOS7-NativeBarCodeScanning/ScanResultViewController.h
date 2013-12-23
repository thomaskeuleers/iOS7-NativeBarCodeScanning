//
//  ScanResultViewController.h
//  iOS7-NativeBarCodeScanning
//
//  Created by Thomas Keuleers on 01/12/13.
//  Copyright (c) 2013 Thomas Keuleers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanResultViewController : UIViewController

// Views
@property (nonatomic, weak) IBOutlet UILabel *resultLabel;

// Properties
@property (nonatomic, strong) NSString *scanResult;
@end
