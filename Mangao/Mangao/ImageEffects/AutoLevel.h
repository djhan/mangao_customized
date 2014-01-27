#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>
#import <Quartzcore/CIFilter.h>

@interface AutoLevel : NSObject
{
    CIImage *ciImage;
    NSArray* adjustments;
    NSCIImageRep *resultRep;
    NSImage *result;
}

+ (NSImage*)AutoLevel:(NSImage*)srcImage black:(float)blackWeight white:(float)whiteWeight gamma:(float)gammaWeight;

@end
