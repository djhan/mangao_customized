//
//  Loupe.h
//  Mangao
//
//  Created by Ryota Minami <RyotaMinami93@gmail.com> on 2013/12/05.
//  Copyright (c) 2013 Ryota Minami. All rights reserved.
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

@interface Loupe : NSObject

- (NSArray*)loupe:(int)witchLoupe witchField:(int)witchField cursor_onImageField:(NSPoint)cursor_onImageField windowSize:(NSSize)size_window imageFieldSize:(NSSize)size_imageField image:(NSImage*)image;

@end
