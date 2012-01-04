//
//  NSURL+SMURLAdditions.m
//  TidyWeblogger
//
//  Created by Simone Manganelli on 03/01/12.
//  Copyright (c) 2012 The Little App Factory. All rights reserved.
//

#import "NSURL+SMURLAdditions.h"

@implementation NSURL (SMURLAdditions)

- (NSString *)relativePathFromURL:(NSURL *)startURL;
{
    NSString *basePath = [[self path] commonPrefixWithString:[startURL path] options:NSLiteralSearch];
    
    NSArray *startRelativeComponents = [[startURL path] componentsSeparatedByString:basePath];
    NSString *startPathRelativeToBasePath = [startRelativeComponents objectAtIndex:1];
    
    // minus two because the -path method removes the last slash even though
    // it's a folder, leaving an extra slash at the start, so that's one extra
    // count; also, we're counting the occurrences of slashes (indicating how
    // many levels to go up), so there is one more component separated by
    // slashes than there are slashes, so that's a second extra count
    NSInteger sublevelCount = [[startPathRelativeToBasePath componentsSeparatedByString:@"/"] count] - 2;
    
    NSString *relativePath = @"";
    NSInteger i = 0;
    for (i = 0; i < sublevelCount; i++) {
        relativePath = [relativePath stringByAppendingPathComponent:@"../"];
    }
    
    NSArray *desiredRelativeComponents = [[self path] componentsSeparatedByString:basePath];
    NSString *desiredPathRelativeToBasePath = [desiredRelativeComponents objectAtIndex:1];
    
    relativePath = [relativePath stringByAppendingPathComponent:desiredPathRelativeToBasePath];
    if ([relativePath isEqualToString:@""]) relativePath = @".";
    
    return relativePath;
}

- (NSURL *)relativeURLStartingFromBaseURL:(NSURL *)baseURL;
{
    NSArray *desiredRelativeComponents = [[self path] componentsSeparatedByString:[baseURL path]];
    NSString *desiredPathRelativeToBasePath = [desiredRelativeComponents objectAtIndex:1];
    if ([desiredPathRelativeToBasePath hasPrefix:@"/"]) desiredPathRelativeToBasePath = [desiredPathRelativeToBasePath substringFromIndex:1];
    NSURL *relativeURL = [NSURL URLWithString:desiredPathRelativeToBasePath relativeToURL:baseURL];
    
    return relativeURL;
}

@end
