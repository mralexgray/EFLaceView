//
//  MyDocument.m
//  EFLaceViewCoreData
//

#import "MyDocument.h"

@implementation MyDocument

- (void)windowWillClose:(NSNotification *)aNotification {
	if ([myView isDescendantOf: [[aNotification valueForKey:@"object"] contentView]]) {
		[myView unbind:@"dataObjects"];	[myView unbind:@"selectionIndexes"];
	}
}
- (NSString *)windowNibName {	return @"MyDocument";	}
- (void)windowControllerDidLoadNib:(NSWindowController *)windowController {
	[super windowControllerDidLoadNib:windowController];
	// user interface preparation code
	[myView bind: @"dataObjects" 		 toObject:controller withKeyPath:@"arrangedObjects"  options:nil];
	[myView bind: @"selectionIndexes" toObject:controller withKeyPath:@"selectionIndexes" options:nil];
}

- (void)printShowingPrintPanel:(BOOL)showPanels {
	// Obtain a custom view that will be printed
	NSView *printView = myView;
	[[self printInfo] setHorizontalPagination:NSFitPagination];
	[[self printInfo] setVerticalPagination:NSFitPagination];
	[[self printInfo] setOrientation:NSLandscapeOrientation];
	// Construct the print operation and setup Print panel
	NSPrintOperation *op = [NSPrintOperation printOperationWithView:printView printInfo:[self printInfo]];
	[op setShowsPrintPanel:showPanels];
	if (showPanels) {
		// Add accessory view, if needed
	}
	
	// Run operation, which shows the Print panel if showPanels was YES
	[self runModalPrintOperation:op delegate:nil didRunSelector:NULL contextInfo:NULL];
}

@end
