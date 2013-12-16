//
//  autoenhance.h
//  DJHAN
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>
#import <Quartzcore/CIFilter.h>

@interface AutoEnhance : NSObject
{
    CIImage *ciImage;
    NSArray* adjustments;
    NSCIImageRep *resultRep;
    NSImage *result;
}

+ (NSImage*)AutoEnhanceImage:(NSImage*)srcImage;

@end
