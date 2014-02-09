#import <Quartz/Quartz.h>

@interface PDFPageToImage : NSObject

- (NSImage*)PDFPageToImage:(PDFPage*)page pageNumber:(long)pageNumber;

@end