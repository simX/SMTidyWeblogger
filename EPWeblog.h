//
//  EPWeblog.h
//  TidyWeblogger
//
//  Created by Simone Manganelli on 11/8/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class EPWeblogEntry;

@interface EPWeblog : NSObject {
	// entriesDict contains plist file-compatible prototypes that can be written
	// to disk
	NSMutableDictionary *entriesDict;
	NSArray *filteredOrderedEntryPrototypes;
	
	NSString *pathToEntriesDictionary;
	NSString *templateFilesLocation;
	NSString *weblogTitle;
	NSMutableDictionary *categoryDictionary;
	NSMutableDictionary *categoryStats;
}

@property(copy) NSArray *filteredOrderedEntryPrototypes;
//@property(retain) NSMutableDictionary *entriesDict;

//- (NSMutableArray *)entries;
//- (void)setEntries:(NSArray *)newEntries;

- (NSMutableDictionary *)entriesDict;
- (void)setEntriesDict:(NSDictionary *)newEntriesDict;

- (void)deleteEntryWithURLStringFromWeblog:(NSString *)URLString deferFileWrite:(BOOL)shouldDeferFileWrite;
- (void)addEntryToWeblog:(EPWeblogEntry *)newWeblogEntry deferFileWrite:(BOOL)shouldDeferFileWrite;

// this method returns URLs with a trailing slash at the end
- (NSString *)baseWeblogURL;

// this method returns paths *without* a trailing slash at the end
- (NSString *)baseWeblogPath;
- (NSString *)pathToEntriesDictionary;
- (void)setPathToEntriesDictionary:(NSString *)newPathToEntriesDictionary;

// this method will always return a path *without* a trailing slash
- (NSString *)templateFilesLocation;
- (void)setTemplateFilesLocation:(NSString *)newTemplateFilesLocation;

- (NSString *)weblogTitle;
- (void)setWeblogTitle:(NSString *)newTitle;

- (NSMutableDictionary *)categoryDictionary;
- (void)setCategoryDictionary:(NSDictionary *)newDictionary;

- (NSMutableDictionary *)categoryStats;
- (void)setCategoryStats:(NSDictionary *)newCategoryStats;

- (void)writeListOfEntriesToDisk;
//- (void)refreshEntriesArray;

@end
