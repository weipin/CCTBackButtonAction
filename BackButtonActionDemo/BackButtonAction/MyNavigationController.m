//
//  MyNavigationController
//  BackButtonAction
//
//  Created by Weipin Xia on 5/13/13.
//  Copyright (c) 2013 Weipin Xia. All rights reserved.
//

#import "CCTBackButtonActionHelper.h"
#import "MyNavigationController.h"


@implementation MyNavigationController

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    BOOL should = [[CCTBackButtonActionHelper sharedInstance] navigationController:self
                                                               navigationBar:navigationBar
                                                               shouldPopItem:item];
    if (!should) {
        return NO;
    }

    return [super navigationBar:navigationBar shouldPopItem:item];
}

@end
