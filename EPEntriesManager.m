//
//  EPEntriesManager.m
//  TidyWeblogger
//
//  Created by Simone Manganelli on 2008-03-15.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "EPWeblog.h"
#import "EPEntriesManager.h"
#import "EPWeblogEntry.h"
#import "EPEntryEditorController.h"
#import "EPHTMLGenerator.h"
#import "EPNewWeblogSheetHandler.h"
#import "EPStringCategory.h"
#import "EPWeblogEntryPrototype.h"
//#import <Connection/Connection.h>


@implementation EPEntriesManager

- (id)init;
{
	if (self = [super init]) {
		weblogs = [[NSMutableArray alloc] init];
		[self createApplicationSupportFolderIfNeeded];
		
		NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
		NSArray *savedWeblogs = [standardDefaults arrayForKey:@"weblogs"];
		
		NSDictionary *currentWeblogPrototype = nil;
		for (currentWeblogPrototype in savedWeblogs) {
			[self importWeblog:currentWeblogPrototype];
		}
		
		NSLog(@"%@",weblogs);
	}
	
	return self;
}

- (void)awakeFromNib;
{
	[realEntriesController setObjectClass:[EPWeblogEntryPrototype class]];
}

- (IBAction)testAction:(id)sender;
{
	[self recalculatePublishOrderingForWeblog:[[weblogsController arrangedObjects] objectAtIndex:0]];
}

- (void)importWeblog:(NSDictionary *)weblogPrototype;
{
    NSString *masterEntriesPlistFileLocation = [[weblogPrototype objectForKey:@"masterEntriesPlistFileLocation"] stringByExpandingTildeInPath];
    NSDictionary *listOfEntriesFile = [NSDictionary dictionaryWithContentsOfFile:masterEntriesPlistFileLocation];
    
	
    NSString *templateFilesLocation = [[listOfEntriesFile objectForKey:@"templateFilesLocation"] stringByExpandingTildeInPath];
    if (! templateFilesLocation) {
        templateFilesLocation = [[weblogPrototype objectForKey:@"templateFilesLocation"] stringByExpandingTildeInPath];
    }
    
	NSString *titleOfWeblogToImport = [weblogPrototype objectForKey:@"weblogTitle"];
    
    NSString *baseWeblogURLString = [listOfEntriesFile objectForKey:@"baseWeblogURL"];
    if (! baseWeblogURLString) baseWeblogURLString = [weblogPrototype objectForKey:@"baseWeblogURL"];
    NSURL *baseWeblogURL = [NSURL URLWithString:baseWeblogURLString];
    
    NSString *baseWebDirPathString = [listOfEntriesFile objectForKey:@"baseWebDirectoryPath"];
    if (! baseWebDirPathString) baseWebDirPathString = [weblogPrototype objectForKey:@"baseWebDirectoryPath"];
    NSURL *baseWebDirectoryPath = [NSURL URLWithString:baseWebDirPathString];

	// load the entries dictionary

	// (mounted iDisk method)
	
	
	
	//CKConnection *mobileMeConnection =
	//	[[CKConnectionRegistry sharedConnectionRegistry] connectionWithURL:[NSURL URLWithString:@"http://idisk.mac.com"]];
	
	//CKWebDavConnection *mobileMeConnection = [[CKWebDavConnection alloc] initWithURL:[NSURL URLWithString:@"http://idisk.mac.com"]];
	
	//id <CKConnection> connection = [[CKFTPConnection alloc] initWithURL:[NSURL URLWithString:@"ftp://ftp.example.com"]];
	
	// (ConnectionKit 1.2 method, creating the request)
	/*CKConnectionRequest *mobileMeConnectionRequest = [CKConnectionRequest requestWithURL:[NSURL URLWithString:@"http://idisk.mac.com/simx/"]];
	CKConnection *mobileMeConnection = [[CKConnection alloc] initWithConnectionRequest:mobileMeConnectionRequest
																			  delegate:self];
	[mobileMeConnection connect];*/
	
	// (ConnectionKit 1.2 method, get the request from the registry
	// NSError *connectionError = nil;
	/*CKConnection *mobileMeConnection =
		[[CKConnectionRegistry sharedConnectionRegistry] connectionWithName:@"WebDav"
																	   host:@"http://idisk.mac.com/"
																	   port:[NSNumber numberWithInt:80]];*/
	
	//if (connectionError) NSLog(@"%@",connectionError);
	
	//[mobileMeConnection setDelegate:self];
	//[mobileMeConnection connect];
	
	/*NSLog(@"%@",[mobileMeConnection contentsOfDirectory:[mobileMeConnection currentDirectory]]);
	
	[mobileMeConnection downloadFile:@"/Sites/technonova/tidyWebloggerEntriesList.plist"
						 toDirectory:@"/Users/simmy/Library/Application Support/TidyWeblogger/"
						   overwrite:YES];
	
	sleep(5);
	
	
	NSDictionary *listOfEntriesFile = [NSDictionary dictionaryWithContentsOfFile:@"/Users/simmy/Library/Application Support/TidyWeblogger/tidyWebloggerEntriesList.plist"];*/
	
	
	NSMutableDictionary *entriesOfWeblogToImport = nil;
	if (listOfEntriesFile == nil) {
		// there are no existing entries (probably because the file doesn't exist);
		// we need to create the directories to the file, and then create the file
		
		// this is just placeholder for now
		
		NSLog(@"Error loading the list of entries.");
		
		entriesOfWeblogToImport = [[NSMutableDictionary alloc] init];
	} else {
		entriesOfWeblogToImport = [NSMutableDictionary dictionaryWithDictionary:[listOfEntriesFile objectForKey:@"entriesDict"]];
		//NSLog(@"%@",listOfEntriesFile);
	}
	
	
	// this is here to ensure key-value observing compliance for the weblog entry prototypes -- they need to be mutable
	// (UPDATE: this might not actually be necessary)
	NSString *currentKey = nil;
	for (currentKey in [entriesOfWeblogToImport allKeys]) {
		NSMutableDictionary *mutableEntryObject = [NSMutableDictionary dictionaryWithDictionary:[entriesOfWeblogToImport objectForKey:currentKey]];
		[entriesOfWeblogToImport setObject:mutableEntryObject
									forKey:currentKey];
	}
	
	/*categoryDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
						   @"Apple Bug Friday",@"apple_bug_friday",
						   @"D2X-XL",@"d2x-xl",
						   @"Intarweb",@"intarweb",
						   @"Publications",@"publications",
						   @"Rants",@"rants",
						   @"Software Development",@"software_development",
						   @"Tips",@"tips",
						   @"Unfiled",@"unfiled",nil];*/
	
	EPWeblog *importedWeblog = [[EPWeblog alloc] init];
    NSURL *pathEntriesDictURL = [NSURL fileURLWithPath:[masterEntriesPlistFileLocation stringByExpandingTildeInPath]];
	[importedWeblog setPathToEntriesDictionary:pathEntriesDictURL];
	[importedWeblog setTemplateFilesLocation:[NSURL fileURLWithPath:[templateFilesLocation stringByExpandingTildeInPath]]];
	[importedWeblog setWeblogTitle:titleOfWeblogToImport];
    
    if (baseWebDirectoryPath) {
        [importedWeblog setBaseFileDirectoryPath:baseWebDirectoryPath];
    } else {
        NSURL *assumedBaseWeblogURL = [pathEntriesDictURL URLByDeletingLastPathComponent];
        [importedWeblog setBaseFileDirectoryPath:assumedBaseWeblogURL];
    }
    
    if (baseWeblogURL) {
        [importedWeblog setBaseWeblogURL:baseWeblogURL];
    } else {
        // check if it's an iDisk weblog
        NSArray *iDiskPathArray = [[[importedWeblog baseFileDirectoryPath] path] componentsSeparatedByString:@"/Volumes/simx/Sites/"];
        
        if ([iDiskPathArray count] > 1) {
            NSString *URLString = [NSString stringWithFormat:@"http://homepage.mac.com/simx/%@/",[iDiskPathArray objectAtIndex:1]];
            NSURL *theURL = [NSURL URLWithString:URLString];
            [importedWeblog setBaseWeblogURL:theURL];
        } else {
            [importedWeblog setBaseWeblogURL:[NSURL URLWithString:@"http://127.0.0.1/"]];
        }
    }
    

    
	
	// this whole block is so that we can add a pointer back to the weblog that owns
	// each entry; unfortunately, it doesn't seem like there's any other way to do this
	// through bindings, and pointers can't be saved into a plist file
	/*NSArray *entriesArray = [entriesOfWeblogToImport allValues];
	NSMutableArray *modifiableEntriesArray = [[NSMutableArray alloc] init];
	NSDictionary *currentEntryPrototype = nil;
	for (currentEntryPrototype in entriesArray) {
		NSMutableDictionary *mutableCurrentEntryPrototype = [NSMutableDictionary dictionaryWithDictionary:currentEntryPrototype];
		[mutableCurrentEntryPrototype setObject:importedWeblog forKey:@"weblog"];
		[modifiableEntriesArray addObject:mutableCurrentEntryPrototype];
	}
	
	// the entries object is for bindings
	[importedWeblog setEntries:modifiableEntriesArray];
	[modifiableEntriesArray release];*/
	
	// the entries dict object represents the master list of entries, and 
	// is for eventual writing to disk
	[importedWeblog setEntriesDict:entriesOfWeblogToImport];
	[importedWeblog setCategoryDictionary:[listOfEntriesFile objectForKey:@"categoryDictionary"]];
		
	//listOfEntriesActiveSet = [[entries allValues] sortedArrayUsingFunction:dateCompareDescending context:NULL];
	//[listOfEntriesActiveSet retain];
	//[listOfEntriesTableView reloadData];
	
	
	NSMutableArray *bindingsCompliantWeblogs = [self mutableArrayValueForKey:@"weblogs"];
	[bindingsCompliantWeblogs addObject:importedWeblog];
	
	// this needs to be done *after* adding it to the bindingsCompliantWeblogs proxy array
	// because it relies on bindings to get the list of entries in the array
	[self recalculatePublishOrderingForWeblog:importedWeblog];
}

