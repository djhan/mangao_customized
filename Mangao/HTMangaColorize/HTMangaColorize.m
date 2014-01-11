//
//  HTMangaColorize.m
//  MangaColorize
//
//  MIT License. Copyright (c) 2013 hetima. All rights reserved.
//

#import "HTMangaColorize.h"

@implementation HTMangaColorize

#if !__has_feature(objc_arc)
@synthesize mapCI=_mapCI;
@synthesize mapPath=_mapPath;
@synthesize skipColoredSource=_skipColoredSource;
#endif

- (id)init
{
    self = [super init];
    if (self) {
        _skipColoredSource=YES;
        _mapPath=nil;
        _mapCI=nil;
        
    }
    return self;
}


- (id)initWithMapFile:(NSString*)filePath
{
    self = [self init];
    if (self) {
        self.mapPath=filePath;
    }
    return self;
}

- (void)dealloc
{
    
#if !__has_feature(objc_arc)
    [_mapPath release];
    [_mapCI release];
    [super dealloc];
#endif
}


- (void)setMapPath:(NSString *)mapPath
{
    NSImage* mapImage=[[NSImage alloc]initWithContentsOfFile:mapPath];
    if (!mapImage) return;
    
    [self setMapImage:mapImage];
    
#if !__has_feature(objc_arc)
    [mapImage release];
#endif
}

- (void)setMapImage:(NSImage*)image
{
    CIImage *ciImage= [[CIImage alloc]initWithBitmapImageRep:[NSBitmapImageRep imageRepWithData:[image TIFFRepresentation]]];
    if(!ciImage) return;
    
    self.mapCI=ciImage;
    
#if !__has_feature(objc_arc)
    [ciImage release];
#endif
    
}

+ (NSImage*)colorizeImage:(NSImage*)srcImage withMapImage:(NSImage*)mapImage skipColoredSource:(BOOL)skipCS
{
    CIImage *mapCI= [[CIImage alloc]initWithBitmapImageRep:[NSBitmapImageRep imageRepWithData:[mapImage TIFFRepresentation]]];
    if(!mapCI) return srcImage;
    
    NSImage* result=[HTMangaColorize colorizeImage:srcImage withMapCI:mapCI skipColoredSource:skipCS];
#if !__has_feature(objc_arc)
    [mapCI release];
#endif
    return result;
}


+ (NSImage*)colorizeImage:(NSImage*)srcImage withMapCI:(CIImage*)mapCI skipColoredSource:(BOOL)skipCS
{
    
    NSBitmapImageRep* srcRep= [NSBitmapImageRep imageRepWithData:[srcImage TIFFRepresentation]];
    CIFilter *ciFilter;
    CIImage *srcCI= [[CIImage alloc]initWithBitmapImageRep:srcRep];

#if !__has_feature(objc_arc)
    [srcCI autorelease];
#endif
    
    //白黒チェック
    //CIAreaAverage で平均色を抽出し彩度を調べて判定。カラー画像なら受け取った NSImage をそのまま返す
    if (skipCS) {
        
#define kRectToCheckReduction 4
        CGRect rectToCheck=[srcCI extent];
        CGFloat width=CGRectGetWidth(rectToCheck);
        CGFloat height=CGRectGetHeight(rectToCheck);
        rectToCheck.size.width = floor(rectToCheck.size.width/kRectToCheckReduction);
        rectToCheck.size.height = floor(rectToCheck.size.height/kRectToCheckReduction);
        rectToCheck.origin.x += floor((width-CGRectGetWidth(rectToCheck))/2);
        rectToCheck.origin.y += floor((height-CGRectGetHeight(rectToCheck))/2);
        
        ciFilter = [CIFilter filterWithName:@"CIAreaAverage" keysAndValues:kCIInputImageKey, srcCI,
                    kCIInputExtentKey, [CIVector vectorWithX:rectToCheck.origin.x
                                                           Y:rectToCheck.origin.y
                                                           Z:rectToCheck.size.width
                                                           W:rectToCheck.size.height],
                    nil];
        CIImage* pixImage=[ciFilter valueForKey:@"outputImage"];
        NSBitmapImageRep *aPixel = [[NSBitmapImageRep alloc]initWithCIImage:pixImage];
        NSColor *color = [aPixel colorAtX:0 y:0];
#if !__has_feature(objc_arc)
        [aPixel release];
#endif
        //モノクロの彩度高いやつで0.01くらい
        if ([color saturationComponent]>0.02f) {
            return srcImage;
        }
        
    }
    
    //カラーを適用
    ciFilter = [CIFilter filterWithName:@"CIColorMap" keysAndValues:kCIInputImageKey, srcCI,
                kCIInputGradientImageKey, mapCI,
                nil];
    CIImage *resultCI=[ciFilter valueForKey:@"outputImage"];
    
    
    NSBitmapImageRep* resultRep=[[NSBitmapImageRep alloc]initWithCIImage:resultCI];
    NSImage* result=[[NSImage alloc]initWithData:[resultRep TIFFRepresentation]];
#if !__has_feature(objc_arc)
    [resultRep release];
    [result autorelease];
#endif
    
    return result;
}


- (NSImage*)colorizeImage:(NSImage*)srcImage
{
    return [HTMangaColorize colorizeImage:srcImage withMapCI:self.mapCI skipColoredSource:self.skipColoredSource];
}




@end

