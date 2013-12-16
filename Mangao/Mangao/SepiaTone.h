//
//  SepiaTone.h
//  DJHAN
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>
#import <Quartzcore/CIFilter.h>

@interface SepiaTone : NSObject
{
    CIImage *ciImage;
    NSCIImageRep *resultRep;
    NSImage *result;
}

+ (NSImage*)SepiaTone:(NSImage*)srcImage;


@end