- (NSMutableArray *)weblogs;
{
	return weblogs;
}

- (void)setWeblogs:(NSArray *)newWeblogs;
{
	if (weblogs != newWeblogs) {
		weblogs = [[NSMutableArray alloc] initWithArray:newWeblogs];
	}
}

- (IBAction)addNewWeblog:(id)sender;
{
	EPNewWeblogSheetHandler *newWeblogHandler = [[EPNewWeblogSheetHandler alloc] initWithEntriesManagerObject:self];
	[newWeblogHandler startCreatingNewWeblogAttachingSheetToWindow:listOfEntriesWindow];
}

- (void)saveNewWeblogToUserDefaults:(NSDictionary *)newWeblogPrototype;
{
	NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
	NSArray *savedWeblogs = [standardDefaults arrayForKey:@"weblogs"];
	
	NSMutableArray *newSavedWeblogs = [[NSMutableArray alloc] initWithArray:savedWeblogs];
	[newSavedWeblogs addObject:newWeblogPrototype];
	[standardDefaults setObject:newSavedWeblogs forKey:@"weblogs"];
	[standardDefaults synchronize];
}

- (void)createApplicationSupportFolderIfNeeded;
{
	NSFileManager *defaultManager = [NSFileManager defaultManager];
	
	NSString *applicationSupportFolderPath = [@"~/Library/Application Support/TidyWeblogger/" stringByExpandingTildeInPath];
	BOOL isDirectory = NO;
	BOOL exists = [defaultManager fileExistsAtPath:applicationSupportFolderPath
									   isDirectory:&isDirectory];
	
	if (exists && isDirectory) {
		// cool, cool
	} else if (exists && (! isDirectory)) {
		// not cool, not cool;
		// a file with the same name exists where our folder should be
	} else if (! exists) {
        NSError *createError = nil;
		BOOL succeeded = [defaultManager createDirectoryAtPath:applicationSupportFolderPath
                                   withIntermediateDirectories:YES
                                                    attributes:nil
                                                         error:&createError];
        if (! succeeded) {
            NSLog(@"Error creating directory at path %@: %@",applicationSupportFolderPath,[createError localizedDescription]);
        }
	} else {
		// this case shouldn't ever happen
		NSBeep();
	}
}

- (IBAction)importWeblogEntry:(id)sender;
{
	NSOpenPanel *importEntriesOpenPanel = [NSOpenPanel openPanel];
	[importEntriesOpenPanel setAllowsMultipleSelection:YES];
	[importEntriesOpenPanel setCanChooseDirectories:YES];
    [importEntriesOpenPanel setAllowedFileTypes:[NSArray arrayWithObjects:@"plist",@"html",nil]];
	[importEntriesOpenPanel beginSheetModalForWindow:listOfEntriesWindow
                                   completionHandler:^(NSInteger returnCode){
                                       if (returnCode == NSOKButton) {
                                           NSArray *pathToFilesToImport = [importEntriesOpenPanel URLs];
                                           [self scanFilesAndCreateWeblogEntryObjects:pathToFilesToImport
                                                                            forWeblog:[[weblogsController selectedObjects] objectAtIndex:0]
                                                                        rootDirectory:@"/"
                                                                  traverseDirectories:YES];
                                       }
                                   }];
}

