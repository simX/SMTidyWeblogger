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
	NSDictionary *entriesDict;
	NSArray *filteredOrderedEntryPrototypes;
	
	NSURL *pathToEntriesDictionary;
	NSURL *templateFilesLocation;
	NSString *weblogTitle;
	NSDictionary *categoryDictionary;
	NSDictionary *categoryStats;
    
    NSURL *baseFileDirectoryPath;
    NSURL *baseWeblogURL;
    NSURL *basePublishPathURL;
}

@property(copy) NSArray *filteredOrderedEntryPrototypes;
@property (strong) NSURL *pathToEntriesDictionary;
@property (strong) NSString *weblogTitle;
@property (strong) NSURL *templateFilesLocation;
@property (strong) NSDictionary *categoryDictionary;
@property (strong) NSDictionary *categoryStats;
@property (strong) NSDictionary *entriesDict;

@property (readonly) NSURL *baseFileDirectoryPath;
@property (strong) NSURL *baseWeblogURL;
@property (strong) NSURL *basePublishPathURL;


- (void)deleteEntryWithURLStringFromWeblog:(NSString *)URLString deferFileWrite:(BOOL)shouldDeferFileWrite;
- (void)addEntryToWeblog:(EPWeblogEntry *)newWeblogEntry deferFileWrite:(BOOL)shouldDeferFileWrite;

- (void)writeListOfEntriesToDisk;
//- (void)refreshEntriesArray;

- (void)migrateEntriesDict;

@end
