//
//  EPHTMLGenerator.m
//  TidyWeblogger
//
//  Created by Simone Manganelli on 2008-01-31.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "EPHTMLGenerator.h"
#import "EPWeblogEntry.h"
#import "EPStringCategory.h"
#import "EPWeblog.h"
#import "NSURL+SMURLAdditions.h"


@implementation EPHTMLGenerator

// returns YES if everything is OK
- (BOOL)pathIsAvailableForWeblog:(EPWeblog *)targetWeblog
					URLizedTitle:(NSString *)URLizedTitle
				 URLizedCategory:(NSString *)URLizedCategory;
{
	BOOL noErrors = YES;
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	BOOL isDirectory = NO;
	BOOL fileExists = [fileManager fileExistsAtPath:[NSString stringWithFormat:@"%@/%@/",[targetWeblog baseFileDirectoryPath],URLizedCategory] isDirectory:&isDirectory];
	
	if (isDirectory && fileExists) {
		// this is good
		//NSLog(@"folder exists");
	} else if (! fileExists) {
        NSError *directoryCreationError = nil;
        NSString *pathForDirectoryToCreate = [NSString stringWithFormat:@"%@/%@",[targetWeblog baseFileDirectoryPath],URLizedCategory];
		BOOL succeeded = [fileManager createDirectoryAtPath:pathForDirectoryToCreate
                                withIntermediateDirectories:YES
                                                 attributes:nil
                                                      error:&directoryCreationError];
        
        if (! succeeded) {
            NSLog(@"Error creating directory at path %@: %@",pathForDirectoryToCreate,[directoryCreationError localizedDescription]);
        }
	} else {
		// there's a file with that name, not a folder
		
		// this is bad
		NSBeep();
		NSBeep();
		NSBeep();
		noErrors = NO;
	}
	
	/* ]{}[}{]{}[}{]{}[}{]{}[}{]{}[}{]{}[ */
	// the URL needs to be conflict-checked here!
	// HERE I SAY, HERE!  OMG HERE!
	/* ]{}[}{]{}[}{]{}[}{]{}[}{]{}[}{]{}[ */
	
	NSString *existingHTMLFilePath = [NSString stringWithFormat:@"%@/%@/%@.html",[targetWeblog baseFileDirectoryPath],URLizedCategory,URLizedTitle];
	BOOL entryFileExists = [fileManager fileExistsAtPath:existingHTMLFilePath];
	if (entryFileExists) {
		// there's already a file with that name
		
		NSDictionary *testPlist = [NSDictionary dictionaryWithContentsOfFile:[NSString stringWithFormat:@"%@/%@/%@.plist",[targetWeblog baseFileDirectoryPath],URLizedCategory,URLizedTitle]];
		if (testPlist == nil) {
			// the existing file wasn't created by TidyWeblogger, so move it and then continue
			
			NSError *moveError = nil;
			
			NSString *pathToWhichToMove = [NSString stringWithFormat:@"%@/%@/%@-backup.html",[targetWeblog baseFileDirectoryPath],URLizedCategory,URLizedTitle];
			BOOL moveSuccessful = [fileManager moveItemAtPath:existingHTMLFilePath
													   toPath:pathToWhichToMove
														error:&moveError];
			
			if (! moveSuccessful) {
				noErrors = NO;
				NSLog(@"%@",moveError);
			} else {
				noErrors = YES;
			}
		} else {
			
			// it's OK, it was created by TidyWeblogger so we can replace it safely (this should be changed to check for a UUID, maybe)
		}
	}
	
	return noErrors;
}


- (BOOL)writePlistFileForWeblogEntryObject:(EPWeblogEntry *)theWeblogEntry
								 forWeblog:(EPWeblog *)targetWeblog
							   publishDate:(NSCalendarDate *)entryPublishedDate;
{
    NSURL *entryPlistFilePathURL = [theWeblogEntry entryPlistFilePath];
	
	NSDictionary *entryDict = [NSMutableDictionary dictionary];
	if ([theWeblogEntry entryTitle]) [entryDict setValue:[theWeblogEntry entryTitle] forKey:@"Title"];
	if ([theWeblogEntry entryAbstract]) [entryDict setValue:[theWeblogEntry entryAbstract] forKey:@"Summary"];
	if ([theWeblogEntry entryUneditedWebViewHTML]) [entryDict setValue:[theWeblogEntry entryUneditedWebViewHTML] forKey:@"Unedited WebView HTML"];
	if ([theWeblogEntry entryMarkdownText]) [entryDict setValue:[theWeblogEntry entryMarkdownText] forKey:@"Unedited Markdown Text"];
	if ([theWeblogEntry entryCategoryID]) [entryDict setValue:[theWeblogEntry entryCategoryID] forKey:@"CategoryID"];
	if (entryPlistFilePathURL) [entryDict setValue:[entryPlistFilePathURL path] forKey:@"entryPlistFilePath"];
	if ([[theWeblogEntry entryURL] absoluteString]) [entryDict setValue:[[theWeblogEntry entryURL] absoluteString] forKey:@"entryURL"];
	if ([[theWeblogEntry entryDeprecatedURL] absoluteString])
		[entryDict setValue:[[theWeblogEntry entryDeprecatedURL] absoluteString] forKey:@"entryDeprecatedURL"];
	if (entryPublishedDate) [entryDict setValue:entryPublishedDate forKey:@"Publish Date"];
	
    BOOL isDirectory = NO;
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:[[entryPlistFilePathURL URLByDeletingLastPathComponent] path]
                                         isDirectory:&isDirectory];
    
    if (! exists) {
        NSError *createError = nil;
        BOOL succeeded = [[NSFileManager defaultManager] createDirectoryAtURL:[entryPlistFilePathURL URLByDeletingLastPathComponent]
                                 withIntermediateDirectories:YES
                                                  attributes:nil
                                                       error:&createError];
        
        if (! succeeded) {
            NSLog(@"creating intermediate directory did not succeed: %@",createError);
        }
    } else if (exists && (! isDirectory)) {
        NSLog(@"File exists where folder should be.  Oops.");
    }
    
	BOOL successfulWrite = [entryDict writeToURL:[theWeblogEntry entryPlistFilePath] atomically:YES];
	if (! successfulWrite) NSLog(@"Unsuccessful write of plist file.");
	return successfulWrite;
}

