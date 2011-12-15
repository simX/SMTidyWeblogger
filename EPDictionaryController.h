//
//  EPDictionaryController.h
//  TidyWeblogger
//
//  Created by Simone Manganelli on 2008-12-28.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface EPDictionaryController : NSDictionaryController {

}

- (void)add:(id)sender;
- (void)addObject:(id)object;
- (void)addObjects:(NSArray *)objects;
- (void)remove:(id)sender;
- (void)removeObject:(id)object;
- (void)removeObjectAtArrangedObjectIndex:(NSUInteger)index;
- (void)removeObjects:(NSArray *)objects;
- (void)removeObjectsAtArrangedObjectIndexes:(NSIndexSet *)indexes;

@end
