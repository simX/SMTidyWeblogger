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
}

@property(copy) NSArray *filteredOrderedEntryPrototypes;
@property (retain) NSURL *pathToEntriesDictionary;
@property (retain) NSString *weblogTitle;
@property (retain) NSURL *templateFilesLocation;
@property (retain) NSDictionary *categoryDictionary;
@property (retain) NSDictionary *categoryStats;
@property (retain) NSDictionary *entriesDict;

@property (retain) NSURL *baseFileDirectoryPath;
@property (retain) NSURL *baseWeblogURL;


- (void)deleteEntryWithURLStringFromWeblog:(NSString *)URLString deferFileWrite:(BOOL)shouldDeferFileWrite;
- (void)addEntryToWeblog:(EPWeblogEntry *)newWeblogEntry deferFileWrite:(BOOL)shouldDeferFileWrite;

- (void)writeListOfEntriesToDisk;
//- (void)refreshEntriesArray;

@end
