//
//  Alert.m
//  Flix
//
//  Created by Fiona Barry on 6/25/20.
//  Copyright © 2020 fbarry. All rights reserved.
//

#import "Alert.h"

UIAlertController *alert(void) {
    UIAlertController *alertController = [UIAlertController
                            alertControllerWithTitle:@"Cannot Load Movies"
                            message:@"The Internet connection appears to be offline."
                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *tryAgain = [UIAlertAction
                               actionWithTitle:@"Try Again"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
    }];
    [alertController addAction:tryAgain];

    return alertController;
}
