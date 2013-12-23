//
//  ScanResultViewController.m
//  iOS7-NativeBarCodeScanning
//
//  Created by Thomas Keuleers on 01/12/13.
//  Copyright (c) 2013 Thomas Keuleers. All rights reserved.
//

#import "ScanResultViewController.h"

@implementation ScanResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.resultLabel.text = self.scanResult;
}

@end
