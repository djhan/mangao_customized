//
//  thumbnail.m
//  Mangao
//
//  Created by Ryota Minami <RyotaMinami93@gmail.com> on 2013/12/09.
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

#import "thumbnail.h"

@implementation thumbnail

@synthesize thumbnailImage;

//IKImageBrowserViewに表示するタイプとしてNSImageを使うことを宣言
- (NSString *)imageRepresentationType
{
	return IKImageBrowserNSImageRepresentationType;
}

//IKImageBrowserViewに表示するオブジェクトを返す
- (id)imageRepresentation
{
	return thumbnailImage;
}

//IKImageBrowserViewに表示するオブジェクトの固有識別子を返す
- (NSString *)imageUID
{
	return [NSString stringWithFormat:@"%@",thumbnailImage];
}

//IKImageBrowserViewに表示するオブジェクトの名前を返す
- (id)imageTitle
{
    return NULL;
}

+ (thumbnail*)imageItemWithContentsOfNSImage:(NSImage*)image;
{
	return [[[thumbnail alloc] initWithContentsOfNSImage:image] autorelease];
}

- (id)initWithContentsOfNSImage:(NSImage*)image
{
	self = [super init];
	if (self)
    {
		thumbnailImage = [image copy];
	}
	return self;
}

- (void)dealloc
{
	[thumbnailImage release];
	[super dealloc];
}

@end
