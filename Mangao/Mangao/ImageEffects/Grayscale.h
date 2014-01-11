//
//  Grayscale.h
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

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>
#import <Quartzcore/CIFilter.h>

@interface Grayscale: NSObject
{
    CIImage *ciImage;
    NSCIImageRep *resultRep;
    NSImage *result;
}

+ (NSImage*)Grayscale:(NSImage*)srcImage;

@end
