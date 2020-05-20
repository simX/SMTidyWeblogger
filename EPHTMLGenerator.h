//
//  EPHTMLGenerator.h
//  TidyWeblogger
//
//  Created by Simone Manganelli on 2008-01-31.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
@class EPWeblogEntry;
@class EPWeblog;


@interface EPHTMLGenerator : NSObject {
	IBOutlet NSTextField *dotMacUsernameTextField;
	IBOutlet NSSecureTextField *dotMacPasswordTextField;
}


- (BOOL)pathIsAvailableForWeblog:(EPWeblog *)targetWeblog
					URLizedTitle:(NSString *)URLizedTitle
				 URLizedCategory:(NSString *)URLizedCategory;
- (BOOL)writePlistFileForWeblogEntryObject:(EPWeblogEntry *)theWeblogEntry
								 forWeblog:(EPWeblog *)targetWeblog
							   publishDate:(NSCalendarDate *)entryPublishedDate;
- (void)createAndSaveHTMLFileUsingWeblogEntryObject:(EPWeblogEntry *)theWeblogEntry
										  forWeblog:(EPWeblog *)targetWeblog
									  shouldPublish:(BOOL)shouldPublish;

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
- (BOOL)createCategoryStatsJavaScriptFileFromStatsDict:(NSDictionary *)categoryStats
											 forWeblog:(EPWeblog *)targetWeblog;
- (void)createRecentEntriesPagesUsingArrayOfWeblogEntryObjects:(NSArray *)arrayOfEntryObjects
														   forWeblog:(EPWeblog *)targetWeblog;
- (void)createCategoryPageForArrayOfWeblogEntryObjects:(NSArray *)arrayOfEntryObjects
											categoryID:(NSString *)categoryID
											 forWeblog:(EPWeblog *)targetWeblog;
- (void)createArchivePageForArrayOfWeblogEntryObjects:(NSArray *)arrayOfEntryObjects
											forWeblog:(EPWeblog *)targetWeblog;

- (NSString *)modifyRawWebViewHTML:(NSString *)immutableRawWebViewHTML;
- (NSString *)getHTMLForMarkdownText:(NSString *)markdownText;

- (IBAction)testNSScannerWithNonASCIIChars:(id)sender;

@end
