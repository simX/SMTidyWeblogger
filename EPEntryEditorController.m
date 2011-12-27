//
//  EPEntryEditorController.m
//  TidyWeblogger
//
//  Created by Simone Manganelli on 2008-03-15.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "EPWeblog.h"
#import "EPEntryEditorController.h"
#import "EPWeblogEntry.h"
#import "EPHTMLGenerator.h"
#import "EPEntriesManager.h"
#import "EPStringCategory.h"

@implementation EPEntryEditorController

- (id)init;
{
	if (self = [super initWithWindowNibName:@"EntryEditor"]) {
		weblog = nil;
		weblogEntry = nil;
		weblogEntryPrototype = nil;
		markdownEditor = NO;
	}
	
	return self;
}

- (IBAction)testAction:(id)sender;
{
	[entriesManagerInstance testAction:sender];
}


- (EPWeblogEntry *)weblogEntry;
{
	return weblogEntry;
}

- (NSObject *)weblogEntryPrototype;
{
	return weblogEntryPrototype;
}

- (void)setWeblogEntryPrototype:(NSObject *)newWeblogEntryPrototype;
{
	if (weblogEntryPrototype != newWeblogEntryPrototype) {
		weblogEntryPrototype = newWeblogEntryPrototype;
	}
}


- (void)setWeblogEntry:(EPWeblogEntry *)theWeblogEntry;
{
	if ([theWeblogEntry entryMarkdownText] == nil) {
		[self setWeblogEntryObject:theWeblogEntry usingMarkdown:NO];
	} else if ([theWeblogEntry entryUneditedWebViewHTML] == nil) {
		// we prefer WebView HTML over Markdown, because Markdown can be
		// converted to WebView HTML, but it's hard to convert from WebView
		// HTML back to Markdown
		
		[self setWeblogEntryObject:theWeblogEntry usingMarkdown:YES];
	}
}

- (NSString *)entryCategoryID;
{
	//NSLog(@"retrieving an ID? %@",[weblogEntry entryCategoryID]);
	/*NSLog(@"from array controller: %@",[categoriesArrayController arrangedObjects]);
	NSLog(@"from EPWeblog: %@",[weblog categoryDictionary]);
	NSLog(@"from NSPopUpButton title: %@",[[categoryPopUpButton selectedItem] title]);
	NSLog(@"from NSPopUpButton representedObject: %@",[[categoryPopUpButton selectedItem] representedObject]);*/
	return [weblogEntry entryCategoryID];
}

- (void)setEntryCategoryID:(NSString *)newEntryCategoryID;
{
	//NSLog(@"receiving an ID? %@",newEntryCategoryID);
	/*NSLog(@"from array controller: %@",[categoriesArrayController arrangedObjects]);
	NSLog(@"from EPWeblog: %@",[weblog categoryDictionary]);
	NSLog(@"from NSPopUpButton title: %@",[[categoryPopUpButton selectedItem] title]);
	NSLog(@"from NSPopUpButton representedObject: %@",[[categoryPopUpButton selectedItem] representedObject]);*/
	[weblogEntry setEntryCategoryID:newEntryCategoryID];
}

- (IBAction)testAnnoyingProblemWithPopUpButton:(id)sender;
{
	NSLog(@"item array: %@",[categoryPopUpButton itemArray]);
	//[categoryPopUpButton selectItem:[categoryPopUpButton selectedItem]];
}

- (IBAction)testHiddenizing:(id)sender;
{
	[markdownScrollView setHidden:YES];
	[titleTextField setHidden:YES];
	[summaryTextView setHidden:YES];
	[editableWebView setHidden:YES];
}

- (EPWeblog *)weblog;
{
	return weblog;
}

- (void)setWeblog:(EPWeblog *)theNewWeblog;
{
	if (theNewWeblog != weblog) {
		weblog = theNewWeblog;
	}
}

