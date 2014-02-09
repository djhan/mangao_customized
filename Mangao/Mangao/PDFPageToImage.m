#import "PDFPageToImage.h"
//#import "Mangao.h"

@implementation PDFPageToImage

- (NSImage*)PDFPageToImage:(PDFPage*)page pageNumber:(long)pageNumber
{
    //회전 판별
    NSInteger rotation;
    rotation = [page rotation];
    //NSLog(@"rotation:%li", (long)rotation);
    
    //NSRect mainScreenRect = [[NSScreen mainScreen] frame];
    //float dimension = mainScreenRect.size.height;
    float dimension = 1600;
    float scale = 0.0;
    NSRect bounds = [page boundsForBox:kPDFDisplayBoxMediaBox];
    //PDF 해상도
    //NSLog(@"imported bound size : width %f / height %f", bounds.size.width, bounds.size.height);

    scale = 1 > (NSHeight(bounds) / NSWidth(bounds)) ? dimension / NSWidth(bounds) :  dimension / NSHeight(bounds);
    bounds.size = NSMakeSize(bounds.size.width*scale,bounds.size.height*scale);
    
    //회전에 따른 사이즈 조절, rect 재생성
    float finalWidth = bounds.size.width;
    float finalheight = bounds.size.height;
    float finalOriginX = bounds.origin.x;
    float finalOriginY = bounds.origin.y;
    switch (rotation)
    {
        case 90:
            finalWidth = bounds.size.height;
            finalheight =bounds.size.width;
            break;
        case 270:
            finalWidth = bounds.size.height;
            finalheight =bounds.size.width;
            break;
    }
    NSRect finalBounds = NSMakeRect(finalOriginX, finalOriginY, finalWidth, finalheight);
    //조정된 PDF 해상도
    //NSLog(@"final bound size : width %f / height %f", finalBounds.size.width, finalBounds.size.height);
    
    NSImage *image = [[[NSImage alloc] initWithSize:finalBounds.size] autorelease];
    
    [image lockFocus];
    //高画質補間を行う
    [[NSGraphicsContext currentContext] setImageInterpolation: NSImageInterpolationHigh];
    [[NSColor whiteColor] set];
    NSRectFill(bounds );
    
    NSAffineTransform * scaleTransform = [NSAffineTransform transform];
    [scaleTransform scaleBy: scale];
    [scaleTransform concat];
    [page drawWithBox:kPDFDisplayBoxMediaBox];
    //[pdfImageRep drawInRect:finalBounds];
    [image unlockFocus];
    
    return image;
}

@end
