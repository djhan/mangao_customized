//
//  RarFile.h
//  RarFile
//
//  Created by Kenji Nishishiro <marvel@programmershigh.org> on 2013/08/29.
//  Copyright 2013 Kenji Nishishiro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RarFile : NSObject {
    NSString *_path;
    NSArray *_fileNames;
}

- (id)initWithFileAtPath:(NSString *)path;
- (BOOL)open;
- (void)close;
- (NSData *)readWithFileName:(NSString *)fileName maxLength:(NSUInteger)maxLength;
- (NSArray *)fileNames;

@end
