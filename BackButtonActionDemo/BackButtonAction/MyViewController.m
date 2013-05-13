//
//  MyViewController.m
//  BackButtonAction
//
//  Created by Weipin Xia on 5/13/13.
//  Copyright 2013 Weipin Xia. All rights reserved.
//

#import "MyViewController.h"

@implementation MyViewController {
}


#pragma mark - Back button

- (void)cct_navigationBar:(UINavigationBar *)navigationBar willPopItem:(UINavigationItem *)item {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Are You Sure?"
                                                      message:nil
                                                     delegate:self
                                            cancelButtonTitle:@"No"
                                            otherButtonTitles:@"Yes", nil];
    [alertView show];
}

#pragma mark - Alert view delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.cancelButtonIndex == buttonIndex) {
        return;
    }

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Action

- (IBAction)next:(id)sender {
    MyViewController *controller = [[MyViewController alloc] init];
    controller.title = [NSString stringWithFormat:@"%d", [self.navigationController.viewControllers count]];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
