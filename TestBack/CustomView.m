//
//  CustomView.m
//  TestBack
//
//  Created by Avi Cohen on 11/22/14.
//  Copyright (c) 2014 Avi Cohen. All rights reserved.
//

#import "CustomView.h"

@interface CustomView ()

@property (nonatomic)BOOL landscape;

@end

@implementation CustomView

- (CGSize)intrinsicContentSize
{
    if (self.landscape) {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 32);
    } else {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 20 - 44);
    }
}

-(id)initWithCoder:(NSCoder *)coder
{
    [self startDeviceOrientationNotification];
    return [super initWithCoder:coder];
}

- (void)removeFromSuperview
{
    [self stopDeviceOrientationNotification];
}

#pragma mark name:UIDeviceOrientationDidChangeNotification

- (void)startDeviceOrientationNotification
{
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}

- (void)stopDeviceOrientationNotification
{
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)orientationChanged:(NSNotification *)notification
{
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    self.landscape = UIDeviceOrientationIsLandscape(deviceOrientation) ? YES : NO;
    [self invalidateIntrinsicContentSize];
}


@end