- (void)scanFilesAndCreateWeblogEntryObjects:(NSArray *)pathToFilesToImport
								   forWeblog:(EPWeblog *)targetWeblog
							   rootDirectory:(NSString *)rootDirectory
						 traverseDirectories:(BOOL)shouldTraverseDirectories;
{
	[self startStatusUpdateSession];
	[self updateStatusWithString:@"Commencing import..."];
	
	NSEnumerator *fileSystemItemsEnumerator = [pathToFilesToImport objectEnumerator];
	NSURL *nextFileSystemObject;
	
	while (nextFileSystemObject = [fileSystemItemsEnumerator nextObject]) {
		NSString *nextFileSystemItem = [nextFileSystemObject path];
		NSString *statusString = [NSString stringWithFormat:@"Attempting to import %@",nextFileSystemItem];
		[self updateStatusWithString:statusString];
		
		BOOL fileSystemItemIsDirectory = NO;
		[[NSFileManager defaultManager] fileExistsAtPath:nextFileSystemItem isDirectory:&fileSystemItemIsDirectory];
		
		if (fileSystemItemIsDirectory && shouldTraverseDirectories) {
			// recurse!
			
			NSError *subPathError = nil;
			NSArray *subPathsArray = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:nextFileSystemItem error:&subPathError];
			
			if (! subPathError) {
				[self scanFilesAndCreateWeblogEntryObjects:subPathsArray
												 forWeblog:targetWeblog
											 rootDirectory:nextFileSystemItem
									   traverseDirectories:NO];
			}
		} else {
			NSString *potentialFileToImportExtension = [nextFileSystemItem pathExtension];
			BOOL isHTMLFile = NO;
			BOOL isPlistFile = NO;
			
			if ([potentialFileToImportExtension isEqualToString:@"html"]) 
				isHTMLFile = YES;
		
			if ([potentialFileToImportExtension isEqualToString:@"plist"])
				isPlistFile = YES;
				
			if (isHTMLFile || isPlistFile) {
				EPWeblogEntry *importedEntry = nil;
				
				if (isHTMLFile) {
					importedEntry = [self scanHTMLFileAndReturnWeblogEntryObject:nextFileSystemItem
																	   forWeblog:targetWeblog];
				} else if (isPlistFile) {
					importedEntry = [self weblogEntryForPlistFilePath:nextFileSystemItem
															forWeblog:targetWeblog];
				}
				
				NSLog(@"did we get here yet?");
				//NSLog(@"%@",[importedEntry entryUneditedWebViewHTML]);
				
				if (importedEntry) {
					EPEntryEditorController *entryEditorControllerInstance = [[EPEntryEditorController alloc] init];
					[entryEditorControllerInstance setHTMLGeneratorObject:HTMLGeneratorInstance];
					[entryEditorControllerInstance setEntriesManagerObject:self];
					
					[entryEditorControllerInstance setWeblogEntry:importedEntry];
					//[entryEditorControllerInstance showWindow:self];
					
					[HTMLGeneratorInstance createAndSaveHTMLFileUsingWeblogEntryObject:importedEntry
																			 forWeblog:targetWeblog
																		 shouldPublish:NO];
					
					NSObject *newObject = [realEntriesController newObject];
					
					NSMutableDictionary *importedEntryPrototype = [[NSMutableDictionary alloc] init];
					[importedEntryPrototype setObject:[importedEntry entryTitle] forKey:@"entryTitle"];
					[importedEntryPrototype setObject:[importedEntry entryCategoryID] forKey:@"entryCategoryID"];
					[importedEntryPrototype setObject:[importedEntry entryPlistFilePath] forKey:@"entryPlistFilePath"];
					NSString *importedEntryPublishedDateStringShort = [importedEntry entryPublishedDateStringShort];
					if (importedEntryPublishedDateStringShort)
						[importedEntryPrototype setObject:importedEntryPublishedDateStringShort forKey:@"entryPublishedDateString"];
						
					[newObject setValue:importedEntryPrototype];
					[newObject setKey:[[importedEntry entryURL] absoluteString]];
					[realEntriesController addObject:newObject];
					//[entriesController addObject:importedEntryPrototype];
					
					//[targetWeblog addEntryToWeblog:importedEntry deferFileWrite:YES];
				}
			}
		}
	}
	[targetWeblog writeListOfEntriesToDisk];
	//[self writeListOfEntriesToDisk];
	//[self refreshListOfEntries];
	
	
	[self updateStatusWithString:@"Import finished."];
	[self stopStatusUpdateSession];
}