- (void)createDummyFileAtFileURL:(NSURL *)URLToWrite
                redirectingToURL:(NSURL *)URLToRedirectTo;
{
    NSURL *parentDirURL = [URLToWrite URLByDeletingLastPathComponent];
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    
    NSError *dirError = nil;
    BOOL succeeded = [defaultManager createDirectoryAtURL:parentDirURL withIntermediateDirectories:YES attributes:nil error:&dirError];
    
    if (! succeeded) NSLog(@"Error creating directory at %@: %@",parentDirURL,dirError);
    
    NSString *dummyFileContents = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\"><html xmlns=\"http://www.w3.org/1999/xhtml\"><head><title></title><meta http-equiv=\"refresh\" content=\"0;url=%@\" /></head><body></body></html>",[URLToRedirectTo absoluteString]];
    
    BOOL fileWriteSuccess = [defaultManager createFileAtPath:[URLToWrite path] contents:[dummyFileContents dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    if (! fileWriteSuccess) NSLog(@"Dummy file not successfully created at %@",URLToWrite);
}

- (void)createAndSaveHTMLFileUsingWeblogEntryObject:(EPWeblogEntry *)theWeblogEntry
										  forWeblog:(EPWeblog *)targetWeblog
									  shouldPublish:(BOOL)shouldPublish;
{
	NSString *truncatedTitle = [[theWeblogEntry entryTitle] URLizedStringWithLengthLimit:40];
	NSString *truncatedCategory = [[theWeblogEntry entryCategoryID] URLizedStringWithLengthLimit:20];
	
	BOOL noPathErrors = [self pathIsAvailableForWeblog:targetWeblog
										  URLizedTitle:truncatedTitle
									   URLizedCategory:truncatedCategory];
	if (! noPathErrors) return;
		
	NSCalendarDate *entryPublishedDate = (NSCalendarDate *)[theWeblogEntry entryPublishedDate];
    
    NSURL *categoryFolderURL = [[targetWeblog basePublishPathURL] URLByAppendingPathComponent:truncatedCategory];
    NSURL *noExtensionURL = [categoryFolderURL URLByAppendingPathComponent:truncatedTitle];
    NSURL *publishURL = [noExtensionURL URLByAppendingPathExtension:@"html"];
    
    NSURL *draftCategoryFolderURL = [[targetWeblog baseFileDirectoryPath] URLByAppendingPathComponent:truncatedCategory];
    NSURL *draftNoExtensionURL = [draftCategoryFolderURL URLByAppendingPathComponent:truncatedTitle];
    NSURL *draftSaveURL = [draftNoExtensionURL URLByAppendingPathExtension:@"html"];
    
    NSError *dirCreateError = nil;
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    BOOL succeeded = [defaultManager createDirectoryAtURL:categoryFolderURL
                         withIntermediateDirectories:YES
                                          attributes:nil
                                               error:&dirCreateError];
    if (! succeeded) {
        NSLog(@"Error creating category folder: %@",dirCreateError);
    }
    
    NSString *templateLocationPath = [[targetWeblog templateFilesLocation] path];
	if (shouldPublish) {
		BOOL firstPublish = YES;
		if (entryPublishedDate != nil) {
			firstPublish = NO;
		} else {
			firstPublish = YES;
			entryPublishedDate = [NSCalendarDate calendarDate];
		}
		
		// set the date here, otherwise getting the date string will fail
		[theWeblogEntry setEntryPublishedDate:entryPublishedDate];
        
		[self writeFileForArrayOfWeblogEntryObjects:[NSArray arrayWithObject:theWeblogEntry]
										  forWeblog:targetWeblog
									currentCategory:nil
								  usingPageTemplate:nil
						  usingForEachEntryTemplate:[NSString stringWithFormat:@"%@/Entry Page Template.txt",templateLocationPath]
							   usingSidebarTemplate:[NSString stringWithFormat:@"%@/Sidebar Template.txt",templateLocationPath]
											 toPath:[publishURL path]
                                    basePublishPath:[[targetWeblog basePublishPathURL] path]
									  validatingXML:YES
									   firstPublish:firstPublish];
		
		if (firstPublish) {
			/*BOOL successfulActivation = [commentsManagerInstance activateCommentsWithUsernameTextField:dotMacUsernameTextField
																			   passwordSecureTextField:dotMacPasswordTextField
																							webPageURL:[NSString stringWithFormat:@"%@%@/%@.html",[targetWeblog baseWeblogURL],truncatedCategory,truncatedTitle]
										 ];
			if (! successfulActivation) {
				// there was an error activating the comments; reset the published date to nil
				[theWeblogEntry setEntryPublishedDate:nil];
				entryPublishedDate = nil;
				NSBeep();
			}*/
		}
	} else {
		[self writeFileForArrayOfWeblogEntryObjects:[NSArray arrayWithObject:theWeblogEntry]
										  forWeblog:targetWeblog
									currentCategory:nil
								  usingPageTemplate:nil
						  usingForEachEntryTemplate:[NSString stringWithFormat:@"%@/Entry Page Template.txt",templateLocationPath]
							   usingSidebarTemplate:[NSString stringWithFormat:@"%@/Sidebar Template.txt",templateLocationPath]
											 toPath:[draftSaveURL path]
                                    basePublishPath:[[targetWeblog baseFileDirectoryPath] path]
									  validatingXML:YES
									   firstPublish:NO];
	}
	
	
    NSURL *entryPlistFileURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@.plist",truncatedCategory,truncatedTitle]
                                      relativeToURL:[targetWeblog baseFileDirectoryPath]];
	[theWeblogEntry setEntryPlistFilePath:entryPlistFileURL];
    NSURL *entryURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@.html",truncatedCategory,truncatedTitle]
                             relativeToURL:[targetWeblog baseWeblogURL]];
	[theWeblogEntry setEntryURL:entryURL];
	
	
	// if the entry has a deprecated URL, create a dummy file to redirect the old URL to
	// the new URL
	
    if (shouldPublish) {
        NSURL *deprecatedURL = [theWeblogEntry entryDeprecatedURL];
        NSString *deprecatedURLString = [deprecatedURL absoluteString];
        if (deprecatedURLString) {
            NSString *relativeDeprecatedURLString = deprecatedURLString;
            if ([deprecatedURLString hasPrefix:@"http://homepage.mac.com/simx/supernova/english/"]) {
                relativeDeprecatedURLString = [[deprecatedURLString componentsSeparatedByString:@"http://homepage.mac.com/simx/supernova/english/"] objectAtIndex:1];
            } else if ([deprecatedURLString hasPrefix:@"http://homepage.mac.com/simx/technonova/"]) {
                relativeDeprecatedURLString = [[deprecatedURLString componentsSeparatedByString:@"http://homepage.mac.com/simx/technonova/"] objectAtIndex:1];
            } else {
                // assume that it's already a relative URL
            }
            
            NSURL *basePublishPathURL = [targetWeblog basePublishPathURL];
            NSURL *dummyPageURL = [basePublishPathURL URLByAppendingPathComponent:relativeDeprecatedURLString isDirectory:NO];
            
            if (! [[entryURL relativeString] isEqualToString:relativeDeprecatedURLString]) {
                [self createDummyFileAtFileURL:dummyPageURL
                              redirectingToURL:entryURL];
            } else {
                NSLog(@"Umm... create an infinite redirecting loop?  No!  Title: %@",[theWeblogEntry entryTitle]);
            }
            
#warning convert deprecated URLs to an array of deprecated relative URLs to the base publish folder
            /*NSString *dummyiDiskFileURL = [commentsManagerInstance convertURLToiDiskFileURL:[[theWeblogEntry entryDeprecatedURL] absoluteString]
             preservingRootFolder:YES];
             [commentsManagerInstance createDummyFile:dummyiDiskFileURL
             entryPageURL:[[theWeblogEntry entryURL] absoluteString]
             iDiskUsername:[dotMacUsernameTextField stringValue]];*/
        }
    }
	
	
	// entryPublishedDate will still be nil if it hasn't been published, and if
	// the current action is only to save, not to publish
	[self writePlistFileForWeblogEntryObject:theWeblogEntry
								   forWeblog:targetWeblog
								 publishDate:entryPublishedDate];

}

