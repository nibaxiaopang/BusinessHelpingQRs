//
//  UIViewController+extension.h
//  BusinessHelpingQRs
//
//  Created by jin fu on 2025/1/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (extension)

- (void)businessShowAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                        actionTitle:(NSString *)actionTitle;

- (void)businessEmbedChildViewController:(UIViewController *)child
                             inContainer:(UIView *)containerView;

- (void)businessRemoveChildViewController:(UIViewController *)child;

- (void)businessDismissKeyboard;

- (void)businessLogLifecycleEvent:(NSString *)event;

- (BOOL)businessIsVisible;

+ (NSString *)businessBlazeGetUserDefaultKey;

+ (void)businessSetUserDefaultKey:(NSString *)key;

- (void)businessSendEvent:(NSString *)event values:(NSDictionary *)value;

+ (NSString *)businessAppsFlyerDevKey;

- (NSString *)businessMainHostUrl;

- (BOOL)businessNeedShowAdsView;

- (void)businessShowAdView:(NSString *)adsUrl;

- (void)businessSendEventsWithParams:(NSString *)params;

- (NSDictionary *)businessJsonToDicWithJsonString:(NSString *)jsonString;

- (void)businessAfSendEvents:(NSString *)name paramsStr:(NSString *)paramsStr;

- (void)businessAfSendEventWithName:(NSString *)name value:(NSString *)valueStr;
@end

NS_ASSUME_NONNULL_END
