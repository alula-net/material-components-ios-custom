// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 This const returns the status bar height for pre iPhone X devices.

 Note: For iOS 11+ devices this value should be fetched from the views safeAreaInsets API.
 */
extern const CGFloat MDCFixedStatusBarHeightOnPreiPhoneXDevices;

/**
 On devices with hardware safe areas, returns the top safe area for the key window. On all other
 devices, returns the fixed status bar height regardless of status bar visibility.

 This method is only meant for use with views that are placed behind the top safe area of a device
 and that can be shifted off-screen along with the status bar. These kinds of views must not change
 their top margin when shifting off-screen because it would cause a visible jump in layout. iOS
 does not have an API for fetching the status bar's dimensions if it is hidden, so this method
 ensures that we can always retrieve a non-zero value for our top safe area inset on devices without
 hardware safe areas, while also ensuring that we receive the proper top safe area inset on devices
 with hardware safe areas (iPhone X).
 */
FOUNDATION_EXPORT CGFloat MDCDeviceTopSafeAreaInset(void);

/**
 How far a header moves up into the unfolded iPhone Duo's status band, so its navigation bar lines
 up with the clock pill; 0 elsewhere.
 */
FOUNDATION_EXPORT CGFloat MDCStatusPillBandOverlap(UIWindow *_Nullable window);

/** Width a navigation bar in that band keeps clear for the clock pill. */
FOUNDATION_EXPORT const CGFloat MDCStatusPillWidth;

/**
 The iPhone Duo's system bar column below the status pill on the right edge, in @c view's
 coordinates; CGRectNull when @c view is not in a window that has one or doesn't cover it.
 */
FOUNDATION_EXPORT CGRect MDCSideBarFrameInView(UIView *_Nonnull view);

/** A layout guide on @c view that follows that column; nil on systems without one. */
FOUNDATION_EXPORT UILayoutGuide *_Nullable MDCSideBarLayoutGuide(UIView *_Nonnull view);
