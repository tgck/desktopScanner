#import "DesktopScanner.h"

@implementation DesktopScanner

- (id)init
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	// setup network
	target = lo_address_new(NULL, SEND_TO_PORT);
	NSLog(@"Setup UDP Sending to port [%s]\n" , SEND_TO_PORT);	
		
	dict = [NSMutableDictionary dictionary];
	
	// get desktop items' path
	NSMutableArray* unixPaths = [self getUnixPaths];
	
	// gets finder items and their position for first time.
	NSArray* finderItems = [self getFinderItemsViaSB:unixPaths];	
	[self scanForDump:finderItems];
	
	// main loop
	while (TRUE) {
				
		// Scripting Bridge
		// updates finder items and their position
		finderItems = [self getFinderItemsViaSB:unixPaths];
		[self scanForUpdates:finderItems];
		
		sleep(POLLING_INTERVAL);
	}
	
	[finderItems dealloc];
	[pool drain];
	
	return self;
}


- (NSMutableArray*) getUnixPaths
{	
  NSArray*  paths = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES);
  NSString* theDirectory = [paths objectAtIndex:0];
	NSError*  error;
	
	// filter with certain extentions
	// NSString* theSuffix = @".aif";			
	NSString* theSuffix = @FILTER_SUFFIX;		
	
	NSMutableArray* targetPaths = [[NSMutableArray alloc] init];

  NSFileManager*  fileManager = [NSFileManager defaultManager];
  for (NSString *path in [fileManager contentsOfDirectoryAtPath:theDirectory error:&error]){
		NSDictionary *attrs = [fileManager attributesOfItemAtPath:path error:&error];
		
    if( [NSFileTypeRegular compare:[attrs objectForKey:NSFileType] ] 
			 && [path hasSuffix:theSuffix]){
			[targetPaths addObject:path];
    }
  }
	return targetPaths;
}

// accessor for Finder
- (NSArray*) getFinderItemsViaSB : (NSMutableArray*) unixPaths
{	
	// get finder items
	FinderApplication *finder = [SBApplication applicationWithBundleIdentifier:@"com.apple.finder"];
	SBElementArray *finderItems = [[finder desktop] files];	// SBで全部取る
	
	// filter items to use (aiffs)
	NSArray *procTargetArr = [[NSMutableArray alloc] init];
	for (id itemName in unixPaths) {
		[procTargetArr addObject:[finderItems objectWithName:itemName]];
	}
	
	return procTargetArr;
}

// dump sending 全送信 
- (void) scanForDump : (NSArray*) sbelementarr
{	
	NSUInteger index = 0;
	for (id finderItem in sbelementarr){

		// get current positions, send
		index++;
		CGPoint p = NSPointToCGPoint([finderItem desktopPosition]);
		NSValue *pAsObj = [NSValue value:&p withObjCType:@encode(CGPoint)];
		[dict setValue:pAsObj
						forKey:[finderItem name]];
		
		[self sendOscMessageSimple:@"/dump" :[finderItem name] :p];
		NSLog(@">> %d %@ %d %d", index, [finderItem name], (int)p.x, (int)p.y);
	}
}

// send for update 差分送信
- (void) scanForUpdates : (NSArray *)sbelementarr
{		
	NSUInteger index = 0;
	for (id finderItem in sbelementarr){
		
		// get current positions
		index++;
		CGPoint p = NSPointToCGPoint([finderItem desktopPosition]);
		NSValue *pAsObj = [NSValue value:&p withObjCType:@encode(CGPoint)];
		
		// lookup dictionary which contains previous position
		NSValue *prevPointAsNSValue = [dict valueForKey:[finderItem name]];
		
		// if differed, send
		if ([ pAsObj isNotEqualTo:prevPointAsNSValue]){
			
			CGPoint prevP;
			[prevPointAsNSValue getValue:&prevP];
						
			[dict setValue: pAsObj 
							forKey: [finderItem name]];
			
			[self sendOscMessageSimple:@"/diff" :[finderItem name] :p];
			NSLog(@">> %d %@ %d %d", index, [finderItem name], (int)p.x, (int)p.y);
		}
	}
}

- (void) sendOscMessageSimple : (NSString *)addr 
												  	  : (NSString *)filename 
													    : (CGPoint) p
{
	char* ad = [addr cStringUsingEncoding:(NSStringEncoding)NSUTF8StringEncoding];
	char* fn = [filename cStringUsingEncoding:(NSStringEncoding)NSUTF8StringEncoding];
	
	lo_send(target, ad, "sii", fn, (int)p.x, (int)p.y);
}

// osc send method for test
- (void) sendOscMessageTest
{	
	lo_send(target, "/dump", "sii", "AshesToAshes.aif", 523, 170);
	lo_send(target, "/dump", "sii", "lightchairfactoryrtgirledit.aif", 665, 362);
	lo_send(target, "/dump", "sii", "Going_downtown.aif", 523, 458);
	lo_send(target, "/dump", "sii", "GensoKikou.aif", 665, 170);
}

@end