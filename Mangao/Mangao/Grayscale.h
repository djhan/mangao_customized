//
//  Grayscale.h
//  DJHAN
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
