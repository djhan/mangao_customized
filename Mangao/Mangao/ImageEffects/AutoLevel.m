#import "AutoLevel.h"

@implementation AutoLevel

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

+ (NSImage*)AutoLevel:(NSImage*)srcImage black:(float)blackWeight white:(float)whiteWeight gamma:(float)gammaWeight
{
    NSData *tiffData = [srcImage TIFFRepresentation];
    
    //CGImageRef 로 변환
    CGImageSourceRef CGImageSource = CGImageSourceCreateWithData((CFDataRef)tiffData, NULL);
    CGImageRef CGImageSrcRef =  CGImageSourceCreateImageAtIndex(CGImageSource, 0, NULL);
    
    /* 화이트 포인트, 블랙 포인트 판정 */
    UInt8* imageData = malloc(100 * 100 * 4);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(imageData, 100, 100, 8, 4 * 100, colorSpace, kCGImageAlphaNoneSkipLast);
    CGColorSpaceRelease(colorSpace);

    CGContextDrawImage(ctx, CGRectMake(0, 0, 100, 100), CGImageSrcRef);
    
    int histogramm[256];
    bzero(histogramm, 256 * sizeof(int));
    
    for (int i = 0; i < 100 * 100 * 4; i += 4) {
        UInt8 value = (imageData[i] + imageData[i+1] + imageData[i+2]) / 3;
        histogramm[value]++;
    }
    
    CGContextRelease(ctx);
    free(imageData);
    
    int black = 0;
    int counter = 0;
    
    // count up to 200 (2%) values from the black side of the histogramm to find the black point
    while ((counter < 200) && (black < 256)) {
        counter += histogramm[black];
        black ++;
    }
    
    int white = 255;
    counter = 0;
    
    // count up to 200 (2%) values from the white side of the histogramm to find the white point
    while ((counter < 200) && (white > 0)) {
        counter += histogramm[white];
        white --;
    }
    
    // 블랙, 화이트 포인트를 가중치를 줘서 조절
    float blackPoint = (0.0 - (black / 256.0)) * blackWeight;
    float whitePoint = (1.0 + ((255-white) / 256.0)) * whiteWeight;
    
    //NSLog(@"blackpoint: %f", blackPoint);
    //NSLog(@"whitepoint: %f", whitePoint);
    /* 화이트 포인트, 블랙 포인트 판정 끝*/
    
    CIImage *ciImage = [CIImage imageWithData:tiffData];
    
    //감마값 조절 : 1/(1+ (0.2 * 가중치))로 밝기 조절
    CIFilter *gammaFilter = [CIFilter filterWithName:@"CIGammaAdjust"];
    [gammaFilter setValue:ciImage forKey:kCIInputImageKey];
    [gammaFilter setValue: [NSNumber numberWithFloat:1/(1 + (0.2 * gammaWeight))]  forKey: @"inputPower"];
    CIImage *resultGammaImage = [gammaFilter valueForKey: @"outputImage"];
    
    //컬러 매트릭스 조절
    CIFilter *filter = [CIFilter filterWithName:@"CIColorMatrix"];
    [filter setDefaults];
    [filter setValue:resultGammaImage forKey:kCIInputImageKey];

    [filter setValue:[CIVector vectorWithX:(whitePoint-blackPoint) Y:0 Z:0 W:0]
              forKey:@"inputRVector"];
    [filter setValue:[CIVector vectorWithX:0 Y:(whitePoint-blackPoint) Z:0 W:0]
              forKey:@"inputGVector"];
    
    [filter setValue:[CIVector vectorWithX:0 Y:0 Z:(whitePoint-blackPoint) W:0]
              forKey:@"inputBVector"];
    [filter setValue:[CIVector vectorWithX:0 Y:0 Z:0 W:1]
              forKey:@"inputAVector"];
    [filter setValue:[CIVector vectorWithX:blackPoint Y:blackPoint Z:blackPoint W:0]
              forKey:@"inputBiasVector"];
    
    ciImage = [filter valueForKey:@"outputImage"];
    
    NSBitmapImageRep* resultRep=[[NSBitmapImageRep alloc]initWithCIImage:ciImage];
    NSImage* result=[[NSImage alloc]initWithData:[resultRep TIFFRepresentation]];
        
    return result;

    [tiffData release];
    [ciImage release];
    [resultRep release];
    [result autorelease];
}

@end