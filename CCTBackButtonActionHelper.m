//
//  CCTBackButtonActionHelper.m
//  BackButtonAction
//
//  Created by Weipin Xia on 5/13/13.
//  Copyright (c) 2013 Weipin Xia. All rights reserved.
//

#import "CCTBackButtonActionHelper.h"

@implementation CCTBackButtonActionHelper

+ (id)sharedInstance {
    static dispatch_once_t once;
    static CCTBackButtonActionHelper *instance;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });

    return instance;
}

- (BOOL)navigationController:(UINavigationController *)navigationController
               navigationBar:(UINavigationBar *)navigationBar
               shouldPopItem:(UINavigationItem *)item {
    if (navigationController.topViewController.navigationItem != item) {
        return YES;
    }

    UIViewController<CCTBackButtonActionHelperProtocol>* controller = nil;
    controller = (UIViewController<CCTBackButtonActionHelperProtocol>*)navigationController.topViewController;
    if ([controller respondsToSelector:@selector(cct_navigationBar:willPopItem:)]) {
        [controller cct_navigationBar:navigationBar willPopItem:item];
        return NO;
    }

    return YES;
}

@end