- (EPWeblogEntry *)scanHTMLFileAndReturnWeblogEntryObject:(NSString *)pathToFileToImport
												forWeblog:(EPWeblog *)targetWeblog;
{
	EPWeblogEntry *importedEntry = nil;
	BOOL scannerShouldContinue = YES;
	// it's an HTML file
	NSString *potentialImportedEntry = [NSString stringWithContentsOfFile:pathToFileToImport encoding:NSUTF8StringEncoding error:nil];
	NSScanner *HTMLScanner = [[NSScanner alloc] initWithString:potentialImportedEntry];
	
	/* This code block is here because sometimes entries don't have abstracts, and we
	   want to continue scanning for other stuff even if the current entry doesn't have
	   an abstract.  This check happens at the beginning, since the scanner which checks
	   to see if there is an abstract affects the scan position.  */
	
	/*BOOL abstractExists = NO;
	[HTMLScanner scanUpToString:@"<div class=\"abstract\"><div>" intoString:nil];
	if (! [HTMLScanner isAtEnd]) {
		abstractExists = YES;
	}*/
	
	// we either partially scanned the HTML or wholly scanned it; we want to reset
	// the scanner to the beginning in either case
	[HTMLScanner setScanLocation:0];
	
	//NSLog(@"come on.");
	
	
	NSString *entryTitle = @"";
	
	scannerShouldContinue = [HTMLScanner scanUpToString:@"<title>" intoString:nil];
	
	if (! scannerShouldContinue) return nil;
	
	if ([HTMLScanner scanString:@"<title>" intoString:nil]) {
		scannerShouldContinue = [HTMLScanner scanUpToString:@"</title>" intoString:&entryTitle];
		if (! scannerShouldContinue) return nil;
	} else {
		return nil;
	}
	
	//NSLog(@"entryTitle: %@",entryTitle);
	
	NSString *calendarDateString;
	scannerShouldContinue = [HTMLScanner scanUpToString:@"<h2 class=\"date\">" intoString:nil];
	if (! scannerShouldContinue) return nil;
	
	if ([HTMLScanner scanString:@"<h2 class=\"date\">" intoString:nil]) {
		scannerShouldContinue = [HTMLScanner scanUpToString:@"</h2>" intoString:&calendarDateString];
		if (! scannerShouldContinue) return nil;
	} else {
		return nil;
	}
	
	/*NSCalendarDate *testDate = [NSCalendarDate dateWithYear:2003
													  month:3
														day:6
													   hour:8
													 minute:59
													 second:0
												   timeZone:[NSTimeZone defaultTimeZone]];
	NSLog(@"%@",[testDate descriptionWithCalendarFormat:@"%B %e, %Y, %H:%M %p"	//]);
											   timeZone:[NSTimeZone defaultTimeZone]
												 locale:[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]]);*/
	
	//NSLog(@"%@",[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);
	
	NSArray *monthNameArray = [NSArray arrayWithObjects:@"Gennaio",@"Febbraio",@"Marzo",@"Aprile",@"Maggio",@"Giugno",
							   @"Luglio",@"Agosto",@"Settembre",@"Ottobre",@"Novembre",@"Dicembre",nil];
	NSArray *shortMonthNameArray = [NSArray arrayWithObjects:@"Gen",@"Feb",@"Mar",@"Apr",@"Mag",@"Giu",@"Lug",@"Aug",
									@"Set",@"Ott",@"Nov",@"Dic",nil];
	NSArray *shortWeekDayNameArray = [NSArray arrayWithObjects:@"Dom",@"Lun",@"Mar",@"Mer",@"Gio",@"Ven",@"Sab",nil];
	NSArray *weekDayNameArray = [NSArray arrayWithObjects:@"Domenica",@"Lunedi",@"Martedi",@"Mercoledi",@"Giovedi",
								 @"Venerdi",@"Sabato",nil];
	NSArray *AMPMDesignationArray = [NSArray arrayWithObjects:@"m.",@"p.",nil];
	NSDictionary *italianDictionaryRepresentation =
		[NSDictionary dictionaryWithObjectsAndKeys:monthNameArray,@"NSMonthNameArray",
												   shortMonthNameArray,@"NSShortMonthNameArray",
												   shortWeekDayNameArray,@"NSShortWeekDayNameArray",
												   weekDayNameArray,@"NSWeekDayNameArray",
												   AMPMDesignationArray,@"NSAMPMDesignation",
         nil];
	
	NSCalendarDate *theDate = (NSCalendarDate *)[NSDate dateWithNaturalLanguageString:[calendarDateString substringFromIndex:6]
													     locale:italianDictionaryRepresentation];
	/*NSLog(@"%@",testDateTwo);
	NSLog(@"%@",[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);
	
	NSCalendarDate *theDate = [NSCalendarDate dateWithString:[calendarDateString substringFromIndex:6]
											  calendarFormat:@"%B %e, %Y, %H:%M %p"
													  locale:[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]];
	if (theDate == nil) {
		theDate = [NSCalendarDate dateWithString:[calendarDateString substringFromIndex:6]
												  calendarFormat:@"%B %e, %Y, %H:%M:%S"
														  locale:[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]];		
	}
	if (theDate == nil) {
		theDate = [NSCalendarDate dateWithString:[calendarDateString substringFromIndex:7]
								  calendarFormat:@"%B %e, %Y, %H:%M %p"
										  locale:[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]];		
	}
	if (theDate == nil) {
		theDate = [NSCalendarDate dateWithString:[calendarDateString substringFromIndex:6]
								  calendarFormat:@"%B %e, %Y, %H:%M:%S"];		
	}
	if (theDate == nil) {
		theDate = [NSCalendarDate dateWithString:[calendarDateString substringFromIndex:6]
								  calendarFormat:@"%B %e, %Y, %H:%M %p"];		
	}
	if (theDate == nil) {
		theDate = [NSCalendarDate dateWithString:[calendarDateString substringFromIndex:7]
								  calendarFormat:@"%B %e, %Y, %H:%M %p"];		
	}
	if (theDate == nil) {
		theDate = [NSCalendarDate dateWithString:calendarDateString
								  calendarFormat:@"%a - %B %e, %Y, %H:%M:%S"
										  locale:[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]];		
	}*/
	if (theDate == nil) NSLog(@"Error converting to NSCalendarDate: %@",[calendarDateString substringFromIndex:6]);
	if (theDate != nil) NSLog(@"Success converting to NSCalendarDate: %@",[calendarDateString substringFromIndex:6]);
	
	
	NSString *debugString = nil;
	NSString *entryAbstract = @"";
	scannerShouldContinue = [HTMLScanner scanUpToString:@"<div class=\"abstract\">" intoString:&debugString];
	if (! scannerShouldContinue) return nil;
	
	scannerShouldContinue = [HTMLScanner scanString:@"<div class=\"abstract\">" intoString:&debugString];
	if (! scannerShouldContinue) return nil;
	
	BOOL shouldScanExtraDiv = [HTMLScanner scanString:@"<div>" intoString:&debugString];
	// sometimes there's no abstract, so we don't want to return nil if nothing gets scanned
	[HTMLScanner scanUpToString:@"</div>" intoString:&entryAbstract];
	if (shouldScanExtraDiv) [HTMLScanner scanUpToString:@"</div>" intoString:&debugString];
	
	//NSLog(@"entryAbstract: %@",entryAbstract);	
	
	
	
	NSString *entryBody;
	// original string to scan up to was "<div>", but some entries didn't have that
	scannerShouldContinue = [HTMLScanner scanUpToString:@"</div> <br />" intoString:&debugString];
	
	// if there is no abstract, the previous line will not scan any characters
	//if (! scannerShouldContinue) return nil;
	
	if ([HTMLScanner scanString:@"</div> <br />" intoString:&debugString]) {
		//NSLog(@"are we getting here too?");
		BOOL extraDivExists = [HTMLScanner scanString:@"<div>" intoString:&debugString];
		//scannerShouldContinue = [HTMLScanner scanUpToString:@"</div>\n <br />\r\r<a href=\"../../index.html\">" intoString:&entryBody];
		scannerShouldContinue = [HTMLScanner scanUpToString:@"<a href=\"../../index.html\">" intoString:&entryBody];
		
		// I'm including the extra div block because the previous string to scan up to was causing bad results in some entries (they had two brs)
		if (extraDivExists) {
			entryBody = [NSString stringWithFormat:@"<div>%@",entryBody];
		}
	} else {
		return nil;
	}
	//NSLog(@"entryBody: %@",entryBody);
	
	
	NSString *uneditedEntryHTML = entryBody; //[NSString stringWithFormat:@"<html><head>\n</head><body style=\"word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space; \">%@</body></html>",entryBody];
	
	NSURL *entryPlistFilePath = [NSURL fileURLWithPath:[[pathToFileToImport stringByDeletingPathExtension] stringByAppendingPathExtension:@"plist"]];
	//NSLog(@"entryPlistFilePath: %@",entryPlistFilePath);
	
	NSString *entryDeprecatedURL;
	if ([pathToFileToImport hasPrefix:@"/Volumes/simx/Sites/"]) {
		// "/Volumes/simx/Sites/" has 20 characters, so since indexing starts at 0, we want to get the rest of the path string
		entryDeprecatedURL = [NSString stringWithFormat:@"http://homepage.mac.com/simx/%@",[pathToFileToImport substringFromIndex:20]];
	}
	
	NSString *entryCategoryID = nil;
	NSString *pathRelativeToBaseWeblogPath = [[pathToFileToImport componentsSeparatedByString:[[targetWeblog baseFileDirectoryPath] path]] objectAtIndex:1];
	entryCategoryID = [[pathRelativeToBaseWeblogPath pathComponents] objectAtIndex:1];
	
	if ([pathToFileToImport hasPrefix:@"/Volumes/simx/Sites/technonova/"] ||
		[pathToFileToImport hasPrefix:@"/Volumes/simx/Sites/supernova/english/"] ||
		[pathToFileToImport hasPrefix:@"/Volumes/simx/Sites/links/"]) {
		if ([entryCategoryID isEqualToString:@"C399512598"]) {
			entryCategoryID = @"d2x-xl";
		} else if ([entryCategoryID isEqualToString:@"C486203617"]) {
			entryCategoryID = @"rants";
		} else if ([entryCategoryID isEqualToString:@"C488455530"]) {
			entryCategoryID = @"tips";
		} else if ([entryCategoryID isEqualToString:@"C757145247"]) {
			entryCategoryID = @"intarweb";
		} else if ([entryCategoryID isEqualToString:@"C1700219634"]) {
			entryCategoryID = @"publications";
		} else if ([entryCategoryID isEqualToString:@"C1766861589"]) {
			entryCategoryID = @"unfiled";
		} else if ([entryCategoryID isEqualToString:@"C1966536352"]) {
			entryCategoryID = @"software_development";
		} else if ([entryCategoryID isEqualToString:@"C2116391994"]) {
			entryCategoryID = @"apple_bug_friday";
		}
		
		
		 else if ([entryCategoryID isEqualToString:@"C248305192"]) {
			entryCategoryID = @"personal";
		} else if ([entryCategoryID isEqualToString:@"C607077210"]) {
			entryCategoryID = @"tidbits";
		} else if ([entryCategoryID isEqualToString:@"C720420348"]) {
			entryCategoryID = @"school";
		} else if ([entryCategoryID isEqualToString:@"C1277196556"]) {
			entryCategoryID = @"music";
		} else if ([entryCategoryID isEqualToString:@"C1600041083"]) {
			entryCategoryID = @"politics";
		} else if ([entryCategoryID isEqualToString:@"C1785428308"]) {
			entryCategoryID = @"puzzles";
		} else if ([entryCategoryID isEqualToString:@"C1808211058"]) {
			entryCategoryID = @"biking";
		}
		
		
		else if ([entryCategoryID isEqualToString:@"C373145902"]) {
			entryCategoryID = @"games";
		} else if ([entryCategoryID isEqualToString:@"C280258839"]) {
			entryCategoryID = @"humor";
		} else if ([entryCategoryID isEqualToString:@"C1002828996"]) {
			entryCategoryID = @"just_interesting";
		} else if ([entryCategoryID isEqualToString:@"C306271790"]) {
			entryCategoryID = @"politics";
		} else if ([entryCategoryID isEqualToString:@"C417687336"]) {
			entryCategoryID = @"science";
		} else if ([entryCategoryID isEqualToString:@"C740902098"]) {
			entryCategoryID = @"technology";
		} else if ([entryCategoryID isEqualToString:@"C417856420"]) {
			entryCategoryID = @"videos";
		} else if ([entryCategoryID isEqualToString:@"C893536046"]) {
			entryCategoryID = @"unfiled";
		}
	}
	
	importedEntry = [[EPWeblogEntry alloc] init];
	[importedEntry setEntryTitle:entryTitle];
	[importedEntry setEntryCategoryID:[entryCategoryID URLizedString]];
	[importedEntry setEntryAbstract:entryAbstract];
	[importedEntry setEntryUneditedWebViewHTML:uneditedEntryHTML];
	[importedEntry setEntryPlistFilePath:entryPlistFilePath];
	[importedEntry setEntryDeprecatedURL:[NSURL URLWithString:entryDeprecatedURL]];
	[importedEntry setEntryPublishedDate:theDate];
	
	NSString *truncatedTitle = [entryTitle URLizedStringWithLengthLimit:40];
	NSString *truncatedCategory = [entryCategoryID URLizedStringWithLengthLimit:20];
	
	NSString *relativeURLString = [NSString stringWithFormat:@"%@/%@.html",truncatedCategory,truncatedTitle];
	NSURL *baseWeblogURL = [NSURL URLWithString:[[targetWeblog baseWeblogURL] path]];
	NSURL *importedEntryURL = [NSURL URLWithString:relativeURLString relativeToURL:baseWeblogURL];
	[importedEntry setEntryURL:importedEntryURL];
	
	//NSLog(@"uneditedEntryHTML: %@",uneditedEntryHTML);
	
	return importedEntry;
}

