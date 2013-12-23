//
//  TKScanView.h
//  iOS7-NativeBarCodeScanning
//
//  Created by Thomas Keuleers on 01/12/13.
//  Copyright (c) 2013 Thomas Keuleers. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const TKScanViewErrorDomain;

enum {
    TKNoVideoDeviceAvailable = -1
};

@protocol TKScanViewDelegate;
@interface TKScanView : UIView

@property (nonatomic, weak) id<TKScanViewDelegate> delegate;
@property (nonatomic, strong) NSArray *metadataObjectTypes; // defaults to AVMetadataObjectTypeQRCode, set to nil for all types

- (void)startCapture;
- (void)endCapture;

@end


@protocol TKScanViewDelegate <NSObject>

@required
- (void)scanview:(TKScanView *)scanView didFinishWithResult:(NSString *)scanResult;

@optional
- (void)scanview:(TKScanView *)scanView didFailWithError:(NSError *)error;

@end
