//
//  ZipFile.h
//  ZipFile
//
//  Created by Kenji Nishishiro <marvel@programmershigh.org> on 10/05/08.
//  Copyright 2010 Kenji Nishishiro. All rights reserved.
//

#import "unzip.h"

@interface ZipFile : NSObject {
	NSString *path_;
	unzFile unzipFile_;
}

- (id)initWithFileAtPath:(NSString *)path;
- (BOOL)open;
- (void)close;
- (NSData *)readWithFileName:(NSString *)fileName maxLength:(NSUInteger)maxLength characterEncoding:(int)witch;
- (NSArray *)fileNames:(int)witch;
@end
