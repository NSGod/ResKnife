#import "PasteboardDocument.h"
#import "Resource.h"

@implementation PasteboardDocument

- (id)init
{
	self = [super init];
	if( self )
	{
		[self readPasteboard:NSGeneralPboard];
	}
	return self;
}

- (void)readPasteboard:(NSString *)pbName
{
	NSPasteboard *pb = [NSPasteboard pasteboardWithName:pbName];
	NSArray *types = [pb types];
	NSEnumerator *enumerator = [types objectEnumerator];
	NSString *currentType;
	
	[[self undoManager] disableUndoRegistration];
	while( currentType = [enumerator nextObject] )
	{
		// create the resource & add it to the array
		NSString	*name		= pbName;
		NSString	*type;
		NSNumber	*resID;
		NSNumber	*attributes;
		NSData		*data;
		Resource	*resource;
		NS_DURING
			type = [currentType substringToIndex:3];
		NS_HANDLER
			type = currentType;
		NS_ENDHANDLER
		resID		= [NSNumber numberWithShort:0];
		attributes	= [NSNumber numberWithShort:0];
		data		= [pb dataForType:type];
		resource	= [Resource resourceOfType:type andID:resID withName:name andAttributes:attributes data:data];
		[resources addObject:resource];		// array retains resource
	}
	[[self undoManager] enableUndoRegistration];
}

@end