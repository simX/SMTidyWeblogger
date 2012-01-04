//
//  NSURL+SMURLAdditions.h
//  TidyWeblogger
//
//  Created by Simone Manganelli on 03/01/12.
//  Copyright (c) 2012 The Little App Factory. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (SMURLAdditions)

- (NSString *)relativePathFromURL:(NSURL *)compareURL;
- (NSURL *)relativeURLStartingFromBaseURL:(NSURL *)startURL;

@end