// the forEachEntryPath argument can be nil, and this method will only use
// the template located at pageTemplatePath; if the pageTemplatePath is nil,
// then this method will assume all desired markup is contained within the page
// located at forEachEntryPath

// please note that general dynamic tags (such as {[WEBLOGTITLE]} ) can be used
// in the template for each entry, because even though they will not be 
// replaced in the for loop that creates the markup for each entry, they will
// be replaced outside the for loop when other general dynamic tags from 
// the main page template path are replaced
- (BOOL)writeFileForArrayOfWeblogEntryObjects:(NSArray *)arrayOfEntryObjects
									forWeblog:(EPWeblog *)targetWeblog
							  currentCategory:(NSString *)currentCategoryID
							usingPageTemplate:(NSString *)pageTemplatePath
					usingForEachEntryTemplate:(NSString *)forEachEntryPath
						 usingSidebarTemplate:(NSString *)sidebarPath
									   toPath:(NSString *)fileWritePath
                              basePublishPath:(NSString *)basePublishPath
								validatingXML:(BOOL)shouldValidateXML
								 firstPublish:(BOOL)firstPublish;
{
	NSCalendarDate *currentDate = [NSCalendarDate calendarDate];
	NSDictionary *categoryDictionary = [targetWeblog categoryDictionary];
	
	NSMutableString *mainPageTemplateString = [NSMutableString stringWithString:@"{[FOREACHENTRY]}"];
	if (pageTemplatePath != nil) {
		NSError *readTemplateError = nil;
		mainPageTemplateString = [NSMutableString stringWithContentsOfFile:pageTemplatePath encoding:NSUTF8StringEncoding error:&readTemplateError];
		if (readTemplateError) {
			NSLog(@"Error reading page template: %@",readTemplateError);
		}
	}
	

    NSURL *basePublishURL = [NSURL fileURLWithPath:basePublishPath];
    NSString *relativePath = [basePublishURL relativePathFromURL:[NSURL fileURLWithPath:fileWritePath]];
	NSURL *currentFileURL = [[NSURL fileURLWithPath:fileWritePath] relativeURLStartingFromBaseURL:basePublishURL];
	NSMutableString *allMainPageEntriesString = [NSMutableString stringWithString:@""];
	if (forEachEntryPath != nil) {
		
		// read the template file that contains the markup for each entry
		NSError *readForEachEntryTemplateError = nil;
		NSMutableString *forEachEntryTemplateString = [NSMutableString stringWithContentsOfFile:forEachEntryPath encoding:NSUTF8StringEncoding error:&readForEachEntryTemplateError];
		if (readForEachEntryTemplateError) {
			NSLog(@"%@",readForEachEntryTemplateError);
		} else {
			//NSLog(@"%@",templateString);
		}
		
		// step through each entry and use the template to create the markup
		// for each entry in the array
		allMainPageEntriesString = [[NSMutableString alloc] init];
		
		// this is for the year and month headers, if applicable
		NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
		NSInteger previousMonth = 0;
		NSInteger previousYear = 0;
		
		int i = 0;
		for (i = 0; i < [arrayOfEntryObjects count]; i++) {
			NSMutableString *currentEntryString = [NSMutableString stringWithString:forEachEntryTemplateString];
			EPWeblogEntry *currentWeblogEntry = [arrayOfEntryObjects objectAtIndex:i];
			
			NSString *entryTitle = [currentWeblogEntry entryTitle];
			NSString *entryCategoryID = [currentWeblogEntry entryCategoryID];
			//NSLog(@"categoryDictionary: %@",categoryDictionary);
			//NSLog(@"blogInfoDict: %@",blogInfoDict);
			NSString *entryCategory = [categoryDictionary objectForKey:entryCategoryID];
            if (! entryCategory) entryCategory = @"Unfiled";
			
			NSString *URLizedTitle = [entryTitle URLizedStringWithLengthLimit:40];
			NSString *URLizedCategory = [entryCategory URLizedStringWithLengthLimit:20];
			NSString *JavaScriptizedTitle = [entryTitle JavaScriptizedString];
			
			NSString *entryAbstract = [currentWeblogEntry entryAbstract];
			
			NSString *dateString = [currentWeblogEntry entryPublishedDateStringLong];
			if (dateString == nil) dateString = @"Not Yet Published";
			
			NSString *monthHeader = @"";
			NSString *yearHeader = @"";
			
			NSDate *entryDate = [currentWeblogEntry entryPublishedDate];
			unsigned calendarFlags = NSYearCalendarUnit | NSMonthCalendarUnit;
			NSDateComponents *entryDateComponents = [gregorianCalendar components:calendarFlags fromDate:entryDate];
			NSInteger currentMonth = [entryDateComponents month];
			NSInteger currentYear = [entryDateComponents year];
			if ( (i == 0) || (currentMonth != previousMonth) ) {
				// we want a month header to appear
				
				NSString *monthString = [entryDate descriptionWithCalendarFormat:@"%B"
																		timeZone:nil
																		  locale:[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]];
				// originally, there was HTML inside this formatted string, but it's more extensible
				// for the user to put it in the template instead
				monthHeader = [NSString stringWithFormat:@"%@",monthString];
				previousMonth = currentMonth;
			}
			
			if ( (i == 0) || (currentYear != previousYear) ) {
				// we want a year header to appear
				
				NSString *yearString = [entryDate descriptionWithCalendarFormat:@"%Y"
																		timeZone:nil
																		  locale:[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]];
				yearHeader = [NSString stringWithFormat:@"%@",yearString];
				previousYear = currentYear;
			}
			
            
            //NSString *currentFileRelativePathString = [[currentWeblogEntry entryURL] relativeString];
            NSURL *currentEntryURL = [currentWeblogEntry entryURL];
            NSURL *currentEntryFileURL = [NSURL URLWithString:[currentEntryURL relativePath] relativeToURL:basePublishURL];
            
            NSString *entryRelativeURLString = [currentEntryFileURL relativePathFromURL:currentFileURL];
            
			NSString *entryURLString = [currentEntryURL absoluteString];
			NSString *entryDeprecatedURLString = [[currentWeblogEntry entryDeprecatedURL] absoluteString];
			//NSString *entryURLString = [[[targetWeblog baseWeblogURL] URLByAppendingPathComponent:entryRelativeURLString] absoluteString];
			NSString *entryRelativeDeprecatedURLString = [[entryDeprecatedURLString componentsSeparatedByString:[[targetWeblog baseWeblogURL] path]] objectAtIndex:1];
			
			NSString *entryPageFileName = [[entryURLString componentsSeparatedByString:@"/"] lastObject];
			NSString *entryDeprecatedPageFileName = [[entryDeprecatedURLString componentsSeparatedByString:@"/"] lastObject];
			
			NSString *bodyHTML = @"";
			if ([currentWeblogEntry entryMarkdownText] == nil) {
				NSString *uneditedWebViewHTML = [currentWeblogEntry entryUneditedWebViewHTML];
				if (uneditedWebViewHTML) bodyHTML = [self modifyRawWebViewHTML:uneditedWebViewHTML];
			} else {
				bodyHTML = [self getHTMLForMarkdownText:[currentWeblogEntry entryMarkdownText]];
			}
			
			NSString *RSSDateString = [currentWeblogEntry RSSPublishedDateString];
			
			if (yearHeader) [currentEntryString replaceOccurrencesOfString:@"{[YEARHEADER]}" withString:yearHeader options:NSLiteralSearch range:NSMakeRange(0,[currentEntryString length])];
			if (monthHeader) [currentEntryString replaceOccurrencesOfString:@"{[MONTHHEADER]}" withString:monthHeader options:NSLiteralSearch range:NSMakeRange(0,[currentEntryString length])];
			
			if (URLizedCategory) [currentEntryString replaceOccurrencesOfString:@"{[URLIZEDCATEGORY]}" withString:URLizedCategory options:NSLiteralSearch range:NSMakeRange(0,[currentEntryString length])];
			if (URLizedTitle) [currentEntryString replaceOccurrencesOfString:@"{[URLIZEDENTRYTITLE]}" withString:URLizedTitle options:NSLiteralSearch range:NSMakeRange(0,[currentEntryString length])];
			if (JavaScriptizedTitle) [currentEntryString replaceOccurrencesOfString:@"{[JAVASCRIPTIZEDENTRYTITLE]}" withString:JavaScriptizedTitle options:NSLiteralSearch range:NSMakeRange(0,[currentEntryString length])];
			if (entryAbstract) [currentEntryString replaceOccurrencesOfString:@"{[ENTRYABSTRACT]}" withString:entryAbstract options:NSLiteralSearch range:NSMakeRange(0,[currentEntryString length])];
			if (dateString) [currentEntryString replaceOccurrencesOfString:@"{[ENTRYPUBLISHEDDATE]}" withString:dateString options:NSLiteralSearch range:NSMakeRange(0,[currentEntryString length])];
			if (entryTitle) [currentEntryString replaceOccurrencesOfString:@"{[ENTRYTITLE]}" withString:entryTitle options:NSLiteralSearch range:NSMakeRange(0,[currentEntryString length])];
			if (entryCategory) [currentEntryString replaceOccurrencesOfString:@"{[ENTRYCATEGORY]}" withString:entryCategory options:NSLiteralSearch range:NSMakeRange(0,[currentEntryString length])];
			if (bodyHTML) [currentEntryString replaceOccurrencesOfString:@"{[ENTRYBODY]}" withString:bodyHTML options:NSLiteralSearch range:NSMakeRange(0,[currentEntryString length])];
			if (entryURLString) [currentEntryString replaceOccurrencesOfString:@"{[ENTRYURL]}" withString:entryURLString options:NSLiteralSearch range:NSMakeRange(0,[currentEntryString length])];
			if (entryDeprecatedURLString) {
				[currentEntryString replaceOccurrencesOfString:@"{[ENTRYDEPRECATEDURL]}" withString:entryDeprecatedURLString options:NSLiteralSearch range:NSMakeRange(0,[currentEntryString length])];
			} else {
				// if there is no deprecated URL, substitute the real URL instead
				if (entryURLString) [currentEntryString replaceOccurrencesOfString:@"{[ENTRYDEPRECATEDURL]}" withString:entryURLString options:NSLiteralSearch range:NSMakeRange(0,[currentEntryString length])];
			}
			if (entryRelativeURLString) [currentEntryString replaceOccurrencesOfString:@"{[RELATIVEENTRYURL]}" withString:entryRelativeURLString options:NSLiteralSearch range:NSMakeRange(0,[currentEntryString length])];
			if (entryRelativeDeprecatedURLString) {
				[currentEntryString replaceOccurrencesOfString:@"{[RELATIVEENTRYDEPRECATEDURL]}" withString:entryRelativeDeprecatedURLString options:NSLiteralSearch range:NSMakeRange(0,[currentEntryString length])];
			} else {
				// if there is no deprecated URL, we substitute the real URL instead
				if (entryRelativeURLString) [currentEntryString replaceOccurrencesOfString:@"{[RELATIVEENTRYDEPRECATEDURL]}" withString:entryRelativeURLString options:NSLiteralSearch range:NSMakeRange(0,[currentEntryString length])];
			}
			if (entryDeprecatedPageFileName) {
				[currentEntryString replaceOccurrencesOfString:@"{[ENTRYDEPRECATEDPAGEFILENAME]}" withString:entryDeprecatedPageFileName options:NSLiteralSearch range:NSMakeRange(0,[currentEntryString length])];
			} else {
				if (entryPageFileName) [currentEntryString replaceOccurrencesOfString:@"{[ENTRYDEPRECATEDPAGEFILENAME]}" withString:entryPageFileName options:NSLiteralSearch range:NSMakeRange(0,[currentEntryString length])];
			}
			if (entryPageFileName) [currentEntryString replaceOccurrencesOfString:@"{[ENTRYPAGEFILENAME]}" withString:entryPageFileName options:NSLiteralSearch range:NSMakeRange(0,[currentEntryString length])];
			if (RSSDateString) [currentEntryString replaceOccurrencesOfString:@"{[RSSFORMATENTRYPUBLISHEDDATE]}" withString:RSSDateString options:NSLiteralSearch range:NSMakeRange(0,[currentEntryString length])];
			
			if (URLizedCategory) [currentEntryString replaceOccurrencesOfString:@"{[ENTRYAUTHOR]}" withString:@"Simone Manganelli" options:NSLiteralSearch range:NSMakeRange(0,[currentEntryString length])];
			
			NSNumber *publishOrderIndex = [currentWeblogEntry publishOrderIndex];
			//NSLog(@"publishOrderIndex: %@",publishOrderIndex);
			NSArray *publishOrderArray = [targetWeblog filteredOrderedEntryPrototypes];
			int publishOrderArrayCount = [publishOrderArray count];
			
			NSString *olderLinkString = @"";
			NSString *newerLinkString = @"";
			
			if (firstPublish && (publishOrderIndex == nil) ) {
				// the current entry is the newest entry
				NSString *olderEntryURLString = [[publishOrderArray objectAtIndex:0] valueForKey:@"key"];
				olderLinkString = [NSString stringWithFormat:@"<a href=\"%@/%@\">Older</a>",relativePath,olderEntryURLString];
			} else if ( (! firstPublish) && ([publishOrderIndex intValue] == 0) ) {
				// the current entry is the newest entry
                if ([publishOrderArray count] > 1) {
                    NSString *olderEntryURLString = [[publishOrderArray objectAtIndex:1] valueForKey:@"key"];
                    olderLinkString = [NSString stringWithFormat:@"<a href=\"%@/%@\">Older</a>",relativePath,olderEntryURLString];
                }
			} else if (firstPublish && ([publishOrderIndex intValue] == [publishOrderArray count]) ) {
				// the current entry is the oldest entry
                if (publishOrderArrayCount > 0) {
                    NSString *newerEntryURLString = [[publishOrderArray objectAtIndex:(publishOrderArrayCount - 1)] valueForKey:@"key"];
                    newerLinkString = [NSString stringWithFormat:@"<a href=\"%@/%@\">Newer</a>",relativePath,newerEntryURLString];
                }
			} else if ( (! firstPublish) && ([publishOrderIndex intValue] == ([publishOrderArray count] - 1)) ) {
				// the current entry is the oldest entry
                if (publishOrderArrayCount > 1) {
                    NSString *newerEntryURLString = [[publishOrderArray objectAtIndex:(publishOrderArrayCount - 2)] valueForKey:@"key"];
                    newerLinkString = [NSString stringWithFormat:@"<a href=\"%@/%@\">Newer</a>",relativePath,newerEntryURLString];
                }
			} else {
				// the current entry is neither the oldest nor the newest entry
				
				NSString *olderEntryURLString = nil;
				NSString *newerEntryURLString = nil;
				olderEntryURLString = [[publishOrderArray objectAtIndex:([publishOrderIndex intValue] + 1)] valueForKey:@"key"];
				newerEntryURLString = [[publishOrderArray objectAtIndex:([publishOrderIndex intValue] - 1)] valueForKey:@"key"];
				olderLinkString = [NSString stringWithFormat:@"<a href=\"%@/%@\">Older</a>",relativePath,olderEntryURLString];
				newerLinkString = [NSString stringWithFormat:@"<a href=\"%@/%@\">Newer</a>",relativePath,newerEntryURLString];
			}
			
			if (olderLinkString) [currentEntryString replaceOccurrencesOfString:@"{[OLDERLINK]}" withString:olderLinkString options:NSLiteralSearch range:NSMakeRange(0,[currentEntryString length])];
			if (newerLinkString) [currentEntryString replaceOccurrencesOfString:@"{[NEWERLINK]}" withString:newerLinkString options:NSLiteralSearch range:NSMakeRange(0,[currentEntryString length])];

			// this block is customized for preserving comments on older
			// non-standardized .mac comments for Technological Supernova
			if ([currentWeblogEntry entryDeprecatedURL] == nil) {
				[currentEntryString replaceOccurrencesOfString:@"{[FAKEURLSCRIPT]}"
												withString:@""
												   options:NSLiteralSearch
													 range:NSMakeRange(0,[currentEntryString length])
				 ];
			} else {
				NSString *fakeURLPathname = [[[currentWeblogEntry entryDeprecatedURL] absoluteString] substringFromIndex:23];
				//NSLog(@"fakeURLPathname: %@",fakeURLPathname);
				[currentEntryString replaceOccurrencesOfString:@"{[FAKEURLSCRIPT]}" withString:[NSString stringWithFormat:@"<script language=\"javascript\" type=\"text/javascript\"><!--\nvar fakeURLPathname = '%@';\n--></script>",fakeURLPathname]
												   options:NSLiteralSearch
													 range:NSMakeRange(0,[currentEntryString length])
				 ];
			}
			
			[allMainPageEntriesString appendString:currentEntryString];
		}
	}
	
	
	
	NSString *currentDateString = [currentDate descriptionWithCalendarFormat:@"%a, %d %b %Y %H:%M:%S %z"];
	
	
	
	// create the string for the {[ARCHIVEPAGEURL]} entity
    //NSURL *fileWriteURL = [NSURL fileURLWithPath:fileWritePath];
    
    
	NSString *archivePageURLString = [relativePath stringByAppendingPathComponent:@"archive.html"];
	
	
	
	// retrieve the contents of the sidebar template and create the string for the {[SIDEBAR]} entity
	NSMutableString *sidebarTemplateString = [NSMutableString stringWithString:@""];
	if (sidebarPath != nil) {
		NSError *sidebarTemplateError = nil;
		sidebarTemplateString = [NSMutableString stringWithContentsOfFile:sidebarPath encoding:NSUTF8StringEncoding error:&sidebarTemplateError];
		if (sidebarTemplateError) {
			NSLog(@"Error reading sidebar template: %@",sidebarTemplateError);
		}
	}
	
	
	
	// the {[FOREACHENTRY]} and {[SIDEBAR]} entity replacements need to be done first, so that general dynamic tags within the template for each entry
	// will also be replaced with the correct markup
	[mainPageTemplateString replaceOccurrencesOfString:@"{[FOREACHENTRY]}" withString:allMainPageEntriesString options:NSLiteralSearch range:NSMakeRange(0,[mainPageTemplateString length])];
	[mainPageTemplateString replaceOccurrencesOfString:@"{[SIDEBAR]}" withString:sidebarTemplateString options:NSLiteralSearch range:NSMakeRange(0,[mainPageTemplateString length])];

	
	[mainPageTemplateString replaceOccurrencesOfString:@"{[FEEDGENERATOR]}" withString:@"TidyWeblogger beta" options:NSLiteralSearch range:NSMakeRange(0,[mainPageTemplateString length])];
	[mainPageTemplateString replaceOccurrencesOfString:@"{[WEBLOGTITLE]}" withString:[targetWeblog weblogTitle] options:NSLiteralSearch range:NSMakeRange(0,[mainPageTemplateString length])];
	[mainPageTemplateString replaceOccurrencesOfString:@"{[URLIZEDWEBLOGTITLE]}" withString:[[targetWeblog weblogTitle] URLizedString] options:NSLiteralSearch range:NSMakeRange(0,[mainPageTemplateString length])];
	[mainPageTemplateString replaceOccurrencesOfString:@"{[BASEWEBLOGURL]}" withString:[[targetWeblog baseWeblogURL] absoluteString] options:NSLiteralSearch range:NSMakeRange(0,[mainPageTemplateString length])];
    [mainPageTemplateString replaceOccurrencesOfString:@"{[RELATIVEBASEWEBLOGURL]}" withString:relativePath options:NSLiteralSearch range:NSMakeRange(0,[mainPageTemplateString length])];
	[mainPageTemplateString replaceOccurrencesOfString:@"{[WEBLOGURL]}" withString:[NSString stringWithFormat:@"%@index.html",[[targetWeblog baseWeblogURL] absoluteString]] options:NSLiteralSearch range:NSMakeRange(0,[mainPageTemplateString length])];
	[mainPageTemplateString replaceOccurrencesOfString:@"{[WEBLOGDESCRIPTION]}" withString:@"Tech and computer-related ramblings and tidbits" options:NSLiteralSearch range:NSMakeRange(0,[mainPageTemplateString length])];
	[mainPageTemplateString replaceOccurrencesOfString:@"{[AUTHOREMAIL]}" withString:@"simX_other@mac.com" options:NSLiteralSearch range:NSMakeRange(0,[mainPageTemplateString length])];
	[mainPageTemplateString replaceOccurrencesOfString:@"{[AUTHORNAME]}" withString:@"Simone Manganelli" options:NSLiteralSearch range:NSMakeRange(0,[mainPageTemplateString length])];
	[mainPageTemplateString replaceOccurrencesOfString:@"{[FEEDLASTBUILDDATE]}" withString:currentDateString options:NSLiteralSearch range:NSMakeRange(0,[mainPageTemplateString length])];
	[mainPageTemplateString replaceOccurrencesOfString:@"{[FEEDPUBLISHDATE]}" withString:currentDateString options:NSLiteralSearch range:NSMakeRange(0,[mainPageTemplateString length])];
	[mainPageTemplateString replaceOccurrencesOfString:@"{[COPYRIGHTDATES]}" withString:@"2001-2012" options:NSLiteralSearch range:NSMakeRange(0,[mainPageTemplateString length])];

	//[mainPageTemplateString replaceOccurrencesOfString:@"{[CATEGORYSTATS]}" withString:categoryStatsString options:NSLiteralSearch range:NSMakeRange(0,[mainPageTemplateString length])];
	[mainPageTemplateString replaceOccurrencesOfString:@"{[ARCHIVEPAGEURL]}" withString:archivePageURLString options:NSLiteralSearch range:NSMakeRange(0,[mainPageTemplateString length])];

	
	if (currentCategoryID) {
        NSString *categoryName = [categoryDictionary objectForKey:currentCategoryID];
        if (! categoryName) categoryName = @"Unfiled";

        [mainPageTemplateString replaceOccurrencesOfString:@"{[OVERALLCATEGORY]}"
																 withString:categoryName
																	options:NSLiteralSearch
																	  range:NSMakeRange(0,[mainPageTemplateString length])];
    }
	
	
	// NSXMLDocument will fix as many validation errors as possible w/o extra info; this is awesome!
	NSString *outputXMLString = nil;
	if (shouldValidateXML) {
		if ([[fileWritePath pathExtension] isEqualToString:@"xml"]) {
			NSXMLDocument *tempXHTMLDoc = [[NSXMLDocument alloc] initWithXMLString:mainPageTemplateString options:NSXMLDocumentTidyXML error:nil];
			outputXMLString = [tempXHTMLDoc XMLString];
		} else if ([[fileWritePath pathExtension] isEqualToString:@"html"]) {
			NSXMLDocument *tempXHTMLDoc = [[NSXMLDocument alloc] initWithXMLString:mainPageTemplateString options:NSXMLDocumentTidyHTML error:nil];
			outputXMLString = [tempXHTMLDoc XMLString];
		} else {
			outputXMLString = mainPageTemplateString;
		}
	} else {
		outputXMLString = mainPageTemplateString;
	}
    
    
    outputXMLString = [outputXMLString stringByReplacingOccurrencesOfString:@"mailto:simX@mac.com" withString:@"&#109;&#097;&#105;&#108;&#116;&#111;&#058;&#115;&#105;&#109;&#088;&#064;&#109;&#097;&#099;&#046;&#099;&#111;&#109;"];
	
    
    NSError *dirCreateError = nil;
    NSURL *categoryFolderURL = [[NSURL fileURLWithPath:fileWritePath] URLByDeletingLastPathComponent];
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    BOOL succeeded = [defaultManager createDirectoryAtURL:categoryFolderURL
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:&dirCreateError];
    if (! succeeded) {
        NSLog(@"Error creating category folder: %@",dirCreateError);
    }
    
    
    NSError *writeError = nil;
	BOOL writeSuccess = [outputXMLString writeToFile:fileWritePath atomically:YES encoding:NSUTF8StringEncoding error:&writeError];
    
    if (! writeSuccess) {
        NSLog(@"Error writing file at path %@: %@",fileWritePath,writeError);
    }
    
	return writeSuccess;
}


