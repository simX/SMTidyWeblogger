//
//  EPWeblogEntryPrototype.h
//  TidyWeblogger
//
//  Created by Simone Manganelli on 2008-12-28.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class EPMutableDictionary;


@interface EPWeblogEntryPrototype : NSObject {
	EPMutableDictionary *value;
	NSString *key;
	NSString *localizedKey;
}

//@property(retain) EPMutableDictionary *value;
@property(retain) NSString *key;
@property(retain) NSString *localizedKey;

- (EPMutableDictionary *)value;
- (void)setValue:(NSDictionary *)newValue;

- (BOOL)isExplicitlyIncluded;
- (NSString *)blahQuestion;

@end
