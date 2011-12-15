//
//  EPWeblogEntry.m
//  TidyWeblogger
//
//  Created by Simone Manganelli on 2008-03-05.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "EPWeblogEntry.h"


@implementation EPWeblogEntry

@synthesize publishOrderIndex;

- (id)init;
{
	if (self = [super init]) {
		entryTitle = [[NSString alloc] initWithString:@"Untitled Entry"];
		entryBodyHTML = [[NSString alloc] init];
		
		entryUneditedWebViewHTML = nil;
		entryMarkdownText = nil;
		
		entryAbstract = [[NSString alloc] initWithString:@""];
		entryURL = [[NSURL alloc] init];
		entryDeprecatedURL = nil;
		entryPlistFilePath = [[NSString alloc] init];
		entryCategoryID = [[NSString alloc] initWithString:@"unfiled"];
		entryPublishedDate = nil;
		entryPublishedDateString = [[NSString alloc] init];
	}
	
	return self;
}

- (void)dealloc;
{
	[entryTitle release];
	[entryBodyHTML release];
	[entryAbstract release];
	[entryURL release];
	[entryPlistFilePath release];
	[entryCategoryID release];
	[entryPublishedDate release];
	
	[super dealloc];
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"entryTitle: %@\nentryURL:%@\nentryCategoryID:%@\nentryPlistFilePath:%@\n",entryTitle,entryURL,entryCategoryID,entryPlistFilePath];
}

- (NSString *)entryTitle;
{
	return entryTitle;
}

- (void)setEntryTitle:(NSString *)newTitle;
{
	[newTitle retain];
	[entryTitle release];
	entryTitle = newTitle;
}


- (NSString *)entryBodyHTML;
{
	return entryBodyHTML;
}

- (void)setEntryBodyHTML:(NSString *)newEntryBodyHTML;
{
	[newEntryBodyHTML retain];
	[entryBodyHTML release];
	entryBodyHTML = newEntryBodyHTML;
}


- (NSString *)entryUneditedWebViewHTML;
{
	return entryUneditedWebViewHTML;
}

- (void)setEntryUneditedWebViewHTML:(NSString *)newEntryUneditedWebViewHTML;
{
	[newEntryUneditedWebViewHTML retain];
	[entryUneditedWebViewHTML release];
	entryUneditedWebViewHTML = newEntryUneditedWebViewHTML;
}

- (NSString *)entryMarkdownText;
{
	return entryMarkdownText;
}

- (void)setEntryMarkdownText:(NSString *)newMarkdownText;
{
	[newMarkdownText retain];
	[entryMarkdownText release];
	entryMarkdownText = newMarkdownText;
}


- (NSString *)entryAbstract;
{
	return entryAbstract;
}

- (void)setEntryAbstract:(NSString *)newEntryAbstract;
{
	[newEntryAbstract retain];
	[entryAbstract release];
	entryAbstract = newEntryAbstract;
}


- (NSURL *)entryURL;
{
	return entryURL;
}

- (void)setEntryURL:(NSURL *)newEntryURL;
{
	[newEntryURL retain];
	[entryURL release];
	entryURL = newEntryURL;
}


- (NSURL *)entryDeprecatedURL;
{
	return entryDeprecatedURL;
}

- (void)setEntryDeprecatedURL:(NSURL *)newEntryDeprecatedURL;
{
	[newEntryDeprecatedURL retain];
	[entryDeprecatedURL release];
	entryDeprecatedURL = newEntryDeprecatedURL;
}


- (NSString *)entryPlistFilePath;
{
	return entryPlistFilePath;
}

- (void)setEntryPlistFilePath:(NSString *)newEntryPlistFilePath;
{
	[newEntryPlistFilePath retain];
	[entryPlistFilePath release];
	entryPlistFilePath = newEntryPlistFilePath;
}


- (NSString *)entryCategoryID;
{
	//NSLog(@"EPWeblogEntry is retrieving an entryCategoryID: %@",entryCategoryID);
	return entryCategoryID;
}

- (void)setEntryCategoryID:(NSString *)newEntryCategoryID;
{
	//NSLog(@"EPWeblogEntry is setting an entryCategoryID: %@",newEntryCategoryID);
	[newEntryCategoryID retain];
	[entryCategoryID release];
	entryCategoryID = newEntryCategoryID;
}

- (NSString *)entryPublishedDateString;
{
	return [self entryPublishedDateStringShort];
}

- (NSString *)entryPublishedDateStringShort;
{
	return [entryPublishedDate descriptionWithCalendarFormat:@"%Y-%m-%d; %H:%M:%S" locale:[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]];
}

- (NSString *)entryPublishedDateStringLong;
{
	return [entryPublishedDate descriptionWithCalendarFormat:@"%A, %Y-%m-%d; %H:%M:%S" locale:[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]];
}

- (NSString *)RSSPublishedDateString;
{
	//NSLog(@"%@",[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);
	return [entryPublishedDate descriptionWithCalendarFormat:@"%a, %d %b %Y %H:%M:%S %z" locale:[NSLocale systemLocale]];
}

- (void)setEntryPublishedDateString:(NSString *)newEntryPublishedDateString;
{
	// set the string object first
	[newEntryPublishedDateString retain];
	[entryPublishedDateString release];
	entryPublishedDateString = newEntryPublishedDateString;
	
	// now set the date object
	NSCalendarDate *newEntryPublishedDate = nil;
	if (entryPublishedDateString != nil) {
		newEntryPublishedDate = [NSCalendarDate dateWithString:entryPublishedDateString calendarFormat:@"%Y-%m-%d; %H:%M:%S" locale:[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]];
	}
	[newEntryPublishedDate retain];
	[entryPublishedDate release];
	entryPublishedDate = newEntryPublishedDate;
}

- (NSDate *)entryPublishedDate;
{
	//NSLog(@"%@",entryPublishedDate);
	return entryPublishedDate;
}

- (void)setEntryPublishedDate:(NSDate *)newEntryPublishedDate;
{
	// set the NSCalendarDate object first
	NSCalendarDate *newEntryPublishedCalendarDate = (NSCalendarDate *)newEntryPublishedDate;
	[newEntryPublishedCalendarDate retain];
	[entryPublishedDate release];
	entryPublishedDate = newEntryPublishedCalendarDate;
	
	// now set the entryPublishedDate object, too
	NSString *newEntryPublishedDateString = nil;
	if (entryPublishedDate == nil) {
		newEntryPublishedDateString = @"";
	} else {
		newEntryPublishedDateString = [entryPublishedDate descriptionWithCalendarFormat:@"%Y-%m-%d; %H:%M:%S" locale:[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]];
	}
	[newEntryPublishedDateString retain];
	[entryPublishedDateString release];
	entryPublishedDateString = newEntryPublishedDateString;
}

- (BOOL)hasBeenPublished;
{
	BOOL hasBeenPublished = NO;
	
	if ([self entryPublishedDate] != nil) {
		hasBeenPublished = YES;
	}
	
	return hasBeenPublished;
}
	 
	

@end