- (BOOL)createCategoryStatsJavaScriptFileFromStatsDict:(NSDictionary *)categoryStats
											 forWeblog:(EPWeblog *)targetWeblog;
{
	NSString *currentStatsCategory = nil;
	NSMutableString *categoryStatsString = [NSMutableString stringWithString:@"var categoryStats=["];
	for (currentStatsCategory in [categoryStats allKeys]) {
		NSString *currentCategoryName = [[targetWeblog categoryDictionary] objectForKey:currentStatsCategory];
        
        if (! currentCategoryName) currentCategoryName = @"Unfiled";
		if (! [currentStatsCategory isEqualToString:@"Total Count"]) {
			NSString *currentCategoryURLString = [NSString stringWithFormat:@"%@%@/index.html",[targetWeblog baseWeblogURL],currentStatsCategory];
			int currentCategoryCount = [[categoryStats objectForKey:currentStatsCategory] intValue];
			
			[categoryStatsString appendString:[NSString stringWithFormat:@"['%@',%d,'%@'],",currentCategoryName,currentCategoryCount,currentCategoryURLString]];
		}
	}
	[categoryStatsString appendString:@"];"];
	[categoryStatsString appendString:[NSString stringWithFormat:@"\nvar totalStatsCount = %d;",
											[[categoryStats objectForKey:@"Total Count"] intValue]]
	 ];
	
    NSURL *publishURL = [[targetWeblog basePublishPathURL] URLByAppendingPathComponent:@"categoryStats.js"];
	BOOL writeSuccess = [categoryStatsString writeToFile:[publishURL path]
											  atomically:YES
												encoding:NSUTF8StringEncoding error:nil];
	return writeSuccess;
}

