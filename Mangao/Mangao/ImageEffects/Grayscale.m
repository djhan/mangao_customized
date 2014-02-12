//
//  Grayscale.m
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

#import "Grayscale.h"

@implementation Grayscale

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

+ (NSImage*)Grayscale:(NSImage *)srcImage
{
    NSData *tiffData = [srcImage TIFFRepresentation];
    CIImage *ciImage = [CIImage imageWithData:tiffData];

    // 그레이스케일 여부를 판정 - 사용하지 않음
    
#define kRectToCheckReduction 4
    CGRect rectToCheck=[ciImage extent];
    CGFloat width=CGRectGetWidth(rectToCheck);
    CGFloat height=CGRectGetHeight(rectToCheck);
    rectToCheck.size.width = floor(rectToCheck.size.width/kRectToCheckReduction);
    rectToCheck.size.height = floor(rectToCheck.size.height/kRectToCheckReduction);
    rectToCheck.origin.x += floor((width-CGRectGetWidth(rectToCheck))/2);
    rectToCheck.origin.y += floor((height-CGRectGetHeight(rectToCheck))/2);
    
    CIFilter *tempFilter = [CIFilter filterWithName:@"CIAreaAverage" keysAndValues:kCIInputImageKey, ciImage,
                kCIInputExtentKey, [CIVector vectorWithX:rectToCheck.origin.x
                                                       Y:rectToCheck.origin.y
                                                       Z:rectToCheck.size.width
                                                       W:rectToCheck.size.height],
                nil];
    CIImage* pixImage=[tempFilter valueForKey:@"outputImage"];
    NSBitmapImageRep *aPixel = [[NSBitmapImageRep alloc]initWithCIImage:pixImage];
    NSColor *color = [aPixel colorAtX:0 y:0];
    [aPixel release];

    if ([color saturationComponent]<0.01f)
    {
        return srcImage;
        [color release];
    }
    else
    {
     
    CIFilter *filter = [CIFilter filterWithName:@"CIColorMonochrome"
                                  keysAndValues:kCIInputImageKey, ciImage,
                        @"inputColor", [CIColor colorWithRed:0.7 green:0.7 blue:0.7],
                        @"inputIntensity", [NSNumber numberWithFloat:1.0],
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
}

@end
