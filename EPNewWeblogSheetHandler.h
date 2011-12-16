//
//  EPNewWeblogSheetController.h
//  TidyWeblogger
//
//  Created by Simone Manganelli on 2008-12-01.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class EPEntriesManager;


@interface EPNewWeblogSheetHandler : NSWindowController {
	IBOutlet NSTextField *weblogNameTextField;
	IBOutlet NSTextField *entriesPlistFileLocationField;
	IBOutlet NSTextField *templateFilesLocationField;
	IBOutlet NSTableView *categoriesTableView;
    
    IBOutlet NSTextField *baseWeblogURLTextField;
    IBOutlet NSTextField *baseWebDirectoryPathField;
	
	NSMutableArray *weblogCategories;
	EPEntriesManager *entriesManagerInstance;
}

- (id)initWithEntriesManagerObject:(EPEntriesManager *)theEntriesManager;

- (IBAction)finishCreatingNewWeblog:(id)sender;
- (IBAction)cancelCreatingNewWeblog:(id)sender;

- (void)startCreatingNewWeblogAttachingSheetToWindow:(NSWindow *)theWindow;
- (void)addWeblogSheetDidEnd:(NSWindow *)sheet
				  returnCode:(int)returnCode
				 contextInfo:(void *)contextInfo;

@end