- (void)createRecentEntriesPagesUsingArrayOfWeblogEntryObjects:(NSArray *)arrayOfEntryObjects
														   forWeblog:(EPWeblog *)targetWeblog;
{
    NSURL *indexPublishURL = [[targetWeblog basePublishPathURL] URLByAppendingPathComponent:@"index.html"];
    NSString *templateLocationPath = [[targetWeblog templateFilesLocation] path];
    NSString *mainPageTemplatePath = [NSString stringWithFormat:@"%@/Main Page Template.txt",templateLocationPath];
    NSString *forEachEntryTemplatePath = [NSString stringWithFormat:@"%@/Main Page For Each Entry.txt",templateLocationPath];
    NSString *sidebarTemplatePath = [NSString stringWithFormat:@"%@/Sidebar Template.txt",templateLocationPath];
    NSString *basePublishPath = [[targetWeblog basePublishPathURL] path];
	[self writeFileForArrayOfWeblogEntryObjects:arrayOfEntryObjects
									  forWeblog:targetWeblog
								currentCategory:nil
							  usingPageTemplate:mainPageTemplatePath
					  usingForEachEntryTemplate:forEachEntryTemplatePath
						   usingSidebarTemplate:sidebarTemplatePath
										 toPath:[indexPublishURL path]
                                basePublishPath:basePublishPath
								  validatingXML:YES
								   firstPublish:NO];
	
    NSURL *RSSPublishURL = [[targetWeblog basePublishPathURL] URLByAppendingPathComponent:@"rss.xml"];
    NSString *RSSPageTemplatePath = [NSString stringWithFormat:@"%@/RSS Page Template.txt",templateLocationPath];
    NSString *RSSForEachEntryTemplatePath = [NSString stringWithFormat:@"%@/RSS Page For Each Entry.txt",templateLocationPath];
	[self writeFileForArrayOfWeblogEntryObjects:arrayOfEntryObjects
									  forWeblog:targetWeblog
								currentCategory:nil
							  usingPageTemplate:RSSPageTemplatePath
					  usingForEachEntryTemplate:RSSForEachEntryTemplatePath
						   usingSidebarTemplate:sidebarTemplatePath
										 toPath:[RSSPublishURL path]
                                basePublishPath:basePublishPath
								  validatingXML:NO
								   firstPublish:NO];
	
    NSURL *recentEntriesPublishURL = [[targetWeblog basePublishPathURL] URLByAppendingPathComponent:@"RecentEntries.js"];
    NSString *JSPageTemplatePath = [NSString stringWithFormat:@"%@/RecentEntries JS Template.txt",templateLocationPath];
    NSString *JSForEachEntryTemplatePath = [NSString stringWithFormat:@"%@/RecentEntries JS For Each Entry.txt",templateLocationPath];
	[self writeFileForArrayOfWeblogEntryObjects:arrayOfEntryObjects
									  forWeblog:targetWeblog
								currentCategory:nil
							  usingPageTemplate:JSPageTemplatePath
					  usingForEachEntryTemplate:JSForEachEntryTemplatePath
						   usingSidebarTemplate:nil
										 toPath:[recentEntriesPublishURL path]
                                basePublishPath:basePublishPath
								  validatingXML:NO
								   firstPublish:NO];
}

