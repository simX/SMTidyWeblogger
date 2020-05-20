//
//  EPWeblog.m
//  TidyWeblogger
//
//  Created by Simone Manganelli on 11/8/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "EPWeblog.h"
#import "EPWeblogEntry.h"


@implementation EPWeblog

@synthesize filteredOrderedEntryPrototypes;
@synthesize pathToEntriesDictionary;
@synthesize weblogTitle;
@synthesize templateFilesLocation;
@synthesize categoryDictionary;
@synthesize categoryStats;
@synthesize entriesDict;

@synthesize baseWeblogURL;
@synthesize basePublishPathURL;

- (id)init {
	if (self = [super init]) {
		[self setTemplateFilesLocation:[NSURL fileURLWithPath:@"/"]];
		[self setWeblogTitle:@"Untitled Weblog"];
	}
	
	return self;
}

- (NSURL *)baseFileDirectoryPath;
{
    return [[self pathToEntriesDictionary] URLByDeletingLastPathComponent]; 
}

- (void)deleteEntryWithURLStringFromWeblog:(NSString *)URLString deferFileWrite:(BOOL)shouldDeferFileWrite;
{
    NSMutableDictionary *newDict = [NSMutableDictionary dictionaryWithDictionary:[self entriesDict]];
	[newDict removeObjectForKey:URLString];
    [self setEntriesDict:[NSDictionary dictionaryWithDictionary:newDict]];
	
	if (! shouldDeferFileWrite) [self writeListOfEntriesToDisk];
}

- (void)addEntryToWeblog:(EPWeblogEntry *)newWeblogEntry deferFileWrite:(BOOL)shouldDeferFileWrite;
{
	
	NSMutableDictionary *theNewEntryDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[newWeblogEntry entryTitle],@"entryTitle",
									 [newWeblogEntry entryCategoryID],@"entryCategoryID",
									 [newWeblogEntry entryPlistFilePath],@"entryPlistFilePath",nil];
	
	
	NSString *entryPublishedDateStringShort = [newWeblogEntry entryPublishedDateStringShort];
	if (entryPublishedDateStringShort)
		[theNewEntryDict setObject:entryPublishedDateStringShort
							forKey:@"entryPublishedDateString"];
    
    NSMutableDictionary *newDict = [NSMutableDictionary dictionaryWithDictionary:[self entriesDict]];
	
	// add the dictionary (without the weblog pointer) to the master list of entries for this weblog
	[newDict setObject:theNewEntryDict forKey:[[newWeblogEntry entryURL] absoluteString]];
    [self setEntriesDict:[NSDictionary dictionaryWithDictionary:newDict]];
	
	// add the dictionary (with the weblog pointer) to the entries array for bindings
	//NSMutableDictionary *entryDictCopy = [NSMutableDictionary dictionaryWithDictionary:theNewEntryDict];
	//[entryDictCopy setObject:self forKey:@"weblog"];
	
	if (! shouldDeferFileWrite) [self writeListOfEntriesToDisk];
}

- (void)writeListOfEntriesToDisk;
{
    NSDictionary *listOfEntriesFile = [NSDictionary dictionaryWithObjectsAndKeys:[self categoryDictionary],@"categoryDictionary",
                                       [self weblogTitle],@"weblogTitle",
                                       [[self templateFilesLocation] path],@"templateFilesLocation",
                                       [self entriesDict],@"entriesDict",
                                       [[self baseWeblogURL] absoluteString],@"baseWeblogURL",
                                       [[self basePublishPathURL] absoluteString],@"basePublishPathURL",
                                       nil];
    
	BOOL successfulWrite = [listOfEntriesFile writeToURL:[self pathToEntriesDictionary]
                                              atomically:YES];
    
	if (! successfulWrite) NSLog(@"Unsuccessful write of entries plist file: %@",[self pathToEntriesDictionary]);
}


@end
