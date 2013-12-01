//
//  TKScanView.m
//  iOS7-NativeBarCodeScanning
//
//  Created by Thomas Keuleers on 01/12/13.
//  Copyright (c) 2013 Thomas Keuleers. All rights reserved.
//

#import "TKScanView.h"
#import "AVCaptureDevice+Availability.h"

@import AVFoundation;

NSString *const TKScanViewErrorDomain = @"TKScanViewErrorDomain";

@interface TKScanView ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession *session;

@end

@interface NSError (Builder)
+ (NSError *)scanViewErrorWithCode:(NSInteger)code description:(NSString *)description;
@end

@implementation TKScanView

#pragma mark - View lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setup];
}

// Default setup method
- (void)setup {
    self.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
}

- (void)startCapture {
    
    // Make capture session
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    
    // Check if video is available
    if ([AVCaptureDevice hasVideo]) {
    
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        NSError *error = nil;
        
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device
                                                                            error:&error];

        if (input) {
            [session addInput:input];
            
            AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
            [session addOutput:output];
            [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
            
            if (nil == self.metadataObjectTypes) {
                self.metadataObjectTypes = [output availableMetadataObjectTypes];
            }
            
            [output setMetadataObjectTypes:self.metadataObjectTypes];
            [session startRunning];
            
            AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
            previewLayer.frame = self.bounds;

            [self.layer addSublayer:previewLayer];
            
            self.session = session;
            
        } else {
            [self sendErrorToDelegate:error];
        }
        
    } else {
        NSError *error = [NSError scanViewErrorWithCode:TKNoVideoDeviceAvailable description:@"No video device available"];
        [self sendErrorToDelegate:error];
    }
    
}

- (void)endCapture {
    [self.session stopRunning];
}


#pragma mark - AVCaptureMetadataOutputObjectsDelegate methods

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    NSString *scanningResult = nil;
    for (AVMetadataObject *metadata in metadataObjects) {
        if ([self.metadataObjectTypes indexOfObject:metadata.type] != NSNotFound && ![metadata.type isEqualToString:AVMetadataObjectTypeFace]) {
            scanningResult = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
            break;
        }
    }
    
    if (nil != scanningResult) {
        [self endCapture];

        if ([self.delegate respondsToSelector:@selector(scanview:didFinishWithResult:)]) {
            [self.delegate scanview:self didFinishWithResult:scanningResult];
        } else {
            if (nil != self.delegate) {
                [NSException raise:NSInternalInconsistencyException format:@"Delegate must implement scanview:didFinishWithResult:"];
            }
        }
    }
    
}

- (void)sendErrorToDelegate:(NSError *)error {

    if ([self.delegate respondsToSelector:@selector(scanview:didFailWithError:)]) {
        [self.delegate scanview:self didFailWithError:error];
    }
    
}


@end

@implementation NSError (Builder)

+ (NSError *)scanViewErrorWithCode:(NSInteger)code description:(NSString *)description {
    
    return [NSError errorWithDomain:TKScanViewErrorDomain code:code userInfo:@{NSLocalizedDescriptionKey: description}];
    
}

@end
