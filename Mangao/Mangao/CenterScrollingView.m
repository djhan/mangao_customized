//
//  DragAndDrop.m
//  Mangao Kai
//
//  Created by Ryota Minami <RyotaMinami93@gmail.com> on 2013/12/02.
//  Copyright (c) 2013 Ryota Minami. All rights reserved.
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

#import "CenterScrollingView.h"
#import "Mangao.h"

@implementation CenterScrollingView

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
    return NSDragOperationLink;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
    NSPasteboard *pasteboard = [sender draggingPasteboard];
    
    //ドラッグ＆ドロップされたファイルをリストにする
    NSArray *array = [pasteboard propertyListForType:NSFilenamesPboardType];
    
    //許可したファイル形式及びフォルダのリストにする
    NSMutableArray *allowedArray = [NSMutableArray array];
    for(NSString *string in array)
    {
        //許可したファイル形式の場合
        if([[string lowercaseString] hasSuffix:@".jpg"]
           || [[string lowercaseString] hasSuffix:@".jpeg"]
           || [[string lowercaseString] hasSuffix:@".png"]
           || [[string lowercaseString] hasSuffix:@".gif"]
           || [[string lowercaseString] hasSuffix:@".bmp"]
           || [[string lowercaseString] hasSuffix:@".tif"]
           || [[string lowercaseString] hasSuffix:@".tiff"]
           || [[string lowercaseString] hasSuffix:@".zip"]
           || [[string lowercaseString] hasSuffix:@".cbz"]
           || [[string lowercaseString] hasSuffix:@".rar"]
           || [[string lowercaseString] hasSuffix:@".cbr"]
           || [[string lowercaseString] hasSuffix:@".7z"]
           || [[string lowercaseString] hasSuffix:@".cb7"]
           || [[string lowercaseString] hasSuffix:@".lzh"]
           || [[string lowercaseString] hasSuffix:@".lha"]
           || [[string lowercaseString] hasSuffix:@".tar"]
           || [[string lowercaseString] hasSuffix:@".gz"]
           || [[string lowercaseString] hasSuffix:@".bz2"]
           || [[string lowercaseString] hasSuffix:@".xz"]
           || [[string lowercaseString] hasSuffix:@".cab"]
           || [[string lowercaseString] hasSuffix:@".pdf"]
           || [[string lowercaseString] hasSuffix:@".cvbdl"]
           || [[string lowercaseString] hasSuffix:@".tc"]
           || [[string lowercaseString] hasSuffix:@".cbtc"])
        {
            //ファイルリストに追加する
            [allowedArray addObject:string];
        }
        //許可したファイル形式以外の場合
        else
        {
            BOOL isDirectory;
            //フォルダの場合
            if ([[NSFileManager defaultManager]fileExistsAtPath:string isDirectory:&isDirectory] && isDirectory)
            {
                //ファイルリストに追加する
                [allowedArray addObject:string];
            }
        }
    }
    
    //数値順でソート
    NSArray *sortedArray = [allowedArray sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
    
    //ファイルが1つ以上ある場合
    if([sortedArray count])
    {
        //1つ目のファイルをMangaoで開く
        NSTask *task = [[NSTask alloc] init];
        [task setLaunchPath:@"/usr/bin/open"];
        [task setArguments:[NSArray arrayWithObjects:@"-a",[[NSBundle mainBundle] bundlePath],[sortedArray objectAtIndex:0],nil]];
        [task launch];
    }
    
    return YES;
}


// TEST 중
/*
 - (void)setImage:(NSImage *)image
 {
 NSLog(@"test");
 }*/


// 화질 보정을 위한 코드 삽입