- (void)createCategoryPageForArrayOfWeblogEntryObjects:(NSArray *)arrayOfEntryObjects
											categoryID:(NSString *)categoryID
											 forWeblog:(EPWeblog *)targetWeblog;
{
    NSURL *categoryFolderURL = [[targetWeblog basePublishPathURL] URLByAppendingPathComponent:categoryID isDirectory:YES];
    NSURL *publishURL = [categoryFolderURL URLByAppendingPathComponent:@"index.html"];
    NSString *templateFilesPath = [[targetWeblog templateFilesLocation] path];
    NSString *publishURLPath = [publishURL path];
    
    NSString *categoryTemplatePath = [NSString stringWithFormat:@"%@/Category Page Template.txt",templateFilesPath];
    NSString *categoryForEachEntryTemplatePath = [NSString stringWithFormat:@"%@/Category Page For Each Entry.txt",templateFilesPath];
    NSString *sidebarTemplatePath = [NSString stringWithFormat:@"%@/Sidebar Template.txt",templateFilesPath];
	[self writeFileForArrayOfWeblogEntryObjects:arrayOfEntryObjects
									  forWeblog:targetWeblog
								currentCategory:categoryID
							  usingPageTemplate:categoryTemplatePath
					  usingForEachEntryTemplate:categoryForEachEntryTemplatePath
						   usingSidebarTemplate:sidebarTemplatePath
										 toPath:publishURLPath
                                basePublishPath:[[targetWeblog basePublishPathURL] path]
								  validatingXML:YES
								   firstPublish:NO];
}

