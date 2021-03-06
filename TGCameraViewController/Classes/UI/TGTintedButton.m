//
//  TGTintedButton.m
//  TGCameraViewController
//
//  Created by Mike Sprague on 3/30/15.
//  Copyright (c) 2015 Tudo Gostoso Internet. All rights reserved.
//

#import "TGTintedButton.h"
#import "TGCameraColor.h"

@interface TGTintedButton ()

- (void)updateTintIfNeeded;

@end


@implementation TGTintedButton

- (void)setNeedsLayout {
    [super setNeedsLayout];
    [self updateTintIfNeeded];
}

- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state {
    if (state != UIControlStateNormal) {
        return;
    }

    UIImageRenderingMode renderingMode = self.disableTint ? UIImageRenderingModeAlwaysOriginal : UIImageRenderingModeAlwaysTemplate;
    [super setBackgroundImage:[image imageWithRenderingMode:renderingMode] forState:state];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    if (state != UIControlStateNormal) {
        return;
    }
    UIImageRenderingMode renderingMode = self.disableTint ? UIImageRenderingModeAlwaysOriginal : UIImageRenderingModeAlwaysTemplate;
    [super setImage:[image imageWithRenderingMode:renderingMode] forState:state];
}

- (void)updateTintIfNeeded {
    UIColor *color = self.customTintColorOverride != nil ? self.customTintColorOverride : [TGCameraColor tintColor];

    UIImageRenderingMode renderingMode = self.disableTint ? UIImageRenderingModeAlwaysOriginal : UIImageRenderingModeAlwaysTemplate;

    if (self.tintColor != color) {
        [self setTintColor:color];

        UIImage* backgroundImage = [self backgroundImageForState:UIControlStateNormal];
        if (backgroundImage != nil) {
            if ([backgroundImage renderingMode] != renderingMode) {
                [self setBackgroundImage:[backgroundImage imageWithRenderingMode:renderingMode] forState:UIControlStateNormal];
            }
        }

        UIImage* image = [self imageForState:UIControlStateNormal];
        if (image != nil) {
            if ([image renderingMode] != renderingMode) {
                [self setImage:[image imageWithRenderingMode:renderingMode] forState:UIControlStateNormal];
            }
        }
    }
}

@end
