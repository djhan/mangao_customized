//
//  Loupe.m
//  Mangao
//
//  Created by Ryota Minami <RyotaMinami93@gmail.com> on 2013/12/05.
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

#import "Loupe.h"

@implementation Loupe

//小さい・大きい、どのフィールド、イメージフィールド上でのマウスカーソルの位置、イメージフィールドのサイズ、イメージを受け取ってマウスカーソル下のNSImageを返す
//right==0,left==1,center==2
- (NSArray*)loupe:(int)witchLoupe witchField:(int)witchField cursor_onImageField:(NSPoint)cursor_onImageField windowSize:(NSSize)size_window imageFieldSize:(NSSize)size_imageField image:(NSImage*)image
{
    NSArray *result = NULL;
    
    //イメージフィールド上でのマウスカーソルの位置を取得
    float cursor_onImageField_X = cursor_onImageField.x;
    float cursor_onImageField_Y = cursor_onImageField.y;
    
    //イメージフィールドのサイズを取得
    float size_window_X = size_window.width;
    float size_window_Y = size_window.height;
    
    //イメージフィールドのサイズを取得
    float size_imageField_X = size_imageField.width;
    float size_imageField_Y = size_imageField.height;
    
    //イメージのサイズを取得
    NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:[image TIFFRepresentation]];
    NSSize size_image = NSMakeSize([imageRep pixelsWide], [imageRep pixelsHigh]);
    float size_image_X = size_image.width;
    float size_image_Y = size_image.height;
    
    //イメージフィールド上でのイメージのサイズを取得
    float size_image_onField_X;
    float size_image_onField_Y;
    //タテ側に合わせてイメージをリサイズしている場合
    if(size_imageField_X / size_image_X > size_imageField_Y / size_image_Y)
    {
        size_image_onField_X = size_image_X * (size_imageField_Y / size_image_Y);
        size_image_onField_Y = size_image_Y * (size_imageField_Y / size_image_Y);
    }
    //ヨコ側に合わせてイメージをリサイズしている場合
    else
    {
        size_image_onField_X = size_image_X * (size_imageField_X / size_image_X);
        size_image_onField_Y = size_image_Y * (size_imageField_X / size_image_X);
    }
    
    //イメージフィールド上のイメージ上でのマウスカーソルの座標を取得
    float cursor_onImage_onField_X;
    float cursor_onImage_onField_Y;
    //左右余白の場合
    if(size_image_onField_X < size_imageField_X)
    {
        //right==0,left==1,center==2
        //rightField
        if(witchField == 0)
        {
            cursor_onImage_onField_X = cursor_onImageField_X;
            cursor_onImage_onField_Y = cursor_onImageField_Y;
        }
        //leftField
        else if(witchField == 1)
        {
            cursor_onImage_onField_X = cursor_onImageField_X - (size_imageField_X - size_image_onField_X);
            cursor_onImage_onField_Y = cursor_onImageField_Y;
        }
        //centerField
        else
        {
            cursor_onImage_onField_X = cursor_onImageField_X - ((size_imageField_X - size_image_onField_X) / 2);
            cursor_onImage_onField_Y = cursor_onImageField_Y;
        }
    }
    //上下余白の場合
    else
    {
        cursor_onImage_onField_X = cursor_onImageField_X;
        cursor_onImage_onField_Y = cursor_onImageField_Y - ((size_imageField_Y - size_image_onField_Y) / 2);
    }
    
    //実イメージ上でのマウスカーソルの座標を取得
    //切り抜きで使うCGRectのために左上原点に変換する
    float cursor_onImage_X = size_image_X * (cursor_onImage_onField_X / size_image_onField_X);
    float cursor_onImage_Y = fabsf(size_image_Y * (cursor_onImage_onField_Y / size_image_onField_Y) - size_image_Y);

    //CGImageRefに変換
    CGImageRef imageRef = [image CGImageForProposedRect:nil context:nil hints:nil];
    
    //切り抜く範囲を指定
    //CGRectは(x,y,幅,高さ)の形式、x,yは四角形の左上頂点
    CGRect cutRect;
    
    //小さいルーペの場合
    if(witchLoupe == 1)
    {
        //[短い方の辺の4分の1×短い方の辺の4分の1]の範囲を拡大する
        if(size_image_X < size_image_Y)
        {
            cutRect = CGRectMake(cursor_onImage_X - (size_image_X / 8),cursor_onImage_Y - (size_image_X / 8),size_image_X / 4,size_image_X / 4);
        }
        else
        {
            cutRect = CGRectMake(cursor_onImage_X - (size_image_Y / 8),cursor_onImage_Y - (size_image_Y / 8),size_image_Y / 4,size_image_Y / 4);
        }
    }
    //大きいルーペの場合
    else if(witchLoupe == 2)
    {
        //縦長画像の場合
        if(size_image_X < size_image_Y)
        {
            //[画像の横幅×縦幅の2分の1]の範囲を拡大する
            cutRect = CGRectMake(0,cursor_onImage_Y - (size_image_X/size_window_X*size_window_Y / 2),size_image_X,size_image_X/size_window_X*size_window_Y);
        }
        //大きい画像の場合
        else
        {
            //[画像の横幅×縦幅]の範囲を拡大する
            cutRect = CGRectMake(0,0,size_image_X,size_image_Y);
        }
    }
    
    //切り抜き
    CGImageRef loupeImageRef = CGImageCreateWithImageInRect(imageRef,cutRect);
    //切り抜かれた画像と同じサイズのNSImageを作る
    NSImage *loupeImage = [[[NSImage alloc] initWithSize:NSMakeSize(CGImageGetWidth(loupeImageRef),CGImageGetHeight(loupeImageRef))]autorelease];
    
    //正常に画像が切り抜けた場合
    if(loupeImageRef)
    {
        //小さいルーペかつイメージ上にマウスカーソルがある、もしくは大きいルーペの場合
        if(((witchLoupe == 1) && (0 < cursor_onImage_onField_X) && (cursor_onImage_onField_X < size_image_onField_X) && (0 < cursor_onImage_onField_Y) && (cursor_onImage_onField_Y < size_image_onField_Y)) || (witchLoupe == 2))
        {
            //切り抜いた画像をNSBitmapImageRepに変換
            NSBitmapImageRep *loupeBitmapImageRep = [[NSBitmapImageRep alloc] initWithCGImage:loupeImageRef];
            //imageへの描画を開始
            [loupeImage lockFocus];
            //高画質補間を行う
            [[NSGraphicsContext currentContext] setImageInterpolation: NSImageInterpolationHigh];
            //loupeBitmapImageRepの内容を書き込む
            [loupeBitmapImageRep drawInRect:NSMakeRect(0,0,CGImageGetWidth(loupeImageRef),CGImageGetHeight(loupeImageRef))];
            //imageへの描画を終了
            [loupeImage unlockFocus];
        }
        else
        {
            loupeImage = NULL;
        }
    }
    //正常に画像が切り抜けなかった場合
    else
    {
        loupeImage = NULL;
    }
    
    //画像が正常に取得できた場合
    if(loupeImage)
    {
        result = [NSArray arrayWithObjects:loupeImage,[NSNumber numberWithFloat:size_image_onField_X],[NSNumber numberWithFloat:size_image_onField_Y],[NSNumber numberWithFloat:cursor_onImage_onField_X],[NSNumber numberWithFloat:cursor_onImage_onField_Y],nil];
    }

    return result;
}

@end