- (EPWeblogEntry *)partialWeblogEntryFromPrototype:(NSObject *)entryControllerKeyValuePair;
{
	NSString *theKey = [entryControllerKeyValuePair key];
	NSDictionary *theValue = [entryControllerKeyValuePair value];
	
	EPWeblogEntry *prototypeEntryObject = [[EPWeblogEntry alloc] init];
	
	[prototypeEntryObject setEntryTitle:[theValue objectForKey:@"entryTitle"]];
	[prototypeEntryObject setEntryCategoryID:[theValue objectForKey:@"entryCategoryID"]];
	[prototypeEntryObject setEntryPlistFilePath:[theValue objectForKey:@"entryPlistFilePath"]];
	[prototypeEntryObject setEntryPublishedDateString:[theValue objectForKey:@"entryPublishedDateString"]];
	
	[prototypeEntryObject setEntryURL:[NSURL URLWithString:theKey]];
	
	return prototypeEntryObject;
}

- (EPWeblogEntry *)weblogEntryForPlistFilePath:(NSString *)plistFilePath
									 forWeblog:(EPWeblog *)targetWeblog;
{
	NSDictionary *theExistingEntryProtoObject = [NSDictionary dictionaryWithContentsOfFile:plistFilePath];
	EPWeblogEntry *existingEntry = nil;
	
	if (theExistingEntryProtoObject != nil) {
		existingEntry = [[EPWeblogEntry alloc] init];
	
		
		NSString *entryTitle = [theExistingEntryProtoObject objectForKey:@"Title"];
		[existingEntry setEntryTitle:entryTitle];
		[existingEntry setEntryUneditedWebViewHTML:[theExistingEntryProtoObject objectForKey:@"Unedited WebView HTML"]];
		[existingEntry setEntryMarkdownText:[theExistingEntryProtoObject objectForKey:@"Unedited Markdown Text"]];
		[existingEntry setEntryAbstract:[theExistingEntryProtoObject objectForKey:@"Summary"]];
		[existingEntry setEntryPlistFilePath:[NSURL fileURLWithPath:plistFilePath]];
		
		id categoryObject = [theExistingEntryProtoObject objectForKey:@"Category"];
		NSString *categoryID = nil;
		if ([[categoryObject className] isEqualToString:@"NSCFNumber"]) {
			if ([categoryObject intValue] == 2) {
				categoryID = @"d2x-xl";
			} else if ([categoryObject intValue] == 5) {
				categoryID = @"rants";
			} else if ([categoryObject intValue] == 7) {
				categoryID = @"tips";
			} else if ([categoryObject intValue] == 3) {
				categoryID = @"intarweb";
			} else if ([categoryObject intValue] == 4) {
				categoryID = @"publications";
			} else if ([categoryObject intValue] == 0) {
				categoryID = @"unfiled";
			} else if ([categoryObject intValue] == 6) {
				categoryID = @"software_development";
			} else if ([categoryObject intValue] == 1) {
				categoryID = @"apple_bug_friday";
			}
		} else if ([[categoryObject className] isEqualToString:@"NSCFString"]) {
			categoryID = [categoryObject URLizedStringWithLengthLimit:20];
		} else {
			NSString *testCategoryID = [theExistingEntryProtoObject objectForKey:@"CategoryID"];
			if (testCategoryID) {
				categoryID = testCategoryID;
			} else {
				categoryID = @"unfiled";
			}
		}
		[existingEntry setEntryCategoryID:categoryID];
		
		NSString *URLString = [theExistingEntryProtoObject objectForKey:@"entryURL"];
		NSString *relativeURLString, *baseURLString;
		if (URLString == nil) {
			NSString *truncatedTitle = [entryTitle URLizedStringWithLengthLimit:40];
			NSString *truncatedCategory = [categoryID URLizedStringWithLengthLimit:20];
			relativeURLString = [NSString stringWithFormat:@"%@/%@.html",truncatedCategory,truncatedTitle];
			baseURLString = [[targetWeblog baseWeblogURL] path];
		} else {
			// problems can happen here if the URL is not as expected; this should be robust-ized
            NSURL *baseWeblogURL = [targetWeblog baseWeblogURL];
            NSString *baseWeblogPath = [baseWeblogURL path];
			NSString *potentialRelativeURLString = [[URLString componentsSeparatedByString:baseWeblogPath] objectAtIndex:1];
            if ([potentialRelativeURLString hasPrefix:@"/"]) {
                relativeURLString = [potentialRelativeURLString substringFromIndex:1];
            } else {
                relativeURLString = potentialRelativeURLString;
            }
			baseURLString = baseWeblogPath;
		}
		[existingEntry setEntryURL:[[NSURL URLWithString:baseURLString] URLByAppendingPathComponent:relativeURLString]];
		
		NSMutableDictionary *weblogEntryPrototype = [[targetWeblog entriesDict] objectForKey:[[existingEntry entryURL] absoluteString]];
		NSNumber *publishOrderIndex = [weblogEntryPrototype objectForKey:@"publishOrderIndex"];
		
		if (publishOrderIndex) [existingEntry setPublishOrderIndex:publishOrderIndex];
		
		NSString *deprecatedURLString = [theExistingEntryProtoObject objectForKey:@"entryDeprecatedURL"];
		if (deprecatedURLString != nil) 
			[existingEntry setEntryDeprecatedURL:[NSURL URLWithString:[theExistingEntryProtoObject objectForKey:@"entryDeprecatedURL"]]];
		
		NSDate *protoDate = [theExistingEntryProtoObject objectForKey:@"Publish Date"];
		//NSLog(@"protoDate: %@, for plist file: %@",protoDate,plistFilePath);
		if (protoDate != nil) {
			[existingEntry setEntryPublishedDate:
			 [NSCalendarDate dateWithTimeIntervalSinceReferenceDate:
			  [protoDate timeIntervalSinceReferenceDate]
			  ]];
		}
	}
	
	return existingEntry;
}

