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
//@synthesize entriesDict;

- (id)init {
	if (self = [super init]) {
		//entries = [[NSMutableArray alloc] init];
		entriesDict = [[NSMutableDictionary alloc] init];
		pathToEntriesDictionary = [@"/" retain];
		templateFilesLocation = [@"/" retain];
		weblogTitle = [@"Untitled Weblog" retain];
		categoryDictionary = [[NSMutableDictionary alloc] init];
		categoryStats = [[NSMutableDictionary dictionary] retain];
	}
	
	return self;
}

- (void)dealloc;
{
	//[entries release];
	//[entriesDict release];
	[pathToEntriesDictionary release];
	[templateFilesLocation release];
	[weblogTitle release];
	[categoryDictionary release];
	[super dealloc];
}

/*- (NSMutableArray *)entries;
{
	return entries;
}

- (void)setEntries:(NSArray *)newEntries;
{
	if (entries != newEntries) {
		[entries autorelease];
		entries = [[NSMutableArray alloc] initWithArray:newEntries];
	}
}*/

- (NSMutableDictionary *)entriesDict;
{
	return entriesDict;
}

- (void)setEntriesDict:(NSDictionary *)newEntriesDict;
{
	//NSLog(@"setEntriesDict:");
	if (entriesDict != newEntriesDict) {
		[entriesDict autorelease];
		entriesDict = [[NSMutableDictionary alloc] initWithDictionary:newEntriesDict];
	}	
}

- (void)deleteEntryWithURLStringFromWeblog:(NSString *)URLString deferFileWrite:(BOOL)shouldDeferFileWrite;
{
	[entriesDict removeObjectForKey:URLString];
	
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
	
	// add the dictionary (without the weblog pointer) to the master list of entries for this weblog
	[entriesDict setObject:theNewEntryDict forKey:[[newWeblogEntry entryURL] absoluteString]];
	
	// add the dictionary (with the weblog pointer) to the entries array for bindings
	//NSMutableDictionary *entryDictCopy = [NSMutableDictionary dictionaryWithDictionary:theNewEntryDict];
	//[entryDictCopy setObject:self forKey:@"weblog"];
	
	if (! shouldDeferFileWrite) [self writeListOfEntriesToDisk];
}

// this method returns URLs with a trailing slash at the end
- (NSString *)baseWeblogURL;
{
	NSArray *iDiskPathArray = [[self baseWeblogPath] componentsSeparatedByString:@"/Volumes/simx/Sites/"];
	return [NSString stringWithFormat:@"http://homepage.mac.com/simx/%@/",[iDiskPathArray objectAtIndex:1]];
}

// this method returns paths *without* a trailing slash at the end
- (NSString *)baseWeblogPath;
{
	return [pathToEntriesDictionary stringByDeletingLastPathComponent];
}

- (NSString *)pathToEntriesDictionary;
{
	return pathToEntriesDictionary;
}

- (void)setPathToEntriesDictionary:(NSString *)newPathToEntriesDictionary;
{
	[newPathToEntriesDictionary retain];
	[pathToEntriesDictionary release];
	pathToEntriesDictionary = newPathToEntriesDictionary;
}

// this method will always return a path *without* a trailing slash
- (NSString *)templateFilesLocation;
{
	return templateFilesLocation;
}

- (void)setTemplateFilesLocation:(NSString *)newTemplateFilesLocation;
{
	NSString *expandedNewTemplateFilesLocation = [newTemplateFilesLocation stringByExpandingTildeInPath];
	[expandedNewTemplateFilesLocation retain];
	[templateFilesLocation release];
	templateFilesLocation = expandedNewTemplateFilesLocation;
}



- (NSString *)weblogTitle;
{
	return weblogTitle;
}

- (void)setWeblogTitle:(NSString *)newTitle;
{
	[newTitle retain];
	[weblogTitle release];
	weblogTitle = newTitle;
}


- (NSMutableDictionary *)categoryDictionary;
{
	//NSLog(@"EPWeblog is returning a categoryDictionary: %@",categoryDictionary);
	return categoryDictionary;
}

- (void)setCategoryDictionary:(NSDictionary *)newDictionary;
{
	//NSLog(@"EPWeblog is setting a categoryDictionary: %@",newDictionary);
	if (categoryDictionary != newDictionary) {
		[categoryDictionary autorelease];
		categoryDictionary = [[NSMutableDictionary alloc] initWithDictionary:newDictionary];
	}
}

- (NSMutableDictionary *)categoryStats;
{
	return categoryStats;
}

- (void)setCategoryStats:(NSDictionary *)newCategoryStats;
{
	if (categoryStats != newCategoryStats) {
		[categoryStats release];
		categoryStats = [[NSMutableDictionary alloc] initWithDictionary:newCategoryStats];
	}
}

- (void)writeListOfEntriesToDisk;
{
	NSDictionary *listOfEntriesFile = [NSDictionary dictionaryWithObjectsAndKeys:entriesDict,@"entriesDict",nil];
	BOOL successfulWrite = [listOfEntriesFile writeToFile:pathToEntriesDictionary atomically:YES];
	if (! successfulWrite) NSLog(@"Unsuccessful write of entries plist file",listOfEntriesFile);
}

/*- (void)refreshEntriesArray;
{
	NSMutableArray *bindingsCompliantEntries = [entries mutableArrayValueForKey:@"entries"];
	[bindingsCompliantEntries removeAllObjects];
	[bindingsCompliantEntries addObjectsFromArray:[entriesDict allValues]];
}*/


@end
