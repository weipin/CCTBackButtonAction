Problem
====

You want to show an alert view when user taps the back button on a navigation bar, and prevent the navigating if user decides to stay on the top view controller.

There are quite some questions on this topic over at stackoverflow: [link1](http://stackoverflow.com/questions/1214965/setting-action-for-back-button-in-navigation-controller), [link2](http://stackoverflow.com/questions/5217992/back-button-callback-in-navigationcontroller-in-ios), [link3](http://stackoverflow.com/questions/1214965/setting-action-for-back-button-in-navigation-controller).

This project tries to solve this problem with a reusable solution, which is based on two facts:

- The method `navigationBar:shouldPopItem:` in UINavigationController will be called, while UINavigationController is not declared to conform the UINavigationBarDelegate.
- The `item` passed to `navigationBar:shouldPopItem:` will vary, depending on how you pop the top view controller. If you navigate by tapping the back button, the `item` will be `navigationItem` of the "current" top controller. If you navigate by calling `popViewControllerAnimated:`, the `item` will be `navigationItem` of the "previous" controller.

This code has not been tested. There are not many lines of code, please use until you've reviewed it.

For more information, see [this post](http://articles.cocoahope.com/blog/2013/05/13/catch-navigationbar-back-button-action/).

Use CCTBackButtonActionHelper
====

- Include CCTBackButtonActionHelper.h and CCTBackButtonActionHelper.m in your project.

- Create a subclass of UINavigationController, import CCTBackButtonActionHelper.h, implement `navigationBar:shouldPopItem:` and create instances with this subclass:

```
    #import "CCTBackButtonActionHelper.h"

    - (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
        BOOL should = [[CCTBackButtonActionHelper sharedInstance] navigationController:self
                                                                   navigationBar:navigationBar
                                                                   shouldPopItem:item];
        if (!should) {
            return NO;
        }

        return [super navigationBar:navigationBar shouldPopItem:item];
    }
```

- In the view controller, implement `cct_navigationBar:willPopItem:(UINavigationItem *)item;` and show alert view there:

```
    - (void)cct_navigationBar:(UINavigationBar *)navigationBar willPopItem:(UINavigationItem *)item {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Are You Sure?"
                                                          message:nil
                                                         delegate:self
                                                cancelButtonTitle:@"No"
                                                otherButtonTitles:@"Yes", nil];
        [alertView show];
    }
```

- In the same view controller, implement alert view delegate and pop view controller manually.

```
    - (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
        if (alertView.cancelButtonIndex == buttonIndex) {
            return;
        }

        [self.navigationController popViewControllerAnimated:YES];
    }
```
