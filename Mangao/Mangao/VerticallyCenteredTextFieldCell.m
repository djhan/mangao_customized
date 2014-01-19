#import "VerticallyCenteredTextFieldCell.h"

@implementation VerticallyCenteredTextFieldCell

- (NSRect)adjustedFrameToVerticallyCenterText:(NSRect)frame {
    // super would normally draw text at the top of the cell
    NSInteger offset = floor((NSHeight(frame) -
                              ([[self font] ascender] - [[self font] descender])) / 2);
    return NSInsetRect(frame, 0.0, offset);
}

- (void)editWithFrame:(NSRect)aRect inView:(NSView *)controlView
               editor:(NSText *)editor delegate:(id)delegate event:(NSEvent *)event {
    [super editWithFrame:[self adjustedFrameToVerticallyCenterText:aRect]
                  inView:controlView editor:editor delegate:delegate event:event];
}

- (void)selectWithFrame:(NSRect)aRect inView:(NSView *)controlView
                 editor:(NSText *)editor delegate:(id)delegate
                  start:(NSInteger)start length:(NSInteger)length {
    
    [super selectWithFrame:[self adjustedFrameToVerticallyCenterText:aRect]
                    inView:controlView editor:editor delegate:delegate
                     start:start length:length];
}

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
    NSRect newRect = [self adjustedFrameToVerticallyCenterText:cellFrame];
    NSBezierPath *betterBounds = [NSBezierPath bezierPathWithRoundedRect:newRect xRadius:(newRect.size.height/5) yRadius:(newRect.size.height/5)];
    [betterBounds addClip];
    [super drawWithFrame:[self adjustedFrameToVerticallyCenterText:cellFrame] inView:controlView];
    if (self.isBezeled) {
        [betterBounds setLineWidth:2];
        [[NSColor colorWithCalibratedRed:0.510 green:0.643 blue:0.804 alpha:1] setStroke];
        [betterBounds stroke];
    }
}
@end