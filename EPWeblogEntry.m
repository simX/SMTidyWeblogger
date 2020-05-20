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
		entryTitle = @"Untitled Entry";
		entryBodyHTML = [[NSString alloc] init];
		
		entryUneditedWebViewHTML = nil;
		entryMarkdownText = nil;
		
		entryAbstract = @"";
        entryURL = nil;
		entryDeprecatedURL = nil;
		entryPlistFilePath = [NSURL fileURLWithPath:@"/"];
		entryCategoryID = @"unfiled";
		entryPublishedDate = nil;
		entryPublishedDateString = [[NSString alloc] init];
	}
	
	return self;
}


- (NSString *)description
{
	return [NSString stringWithFormat:@"entryTitle: %@\nentryURL:%@\nentryCategoryID:%@\nentryPlistFilePath:%@\npublishOrderIndex: %@\n",entryTitle,entryURL,entryCategoryID,entryPlistFilePath,[self publishOrderIndex]];
}

- (NSString *)entryTitle;
{
	return entryTitle;
}

- (void)setEntryTitle:(NSString *)newTitle;
{
	entryTitle = newTitle;
}


- (NSString *)entryBodyHTML;
{
	return entryBodyHTML;
}

- (void)setEntryBodyHTML:(NSString *)newEntryBodyHTML;
{
	entryBodyHTML = newEntryBodyHTML;
}


- (NSString *)entryUneditedWebViewHTML;
{
	return entryUneditedWebViewHTML;
}

- (void)setEntryUneditedWebViewHTML:(NSString *)newEntryUneditedWebViewHTML;
{
	entryUneditedWebViewHTML = newEntryUneditedWebViewHTML;
}

- (NSString *)entryMarkdownText;
{
	return entryMarkdownText;
}

- (void)setEntryMarkdownText:(NSString *)newMarkdownText;
{
	entryMarkdownText = newMarkdownText;
}


- (NSString *)entryAbstract;
{
	return entryAbstract;
}

- (void)setEntryAbstract:(NSString *)newEntryAbstract;
{
	entryAbstract = newEntryAbstract;
}


- (NSURL *)entryURL;
{
	return entryURL;
}

- (void)setEntryURL:(NSURL *)newEntryURL;
{
	entryURL = newEntryURL;
}


- (NSURL *)entryDeprecatedURL;
{
	return entryDeprecatedURL;
}

- (void)setEntryDeprecatedURL:(NSURL *)newEntryDeprecatedURL;
{
	entryDeprecatedURL = newEntryDeprecatedURL;
}


- (NSURL *)entryPlistFilePath;
{
	return entryPlistFilePath;
}

- (void)setEntryPlistFilePath:(NSURL *)newEntryPlistFilePath;
{
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
	entryPublishedDateString = newEntryPublishedDateString;
	
	// now set the date object
	NSCalendarDate *newEntryPublishedDate = nil;
	if (entryPublishedDateString != nil) {
		newEntryPublishedDate = [NSCalendarDate dateWithString:entryPublishedDateString calendarFormat:@"%Y-%m-%d; %H:%M:%S" locale:[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]];
	}
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
	entryPublishedDate = newEntryPublishedCalendarDate;
	
	// now set the entryPublishedDate object, too
	NSString *newEntryPublishedDateString = nil;
	if (entryPublishedDate == nil) {
		newEntryPublishedDateString = @"";
	} else {
		newEntryPublishedDateString = [entryPublishedDate descriptionWithCalendarFormat:@"%Y-%m-%d; %H:%M:%S" locale:[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]];
	}
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
