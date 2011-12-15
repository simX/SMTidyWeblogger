//
//  EPDictionaryController.m
//  TidyWeblogger
//
//  Created by Simone Manganelli on 2008-12-28.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "EPDictionaryController.h"
#import "EPMutableDictionary.h"


@implementation EPDictionaryController

- (id)init;
{
	if (self = [super init]) {
		[self setObjectClass:[NSMutableDictionary class]];
	}
	
	return self;
}

- (void)add:(id)sender;
{
	NSLog(@"add:");
	[super add:sender];
}

- (id)newObject;
{
	id superNewObject = [super newObject];
	NSLog(@"superNewObject");
	return superNewObject;
}


- (void)addObject:(id)object;
{
	NSLog(@"addObject:");
	[super addObject:object];
}


- (void)addObjects:(NSArray *)objects;
{
	NSLog(@"addObjects:");
	[super addObjects:objects];
}



- (void)remove:(id)sender;
{
	NSLog(@"remove:");
	[super remove:sender];
}



- (void)removeObject:(id)object;
{
	NSLog(@"removeObject:");
	[super removeObject:object];
}



- (void)removeObjectAtArrangedObjectIndex:(NSUInteger)index;
{
	NSLog(@"removeObjecAtArrangedObjectIndex:");
	[super removeObjectAtArrangedObjectIndex:index];
}



- (void)removeObjects:(NSArray *)objects;
{
	NSLog(@"removeObjects:");
	[super removeObjects:objects];
}



- (void)removeObjectsAtArrangedObjectIndexes:(NSIndexSet *)indexes;
{
	NSLog(@"removeObjectsAtArrangedObjectIndexes:");
	[super removeObjectsAtArrangedObjectIndexes:indexes];
}




@end
