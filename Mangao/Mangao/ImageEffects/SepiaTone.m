//
//  SepiaTone.m
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

#import "SepiaTone.h"

@implementation SepiaTone

- (id)init
{
    self =[super init];
    return self;
}

- (void)dealloc
{
    [ciImage release];
    [resultRep release];
    [result release];

	[super dealloc];
}

+ (NSImage*)SepiaTone:(NSImage *)srcImage
{
    NSData *tiffData = [srcImage TIFFRepresentation];
    CIImage *ciImage = [CIImage imageWithData:tiffData];
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"
                                    keysAndValues:kCIInputImageKey, ciImage,
                          @"inputIntensity", [NSNumber numberWithFloat:0.8],
                          nil
                          ];
    
    ciImage = [filter valueForKey:@"outputImage"];
    
    
//    NSCIImageRep *resultRep = [NSCIImageRep imageRepWithCIImage:ciImage];
//    NSImage *result = [[NSImage alloc] initWithSize:resultRep.size];
//    [result addRepresentation:resultRep];
  
    //auto colorize에서의 대체 코드
    NSBitmapImageRep* resultRep=[[NSBitmapImageRep alloc]initWithCIImage:ciImage];
    NSImage* result=[[NSImage alloc]initWithData:[resultRep TIFFRepresentation]];

    return result;

    [tiffData release];
    [ciImage release];
    [resultRep release];
    [result autorelease];
}



@end