- (void)setWeblogEntryObject:(EPWeblogEntry *)theWeblogEntry usingMarkdown:(BOOL)shouldUseMarkdown;
{
	weblogEntry = theWeblogEntry;
	
	[titleTextField setStringValue:[weblogEntry entryTitle]];
	[summaryTextView setString:[weblogEntry entryAbstract]];
	
	if (shouldUseMarkdown) {
		markdownEditor = YES;
	} else {
		markdownEditor = NO;
	}
}

- (void)setEntryURL:(NSString *)theURLString;
{
	
}

- (void)setHTMLGeneratorObject:(EPHTMLGenerator *)theHTMLGeneratorInstance;
{
	HTMLGeneratorInstance = theHTMLGeneratorInstance;
}

- (void)setEntriesManagerObject:(EPEntriesManager *)theEntriesManagerInstance;
{
	entriesManagerInstance = theEntriesManagerInstance;
}


- (void)windowDidLoad;
{
	if (markdownEditor) {
		[editableWebView setHidden:YES];
		
		NSString *entryMarkdownText = [weblogEntry entryMarkdownText];
		if (entryMarkdownText == nil) {
			[markdownBodyTextView setString:@""];
		} else {
			[markdownBodyTextView setString:[weblogEntry entryMarkdownText]];
		}
	} else {
		[markdownScrollView setHidden:YES];
		
		// set up the editable web view by loading a blank page
		if ([weblogEntry entryUneditedWebViewHTML] != nil) {
			[[editableWebView mainFrame] loadHTMLString:
			 [NSString stringWithFormat:@"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\"><html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"en\" lang=\"en\"><head>\n</head><body>%@</body></html>",[weblogEntry entryUneditedWebViewHTML]]
												baseURL:nil];
		} else {
			[[editableWebView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[@"/Volumes/Macintosh HD/Users/simmy/Development/TidyWeblogger/Template Files/Blank HTML File.html" stringByExpandingTildeInPath]]]];
		}
		
		while ([[[editableWebView mainFrame] dataSource] isLoading]) {
			sleep(1);
		}
		
		[editableWebView setEditable:YES];
		
		
		// the following commented-out code produces a log line of just "<html></html>" for some reason, but retrieving the stuff in the
		// WebView later on is fine.  Not sure why.
		
		/*DOMHTMLElement *theNode = (DOMHTMLElement *)[[[editableWebView mainFrame] DOMDocument] documentElement];
		 NSMutableString *uneditedWebViewString = [[NSMutableString alloc] initWithString:[theNode outerHTML]];
		 NSLog(@"uneditedWebViewString: %@",uneditedWebViewString);*/
	}
	

	//[titleTextField setStringValue:[weblogEntry entryTitle]];
	if ([weblogEntry entryAbstract]) [summaryTextView setString:[weblogEntry entryAbstract]];
	[markdownBodyTextView setAlignment:NSNaturalTextAlignment];
	//[categoryPopUpButton selectItemWithTitle:[[weblog categoryDictionary] objectForKey:[weblogEntry entryCategoryID]]];
}


- (IBAction)saveEntry:(id)sender;
{
	[self saveStuffToEntryObject];
	
	// create the individual files on disk for the entry
	[HTMLGeneratorInstance createAndSaveHTMLFileUsingWeblogEntryObject:weblogEntry
															 forWeblog:weblog
														 shouldPublish:NO];
	
	
	[self updateWeblogEntryPrototype];
	//[weblog addEntryToWeblog:weblogEntry deferFileWrite:NO];
	
	[weblog writeListOfEntriesToDisk];
	
	//[entriesManagerInstance addWeblogEntryObject:weblogEntry deferFileWrite:NO];
}

