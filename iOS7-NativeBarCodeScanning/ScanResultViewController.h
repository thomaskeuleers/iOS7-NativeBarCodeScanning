//
//  ScanResultViewController.h
//  iOS7-NativeBarCodeScanning
//
//  Created by Thomas Keuleers on 01/12/13.
//  Copyright (c) 2013 Thomas Keuleers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanResultViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;



@property (nonatomic, strong) NSString *scanResult;
@end