- (void)createArchivePageForArrayOfWeblogEntryObjects:(NSArray *)arrayOfEntryObjects
											forWeblog:(EPWeblog *)targetWeblog;
{
    NSURL *publishURL = [[targetWeblog basePublishPathURL] URLByAppendingPathComponent:@"archive.html"];
    NSString *templateFilesPath = [[targetWeblog templateFilesLocation] path];
    NSString *publishURLPath = [publishURL path];
    
    NSString *archiveTemplatePath = [NSString stringWithFormat:@"%@/Archive Page Template.txt",templateFilesPath];
    NSString *archiveForEachEntryTemplatePath = [NSString stringWithFormat:@"%@/Archive Page For Each Entry.txt",templateFilesPath];
    NSString *sidebarTemplatePath = [NSString stringWithFormat:@"%@/Sidebar Template.txt",templateFilesPath];
	[self writeFileForArrayOfWeblogEntryObjects:arrayOfEntryObjects
									  forWeblog:targetWeblog
								currentCategory:nil
							  usingPageTemplate:archiveTemplatePath
					  usingForEachEntryTemplate:archiveForEachEntryTemplatePath
						   usingSidebarTemplate:sidebarTemplatePath
										 toPath:publishURLPath
                                basePublishPath:[[targetWeblog basePublishPathURL] path]
								  validatingXML:YES
								   firstPublish:NO];
}