- (void)updateWeblogEntryPrototype;
{
	// this line breaks MVC paradigm
	[[entriesManagerInstance realEntriesController] removeObject:weblogEntryPrototype];
	
	NSMutableDictionary *dictionaryValue = [NSMutableDictionary dictionary];
	[dictionaryValue setObject:[weblogEntry entryTitle] forKey:@"entryTitle"];
	[dictionaryValue setObject:[weblogEntry entryCategoryID] forKey:@"entryCategoryID"];
    NSURL *entryPlistFilePathURL = [weblogEntry entryPlistFilePath];
	[dictionaryValue setObject:[entryPlistFilePathURL path] forKey:@"entryPlistFilePath"];
	
	NSString *entryPublishedDateStringShort = [weblogEntry entryPublishedDateStringShort];
	if (entryPublishedDateStringShort)
		[dictionaryValue setObject:entryPublishedDateStringShort forKey:@"entryPublishedDateString"];
	
	NSMutableDictionary *testMutDict = [NSMutableDictionary dictionaryWithDictionary:[weblog entriesDict]];
	[testMutDict setObject:dictionaryValue forKey:[[weblogEntry entryURL] absoluteString]];
	[weblog setEntriesDict:testMutDict];
}

- (IBAction)publishEntry:(id)sender;
{
	[self saveStuffToEntryObject];
	[HTMLGeneratorInstance createAndSaveHTMLFileUsingWeblogEntryObject:weblogEntry
															 forWeblog:weblog
														 shouldPublish:YES];
	[self updateWeblogEntryPrototype];
	[weblog writeListOfEntriesToDisk];
	[entriesManagerInstance recalculatePublishOrderingForWeblog:weblog];
}

- (IBAction)publishAllFiles:(id)sender;
{
	//BOOL hasBeenPublished = [weblogEntry hasBeenPublished];
	
	[self saveStuffToEntryObject];
	[HTMLGeneratorInstance createAndSaveHTMLFileUsingWeblogEntryObject:weblogEntry
															 forWeblog:weblog
														 shouldPublish:YES];
	[self updateWeblogEntryPrototype];
	
	[entriesManagerInstance recalculatePublishOrderingForWeblog:weblog];
	
	/*int previousEntryFilteredOrderedIndex = 0;
	if (hasBeenPublished) {
		previousEntryFilteredOrderedIndex = 1;
	}*/
	
	NSString *previousEntryPlistFilePath = [[[weblog valueForKey:@"filteredOrderedEntryPrototypes"] objectAtIndex:1] valueForKeyPath:@"value.entryPlistFilePath"];
	EPWeblogEntry *previousEntry = [entriesManagerInstance weblogEntryForPlistFilePath:previousEntryPlistFilePath forWeblog:weblog];
	[HTMLGeneratorInstance createAndSaveHTMLFileUsingWeblogEntryObject:previousEntry
															 forWeblog:weblog
														 shouldPublish:YES];
	
	[weblog writeListOfEntriesToDisk];
	
	
	[entriesManagerInstance publishAllEntriesForWeblog:weblog];
}

- (void)saveStuffToEntryObject;
{
	[weblogEntry setEntryTitle:[titleTextField stringValue]];
	[weblogEntry setEntryAbstract:[summaryTextView string]];
	[weblogEntry setEntryCategoryID:[[[categoryPopUpButton selectedItem] title] URLizedStringWithLengthLimit:20]];
	
	// update the publish order index in the EPWeblogEntry object from the prototype object
	
	NSNumber *entryPublishOrderIndex = nil;
	entryPublishOrderIndex = [weblogEntryPrototype valueForKeyPath:@"value.publishOrderIndex"];
	if (entryPublishOrderIndex) [weblogEntry setPublishOrderIndex:[weblogEntryPrototype valueForKeyPath:@"value.publishOrderIndex"]];
	
	if (markdownEditor) {
		[weblogEntry setEntryMarkdownText:[markdownBodyTextView string]];
	} else {
		NSMutableString *uneditedWebViewString = [[NSMutableString alloc] initWithString:[(DOMHTMLElement *)[[[[editableWebView mainFrame] DOMDocument] documentElement] lastChild] innerHTML]];
		NSLog(@"uneditedWebViewString: %@",uneditedWebViewString);
		[weblogEntry setEntryUneditedWebViewHTML:uneditedWebViewString];
	}
}



@end