/*- (NSString *)categoryDisplayNameForCategoryID:(NSString *)categoryID;
{
	return [categoryDictionary objectForKey:categoryID];
}

- (NSDictionary *)categoryDictionary;
{
	return categoryDictionary;
}*/

- (void)startStatusUpdateSession;
{
	[inlineStatusProgressIndicator startAnimation:nil];
	[inlineStatusText setHidden:NO];
}

- (void)stopStatusUpdateSession;
{
	[inlineStatusProgressIndicator stopAnimation:nil];
	[inlineStatusText setHidden:YES];
}

- (void)updateStatusWithString:(NSString *)statusString;
{
	[self performSelectorOnMainThread:@selector(updateStatusLineAndWindowWithString:)
						   withObject:statusString
						waitUntilDone:NO];
}

- (void)updateStatusLineAndWindowWithString:(NSString *)statusString;
{
	[statusWindowText setStringValue:statusString];
	[statusWindowText display];
	
	[inlineStatusText setStringValue:statusString];
	[inlineStatusText display];
}

- (void)reloadTableViewData;
{
	[realEntriesController rearrangeObjects];
	//[listOfEntriesTableView reloadData];
}

- (void)recalculatePublishOrderingForWeblog:(EPWeblog *)targetWeblog;
{
	//NSLog(@"Recalculating Publish Ordering...");
	NSDictionaryController *dictionaryController = [[NSDictionaryController alloc] initWithContent:[targetWeblog entriesDict]];
	NSArray *allEntryPrototypes = [dictionaryController arrangedObjects];

	//NSLog(@"%@",allEntryPrototypes);
	NSPredicate *publishedPredicate = [NSPredicate predicateWithFormat:@"%K != NULL",@"value.entryPublishedDateString"];
	NSSortDescriptor *descendingDateDescriptor = [[NSSortDescriptor alloc] initWithKey:@"value.entryPublishedDateString"
																		   ascending:NO];
	NSArray *filteredEntryPrototypes = [allEntryPrototypes filteredArrayUsingPredicate:publishedPredicate];
	NSArray *filteredOrderedEntryPrototypes = [filteredEntryPrototypes
													sortedArrayUsingDescriptors:[NSArray arrayWithObject:descendingDateDescriptor]];
	
	
	id currentEntryPrototype = nil;
	int publishOrderIndex = 0;
	NSMutableDictionary *testMutDict = [NSMutableDictionary dictionaryWithDictionary:[targetWeblog entriesDict]];
	for (currentEntryPrototype in filteredOrderedEntryPrototypes) {
		NSString *currentKey = [currentEntryPrototype valueForKey:@"key"];
		
		NSMutableDictionary *mutableEntryPrototype = [NSMutableDictionary dictionaryWithDictionary:[testMutDict objectForKey:currentKey]];
		[mutableEntryPrototype setObject:[NSNumber numberWithInt:publishOrderIndex] forKey:@"publishOrderIndex"];
		[testMutDict setObject:mutableEntryPrototype forKey:currentKey];
		
		// the following should work but it doesn't
		//[currentEntryPrototype setValue:[NSNumber numberWithInt:publishOrderIndex] forKeyPath:@"value.publishOrderIndex"];
		publishOrderIndex++;
	}
	[targetWeblog setEntriesDict:testMutDict];
	
	[targetWeblog setValue:filteredOrderedEntryPrototypes forKey:@"filteredOrderedEntryPrototypes"];
}

- (IBAction)resetAndPublishAllEntries:(id)sender;
{
	[self startStatusUpdateSession];
	[self updateStatusWithString:@"Resetting and publishing all entries..."];
	
	[NSThread detachNewThreadSelector:@selector(resetAndPublishAllEntriesForSelectedWeblog)
							 toTarget:self
						   withObject:nil];
	
	// if you try to stop the spinny progress indicator here, it won't work
	// because it doesn't (can't) wait for the method in the spun-off thread
	// to finish
}

- (void)resetAndPublishAllEntriesForSelectedWeblog;
{	
	// the entry pages need to be published last, because the category counts are calculated
	// inside this method
	[self publishAllEntriesForSelectedWeblog];
	
	EPWeblog *selectedWeblog = [[weblogsController selectedObjects] objectAtIndex:0];
	NSArray *entryPrototypesArray = [realEntriesController arrangedObjects];
	
	for (NSObject *currentEntryPrototype in entryPrototypesArray) {
		NSString *currentEntryPath = [[currentEntryPrototype value] objectForKey:@"entryPlistFilePath"];
		
		[self updateStatusWithString:[NSString stringWithFormat:@"Publishing entry page for path: %@",currentEntryPath]];
		
		EPWeblogEntry *existingEntry = [self weblogEntryForPlistFilePath:currentEntryPath
															   forWeblog:selectedWeblog];
		
		// we don't want to publish here because if there are entries being held as drafts,
		// (done by saving but not publishing from the entry window), then publishing them
		// would make them non-drafts; (really, it's because something chokes when trying
		// to publish an entry that hasn't been published from the entry window)
		[HTMLGeneratorInstance createAndSaveHTMLFileUsingWeblogEntryObject:existingEntry
																 forWeblog:selectedWeblog
															 shouldPublish:NO];
	}
	
	[self stopStatusUpdateSessionOnMainThreadWithString:@"Reset and publish all completed."];
}

- (IBAction)publishAllEntries:(id)sender;
{
	[self startStatusUpdateSession];
	[self updateStatusWithString:@"Commencing publish all..."];
	
	[NSThread detachNewThreadSelector:@selector(publishAllEntriesForSelectedWeblogAndStop)
							 toTarget:self
						   withObject:nil];
	
	// if you try to stop the spinny progress indicator here, it won't work
	// because it doesn't (can't) wait for the method in the spun-off thread
	// to finish
}

