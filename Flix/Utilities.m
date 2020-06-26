//
//  Utilities.m
//  Flix
//
//  Created by Fiona Barry on 6/25/20.
//  Copyright © 2020 fbarry. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

// For handler signature, learn this from Apple iOS class API reference
// e.g. + (instancetype)actionWithTitle:(nullable NSString *)title style:(UIAlertActionStyle)style handler:(void (^ __nullable)(UIAlertAction *action))handler;
// the type is '(void (^ __nullable)(UIAlertAction *action))'
+ (void) showAlertWithTitle:(NSString *)title
                    message:(NSString *)message
                buttonTitle:(NSString *)buttonTitle
              buttonHandler:(void (^)(UIAlertAction *action))handler
           inViewController:(UIViewController *)viewController {

    UIAlertController *const alertController = [UIAlertController
                                               alertControllerWithTitle:title
                                               message:message
                                               preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction
                             actionWithTitle:buttonTitle
                             style:UIAlertActionStyleDefault
                             handler:handler];
   [alertController addAction:action];
   [viewController presentViewController:alertController animated:YES completion:nil];
}

@end