- (NSString *)modifyRawWebViewHTML:(NSString *)immutableRawWebViewHTML;
{
	// previously this method was searching for &lt;HTMLSource>; I suspect this might be due to importation changes
	
	NSMutableString *rawWebViewHTML = [NSMutableString stringWithString:immutableRawWebViewHTML];
	
	BOOL keepSearchingForHTMLSourceLiterals;
	NSScanner *scanner = [[NSScanner alloc] initWithString:rawWebViewHTML];
	[scanner scanUpToString:@"<htmlsource>" intoString:nil];
	NSUInteger startLoc = [scanner scanLocation];
	NSUInteger endLoc = 0;
	keepSearchingForHTMLSourceLiterals = [scanner scanString:@"<htmlsource>" intoString:nil];
	
	while (keepSearchingForHTMLSourceLiterals) {
		NSLog(@"blah");
		NSString *tempScannerString = nil;
		
		[scanner scanUpToString:@"</htmlsource>" intoString:&tempScannerString];
		if ([scanner isAtEnd]) break;
		[scanner scanString:@"</htmlsource>" intoString:nil];
		endLoc = [scanner scanLocation];
		
		NSMutableString *tempString = [NSMutableString stringWithString:tempScannerString];
		
		[tempString replaceOccurrencesOfString:@"&amp;" withString:@"&" options:NSLiteralSearch range:NSMakeRange(0,[tempString length])];
		[tempString replaceOccurrencesOfString:@"&lt;" withString:@"<" options:NSLiteralSearch range:NSMakeRange(0,[tempString length])];
		[tempString replaceOccurrencesOfString:@">" withString:@">" options:NSLiteralSearch range:NSMakeRange(0,[tempString length])];
		
		
		NSLog(@"%lu for %lu of %lu",(long)startLoc, (long)(endLoc-startLoc), [rawWebViewHTML length]);
		[rawWebViewHTML replaceCharactersInRange:NSMakeRange(startLoc,endLoc-startLoc) withString:tempString];
		
		scanner = [[NSScanner alloc] initWithString:rawWebViewHTML];
		
		[scanner scanUpToString:@"<htmlsource>" intoString:nil];
		startLoc = [scanner scanLocation];
		keepSearchingForHTMLSourceLiterals = [scanner scanString:@"<htmlsource>" intoString:nil];
	}
	
	[rawWebViewHTML replaceOccurrencesOfString:[NSString stringWithFormat:@"%C",0x00A0] withString:@" " options:NSLiteralSearch range:NSMakeRange(0,[rawWebViewHTML length])];
	
	return rawWebViewHTML;
}

- (NSString *)getHTMLForMarkdownText:(NSString *)markdownText;
{
	NSError *markdownFileWriteError = nil;
	NSString *tempMarkdownFileLocation = [@"~/Library/Application Support/TidyWeblogger/temp-markdown.txt" stringByExpandingTildeInPath];
	[markdownText writeToFile:[tempMarkdownFileLocation stringByExpandingTildeInPath]
				   atomically:YES
					 encoding:NSUTF8StringEncoding
						error:&markdownFileWriteError];
	
	NSString *HTMLReturnString = nil;
	if (markdownFileWriteError == nil) {
		// markdown should be run before smartypants, in case smartypants screws
		// up some of the formatting syntax for markdown
		NSTask *markdownTask = [[NSTask alloc] init];
		NSPipe *outPipe = [NSPipe pipe];
		NSFileHandle *theHandle = [outPipe fileHandleForReading];
		
		NSString *markdownOutputString = nil;
		[markdownTask setLaunchPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Markdown.pl"]];
		[markdownTask setArguments:[NSArray arrayWithObject:tempMarkdownFileLocation]];
		[markdownTask setStandardOutput:outPipe];
		[markdownTask launch];
		markdownOutputString = [[NSString alloc] initWithData:[theHandle readDataToEndOfFile] encoding:NSUTF8StringEncoding];
		//NSLog(@"%@",tempOutput);
		
		NSError *smartyPantsFileWriteError = nil;
		NSString *tempMarkdownOutputFileLocation = [@"~/Library/Application Support/TidyWeblogger/temp-markdown-output.txt" stringByExpandingTildeInPath];
		[markdownOutputString writeToFile:[tempMarkdownOutputFileLocation stringByExpandingTildeInPath]
					   atomically:YES
						 encoding:NSUTF8StringEncoding
							error:&smartyPantsFileWriteError];
		

		if (smartyPantsFileWriteError == nil) {
			NSTask *smartyPantsTask = [[NSTask alloc] init];
			NSPipe *smartyPantsPipe = [NSPipe pipe];
			NSFileHandle *smartyHandle = [smartyPantsPipe fileHandleForReading];
			
			NSString *smartyPantsOutputString = nil;
			[smartyPantsTask setLaunchPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"SmartyPants.pl"]];
			[smartyPantsTask setArguments:[NSArray arrayWithObject:tempMarkdownOutputFileLocation]];
			[smartyPantsTask setStandardOutput:smartyPantsPipe];
			[smartyPantsTask launch];
			
			smartyPantsOutputString = [[NSString alloc] initWithData:[smartyHandle readDataToEndOfFile] encoding:NSUTF8StringEncoding];
			
			HTMLReturnString = smartyPantsOutputString;
		} else {
			// handle the file write error here
		}
	} else {
		// handle the error here
	}
	
	return HTMLReturnString;
}

- (IBAction)testNSScannerWithNonASCIIChars:(id)sender;
{
	NSString *theString = [NSString stringWithContentsOfFile:@"/Users/simmy/Desktop/test.txt" encoding:NSUTF8StringEncoding error:nil];
	NSScanner *theScanner = [[NSScanner alloc] initWithString:theString];
	
	NSString *blah = nil;
	[theScanner scanUpToString:@"blahblahblah" intoString:&blah];
	NSLog(@"%@",blah);
	NSLog(@"%@",theString);
}



@end
