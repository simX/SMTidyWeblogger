//
//  EPStringCategory.m
//  TidyWeblogger
//
//  Created by Simone Manganelli on 2008-12-01.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "EPStringCategory.h"


@implementation NSString (EPStringCategory)

- (NSString *)JavaScriptizedString;
{
	return [self URLizedStringWithLengthLimit:0 forJavaScript:YES];
}

- (NSString *)URLizedString;
{
	return [self URLizedStringWithLengthLimit:0 forJavaScript:NO];
}

- (NSString *)URLizedStringWithLengthLimit:(int)length;
{
	return [self URLizedStringWithLengthLimit:length forJavaScript:NO];
}

// passing 0 as the length parameter will cause no truncation to be performed
- (NSString *)URLizedStringWithLengthLimit:(int)length forJavaScript:(BOOL)forJavaScript;
{
	NSMutableString *tempString = nil;
	
	if (! forJavaScript) {
		tempString = [NSMutableString stringWithString:[self lowercaseString]];
		[tempString replaceOccurrencesOfString:@"'" withString:@"" options:NSLiteralSearch range:NSMakeRange(0,[tempString length])];
		[tempString replaceOccurrencesOfString:@"\"" withString:@"" options:NSLiteralSearch range:NSMakeRange(0,[tempString length])];
	} else {
		tempString = [NSMutableString stringWithString:self];
		[tempString replaceOccurrencesOfString:@"'" withString:@"&apos;" options:NSLiteralSearch range:NSMakeRange(0,[tempString length])];
		[tempString replaceOccurrencesOfString:@"\"" withString:@"&quot;" options:NSLiteralSearch range:NSMakeRange(0,[tempString length])];
		[tempString replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:NSMakeRange(0,[tempString length])];
	}
	
	if (! forJavaScript) {
		[tempString replaceOccurrencesOfString:@" " withString:@"_" options:NSLiteralSearch range:NSMakeRange(0,[tempString length])];
		//[tempString replaceOccurrencesOfString:@"-" withString:@"_" options:NSLiteralSearch range:NSMakeRange(0,[tempString length])];
		[tempString replaceOccurrencesOfString:@"," withString:@"" options:NSLiteralSearch range:NSMakeRange(0,[tempString length])];
		[tempString replaceOccurrencesOfString:@"." withString:@"" options:NSLiteralSearch range:NSMakeRange(0,[tempString length])];
		[tempString replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:NSMakeRange(0,[tempString length])];
		[tempString replaceOccurrencesOfString:@"\r" withString:@"" options:NSLiteralSearch range:NSMakeRange(0,[tempString length])];
		[tempString replaceOccurrencesOfString:@"(" withString:@"" options:NSLiteralSearch range:NSMakeRange(0,[tempString length])];
		[tempString replaceOccurrencesOfString:@")" withString:@"" options:NSLiteralSearch range:NSMakeRange(0,[tempString length])];
		[tempString replaceOccurrencesOfString:@"!" withString:@"" options:NSLiteralSearch range:NSMakeRange(0,[tempString length])];
		[tempString replaceOccurrencesOfString:@"/" withString:@"" options:NSLiteralSearch range:NSMakeRange(0,[tempString length])];
		[tempString replaceOccurrencesOfString:@":" withString:@"" options:NSLiteralSearch range:NSMakeRange(0,[tempString length])];
		[tempString replaceOccurrencesOfString:@"?" withString:@"" options:NSLiteralSearch range:NSMakeRange(0,[tempString length])];
		[tempString replaceOccurrencesOfString:@"|" withString:@"" options:NSLiteralSearch range:NSMakeRange(0,[tempString length])];
		[tempString replaceOccurrencesOfString:@"%" withString:@"" options:NSLiteralSearch range:NSMakeRange(0,[tempString length])];
	}
	
	NSData *ASCIIStringData = [tempString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
	NSString *ASCIIString = [[NSString alloc] initWithData:ASCIIStringData encoding:NSASCIIStringEncoding];
	//[tempString replaceOccurrencesOfString:@"é" withString:@"e" options:NSLiteralSearch range:NSMakeRange(0,[tempString length])];
	
	
	NSString *truncatedString = nil;
	if (length == 0) {
		truncatedString = ASCIIString;
	} else if ([tempString length] > length) {
		truncatedString = [ASCIIString substringToIndex:(length - 1)];
	} else {
		truncatedString = ASCIIString;
	}
	
	return truncatedString;
}


@end
