//
//  ViewController.m
//  iOS7-NativeBarCodeScanning
//
//  Created by Thomas Keuleers on 01/12/13.
//  Copyright (c) 2013 Thomas Keuleers. All rights reserved.
//

#import "ViewController.h"
#import "TKScanView.h"
#import "ScanResultViewController.h"
@import AVFoundation;

NSString *const segueGoToScanResult = @"goToScanResult";

@interface ViewController ()<TKScanViewDelegate>

@property (nonatomic, strong) NSString *scanResult;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scanView.delegate = self;
    // no preferences set, handle all types
    self.scanView.metadataObjectTypes = nil;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.scanView startCapture];
}

- (void)scanview:(TKScanView *)scanView didFinishWithResult:(NSString *)scanResult {
    
    self.scanResult = scanResult;
    [self performSegueWithIdentifier:segueGoToScanResult sender:nil];
    
}

- (void)scanview:(TKScanView *)scanView didFailWithError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:segueGoToScanResult]) {
        
        ScanResultViewController *resultVC = segue.destinationViewController;
        resultVC.scanResult = self.scanResult;
        
    }
}

@end
