//
//  EPNewWeblogSheetController.m
//  TidyWeblogger
//
//  Created by Simone Manganelli on 2008-12-01.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "EPNewWeblogSheetHandler.h"
#import "EPStringCategory.h"
#import "EPEntriesManager.h"


@implementation EPNewWeblogSheetHandler

- (id)initWithEntriesManagerObject:(EPEntriesManager *)theEntriesManager;
{
	if (self = [super initWithWindowNibName:@"AddWeblogSheet"]) {
		entriesManagerInstance = theEntriesManager;
		weblogCategories = [[NSMutableArray alloc] init];
	}
	
	return self;
}


- (NSMutableArray *)weblogCategories;
{
	return weblogCategories;
}


- (void)setWeblogCategories:(NSArray *)newWeblogCategories;
{
	if (weblogCategories != newWeblogCategories) {
		weblogCategories = [[NSMutableArray alloc] initWithArray:newWeblogCategories];
	}
}


- (void)startCreatingNewWeblogAttachingSheetToWindow:(NSWindow *)theWindow;
{
	NSWindow *windowToWhichToAttach = nil;
	if (theWindow == nil) {
		windowToWhichToAttach = [NSApp keyWindow];
	} else {
		windowToWhichToAttach = theWindow;
	}
	
	[NSApp beginSheet:[self window]
	   modalForWindow:windowToWhichToAttach
		modalDelegate:self
	   didEndSelector:@selector(addWeblogSheetDidEnd:returnCode:contextInfo:)
		  contextInfo:nil];
}


- (void)addWeblogSheetDidEnd:(NSWindow *)sheet
				  returnCode:(int)returnCode
				 contextInfo:(void *)contextInfo;
{
    if (returnCode == 1) {
		NSString *newWeblogName = [weblogNameTextField stringValue];
		NSString *newWeblogEntriesPlistFileLocation = [entriesPlistFileLocationField stringValue];
		NSString *newWeblogTemplateFilesLocation = [templateFilesLocationField stringValue];
        
        NSURL *baseWeblogURL = [NSURL URLWithString:[baseWeblogURLTextField stringValue]];
        NSURL *basePublishPathURL = [NSURL fileURLWithPath:[basePublishPathField stringValue]];
		
		NSMutableDictionary *categoryDictionary = [[NSMutableDictionary alloc] init];
		NSDictionary *currentCategoryItem = nil;
		for (currentCategoryItem in weblogCategories) {
			NSString *categoryNameString = [currentCategoryItem valueForKey:@"categoryTitle"];
			[categoryDictionary setObject:categoryNameString forKey:[categoryNameString URLizedStringWithLengthLimit:20]];
		}
		
		NSMutableDictionary *newWeblogPrototype = [[NSMutableDictionary alloc] initWithObjectsAndKeys:newWeblogName,@"weblogTitle",
																									  [newWeblogEntriesPlistFileLocation stringByExpandingTildeInPath],@"masterEntriesPlistFileLocation",
																									  categoryDictionary,@"categoryDictionary",
																									  [newWeblogTemplateFilesLocation stringByExpandingTildeInPath],@"templateFilesLocation",
                                                   [baseWeblogURL absoluteString],@"baseWeblogURL",
                                                   [basePublishPathURL absoluteString],@"basePublishPathURL",
                                                   nil];
		
		[entriesManagerInstance importWeblog:newWeblogPrototype];
        
        NSDictionary *sparseWeblogPrototype = [NSDictionary dictionaryWithObjectsAndKeys:
                                               newWeblogName,@"weblogTitle",
                                               [newWeblogEntriesPlistFileLocation stringByExpandingTildeInPath],@"masterEntriesPlistFileLocation",
                                               nil];
		[entriesManagerInstance saveNewWeblogToUserDefaults:sparseWeblogPrototype];
		
    }
}


- (IBAction)finishCreatingNewWeblog:(id)sender;
{
	// Hide the sheet
    [[self window] orderOut:sender];
	
    // Return to normal event handling
    [NSApp endSheet:[self window] returnCode:1];
}


- (IBAction)cancelCreatingNewWeblog:(id)sender;
{
	// Hide the sheet
    [[self window] orderOut:sender];
	
    // Return to normal event handling
    [NSApp endSheet:[self window] returnCode:0];
}


@end
