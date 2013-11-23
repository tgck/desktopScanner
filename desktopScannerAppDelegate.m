//
//  desktopScannerAppDelegate.m
//  desktopScanner
//
//  Created by tani on 13/11/23.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "desktopScannerAppDelegate.h"
#import "DesktopScanner.h"

@implementation desktopScannerAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
	
	DesktopScanner* app = [[DesktopScanner alloc] init];
	[app dealloc];
	
}

@end
