//
//  Brightness and Contrast
//  DJHAN
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>
#import <Quartzcore/CIFilter.h>

@interface BrightnessAndContrast: NSObject
{
    CIImage *ciImage;
    NSCIImageRep *resultRep;
    NSImage *result;
}

+ (NSImage*)BrightnessAndContrast:(NSImage *)srcImage Brightness:(float*)srcBrightness Contrast:(float*)srcContrast;

@end
