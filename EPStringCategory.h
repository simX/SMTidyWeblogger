//
//  EPStringCategory.h
//  TidyWeblogger
//
//  Created by Simone Manganelli on 2008-12-01.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSString (EPStringCategory)

- (NSString *)URLizedString;
- (NSString *)URLizedStringWithLengthLimit:(int)length;
- (NSString *)JavaScriptizedString;
- (NSString *)URLizedStringWithLengthLimit:(int)length forJavaScript:(BOOL)forJavaScript;

@end