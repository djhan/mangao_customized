#import "SepiaTone.h"

@implementation SepiaTone

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

+ (NSImage*)SepiaTone:(NSImage *)srcImage
{
    NSData *tiffData = [srcImage TIFFRepresentation];
    CIImage *ciImage = [CIImage imageWithData:tiffData];
    [tiffData release];
    
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"
                                    keysAndValues:kCIInputImageKey, ciImage,
                          @"inputIntensity", [NSNumber numberWithFloat:0.8],
                          nil
                          ];
    
    ciImage = [filter valueForKey:@"outputImage"];
    
    
//    NSCIImageRep *resultRep = [NSCIImageRep imageRepWithCIImage:ciImage];
//    NSImage *result = [[NSImage alloc] initWithSize:resultRep.size];
//    [result addRepresentation:resultRep];
  
    //auto colorize에서의 대체 코드
    NSBitmapImageRep* resultRep=[[NSBitmapImageRep alloc]initWithCIImage:ciImage];
    NSImage* result=[[NSImage alloc]initWithData:[resultRep TIFFRepresentation]];

    return result;
    
    [ciImage release];
    [resultRep release];
    [result autorelease];
}

@end
