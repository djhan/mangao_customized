//
//  ZipFile.m
//  ZipFile
//
//  Created by Kenji Nishishiro <marvel@programmershigh.org> on 10/05/08.
//  Copyright 2010 Kenji Nishishiro. All rights reserved.
//
//  対応文字コードにCP932・ISO-8859-1を追加
//  NSUIntegerを明示的にintに
//  by Ryota Minami <RyotaMinami93@gmail.com> on 2013/09/09.
//
//  対応文字コードにISO-2022-JPを追加
//  by Ryota Minami <RyotaMinami93@gmail.com> on 2013/10/13.
//
//  対応文字コードに
//  中国語
//  (GB18030,GBK,BIG5,CP936,CP950,EUC-CN,EUC-TW,Big5-HKSCS,GB2312,X-MAC-SIMP-CHINESE,X-MAC-TRAD-CHINESE)
//  韓国語
//  (EUC-KR,CP949,ISO-2022-KR,X-MAC-KOREAN)
//  を追加
//  by Ryota Minami <RyotaMinami93@gmail.com> on 2013/12/11.
//

#import "ZipFile.h"

@implementation ZipFile

static const int CASE_SENSITIVITY = 0;
static const unsigned int BUFFER_SIZE = 8192;

- (id)initWithFileAtPath:(NSString *)path {
	NSAssert(path, @"path");
	
	if (self = [super init]) {
		path_ = [path retain];
		unzipFile_ = NULL;
	}
	return self;
}

- (void)dealloc {
	NSAssert(!unzipFile_, @"!unzipFile_");
	
	[path_ release];
	[super dealloc];
}

- (BOOL)open {
	NSAssert(!unzipFile_, @"!unzipFile_");
	
	unzipFile_ = unzOpen64([path_ UTF8String]);
	return unzipFile_ != NULL;
}

- (void)close {
	NSAssert(unzipFile_, @"unzipFile_");
	
	unzClose(unzipFile_);
	unzipFile_ = NULL;
}

- (NSData *)readWithFileName:(NSString *)fileName maxLength:(NSUInteger)maxLength characterEncoding:(int)witch
{
	NSAssert(unzipFile_, @"unzipFile_");
	NSAssert(fileName, @"fileName");
	
	if (unzGoToFirstFile(unzipFile_) != UNZ_OK) {
		return nil;
	}
    unz_file_info fileInfo;
    char fileName1[PATH_MAX];
    if (unzGetCurrentFileInfo(unzipFile_, &fileInfo, fileName1, PATH_MAX, NULL, 0, NULL, 0) != UNZ_OK) {
        return nil;
    }
    
    const char *cp = nil;
    int i = 0;
    
    //0→日本語,1→中国語,2→韓国語
    if(witch == 0)
    {
        NSStringEncoding CharacterEncodingList[] =
        {
            NSUTF8StringEncoding,NSShiftJISStringEncoding,NSISO2022JPStringEncoding,NSISOLatin1StringEncoding,0
        };
        
        while(CharacterEncodingList[i] != 0)
        {
            if([NSString stringWithCString: fileName1 encoding:CharacterEncodingList[i]] != NULL)
            {
                cp = [fileName cStringUsingEncoding:CharacterEncodingList[i]];
                break;
            }
            i++;
        }
    }
    else if(witch == 1)
    {
        NSStringEncoding CharacterEncodingList[] =
        {
            -2147482062,-2147482063,-2147481085,-2147482591,-2147482589,NSUTF8StringEncoding,-2147481296,-2147481295,-2147481082,-2147481083,-2147483623,-2147483646,0
        };
        
        while(CharacterEncodingList[i] != 0)
        {
            if([NSString stringWithCString: fileName1 encoding:CharacterEncodingList[i]] != NULL)
            {
                cp = [fileName cStringUsingEncoding:CharacterEncodingList[i]];
                break;
            }
            i++;
        }
    }
    else if(witch == 2)
    {
        NSStringEncoding CharacterEncodingList[] =
        {
            -2147481280,-2147482590,NSUTF8StringEncoding,NSShiftJISStringEncoding,-2147481536,-2147483645,0
        };
        
        while(CharacterEncodingList[i] != 0)
        {
            if([NSString stringWithCString: fileName1 encoding:CharacterEncodingList[i]] != NULL)
            {
                cp = [fileName cStringUsingEncoding:CharacterEncodingList[i]];
                break;
            }
            i++;
        }
    }
	
	if (unzLocateFile(unzipFile_, cp, CASE_SENSITIVITY) != UNZ_OK) {
		return nil;
	}
	
	if (unzOpenCurrentFile(unzipFile_) != UNZ_OK) {
		return nil;
	}
	
	NSMutableData *data = [NSMutableData data];
	NSUInteger length = 0;
	void *buffer = (void *)malloc(BUFFER_SIZE);
	while (YES) {
		//NSUIntegerがintかlongかは処理系に依存するので明示的にintにする
        int maxLengthInt = (int)maxLength;
        int lengthInt = (int)length;
        
		unsigned size = length + BUFFER_SIZE <= maxLength ? BUFFER_SIZE : maxLengthInt - lengthInt;
		int readLength = unzReadCurrentFile(unzipFile_, buffer, size);
		if (readLength < 0) {
			free(buffer);
			unzCloseCurrentFile(unzipFile_);
			return nil;
		}
		if (readLength > 0) {
			[data appendBytes:buffer length:readLength];
			length += readLength;
		}
		if (readLength == 0) {
			break;
		}
	};
	free(buffer);
	
	unzCloseCurrentFile(unzipFile_);
	
	return data;
}

