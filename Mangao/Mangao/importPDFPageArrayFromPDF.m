//
//  getPDFPageArrayFromPDF.m
//  Mangao
//
//  Created by Ryota Minami <RyotaMinami93@gmail.com> on 2014/01/19.
//  Copyright (c) 2013, 2014 Ryota Minami. All rights reserved.
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

#import "importPDFPageArrayFromPDF.h"
//↓は読み込みキャンセル信号を送るため
//利用者の環境に応じて削除/変更すること
#import "Mangao.h"

@implementation importPDFPageArrayFromPDF

//PDF内のPDFPageのNSMutableArrayを取得
//なおarray[0]は(NSNumber*)0→破損したアーカイブ,(NSNumber*)1→破損していないアーカイブ
- (NSMutableArray*)importPDFPageArrayFromPDF:(NSString*)PDFPath
{
    NSMutableArray *result = [NSMutableArray array];
    
    //PDFへのパスをNSURLに変換
    NSURL *url = [NSURL fileURLWithPath:PDFPath];
    //NSURLからPDFを読み込み
    PDFDocument *pdf = [[PDFDocument alloc] initWithURL:url];
    
    //PDFファイルが開けなかった場合
    if (!pdf)
    {
        //アーカイブ破損判定を追加
        [result addObject:[NSNumber numberWithInt:0]];
    }
    //PDFファイルが開けた場合
    else
    {
        //アーカイブ破損判定を追加
        [result addObject:[NSNumber numberWithInt:1]];
        
        //PDF内の要素数を取得
        NSInteger listSize = [pdf pageCount];
        
        for(int i=0; i < listSize; i++)
        {
            //読み込みがキャンセルされた場合
            //利用者の環境に応じて削除/変更すること
            if([(Mangao *)[[NSApplication sharedApplication] delegate]isCancelLoadingArchive])
            {
                goto end;
            }
            
            //指定ページのPDFを読み込む
            PDFPage *page = [pdf pageAtIndex:i];
            
            [result addObject:page];
        }
    }

end:return result;
}

@end