- (void)stopStatusUpdateSessionOnMainThreadWithString:(NSString *)stopString;
{
	
	
	[self performSelectorOnMainThread:@selector(updateStatusWithString:)
						   withObject:stopString
						waitUntilDone:NO];
	
	[self performSelectorOnMainThread:@selector(stopStatusUpdateSession)
						   withObject:nil
						waitUntilDone:NO];
}

- (void)publishAllEntriesForSelectedWeblogAndStop;
{
	[self publishAllEntriesForSelectedWeblog];
	[self stopStatusUpdateSessionOnMainThreadWithString:@"Publish all completed."];
}

- (void)publishAllEntriesForSelectedWeblog;
{
	EPWeblog *selectedWeblog = [[weblogsController selectedObjects] objectAtIndex:0];
	[self publishAllEntriesForWeblog:selectedWeblog];
}

- (void)publishAllEntriesForWeblog:(EPWeblog *)targetWeblog;
{
	// we can't depend on the target weblog being the selected weblog, so we have to allocate an entirely
	// new dictionary controller if we want NSDictionaryControllerKeyValuePair objects
	
	NSDictionaryController *dictionaryController = [[NSDictionaryController alloc] initWithContent:[targetWeblog entriesDict]];
	NSArray *sortedEntriesArray = [[dictionaryController arrangedObjects] sortedArrayUsingFunction:dateCompareDescending context:NULL];
	
	
	NSMutableDictionary *categoryEntriesDictionary = [NSMutableDictionary dictionary];
	NSMutableArray *arrayOfPartialWeblogEntries = [NSMutableArray array];
	
	[self updateStatusWithString:@"Sorting through your rambling entries..."];
	
	NSEnumerator *enumerator = [sortedEntriesArray objectEnumerator];
	NSObject *currentWeblogEntryPrototypeKeyValuePair = nil;
	while (currentWeblogEntryPrototypeKeyValuePair = [enumerator nextObject]) {
		
        NSDictionary *currentWeblogEntryPrototype = (NSDictionary *)[currentWeblogEntryPrototypeKeyValuePair value];
        
        
		// this line is to create an array of EPWeblogEntry objects suitable for publishing from just the
		// prototype dictionaries, so that we can create the archive page -- we don't want to actually
		// retrieve any of the information from the plist files for the entries themselves; we're just
		// using the summary information from the plist for the global list of entries
        
        NSString *publishedDateString = [currentWeblogEntryPrototype objectForKey:@"entryPublishedDateString"];
        
		if (publishedDateString) {
            //NSLog(@"%@: %@",[currentWeblogEntryPrototype objectForKey:@"entryTitle"],[currentWeblogEntryPrototype objectForKey:@"entryPublishedDateString"]);
			[arrayOfPartialWeblogEntries addObject:[self partialWeblogEntryFromPrototype:currentWeblogEntryPrototypeKeyValuePair]];
            
            // we don't want drafts being counted or included in the category pages
            NSString *currentEntryCategoryID = [currentWeblogEntryPrototype objectForKey:@"entryCategoryID"];
            if (! [categoryEntriesDictionary objectForKey:currentEntryCategoryID]) {
                
                // there's no array for this category in the categoryEntriesDictionary yet
                [categoryEntriesDictionary setObject:[NSMutableArray array] forKey:currentEntryCategoryID];
            }
            
            [[categoryEntriesDictionary objectForKey:currentEntryCategoryID]
             addObject:[self weblogEntryForPlistFilePath:[currentWeblogEntryPrototype objectForKey:@"entryPlistFilePath"]
                                               forWeblog:targetWeblog]
             ];
        } else {
            NSLog(@"not published: %@",[currentWeblogEntryPrototype objectForKey:@"entryTitle"]);
        }
		
		// the stuff below this line is to sort entries into categories for when we create
		// the category pages
		
		
        
		
	}
	
	
	
	// create an array of EPWeblogEntry objects, with the actual contents of the weblog
	// post, abstract, etc.
	
	NSMutableArray *recentWeblogEntries = [NSMutableArray array];
	int i = 0;
	for (i = 0; i < 10; i++) {
		NSDictionary *entryPrototypeKeyValuePair = [sortedEntriesArray objectAtIndex:i];
		[recentWeblogEntries addObject:[self weblogEntryForPlistFilePath:[[entryPrototypeKeyValuePair value] objectForKey:@"entryPlistFilePath"]
															   forWeblog:targetWeblog]
		 ];
	}
	
	
	
	// update the count of total number of entries in each category in the EPWeblog object before
	// we actually publish any pages
	
	NSMutableDictionary *categoryStats = [NSMutableDictionary dictionary];
	NSString *currentCategoryID = nil;
	int totalCount = 0;
	for (currentCategoryID in [categoryEntriesDictionary allKeys]) {
		int categoryCount = [[categoryEntriesDictionary objectForKey:currentCategoryID] count];
		totalCount += categoryCount;
		[categoryStats setObject:[NSNumber numberWithInt:categoryCount] forKey:currentCategoryID];
	}
	[categoryStats setObject:[NSNumber numberWithInt:totalCount] forKey:@"Total Count"];
	[targetWeblog setCategoryStats:categoryStats];
	
	[self updateStatusWithString:@"Creating categoryStats.js..."];
	[HTMLGeneratorInstance createCategoryStatsJavaScriptFileFromStatsDict:categoryStats
																forWeblog:targetWeblog];
	
	
	
	[self updateStatusWithString:@"Creating index.html, rss.xml, RecentEntries.js..."];
	[HTMLGeneratorInstance createRecentEntriesPagesUsingArrayOfWeblogEntryObjects:recentWeblogEntries
																			  forWeblog:targetWeblog];
	
	
	[self updateStatusWithString:@"Creating archive.html..."];
	[HTMLGeneratorInstance createArchivePageForArrayOfWeblogEntryObjects:arrayOfPartialWeblogEntries
															   forWeblog:targetWeblog];
	
	
	currentCategoryID = nil;
	for (currentCategoryID in [categoryEntriesDictionary allKeys]) {
		[self updateStatusWithString:[NSString stringWithFormat:@"Publishing %@ category page...",currentCategoryID]];
		[HTMLGeneratorInstance createCategoryPageForArrayOfWeblogEntryObjects:[categoryEntriesDictionary objectForKey:currentCategoryID]
																   categoryID:currentCategoryID
																	forWeblog:targetWeblog];
	}
	
}

- (IBAction)openWeblogEntry:(id)sender;
{
	//int theSelectedIndex = [listOfEntriesTableView selectedRow];
	NSMutableDictionary *theExistingEntryPrototype = [[realEntriesController selectedObjects] objectAtIndex:0];
	//NSLog(@"%@",theExistingEntryPrototype);
	EPWeblog *selectedWeblog = [[weblogsController selectedObjects] objectAtIndex:0];
	
	EPEntryEditorController *entryEditorControllerInstance = [[EPEntryEditorController alloc] init];
	//[entryEditorControllerInstance setEntryURL:[listOfEntriesKeysArray objectAtIndex:theSelectedIndex]];
	[entryEditorControllerInstance setHTMLGeneratorObject:HTMLGeneratorInstance];
	[entryEditorControllerInstance setEntriesManagerObject:self];
	[entryEditorControllerInstance setWeblogEntryPrototype:theExistingEntryPrototype];
	[entryEditorControllerInstance setWeblog:selectedWeblog];
	
	// here we need to open the plist file and re-create the EPWeblogEntry object so that it can be displayed
	EPWeblogEntry *existingEntry = [self weblogEntryForPlistFilePath:[[theExistingEntryPrototype value] objectForKey:@"entryPlistFilePath"]
														   forWeblog:selectedWeblog];
	[entryEditorControllerInstance setWeblogEntry:existingEntry];
	
	//NSLog(@"window is now about to load");
	[entryEditorControllerInstance showWindow:self];
}

