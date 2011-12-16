//
//  EPWeblogEntryPrototype.m
//  TidyWeblogger
//
//  Created by Simone Manganelli on 2008-12-28.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "EPWeblogEntryPrototype.h"
#import "EPMutableDictionary.h"


@implementation EPWeblogEntryPrototype

//@synthesize value;
@synthesize key;
@synthesize localizedKey;

- (id)init;
{
	if (self = [super init]) {
		key = @"atoeurclb";
		localizedKey = @",r.ckb,lc.lrmoesnu";
		value = [EPMutableDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"rcoehu",@"rcoehurch",nil]];
	}
	
	return self;
}

- (EPMutableDictionary *)value;
{
	return value;
}

- (void)setValue:(NSDictionary *)newValue;
{
	NSLog(@"%@",newValue);
	
	if (value != newValue) {
		value = [[EPMutableDictionary alloc] initWithDictionary:newValue];
	}
}

- (NSString *)blahQuestion;
{
	return @"blahResponse";
}

- (BOOL)isExplicitlyIncluded;
{
	return NO;
}

@end
