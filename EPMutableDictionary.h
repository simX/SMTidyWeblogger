//
//  EPMutableDictionary.h
//  TidyWeblogger
//
//  Created by Simone Manganelli on 2008-12-28.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface EPMutableDictionary : NSMutableDictionary {
	NSMutableDictionary *annoyedDictionary;
}

@property(retain) NSMutableDictionary *annoyedDictionary;


- (NSString *)blahQuestion;
- (id)initWithCapacity:(NSUInteger)numItems;

- (void)setObject:(id)anObject forKey:(id)aKey;
- (void)setValue:(id)value forKey:(NSString *)key;

- (void)addEntriesFromDictionary:(NSDictionary *)otherDictionary;
- (void)setDictionary:(NSDictionary *)otherDictionary;

- (id)objectForKey:(id)aKey;
- (NSArray *)allKeys;
+ (id)dictionaryWithDictionary:(NSDictionary *)otherDictionary;

- (NSMutableDictionary *)annoyedDictionary;

- (NSEnumerator *)keyEnumerator;
- (NSUInteger)count;

@end
