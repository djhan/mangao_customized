#import "BrightnessAndContrast.h"

@implementation BrightnessAndContrast

- (id)init
{
    self =[super init];
    return self;
}

- (void)dealloc
{
    [ciImage release];
    [resultRep release];
    [result release];
	[super dealloc];
}

+ (NSImage*)BrightnessAndContrast:(NSImage *)srcImage Brightness:(float*)srcBrightness Contrast:(float*)srcContrast;
{
    NSData *tiffData = [srcImage TIFFRepresentation];
    CIImage *ciImage = [CIImage imageWithData:tiffData];
    //NSLog(@"srcWitch;%f", *srcWitch);
    
    CIFilter *filter = [CIFilter filterWithName:@"CIColorControls" keysAndValues:kCIInputImageKey, ciImage, @"inputBrightness", [NSNumber numberWithFloat:*srcBrightness], @"inputContrast", [NSNumber numberWithFloat:*srcContrast], @"inputSaturation", [NSNumber numberWithFloat:1.0], nil];
    
    ciImage = [filter valueForKey:@"outputImage"];
    
    //auto colorize에서의 대체 코드
    NSBitmapImageRep* resultRep=[[NSBitmapImageRep alloc]initWithCIImage:ciImage];
    NSImage* result=[[NSImage alloc]initWithData:[resultRep TIFFRepresentation]];
    
    return result;
    
    [tiffData release];
    [ciImage release];
    [resultRep release];
    [result autorelease];
}

@end
