//
//  EPEntryEditorController.h
//  TidyWeblogger
//
//  Created by Simone Manganelli on 2008-03-15.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
@class EPWeblogEntry;
@class EPHTMLGenerator;
@class EPEntriesManager;


@interface EPEntryEditorController : NSWindowController {
	EPWeblogEntry *weblogEntry;
	EPWeblog *weblog;
	NSMutableDictionary *weblogEntryPrototype;
	EPHTMLGenerator *HTMLGeneratorInstance;
	EPEntriesManager *entriesManagerInstance;
	
	IBOutlet NSTextField *titleTextField;
	IBOutlet NSTextView *summaryTextView;
	IBOutlet WebView *editableWebView;
	IBOutlet NSTextView *markdownBodyTextView;
	IBOutlet NSScrollView *markdownScrollView;
	IBOutlet NSPopUpButton *categoryPopUpButton;
	IBOutlet NSArrayController *categoriesArrayController;
	
	IBOutlet NSTextField *customEndURLComponentTextField;
	
	BOOL markdownEditor;
}

- (IBAction)testAction:(id)sender;
- (IBAction)testAnnoyingProblemWithPopUpButton:(id)sender;
- (IBAction)testHiddenizing:(id)sender;

- (IBAction)saveEntry:(id)sender;
- (void)updateWeblogEntryPrototype;
- (IBAction)publishEntry:(id)sender;
- (IBAction)publishAllFiles:(id)sender;
- (void)saveStuffToEntryObject;

- (NSString *)entryCategoryID;
- (void)setEntryCategoryID:(NSString *)newEntryCategoryID;

- (NSMutableDictionary *)weblogEntryPrototype;
- (void)setWeblogEntryPrototype:(NSDictionary *)newWeblogEntryPrototype;

- (EPWeblog *)weblog;
- (void)setWeblog:(EPWeblog *)theNewWeblog;

- (EPWeblogEntry *)weblogEntry;
- (void)setWeblogEntry:(EPWeblogEntry *)theWeblogEntry;
- (void)setWeblogEntryObject:(EPWeblogEntry *)theWeblogEntry usingMarkdown:(BOOL)shouldUseMarkdown;
- (void)setHTMLGeneratorObject:(EPHTMLGenerator *)theHTMLGeneratorInstance;
- (void)setEntriesManagerObject:(EPEntriesManager *)theEntriesManagerInstance;

@end
