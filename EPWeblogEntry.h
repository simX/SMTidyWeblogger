//
//  EPWeblogEntry.h
//  TidyWeblogger
//
//  Created by Simone Manganelli on 2008-03-05.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface EPWeblogEntry : NSObject {
	NSString *entryTitle;
	NSString *entryBodyHTML;
	NSString *entryUneditedWebViewHTML;
	NSString *entryMarkdownText;
	NSString *entryAbstract;
	NSURL *entryURL;
	NSURL *entryDeprecatedURL;
	NSString *entryPlistFilePath;
	NSString *entryCategoryID;
	NSCalendarDate *entryPublishedDate;
	NSString *entryPublishedDateString;
	
	NSNumber *publishOrderIndex;
}

@property(assign) NSNumber *publishOrderIndex;

- (NSString *)entryTitle;
- (void)setEntryTitle:(NSString *)newTitle;

- (NSString *)entryBodyHTML;
- (void)setEntryBodyHTML:(NSString *)newEntryBodyHTML;

- (NSString *)entryUneditedWebViewHTML;
- (void)setEntryUneditedWebViewHTML:(NSString *)newEntryUneditedWebViewHTML;

- (NSString *)entryMarkdownText;
- (void)setEntryMarkdownText:(NSString *)newMarkdownText;

- (NSString *)entryAbstract;
- (void)setEntryAbstract:(NSString *)newEntryAbstract;

- (NSURL *)entryURL;
- (void)setEntryURL:(NSURL *)newEntryURL;

- (NSURL *)entryDeprecatedURL;
- (void)setEntryDeprecatedURL:(NSURL *)newEntryDeprecatedURL;

- (NSString *)entryPlistFilePath;
- (void)setEntryPlistFilePath:(NSString *)newEntryPlistFilePath;

- (NSString *)entryCategoryID;
- (void)setEntryCategoryID:(NSString *)newEntryCategoryID;

- (NSString *)entryPublishedDateString;
- (NSString *)entryPublishedDateStringShort;
- (NSString *)entryPublishedDateStringLong;
- (NSString *)RSSPublishedDateString;

- (NSDate *)entryPublishedDate;
- (void)setEntryPublishedDate:(NSDate *)newEntryPublishedDate;
- (void)setEntryPublishedDateString:(NSString *)newEntryPublishedDateString;

- (BOOL)hasBeenPublished;

@end
