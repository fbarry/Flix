//
//  Utilities.h
//  Flix
//
//  Created by Fiona Barry on 6/25/20.
//  Copyright © 2020 fbarry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utilities : NSObject

+ (void) showAlertWithTitle:(NSString *)title
                    message:(NSString *)message
                buttonTitle:(NSString *)buttonTitle
              buttonHandler:(void (^)(UIAlertAction *action))handler
          secondButtonTitle:(NSString *)secondButtonTitle
        secondButtonHandler:(void (^)(UIAlertAction *secondAction))secondHandler
           inViewController:(UIViewController *)viewController;

@end