- (void)drawRect:(NSRect)rect
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];

    if (app.viewSetting == 1)
    {
        [self resizeFrame];
    }

    float displayScale = [[NSScreen mainScreen] backingScaleFactor];
    // 비레티나 디스플레이인 경우 화질 향상 루틴 적용
    //NSLog(@"displayscale: %f", displayScale);
    
    if (displayScale == 0)
    {
        [NSGraphicsContext saveGraphicsState];
        
        NSImage *image = [self image];
        
        NSRect originFrame;
        originFrame.origin = NSZeroPoint;
        originFrame.size = image.size;
        NSRect targetFrame = [self bounds];
        
        /*
         NSLog(@"original size: %f, %f",originFrame.size.width, originFrame.size.height);
         NSLog(@"object value:%@", self.identifier);
         NSLog(@"origin of target frame:%f, %f", targetFrame.origin.x, targetFrame.origin.y);
         NSLog(@"target frame: %f, %f",targetFrame.size.width, targetFrame.size.height);
         */
        
        float width = image.size.width;
        float height = image.size.height;
        
        float targetWidth = targetFrame.size.width;
        float targetHeight = targetFrame.size.height;
        float scaleFactor = 0.0;
        float scaleWidth = targetWidth;
        float scaleHeight = targetHeight;
        float scaleOriginX = targetFrame.origin.x;
        float scaleOriginY = targetFrame.origin.y;
        
        if ( NSEqualSizes(originFrame.size, targetFrame.size) == NO )
        {
            float widthFactor = targetWidth / width;
            float heightFacor = targetHeight / height;
            
            if ( widthFactor < heightFacor)
                scaleFactor = widthFactor;
            else
                scaleFactor = heightFacor;
            
            scaleWidth = width * scaleFactor;
            scaleHeight = height * scaleFactor;
            
            //NSLog(@"scaled size: %f, %f",scaleWidth, scaleHeight);
            
            if (scaleHeight < targetHeight)
            {
                //프레임 높이가 이미지 높이보다 클 때 중앙에 위치시킨다
                scaleOriginY = (targetHeight - scaleHeight) /2;
                //NSLog(@"scaled originY: %f", scaleOriginY);
            }
            
            if (scaleWidth < targetWidth)
            {
                    scaleOriginX = (targetWidth - scaleWidth) /2;
            }
        }
        
        NSRect finalRect = NSMakeRect(scaleOriginX, scaleOriginY, scaleWidth, scaleHeight);
        
        [[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
        
        [image drawInRect:[self centerScanRect:finalRect]
                 fromRect:NSZeroRect
                operation:NSCompositeSourceOver
                 fraction:1];
        
        [NSGraphicsContext restoreGraphicsState];
    }
    
    //super 함수의 위치 변경
    [super drawRect:rect];
}

- (void)resizeFrame
{
    //center imageview frame 설정
    NSImage *image = [self image];
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;

    NSSize finalFrameSize = [self frameSize:imageWidth:imageHeight];
    //NSLog(@"image size x/y: %f/%f", imageWidth,imageHeight);
    //NSLog(@"scrollview x/y: %f/%f", [[self enclosingScrollView] visibleRect].size.width, [[self enclosingScrollView] visibleRect].size.height);
    //NSLog(@"final frame size x/y: %f/%f", finalFrameSize.width,finalFrameSize.height);
    [self setFrameSize:finalFrameSize];
}

- (NSSize)frameSize: (float)width : (float)height;
{
    NSRect scrollViewRect = [[self enclosingScrollView] visibleRect];
    //scrollViewRect의 width/height를 변수로 설정
    float scrollViewWidth = scrollViewRect.size.width;
    //float scrollViewHeight = scrollViewRect.size.height;
    
    float scaleWidth = scrollViewWidth;
    float scaleFactor = scrollViewWidth / width;
    float scaleHeight = height * scaleFactor;

    NSSize finalFrameSize = NSMakeSize(scaleWidth, scaleHeight);
    return finalFrameSize;
}

- (void)setImage:(NSImage *)image
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];

    [super setImage:image];

    NSPoint defaultScrollPoint;

    if (app.viewSetting == 1)
    {
    NSRect scrollViewRect = [[self enclosingScrollView] visibleRect];
    float height = image.size.height;
    float width = image.size.width;
        if (!(height == 0))
        {
            float scaleFactor = scrollViewRect.size.width / width;
            float scaleHeight = height * scaleFactor;
    
            float defaultScrollPointY = scaleHeight - [[self enclosingScrollView] visibleRect].size.height;
            defaultScrollPoint = NSMakePoint(0, defaultScrollPointY);
            
            [self scrollPoint:defaultScrollPoint];
            [[self enclosingScrollView] setNeedsDisplay:YES];
            //NSLog(@"scrollpoint:%f",defaultScrollPoint.y);
        }
    }
    //[[self enclosingScrollView] setNeedsDisplay:YES];
}

@end