#import <Foundation/Foundation.h>
#import <ScriptingBridge/ScriptingBridge.h>
#import "Finder.h"
#import "lo/lo.h"
#define SEND_TO_PORT "8880"
#define POLLING_INTERVAL 1 // seconds
#define FILTER_SUFFIX ".aif"

@interface DesktopScanner : NSObject 
{
	lo_address target;
	NSMutableDictionary* dict;
}

-(void)scanForDump:(NSArray*)arr;
-(void)scanForUpdates:(NSArray*)arr;
-(void)sendOscMessageSimple:(NSString*)addr :(NSString*)filename :(CGPoint)p;
-(void)sendOscMessageTest;

-(NSMutableArray*) getUnixPaths;
-(NSArray*)getFinderItemsViaSB:(NSMutableArray*) targetPaths;

@end