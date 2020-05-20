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
    NSString *returnString = nil;
    
    NSString *startPath = [startURL path];
    NSString *endPath = [self path];
    
    if ([startPath isEqualToString:endPath])
    {
        returnString = [startPath lastPathComponent];
    }
    else
    {
        // first: determine the common path to both URLs
        NSString *basePath = endPath;
        while (! [startPath hasPrefix:basePath])
        {
            basePath = [basePath stringByDeletingLastPathComponent];
        }
        
        
        // second: determine how many levels to go up from the start path
        
        // we start by deleting one component and the count at 0 because the last
        // path component is the name of the file.  So two files in the same folder
        // should have a sublevelCount of 0, but you will delete one component to
        // find the base path of those two files.
        NSInteger sublevelCount = 0;
        NSString *intermediatePath = [startPath stringByDeletingLastPathComponent];
        while (! [intermediatePath isEqualToString:basePath])
        {
            intermediatePath = [intermediatePath stringByDeletingLastPathComponent];
            sublevelCount++;
        }
        
        
        
        // third: construct the part of the relative path that traverses up the hierarchy
        
        NSString *relativePath = @"";
        NSInteger i = 0;
        for (i = 0; i < sublevelCount; i++) {
            relativePath = [relativePath stringByAppendingPathComponent:@"../"];
        }
        
        
        // fourth: construct the part of the relative path that goes back down the
        // hierarchy (this is the part of the end path that is NOT common to the start
        // path)
        
        NSInteger basePathComponentsCount = [[basePath pathComponents] count];
        NSArray *selfPathComponents = [self pathComponents];
        for (i = basePathComponentsCount; i < [selfPathComponents count]; i++)
        {
            relativePath = [relativePath stringByAppendingPathComponent:[selfPathComponents objectAtIndex:i]];
        }
        
        
        // fifth: special case... if we don't have anything in the relative path,
        // just return "." to keep it in the same directory
        
        if ([relativePath isEqualToString:@""]) relativePath = @".";
        returnString = relativePath;
    }
    
    return returnString;
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