- (NSArray *)fileNames:(int)witch
{
	NSMutableArray *results = [NSMutableArray array];
	if (unzGoToFirstFile(unzipFile_) != UNZ_OK) {
		return nil;
	}
	while (YES) {
		unz_file_info64 fileInfo;
		char fileName[PATH_MAX];
		if (unzGetCurrentFileInfo64(unzipFile_, &fileInfo, fileName, PATH_MAX, NULL, 0, NULL, 0) != UNZ_OK) {
			return nil;
		}
		
		NSString *str = nil;
        int i = 0;
        //0→日本語,1→中国語,2→韓国語
        if(witch == 0)
        {
            NSStringEncoding CharacterEncodingList[] =
            {
                NSUTF8StringEncoding,NSShiftJISStringEncoding,NSISO2022JPStringEncoding,NSISOLatin1StringEncoding,0
            };
            
            while(CharacterEncodingList[i] != 0)
            {
                if([NSString stringWithCString: fileName encoding:CharacterEncodingList[i]] != NULL)
                {
                    str = [NSString stringWithCString: fileName encoding:CharacterEncodingList[i]];
                    break;
                }
                i++;
            }
        }
        else if(witch == 1)
        {
            NSStringEncoding CharacterEncodingList[] =
            {
                -2147482062,-2147482063,-2147481085,-2147482591,-2147482589,NSUTF8StringEncoding,-2147481296,-2147481295,-2147481082,-2147481083,-2147483623,-2147483646,0
            };
            
            while(CharacterEncodingList[i] != 0)
            {
                if([NSString stringWithCString: fileName encoding:CharacterEncodingList[i]] != NULL)
                {
                    str = [NSString stringWithCString: fileName encoding:CharacterEncodingList[i]];
                    break;
                }
                i++;
            }
        }
        else if(witch == 2)
        {
            NSStringEncoding CharacterEncodingList[] =
            {
                -2147481280,-2147482590,NSUTF8StringEncoding,NSShiftJISStringEncoding,-2147481536,-2147483645,0
            };
            
            while(CharacterEncodingList[i] != 0)
            {
                if([NSString stringWithCString: fileName encoding:CharacterEncodingList[i]] != NULL)
                {
                    str = [NSString stringWithCString: fileName encoding:CharacterEncodingList[i]];
                    break;
                }
                i++;
            }
        }

        [results addObject:str];
		
		int error = unzGoToNextFile(unzipFile_);
		if (error == UNZ_END_OF_LIST_OF_FILE) {
			break;
		}
		if (error != UNZ_OK) {
			return nil;
		}
	}
	return results;
}

@end
