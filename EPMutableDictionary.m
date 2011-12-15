//
//  EPMutableDictionary.m
//  TidyWeblogger
//
//  Created by Simone Manganelli on 2008-12-28.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "EPMutableDictionary.h"


@implementation EPMutableDictionary

@synthesize annoyedDictionary;

- (NSString *)blahQuestion;
{
	return @"blahResponse";
}

- (id)init;
{
	NSLog(@"initing...");
	if (self = [super init]) {
		annoyedDictionary = [[NSMutableDictionary alloc] init];
	}
	
	return self;
}

- (id)initWithCapacity:(NSUInteger)numItems;
{
	NSLog(@"initing with capacity...");
	if (self = [super init]) {
		annoyedDictionary = [[NSMutableDictionary alloc] init];
	}
	
	return self;
}

- (void)setObject:(id)anObject forKey:(id)aKey;
{
	NSLog(@"setObject:forKey: uh... what?");
	
	if ([[anObject className] isEqualToString:@"NSCFDictionary"] || [[anObject className] isEqualToString:@"EPMutableDictionary"]) {
		if ([anObject respondsToSelector:@selector(setObject:forKey:)]) {
			NSLog(@"anObject responds to an NSMutableDictionary method");
		} else {
			NSLog(@"anObject DOES NOT RESPOND to an NSMutableDictionary method");
		}
	} else {
		NSLog(@"WTF this object is an %@",[anObject className]);
	}
	
	return [annoyedDictionary setObject:anObject forKey:aKey];
}


- (void)setValue:(id)value forKey:(NSString *)key;
{
	NSLog(@"setValue:forKey: uh... what?");
	
	if ([[value className] isEqualToString:@"NSCFDictionary"] || [[value className] isEqualToString:@"EPMutableDictionary"]) {
		if ([value respondsToSelector:@selector(setObject:forKey:)]) {
			NSLog(@"anObject responds to an NSMutableDictionary method");
		} else {
			NSLog(@"anObject DOES NOT RESPOND to an NSMutableDictionary method");
		}
	} else {
		NSLog(@"WTF this object is an %@",[value className]);
	}
	
	return [annoyedDictionary setValue:value forKey:key];
}

- (void)addEntriesFromDictionary:(NSDictionary *)otherDictionary;
{
	NSLog(@"addEntriesFromDictionary:");
	
	return [annoyedDictionary addEntriesFromDictionary:otherDictionary];
}


- (void)setDictionary:(NSDictionary *)otherDictionary;
{
	NSLog(@"setDictionary:");
	
	return [annoyedDictionary setDictionary:otherDictionary];
}

- (id)objectForKey:(id)aKey;
{
	return [annoyedDictionary objectForKey:aKey];
}

- (NSArray *)allKeys;
{
	return [annoyedDictionary allKeys];
}

+ (id)dictionaryWithDictionary:(NSDictionary *)otherDictionary;
{
	EPMutableDictionary *newDictionary = [[EPMutableDictionary alloc] init];
	[[newDictionary annoyedDictionary] setDictionary:otherDictionary];
	//NSLog(@"%@",[newDictionary annoyedDictionary]);
	return [newDictionary autorelease];
}

- (NSMutableDictionary *)annoyedDictionary;
{
	return annoyedDictionary;
}

- (NSEnumerator *)keyEnumerator;
{
	return [annoyedDictionary keyEnumerator];
}

- (NSUInteger)count;
{
	return [annoyedDictionary count];
}

@end
