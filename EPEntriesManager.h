//
//  EPEntriesManager.h
//  TidyWeblogger
//
//  Created by Simone Manganelli on 2008-03-15.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class EPHTMLGenerator;
@class EPWeblogEntry;
@class EPWeblog;


@interface EPEntriesManager : NSObject {
	//NSMutableDictionary *entries;
	NSMutableArray *weblogs;
	//NSArray *listOfEntriesActiveSet;
	//IBOutlet NSArrayController *entriesController;
	IBOutlet NSDictionaryController *realEntriesController;
	IBOutlet NSArrayController *weblogsController;
	IBOutlet NSTableView *listOfEntriesTableView;
	IBOutlet EPHTMLGenerator *HTMLGeneratorInstance;
	IBOutlet NSWindow *listOfEntriesWindow;
	IBOutlet NSTextField *statusWindowText;
	IBOutlet NSProgressIndicator *inlineStatusProgressIndicator;
	IBOutlet NSTextField *inlineStatusText;
	
	//IBOutlet NSWindow *statusWindow;
	
	//NSDictionary *categoryDictionary;
	
	IBOutlet NSTextField *dotMacUsernameTextField;
	IBOutlet NSSecureTextField *dotMacPasswordTextField;
}

- (IBAction)testAction:(id)sender;


- (NSMutableArray *)weblogs;
- (void)setWeblogs:(NSArray *)newWeblogs;
- (void)importWeblog:(NSDictionary *)weblogPrototype;
- (IBAction)addNewWeblog:(id)sender;
- (void)saveNewWeblogToUserDefaults:(NSDictionary *)newWeblogPrototype;

- (void)createApplicationSupportFolderIfNeeded;

- (void)recalculatePublishOrderingForWeblog:(EPWeblog *)targetWeblog;
- (void)reloadTableViewData;

- (void)resetAndPublishAllEntriesForSelectedWeblog;
- (void)publishAllEntriesForSelectedWeblog;
- (void)publishAllEntriesForSelectedWeblogAndStop;
- (void)publishAllEntriesForWeblog:(EPWeblog *)targetWeblog;
- (IBAction)resetAndPublishAllEntries:(id)sender;
- (IBAction)publishAllEntries:(id)sender;

// future ideas for the status line:
	// use small green check, red stop sign, and yellow warning signs
		// for *persistent* status messages (i.e.: ones that stay on the screen
		// even though nothing's happening)
	// date and time stamps so users know when the persistent status messages
		// apply
- (void)startStatusUpdateSession;
- (void)stopStatusUpdateSession;
- (void)updateStatusWithString:(NSString *)statusString;
- (void)updateStatusLineAndWindowWithString:(NSString *)statusString;
- (void)stopStatusUpdateSessionOnMainThreadWithString:(NSString *)stopString;

/*- (NSString *)categoryDisplayNameForCategoryID:(NSString *)categoryID;
- (NSDictionary *)categoryDictionary;*/

- (NSDictionaryController *)realEntriesController;
- (IBAction)deleteSelectedWeblogEntry:(id)sender;
- (IBAction)createNewMarkdownWeblogEntry:(id)sender;
- (IBAction)createNewWebViewWeblogEntry:(id)sender;
- (void)createNewWeblogEntryUsingMarkdown:(BOOL)shouldUseMarkdown
								forWeblog:(EPWeblog *)targetWeblog;

//- (void)refreshListOfEntries;
- (IBAction)openWeblogEntry:(id)sender;
- (IBAction)importWeblogEntry:(id)sender;
- (void)importOpenPanelDidEnd:(NSOpenPanel *)importPanel returnCode:(int)returnCode contextInfo:(void  *)contextInfo;
- (void)scanFilesAndCreateWeblogEntryObjects:(NSArray *)pathToFilesToImport
								   forWeblog:(EPWeblog *)targetWeblog
							   rootDirectory:(NSString *)rootDirectory
						 traverseDirectories:(BOOL)shouldTraverseDirectories;
- (EPWeblogEntry *)partialWeblogEntryFromPrototype:(id)entryControllerKeyValuePair;
- (EPWeblogEntry *)weblogEntryForPlistFilePath:(NSString *)plistFilePath
									 forWeblog:(EPWeblog *)targetWeblog;
- (EPWeblogEntry *)scanHTMLFileAndReturnWeblogEntryObject:(NSString *)pathToFileToImport
												forWeblog:(EPWeblog *)targetWeblog;
//- (void)addWeblogEntryObject:(EPWeblogEntry *)theWeblogEntry deferFileWrite:(BOOL)shouldDeferWrite;
//- (void)writeListOfEntriesToDisk;

int dateCompare(id object1, id object2, void *context);
int dateCompareDescending(id object1, id object2, void *context);
int dateCompareAscending(id object1, id object2, void *context);
/*int entryTitleCompareDescending(id object1, id object2, void *context);
int entryTitleCompareAscending(id object1, id object2, void *context);
int entryCategoryCompareDescending(id object1, id object2, void *context);
int entryCategoryCompareAscending(id object1, id object2, void *context);
int dateCompare(id object1, id object2, void *context);
int entryTitleCompare(id object1, id object2, void *context);
int categoryCompare(id object1, id object2, void *context);*/

@end
