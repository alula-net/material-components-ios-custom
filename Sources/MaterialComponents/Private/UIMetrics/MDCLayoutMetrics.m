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

#import "MDCLayoutMetrics.h"

#import "MaterialApplication.h"

const CGFloat MDCFixedStatusBarHeightOnPreiPhoneXDevices = 20;
const CGFloat MDCStatusPillWidth = 132;

static const CGFloat kStatusPillNavigationBarHeight = 56;
static const CGFloat kStatusPillMinimumWindowWidth = 600;
static const CGFloat kSideBarExtent = 48;

static BOOL HasHardwareSafeAreas(void) {
  static BOOL hasHardwareSafeAreas = NO;
  if (@available(iOS 11.0, *)) {
    static BOOL hasCheckedForHardwareSafeAreas = NO;
    static dispatch_once_t onceToken;
    if (!hasCheckedForHardwareSafeAreas && [UIApplication mdc_safeSharedApplication].keyWindow) {
      dispatch_once(&onceToken, ^{
        UIEdgeInsets insets = [UIApplication mdc_safeSharedApplication].keyWindow.safeAreaInsets;
        hasHardwareSafeAreas = (insets.top > MDCFixedStatusBarHeightOnPreiPhoneXDevices ||
                                insets.left > 0 || insets.bottom > 0 || insets.right > 0);

        hasCheckedForHardwareSafeAreas = YES;
      });
    }
  }
  return hasHardwareSafeAreas;
}

CGFloat MDCDeviceTopSafeAreaInset(void) {
  CGFloat topInset = MDCFixedStatusBarHeightOnPreiPhoneXDevices;
  if (@available(iOS 11.0, *)) {
    // Devices with hardware safe area insets have fixed insets that depend on the device
    // orientation. On such devices, we aren't interested in the status bar's height because the
    // hardware safe area insets are what ultimately define the margins for the app. If we are
    // running on such a device, we read from the safe area insets instead of the fixed status bar
    // height so that we react to changes in safe area insets (usually due to orientation changes)
    // and update the fixed margin accordingly.
    if (HasHardwareSafeAreas()) {
      UIEdgeInsets insets = [UIApplication mdc_safeSharedApplication].keyWindow.safeAreaInsets;
      topInset = insets.top;
    }
  }
  return topInset;
}

CGFloat MDCStatusPillBandOverlap(UIWindow *window) {
  if (@available(iOS 13.0, *)) {
    UIWindow *hostWindow = window ?: [UIApplication mdc_safeSharedApplication].keyWindow;
    CGFloat topInset = hostWindow.safeAreaInsets.top;
    CGFloat statusBarHeight =
        hostWindow.windowScene.statusBarManager.statusBarFrame.size.height ?: topInset;
    if (CGRectGetWidth(hostWindow.bounds) >= kStatusPillMinimumWindowWidth &&
        topInset > kStatusPillNavigationBarHeight && statusBarHeight < topInset / 2) {
      return kStatusPillNavigationBarHeight;
    }
  }
  return 0;
}

UILayoutGuide *MDCSideBarLayoutGuide(UIView *view) {
#if defined(__IPHONE_27_1) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_27_1
  if (@available(iOS 27.1, *)) {
    UIViewLayoutRegion *region = [UIViewLayoutRegion layoutRegionForBarOnEdge:UIRectEdgeRight
                                                                       extent:kSideBarExtent];
    return [view layoutGuideForLayoutRegion:region];
  }
#endif
  return nil;
}

CGRect MDCSideBarFrameInView(UIView *view) {
#if defined(__IPHONE_27_1) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_27_1
  if (@available(iOS 27.1, *)) {
    UIWindow *window = view.window;
    if (!window) {
      return CGRectNull;
    }
    CGRect frame = MDCSideBarLayoutGuide(window).layoutFrame;
    UIEdgeInsets safeAreaInsets = window.safeAreaInsets;
    // Other iPhones report the region over the content; the Duo's sits in its own right inset.
    if (CGRectIsEmpty(frame) || safeAreaInsets.left > 0 ||
        safeAreaInsets.right < CGRectGetWidth(frame)) {
      return CGRectNull;
    }
    return [window convertRect:frame toView:view];
  }
#endif
  return CGRectNull;
}
