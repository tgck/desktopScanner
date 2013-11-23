//
//  desktopScannerAppDelegate.h
//  desktopScanner
//
//  Created by tani on 13/11/23.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface desktopScannerAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end
