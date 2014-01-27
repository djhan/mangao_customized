//
//  AutoEnhance.m
//  Mangao Kai
//
//  Created by DJ.HAN http://djhan.ddanzimovie.com/ .
//  Copyright (c) 2013 DJ.HAN. All rights reserved.
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

#import "AutoEnhance.h"

@implementation AutoEnhance

- (id)init
{
    self =[super init];
    return self;
}

- (void)dealloc
{
    [ciImage release];
    [adjustments release];
    [resultRep release];
    [result release];

	[super dealloc];
}

+ (NSImage*)AutoEnhanceImage:(NSImage*)srcImage
{
    NSData *tiffData = [srcImage TIFFRepresentation];
//    CGContextRef cgContext = [[NSGraphicsContext currentContext]
//                              graphicsPort];
//    NSDictionary *contextOptions = [NSDictionary dictionaryWithObjectsAndKeys:
//                                    [NSNumber numberWithBool:NO], @"kCIContextUseSoftwareRenderer", nil];
//    CIContext *coreContext = [CIContext contextWithCGContext:cgContext
//                                                     options:contextOptions];
    
    CIImage *ciImage = [CIImage imageWithData:tiffData];

    NSArray* adjustments = [ciImage autoAdjustmentFiltersWithOptions:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:false] forKey:kCIImageAutoAdjustRedEye]];
    
    for (CIFilter *filter in adjustments)
    {
        [filter setValue:ciImage forKey:kCIInputImageKey];
        ciImage = [filter valueForKey:@"outputImage"];
    }
    
//    CGImageRef imgRef = [coreContext createCGImage:ciImage fromRect:ciImage.extent] ;
    
//원래 코드
//    NSCIImageRep *resultRep = [NSCIImageRep imageRepWithCIImage:ciImage];
//        NSImage *result = [[NSImage alloc] initWithSize:resultRep.size];

//auto colorize에서의 대체 코드
    NSBitmapImageRep* resultRep=[[NSBitmapImageRep alloc]initWithCIImage:ciImage];
    NSImage* result=[[NSImage alloc]initWithData:[resultRep TIFFRepresentation]];

    
    //    NSImage *result = [[NSImage alloc] initWithCGImage:imgRef size:NSZeroSize];

//원래 코드
//    [result addRepresentation:resultRep];

    return result;

    [adjustments release];
    [tiffData release];
    [ciImage release];
    [resultRep release];
    [result autorelease];
}

@end