- (IBAction)deleteSelectedWeblogEntry:(id)sender;
{
	// this method needs to be rewritten following a massive re-refactoring of the data objects
	// so that they use an NSDictionaryController instead of an NSArrayController
	//NSLog(@"%@",[[[weblogsController selectedObjects] objectAtIndex:0] entriesDict]);
	//NSLog(@"%@",[[entriesController selectedObjects] objectAtIndex:0]);
	
	/*NSString *plistFilePath = [[[entriesController selectedObjects] objectAtIndex:0] objectForKey:@"entryPlistFilePath"];
	NSDictionary *theExistingEntryProtoObject = [NSDictionary dictionaryWithContentsOfFile:plistFilePath];
	NSString *URLString = [theExistingEntryProtoObject objectForKey:@"entryURL"];*/
	
	NSDictionary *entryPrototype = [[realEntriesController selectedObjects] objectAtIndex:0];
	[realEntriesController removeObject:entryPrototype];
	
	EPWeblog *selectedWeblog = [[weblogsController selectedObjects] objectAtIndex:0];
	//NSMutableArray *bindingsCompliantEntries = [selectedWeblog mutableArrayValueForKey:@"entries"];
	//[bindingsCompliantEntries removeObject:entryPrototype];
	
	[selectedWeblog writeListOfEntriesToDisk];
	//[selectedWeblog deleteEntryWithURLStringFromWeblog:URLString deferFileWrite:NO];
}

- (IBAction)createNewMarkdownWeblogEntry:(id)sender;
{
	[self createNewWeblogEntryUsingMarkdown:YES
								  forWeblog:[[weblogsController selectedObjects] objectAtIndex:0]];
}

- (IBAction)createNewWebViewWeblogEntry:(id)sender;
{
	[self createNewWeblogEntryUsingMarkdown:NO
								  forWeblog:[[weblogsController selectedObjects] objectAtIndex:0]];
}

// this breaks MVC paradigm, but whatever
- (NSDictionaryController *)realEntriesController;
{
	return realEntriesController;
}

- (void)createNewWeblogEntryUsingMarkdown:(BOOL)shouldUseMarkdown
								forWeblog:(EPWeblog *)targetWeblog;
{
	//[listOfEntriesArray addObject:newEntry];
	[targetWeblog writeListOfEntriesToDisk];
	//[listOfEntriesTableView reloadData];
	
	EPWeblogEntry *newEntry = [[EPWeblogEntry alloc] init];
	
	// an untitled object is initialized here so that we have a prototype to update
	// if the user decides to save the entry; otherwise, we'd have to call back
	// to the entriesManager from the editor window to get the controller and 
	// create a new object
	NSObject *newObject = [realEntriesController newObject];
	//NSLog(@"%@",[newObject blahQuestion]);
	
	NSMutableDictionary *newEntryPrototype = [[NSMutableDictionary alloc] init];
	[newEntryPrototype setObject:[newEntry entryTitle] forKey:@"entryTitle"];
	[newEntryPrototype setObject:[newEntry entryCategoryID] forKey:@"entryCategoryID"];
	[newEntryPrototype setObject:[newEntry entryPlistFilePath] forKey:@"entryPlistFilePath"];
	NSString *newEntryPublishedDateStringShort = [newEntry entryPublishedDateStringShort];
	if (newEntryPublishedDateStringShort)
		[newEntryPrototype setObject:newEntryPublishedDateStringShort forKey:@"entryPublishedDateString"];
	
	[newObject setValue:newEntryPrototype];
	[newObject setKey:[[newEntry entryURL] absoluteString]];
	[realEntriesController addObject:newObject];
	/*NSMutableDictionary *mutablePrototype = [NSMutableDictionary dictionaryWithDictionary:theNewEntryPrototype];
	[mutablePrototype setObject:[weblogs objectAtIndex:0] forKey:@"weblog"];*/
	
	
	EPEntryEditorController *entryEditorControllerInstance = [[EPEntryEditorController alloc] init];
	[entryEditorControllerInstance setWeblogEntryPrototype:(NSDictionary *)newObject];
	[entryEditorControllerInstance setWeblog:targetWeblog];
	[entryEditorControllerInstance setWeblogEntryObject:newEntry usingMarkdown:shouldUseMarkdown];
	[entryEditorControllerInstance setHTMLGeneratorObject:HTMLGeneratorInstance];
	[entryEditorControllerInstance setEntriesManagerObject:self];
	[entryEditorControllerInstance showWindow:self];
}

/*- (void)addWeblogEntryObject:(EPWeblogEntry *)theWeblogEntry deferFileWrite:(BOOL)shouldDeferWrite;
{	
	[entries setObject:[NSDictionary dictionaryWithObjectsAndKeys:[theWeblogEntry entryTitle],@"entryTitle",
		[theWeblogEntry entryCategoryID],@"entryCategoryID",
		[theWeblogEntry entryPlistFilePath],@"entryPlistFilePath",
		[theWeblogEntry entryPublishedDateStringShort],@"entryPublishedDateString",nil] forKey:[[theWeblogEntry entryURL] absoluteString]];
	[self refreshListOfEntries];
	if (! shouldDeferWrite)	[self writeListOfEntriesToDisk];
}*/

NSInteger dateCompare(NSObject *object1, NSObject *object2, void *context)
{
	NSInteger returnValue = NSOrderedSame;
	
	NSString *firstEntryDateString = [[object1 value] objectForKey:@"entryPublishedDateString"];
	NSString *secondEntryDateString = [[object2 value] objectForKey:@"entryPublishedDateString"];
	
	/*if ([firstEntryDateString isEqualToString:@""] || [secondEntryDateString isEqualToString:@""]) {
		if ([firstEntryDateString isEqualToString:@""] && [secondEntryDateString isEqualToString:@""]) {
			returnValue = NSOrderedSame;
		} else if ([firstEntryDateString isEqualToString:@""]) {
			returnValue = NSOrderedDescending;
		} else {
			returnValue = NSOrderedAscending;
		}
	} else {*/
		NSCalendarDate *firstEntryDate = [NSCalendarDate dateWithString:firstEntryDateString calendarFormat:@"%Y-%m-%d; %H:%M:%S" locale:[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]];
		NSCalendarDate *secondEntryDate = [NSCalendarDate dateWithString:secondEntryDateString calendarFormat:@"%Y-%m-%d; %H:%M:%S" locale:[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]];
		returnValue = [firstEntryDate compare:secondEntryDate];
	//}
		
    return returnValue;
}

NSInteger dateCompareDescending(id object1, id object2, void *context)
{
	NSInteger result = dateCompare(object1, object2, NULL);
	
	if (result == NSOrderedSame) {
		/*if (context == @"secondary_done") {
		 return result;
		 }
		 result = (*secondary_sort_order)(object1,object2,@"secondary_done");*/
		
		// use this block to implement secondary sort ordering
    }
	
	return -result;
}


@end
