#import "AutoEnhance.h"

@implementation AutoEnhance

- (id)init
{
    self =[super init];
    return self;
}

- (void)dealloc
{
    [ciImage release];
    [adjustments release];
    [resultRep release];
    [result release];

	[super dealloc];
}

+ (NSImage*)AutoEnhanceImage:(NSImage*)srcImage
{
    NSData *tiffData = [srcImage TIFFRepresentation];
//    CGContextRef cgContext = [[NSGraphicsContext currentContext]
//                              graphicsPort];
//    NSDictionary *contextOptions = [NSDictionary dictionaryWithObjectsAndKeys:
//                                    [NSNumber numberWithBool:NO], @"kCIContextUseSoftwareRenderer", nil];
//    CIContext *coreContext = [CIContext contextWithCGContext:cgContext
//                                                     options:contextOptions];
    
    CIImage *ciImage = [CIImage imageWithData:tiffData];
    [tiffData release];

    NSArray* adjustments = [ciImage autoAdjustmentFiltersWithOptions:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:false] forKey:kCIImageAutoAdjustRedEye]];
    
    for (CIFilter *filter in adjustments)
    {
        [filter setValue:ciImage forKey:kCIInputImageKey];
        ciImage = [filter valueForKey:@"outputImage"];
    }
    
//    CGImageRef imgRef = [coreContext createCGImage:ciImage fromRect:ciImage.extent] ;
    
//원래 코드
//    NSCIImageRep *resultRep = [NSCIImageRep imageRepWithCIImage:ciImage];
//        NSImage *result = [[NSImage alloc] initWithSize:resultRep.size];

//auto colorize에서의 대체 코드
    NSBitmapImageRep* resultRep=[[NSBitmapImageRep alloc]initWithCIImage:ciImage];
    NSImage* result=[[NSImage alloc]initWithData:[resultRep TIFFRepresentation]];

    
    //    NSImage *result = [[NSImage alloc] initWithCGImage:imgRef size:NSZeroSize];

//원래 코드
//    [result addRepresentation:resultRep];

    return result;

    [adjustments release];
    [ciImage release];
    [resultRep release];
    [result autorelease];
}

@end
