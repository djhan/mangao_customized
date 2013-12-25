//
//  Mangao.m
//  Mangao
//
//  Created by Ryota Minami <RyotaMinami93@gmail.com> on 2013/12/11.
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
//
//  (NSImage*)readImage - else if(app.nowOpenPDF) function is:
//
//  Copyright (c) 2007 Dancing Tortoise Software
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import "Mangao.h"
#import "Loupe.h"
#import "thumbnail.h"
#import "ZipFile.h"
#import "RarFile.h"
#import "HTMangaColorize.h"
#import "AutoEnhance.h"
#import "SepiaTone.h"
#import "Grayscale.h"
//#import "Brightness.h"
//#import "Contrast.h"
#import "BrightnessAndContrast.h"

@implementation Mangao

@synthesize viewWindow;
@synthesize mainMenu;
@synthesize mainMenuItem;
@synthesize sparkle;
@synthesize imageRightField;
@synthesize imageLeftField;
@synthesize imageRightFieldxxx;
@synthesize imageLeftFieldxxx;
@synthesize imageCenterField;
@synthesize loupeWindow;
@synthesize loupeField;
@synthesize jumpPanel;
@synthesize jumpPanel_index;
@synthesize jumpPanel_listSize;
@synthesize confirmPanel;
@synthesize confirmPanel_text;
@synthesize thumbnailController;
@synthesize thumbnailWindow;
@synthesize thumbnailView;
//pagenumber 추가
@synthesize pagenumberPrev;
@synthesize pagenumberNext;

//許可する画像の種類
@synthesize imageFileType;
//選択したファイルのフルパス
@synthesize filePath;
//選択したファイルを含むディレクトリのフルパス
@synthesize folderPath;
//選択したアーカイブを含むディレクトリのアーカイブのフルパスのリスト
@synthesize fileListFullPathOfArchive;
//現在開いているアーカイブがディレクトリ内で何番目か
@synthesize indexOfArchive;
//現在開いているアーカイブを含むディレクトリのアーカイブ要素数
@synthesize listSizeOfArchive;
//選択したファイルがディレクトリ内で何番目か
@synthesize index;
//選択したファイルを含むディレクトリのイメージファイルの要素数
@synthesize listSize;
//左側の画像のNSImage
@synthesize imageLeft;
//右側の画像のNSImage
@synthesize imageRight;
//中央の画像のNSImage
@synthesize imageCenter;
//現在開いているPDF内画像のPDFPageのリスト
@synthesize PDFArray;
//現在開いているアーカイブ内画像のNSImageのリスト
@synthesize imageArray;
//現在ZIPファイルを開いているかどうか
@synthesize nowOpenZIP;
//現在RARファイルを開いているかどうか
@synthesize nowOpenRAR;
//現在PDFファイルを開いているかどうか
@synthesize nowOpenPDF;
//現在cvbdlフォルダを開いているかどうか
@synthesize nowOpenCvbdl;
//現在Imageファイルを開いているかどうか
@synthesize nowOpenImageFolder;
//開いた画像がヨコナガ
@synthesize yokonaga;
//左開きモードかどうか
@synthesize hidaribirakiMode;
//1画面モードかどうか
@synthesize onePageMode;
//スライドショー
@synthesize slideshow;
//現在スライドショーを実行しているかどうか
@synthesize nowPlaySlideshow;
//現在フルスクリーンfor10.6を実行しているかどうか
@synthesize isFullscreenFor106;
//現在サムネイル一覧を実行しているかどうか
@synthesize isThumbnail;
//最後にサムネイル一覧を実行した時のパス
@synthesize thumbnailPath;
//MangaoによってマウントしたTrueCryptボリュームの一覧
@synthesize mountedTrueCryptVolume;
//『フルスクリーン』実行前のウィンドウのNSRect
@synthesize windowRectBeforeFullscreen;
//ルーペを使用しているかどうか(1==小さい,2==大きい)
@synthesize isLoupe;
//ImageCenterField上でのマウスカーソルの座標
@synthesize cursor_onImageCenterField;
//最後に二本指ダブルタップをした時間
@synthesize timestamp_tapWithTwoFingers;
@synthesize defaults;
@synthesize plistKey;
@synthesize plistValue;
@synthesize plistKeyIndex;
@synthesize lastfile;

- (void)dealloc
{
    [super dealloc];
}

//アプリケーション起動前に呼び出される
- (void)applicationWillFinishLaunching:(NSNotification *)aNotification
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //ウィンドウタイトルを『mangao ver.x.x.x』にする
    [self resetWindowTitle];
    
    //初期画像をセットする
    app.imageCenter = [NSImage imageNamed:@"PleasePressO"];
    [self CniSet];
    
    //ウインドウのサイズと場所を記憶するようにする
    [self.viewWindow setFrameAutosaveName:@"Autosave"];
    
    //자동 업데이트 중단
    /*
    [sparkle setAutomaticallyChecksForUpdates:YES];
    [sparkle setAutomaticallyDownloadsUpdates:YES];
    [sparkle checkForUpdatesInBackground];
    */
     
    //plistを読み込み
    //この方法以外だと"mutating method sent to immutable object"になる
    app.defaults = [NSUserDefaults standardUserDefaults];
    app.plistKey = [[defaults objectForKey:@"key"]mutableCopy];
    app.plistValue = [[defaults objectForKey:@"value"]mutableCopy];
    //가장 마지막 파일 패스 열기
    app.lastfile = [defaults objectForKey:@"lastfile"];
    
    //初回起動の場合
    if(!app.plistKey)
    {
        //keyに00000000000000000000000000000000を追加
        //valueに(デフォルトで左開きフラグ,デフォルトで1画面フラグ,予約,予約,予約,予約,予約,予約,予約,背景色,밝기값,콘트라스트값 2개 추가)を追加
        app.plistKey = [NSMutableArray arrayWithObject:@"00000000000000000000000000000000"];
        app.plistValue = [NSMutableArray arrayWithObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithFloat:0],[NSNumber numberWithFloat:1],nil]];
    }
    
    //許可する画像の種類をセット
    app.imageFileType = [NSArray arrayWithObjects:@"jpg",@"JPG",@"jpeg",@"JPEG",@"png",@"PNG",@"gif",@"GIF",@"bmp",@"BMP",@"tif",@"TIF",@"tiff",@"TIFF",nil];
    
    //背景色を設定
    if([[[plistValue objectAtIndex:0] objectAtIndex:9] intValue] == 2)
    {
        [viewWindow setBackgroundColor:[NSColor blackColor]];
        [loupeWindow setBackgroundColor:[NSColor blackColor]];
    }
    else if([[[plistValue objectAtIndex:0] objectAtIndex:9] intValue])
    {
        [viewWindow setBackgroundColor:[NSColor whiteColor]];
        [loupeWindow setBackgroundColor:[NSColor whiteColor]];
    }
    
    //左開きに設定
    imageLeftFieldxxx = imageLeftField;
    imageRightFieldxxx = imageRightField;
    
    //メインメニューを構成
    mainMenu = [[NSMenu alloc] init];
    
    NSMenuItem	*AboutMangaoItem = [[[NSMenuItem alloc] init] autorelease];
    NSMenu *AboutMangao = [[[NSMenu alloc] init] autorelease];
    [AboutMangaoItem setTitle:NSLocalizedString(@"Mangaoについて",@"")];
    [AboutMangao setTitle: NSLocalizedString(@"Mangaoについて",@"")];
    NSMenuItem	*CharacterEncodingItem = [[[NSMenuItem alloc] init] autorelease];
    NSMenu *CharacterEncoding = [[[NSMenu alloc] init] autorelease];
    [CharacterEncodingItem setTitle:NSLocalizedString(@"文字コード",@"")];
    [CharacterEncoding setTitle: NSLocalizedString(@"文字コード",@"")];
    NSMenuItem *NSMenuItemCharacterEncodingJa = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"日本語",@"") action:@selector(SetcharacterEncodingJa) keyEquivalent:@"j"];
    NSMenuItem *NSMenuItemCharacterEncodingCh = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"中国語",@"") action:@selector(SetcharacterEncodingCh) keyEquivalent:@"c"];
    NSMenuItem *NSMenuItemCharacterEncodingKo = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"韓国語",@"") action:@selector(SetcharacterEncodingKo) keyEquivalent:@"k"];
    [NSMenuItemCharacterEncodingJa setKeyEquivalentModifierMask:NSAlternateKeyMask|NSCommandKeyMask];
    [NSMenuItemCharacterEncodingCh setKeyEquivalentModifierMask:NSAlternateKeyMask|NSCommandKeyMask];
    [NSMenuItemCharacterEncodingKo setKeyEquivalentModifierMask:NSAlternateKeyMask|NSCommandKeyMask];
    //選択されている文字コードにチェックを付ける
    if([[[plistValue objectAtIndex:0] objectAtIndex:7] intValue] == 0)
    {
        [NSMenuItemCharacterEncodingJa setState:NSOnState];
    }
    else if([[[plistValue objectAtIndex:0] objectAtIndex:7] intValue] == 1)
    {
        [NSMenuItemCharacterEncodingCh setState:NSOnState];
    }
    else if([[[plistValue objectAtIndex:0] objectAtIndex:7] intValue] == 2)
    {
        [NSMenuItemCharacterEncodingKo setState:NSOnState];
    }
    [CharacterEncoding addItem: NSMenuItemCharacterEncodingJa];
    [CharacterEncoding addItem: NSMenuItemCharacterEncodingCh];
    [CharacterEncoding addItem: NSMenuItemCharacterEncodingKo];
    [CharacterEncodingItem setSubmenu: CharacterEncoding];
    [AboutMangao addItem: CharacterEncodingItem];
    [AboutMangao addItemWithTitle:NSLocalizedString(@"クレジット",@"") action:@selector(showCreditsPanel) keyEquivalent:@""];
    [AboutMangao addItemWithTitle:NSLocalizedString(@"Mangaoに寄付する",@"") action:@selector(donation) keyEquivalent:@""];
    [AboutMangaoItem setSubmenu: AboutMangao];
    [mainMenu addItem: AboutMangaoItem];

    [mainMenu addItem: [NSMenuItem separatorItem]];

    //Image Effects : None / Auto Colorize / Auto Image Enchancement / Sepia Tone / Grayscale
    NSMenuItem	*ImageEffectsItem = [[[NSMenuItem alloc] init] autorelease];
    NSMenu *ImageEffects = [[[NSMenu alloc] init] autorelease];
    [ImageEffectsItem setTitle:NSLocalizedString(@"イメージ効果",@"")];
    [ImageEffects setTitle:NSLocalizedString(@"イメージ効果",@"")];
    
    NSMenuItem *NSMenuItemNone  = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"効果なし",@"") action:@selector(SetImageEffectsOff) keyEquivalent:@"n"];
    NSMenuItem *NSMenuItemAutoColorize  = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"自動着色",@"") action:@selector(SetImageEffectsAutoColorize) keyEquivalent:@"a"];
    NSMenuItem *NSMenuItemAutoImageEnhance  = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"自動イメージ補訂",@"") action:@selector(SetImageEffectsAutoImageEnhance) keyEquivalent:@"i"];
    NSMenuItem *NSMenuItemSepiaTone  = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"セピアトーン",@"") action:@selector(SetImageEffectsSepiaTone) keyEquivalent:@"e"];
    NSMenuItem *NSMenuItemGrayscale  = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"グレースケール",@"") action:@selector(SetImageEffectsGrayscale) keyEquivalent:@"g"];

    // 자동 채색, 이미지 보정, 세피아톤, 그레이스케일 설정에 따라 체크 유무 설정
    if([[[plistValue objectAtIndex:0] objectAtIndex:8] intValue] == 0)
    {
        [NSMenuItemNone setState:NSOnState];
        [NSMenuItemAutoColorize setState:NSOffState];
        [NSMenuItemAutoImageEnhance setState:NSOffState];
        [NSMenuItemSepiaTone setState:NSOffState];
        [NSMenuItemGrayscale setState:NSOffState];
    }
    else if([[[plistValue objectAtIndex:0] objectAtIndex:8] intValue] == 1)
    {
        [NSMenuItemNone setState:NSOffState];
        [NSMenuItemAutoColorize setState:NSOnState];
        [NSMenuItemAutoImageEnhance setState:NSOffState];
        [NSMenuItemSepiaTone setState:NSOffState];
        [NSMenuItemGrayscale setState:NSOffState];
    }
    else if([[[plistValue objectAtIndex:0] objectAtIndex:8] intValue] == 2)
    {
        [NSMenuItemNone setState:NSOffState];
        [NSMenuItemAutoColorize setState:NSOffState];
        [NSMenuItemAutoImageEnhance setState:NSOnState];
        [NSMenuItemSepiaTone setState:NSOffState];
        [NSMenuItemGrayscale setState:NSOffState];
    }
    else if([[[plistValue objectAtIndex:0] objectAtIndex:8] intValue] == 3)
    {
        [NSMenuItemNone setState:NSOffState];
        [NSMenuItemAutoColorize setState:NSOffState];
        [NSMenuItemAutoImageEnhance setState:NSOffState];
        [NSMenuItemSepiaTone setState:NSOnState];
        [NSMenuItemGrayscale setState:NSOffState];
    }
    else if([[[plistValue objectAtIndex:0] objectAtIndex:8] intValue] == 4)
    {
        [NSMenuItemNone setState:NSOffState];
        [NSMenuItemAutoColorize setState:NSOffState];
        [NSMenuItemAutoImageEnhance setState:NSOffState];
        [NSMenuItemSepiaTone setState:NSOffState];
        [NSMenuItemGrayscale setState:NSOnState];
    }
    
    [ImageEffects addItem:NSMenuItemNone];
    [ImageEffects addItem:NSMenuItemAutoColorize];
    [ImageEffects addItem:NSMenuItemAutoImageEnhance];
    [ImageEffects addItem:NSMenuItemSepiaTone];
    [ImageEffects addItem:NSMenuItemGrayscale];
    [ImageEffectsItem setSubmenu: ImageEffects];
    [mainMenu addItem: ImageEffectsItem];

    //밝기 메뉴 추가
    NSMenuItem	*BrightnessItem = [[[NSMenuItem alloc] init] autorelease];
    NSMenu *Brightness = [[[NSMenu alloc] init] autorelease];
    [BrightnessItem setTitle:NSLocalizedString(@"明るさ",@"")];
    [Brightness setTitle:NSLocalizedString(@"明るさ",@"")];
    
    NSMenuItem *NSMenuItemDefaultBrightness  = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"デフォルト",@"") action:@selector(SetDefaultBrightness) keyEquivalent:@"/"];
    NSMenuItem *NSMenuItemMinusBrightness  = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"暗く",@"") action:@selector(SetMinusBrightness) keyEquivalent:@","];
    NSMenuItem *NSMenuItemPlusBrightness  = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"明るく",@"") action:@selector(SetPlusBrightness) keyEquivalent:@"."];
    [NSMenuItemDefaultBrightness setKeyEquivalentModifierMask:0];
    [NSMenuItemMinusBrightness setKeyEquivalentModifierMask:0];
    [NSMenuItemPlusBrightness setKeyEquivalentModifierMask:0];
    
    // 밝기 기본일 때 체크 유무 설정
    if([[[plistValue objectAtIndex:0] objectAtIndex:10] floatValue] == 0)
    {
        [NSMenuItemDefaultBrightness setState:NSOnState];
        [NSMenuItemMinusBrightness setState:NSOffState];
        [NSMenuItemPlusBrightness setState:NSOffState];
    }
    else
    {
        [NSMenuItemDefaultBrightness setState:NSOffState];
        [NSMenuItemMinusBrightness setState:NSOffState];
        [NSMenuItemPlusBrightness setState:NSOffState];
    }
    [Brightness addItem:NSMenuItemDefaultBrightness];
    [Brightness addItem:NSMenuItemMinusBrightness];
    [Brightness addItem:NSMenuItemPlusBrightness];
    [BrightnessItem setSubmenu: Brightness];
    [mainMenu addItem: BrightnessItem];

    //콘트라스트 메뉴 추가
    NSMenuItem	*ContrastItem = [[[NSMenuItem alloc] init] autorelease];
    NSMenu *Contrast = [[[NSMenu alloc] init] autorelease];
    [ContrastItem setTitle:NSLocalizedString(@"コントラスト",@"")];
    [Contrast setTitle:NSLocalizedString(@"コントラスト",@"")];
    
    NSMenuItem *NSMenuItemDefaultContrast  = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"デフォルト",@"") action:@selector(SetDefaultContrast) keyEquivalent:@"?"];
    NSMenuItem *NSMenuItemMinusContrast  = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"低く",@"") action:@selector(SetMinusContrast) keyEquivalent:@"<"];
    NSMenuItem *NSMenuItemPlusContrast  = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"高く",@"") action:@selector(SetPlusContrast) keyEquivalent:@">"];
    [NSMenuItemDefaultContrast setKeyEquivalentModifierMask:0];
    [NSMenuItemMinusContrast setKeyEquivalentModifierMask:0];
    [NSMenuItemPlusContrast setKeyEquivalentModifierMask:0];
    
    // 콘트라스트 기본일 때 체크 유무 설정
    if([[[plistValue objectAtIndex:0] objectAtIndex:11] floatValue] == 1)
    {
        [NSMenuItemDefaultContrast setState:NSOnState];
        [NSMenuItemMinusContrast setState:NSOffState];
        [NSMenuItemPlusContrast setState:NSOffState];
    }
    else
    {
        [NSMenuItemDefaultContrast setState:NSOffState];
        [NSMenuItemMinusContrast setState:NSOffState];
        [NSMenuItemPlusContrast setState:NSOffState];
    }
    [Contrast addItem:NSMenuItemDefaultContrast];
    [Contrast addItem:NSMenuItemMinusContrast];
    [Contrast addItem:NSMenuItemPlusContrast];
    [ContrastItem setSubmenu: Contrast];
    [mainMenu addItem: ContrastItem];

    
//    NSMenuItem *NSMenuItemAutoColorize  = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"自動着色",@"") action:@selector(autoColorize) keyEquivalent:@"a"];
    NSMenuItem *NSMenuItemDefaultHidaribiraki = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"デフォルトで左開き",@"") action:@selector(defaultHidaribiraki) keyEquivalent:@""];
    NSMenuItem *NSMenuItemDefaultOnePageDisplay = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"デフォルトで1画面",@"") action:@selector(defaultOnePageDisplay) keyEquivalent:@""];
    NSMenuItem *NSMenuItemDefaultRotateRight = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"デフォルトで右回転",@"") action:@selector(defaultRotateRight) keyEquivalent:@"]"];
    NSMenuItem *NSMenuItemDefaultRotateLeft = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"デフォルトで左回転",@"") action:@selector(defaultRotateLeft) keyEquivalent:@"["];
//    NSMenuItem *NSMenuItemAutoImageEnhance  = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"自動イメージ補訂",@"") action:@selector(AutoImageEnhance) keyEquivalent:@""];
//    [NSMenuItemAutoColorize setKeyEquivalentModifierMask:0];
    [NSMenuItemDefaultRotateRight setKeyEquivalentModifierMask:0];
    [NSMenuItemDefaultRotateLeft setKeyEquivalentModifierMask:0];
    //自動着色,デフォルトで左開き・1画面・右回転・左回転がオンならメニューアイテムにチェックを付ける
/*    if([[[plistValue objectAtIndex:0] objectAtIndex:8] intValue] == 1)
    {
        [NSMenuItemAutoColorize setState:NSOnState];
    } */
    if([[[plistValue objectAtIndex:0] objectAtIndex:1] intValue])
    {
        [NSMenuItemDefaultHidaribiraki setState:NSOnState];
    }
    if([[[plistValue objectAtIndex:0] objectAtIndex:2] intValue])
    {
        [NSMenuItemDefaultOnePageDisplay setState:NSOnState];
    }
    if([[[plistValue objectAtIndex:0] objectAtIndex:3] intValue])
    {
        [NSMenuItemDefaultRotateRight setState:NSOnState];
    }
    if([[[plistValue objectAtIndex:0] objectAtIndex:4] intValue])
    {
        [NSMenuItemDefaultRotateLeft setState:NSOnState];
    }
/*    if([[[plistValue objectAtIndex:0] objectAtIndex:8] intValue] == 2)
    {
        [NSMenuItemAutoImageEnhance setState:NSOnState];
    }*/
//    [mainMenu addItem:NSMenuItemAutoColorize];
    [mainMenu addItem:NSMenuItemDefaultHidaribiraki];
    [mainMenu addItem:NSMenuItemDefaultOnePageDisplay];
    [mainMenu addItem:NSMenuItemDefaultRotateRight];
    [mainMenu addItem:NSMenuItemDefaultRotateLeft];
//    [mainMenu addItem:NSMenuItemAutoImageEnhance];
    
    [mainMenu addItem: [NSMenuItem separatorItem]];
    
    [mainMenu addItemWithTitle:NSLocalizedString(@"開く",@"") action:@selector(openMenu) keyEquivalent:@"o"];
    [mainMenu addItemWithTitle:NSLocalizedString(@"Open Last File",@"") action:@selector(openLastFile) keyEquivalent:@"O"];

// 최근 파일 열기 메뉴 추가
    NSMenuItem	*OpenRecentItem = [[[NSMenuItem alloc] init] autorelease];
    OpenRecentItem = [mainMenu addItemWithTitle:NSLocalizedString(@"Open Recent", nil)
                                         action:NULL
                                  keyEquivalent:@""];
	NSMenu * openRecentMenu = [[[NSMenu alloc] initWithTitle:@"Open Recent"] autorelease];
	[openRecentMenu performSelector:@selector(_setMenuName:) withObject:@"NSRecentDocumentsMenu"];
	[OpenRecentItem setSubmenu:openRecentMenu];
	
	OpenRecentItem = [openRecentMenu addItemWithTitle:NSLocalizedString(@"Clear Menu", nil)
                                               action:@selector(clearRecentDocuments:)
                                        keyEquivalent:@""];
//최근 파일 열기 메뉴 종료
    
    [mainMenu addItem: [NSMenuItem separatorItem]];
    
    NSMenuItem	*GoPageItem = [[[NSMenuItem alloc] init] autorelease];
    NSMenu *GoPage = [[[NSMenu alloc] init] autorelease];
    [GoPageItem setTitle:NSLocalizedString(@"ページ移動",@"")];
    [GoPage setTitle: NSLocalizedString(@"ページ移動",@"")];
    [[GoPage addItemWithTitle: NSLocalizedString(@"前のページ",@"")
                       action: @selector(pagePrev) keyEquivalent: @"→"]setKeyEquivalentModifierMask:0];
    [[GoPage addItemWithTitle: NSLocalizedString(@"",@"")
                       action: @selector(pagePrev) keyEquivalent: @"k"]setKeyEquivalentModifierMask:0];
    [[GoPage addItemWithTitle: NSLocalizedString(@"",@"")
                       action: @selector(pagePrev) keyEquivalent: @" "]setKeyEquivalentModifierMask:NSShiftKeyMask];
    [GoPage addItem: [NSMenuItem separatorItem]];
    [[GoPage addItemWithTitle: NSLocalizedString(@"次のページ",@"")
                       action: @selector(pageNext) keyEquivalent: @"←"]setKeyEquivalentModifierMask:0];
    [[GoPage addItemWithTitle: NSLocalizedString(@"",@"")
                       action: @selector(pageNext) keyEquivalent: @"j"]setKeyEquivalentModifierMask:0];
    [[GoPage addItemWithTitle: NSLocalizedString(@"",@"")
                       action: @selector(pageNext) keyEquivalent: @" "]setKeyEquivalentModifierMask:0];
    [GoPage addItem: [NSMenuItem separatorItem]];
    [GoPage addItemWithTitle: NSLocalizedString(@"最初のページ",@"")
                      action: @selector(pageFirst) keyEquivalent: @"→"];
    [GoPage addItemWithTitle: NSLocalizedString(@"",@"")
                      action: @selector(pageFirst) keyEquivalent: @"k"];
    [GoPage addItem: [NSMenuItem separatorItem]];
    [GoPage addItemWithTitle: NSLocalizedString(@"最後のページ",@"")
                      action: @selector(pageLast) keyEquivalent: @"←"];
    [GoPage addItemWithTitle: NSLocalizedString(@"",@"")
                      action: @selector(pageLast) keyEquivalent: @"j"];
    [GoPage addItem: [NSMenuItem separatorItem]];
    [[GoPage addItemWithTitle: NSLocalizedString(@"10ページ戻る",@"")
                       action: @selector(page10Prev) keyEquivalent: @"⇥"]setKeyEquivalentModifierMask:NSShiftKeyMask];
    [[GoPage addItemWithTitle: NSLocalizedString(@"10ページ進む",@"")
                       action: @selector(page10Next) keyEquivalent: @"⇥"]setKeyEquivalentModifierMask:0];
    [GoPage addItem: [NSMenuItem separatorItem]];
    [[GoPage addItemWithTitle: NSLocalizedString(@"ページ数を指定して移動",@"")
                       action: @selector(openJumpPanelInt) keyEquivalent: @"p"]setKeyEquivalentModifierMask:0];
    [GoPage addItemWithTitle: NSLocalizedString(@"ページ％を指定して移動",@"")
                      action: @selector(openJumpPanelPercent) keyEquivalent: @"p"];
    [GoPageItem setSubmenu: GoPage];
    [mainMenu addItem: GoPageItem];
    
    NSMenuItem	*GoArchiveItem = [[[NSMenuItem alloc] init] autorelease];
    NSMenu *GoArchive = [[[NSMenu alloc] init] autorelease];
    [GoArchiveItem setTitle:NSLocalizedString(@"アーカイブ移動",@"")];
    [GoArchive setTitle: NSLocalizedString(@"アーカイブ移動",@"")];
    [[GoArchive addItemWithTitle: NSLocalizedString(@"前のアーカイブ",@"")
                          action: @selector(archivePrev) keyEquivalent: @"↑"]setKeyEquivalentModifierMask:0];
    [[GoArchive addItemWithTitle: NSLocalizedString(@"",@"")
                          action: @selector(archivePrev) keyEquivalent: @"i"]setKeyEquivalentModifierMask:0];
    [GoArchive addItem: [NSMenuItem separatorItem]];
    [[GoArchive addItemWithTitle: NSLocalizedString(@"次のアーカイブ",@"")
                          action: @selector(archiveNext) keyEquivalent: @"↓"]setKeyEquivalentModifierMask:0];
    [[GoArchive addItemWithTitle: NSLocalizedString(@"",@"")
                          action: @selector(archiveNext) keyEquivalent: @"n"]setKeyEquivalentModifierMask:0];
    [GoArchiveItem setSubmenu: GoArchive];
    [mainMenu addItem: GoArchiveItem];
    
    NSMenuItem	*SlideshowItem = [[[NSMenuItem alloc] init] autorelease];
    NSMenu *Slideshow = [[[NSMenu alloc] init] autorelease];
    [SlideshowItem setTitle:NSLocalizedString(@"スライドショー",@"")];
    [Slideshow setTitle: NSLocalizedString(@"スライドショー",@"")];
    [Slideshow addItemWithTitle: NSLocalizedString(@"0.1秒ごと",@"スライドショー")
                         action: @selector(slideshow01) keyEquivalent: @"1"];
    [Slideshow addItemWithTitle: NSLocalizedString(@"0.2秒ごと",@"スライドショー")
                         action: @selector(slideshow02) keyEquivalent: @"2"];
    [Slideshow addItemWithTitle: NSLocalizedString(@"0.3秒ごと",@"スライドショー")
                         action: @selector(slideshow03) keyEquivalent: @"3"];
    [Slideshow addItemWithTitle: NSLocalizedString(@"0.4秒ごと",@"スライドショー")
                         action: @selector(slideshow04) keyEquivalent: @"4"];
    [Slideshow addItemWithTitle: NSLocalizedString(@"0.5秒ごと",@"スライドショー")
                         action: @selector(slideshow05) keyEquivalent: @"5"];
    [Slideshow addItemWithTitle: NSLocalizedString(@"0.6秒ごと",@"スライドショー")
                         action: @selector(slideshow06) keyEquivalent: @"6"];
    [Slideshow addItemWithTitle: NSLocalizedString(@"0.7秒ごと",@"スライドショー")
                         action: @selector(slideshow07) keyEquivalent: @"7"];
    [Slideshow addItemWithTitle: NSLocalizedString(@"0.8秒ごと",@"スライドショー")
                         action: @selector(slideshow08) keyEquivalent: @"8"];
    [Slideshow addItemWithTitle: NSLocalizedString(@"0.9秒ごと",@"スライドショー")
                         action: @selector(slideshow09) keyEquivalent: @"9"];
    [[Slideshow addItemWithTitle: NSLocalizedString(@"1秒ごと",@"スライドショー")
                          action: @selector(slideshow1) keyEquivalent: @"1"]setKeyEquivalentModifierMask:0];
    [[Slideshow addItemWithTitle: NSLocalizedString(@"2秒ごと",@"スライドショー")
                          action: @selector(slideshow2) keyEquivalent: @"2"]setKeyEquivalentModifierMask:0];
    [[Slideshow addItemWithTitle: NSLocalizedString(@"3秒ごと",@"スライドショー")
                          action: @selector(slideshow3) keyEquivalent: @"3"]setKeyEquivalentModifierMask:0];
    [[Slideshow addItemWithTitle: NSLocalizedString(@"4秒ごと",@"スライドショー")
                          action: @selector(slideshow4) keyEquivalent: @"4"]setKeyEquivalentModifierMask:0];
    [[Slideshow addItemWithTitle: NSLocalizedString(@"5秒ごと",@"スライドショー")
                          action: @selector(slideshow5) keyEquivalent: @"5"]setKeyEquivalentModifierMask:0];
    [[Slideshow addItemWithTitle: NSLocalizedString(@"6秒ごと",@"スライドショー")
                          action: @selector(slideshow6) keyEquivalent: @"6"]setKeyEquivalentModifierMask:0];
    [[Slideshow addItemWithTitle: NSLocalizedString(@"7秒ごと",@"スライドショー")
                          action: @selector(slideshow7) keyEquivalent: @"7"]setKeyEquivalentModifierMask:0];
    [[Slideshow addItemWithTitle: NSLocalizedString(@"8秒ごと",@"スライドショー")
                          action: @selector(slideshow8) keyEquivalent: @"8"]setKeyEquivalentModifierMask:0];
    [[Slideshow addItemWithTitle: NSLocalizedString(@"9秒ごと",@"スライドショー")
                          action: @selector(slideshow9) keyEquivalent: @"9"]setKeyEquivalentModifierMask:0];
    [[Slideshow addItemWithTitle: NSLocalizedString(@"停止",@"スライドショー")
                          action: @selector(slideshow0) keyEquivalent: @"0"]setKeyEquivalentModifierMask:0];
    [SlideshowItem setSubmenu: Slideshow];
    [mainMenu addItem: SlideshowItem];
    
    NSMenuItem	*RandomSlideshowItem = [[[NSMenuItem alloc] init] autorelease];
    NSMenu *RandomSlideshow = [[[NSMenu alloc] init] autorelease];
    [RandomSlideshowItem setTitle:NSLocalizedString(@"ランダムスライドショー",@"")];
    [RandomSlideshow setTitle: NSLocalizedString(@"ランダムスライドショー",@"")];
    [[RandomSlideshow addItemWithTitle: NSLocalizedString(@"0.1秒ごと",@"ランダムスライドショー")
                                action: @selector(slideshowRandom01) keyEquivalent: @"1"]setKeyEquivalentModifierMask:NSAlternateKeyMask|NSCommandKeyMask];
    [[RandomSlideshow addItemWithTitle: NSLocalizedString(@"0.2秒ごと",@"ランダムスライドショー")
                                action: @selector(slideshowRandom02) keyEquivalent: @"2"]setKeyEquivalentModifierMask:NSAlternateKeyMask|NSCommandKeyMask];
    [[RandomSlideshow addItemWithTitle: NSLocalizedString(@"0.3秒ごと",@"ランダムスライドショー")
                                action: @selector(slideshowRandom03) keyEquivalent: @"3"]setKeyEquivalentModifierMask:NSAlternateKeyMask|NSCommandKeyMask];
    [[RandomSlideshow addItemWithTitle: NSLocalizedString(@"0.4秒ごと",@"ランダムスライドショー")
                                action: @selector(slideshowRandom04) keyEquivalent: @"4"]setKeyEquivalentModifierMask:NSAlternateKeyMask|NSCommandKeyMask];
    [[RandomSlideshow addItemWithTitle: NSLocalizedString(@"0.5秒ごと",@"ランダムスライドショー")
                                action: @selector(slideshowRandom05) keyEquivalent: @"5"]setKeyEquivalentModifierMask:NSAlternateKeyMask|NSCommandKeyMask];
    [[RandomSlideshow addItemWithTitle: NSLocalizedString(@"0.6秒ごと",@"ランダムスライドショー")
                                action: @selector(slideshowRandom06) keyEquivalent: @"6"]setKeyEquivalentModifierMask:NSAlternateKeyMask|NSCommandKeyMask];
    [[RandomSlideshow addItemWithTitle: NSLocalizedString(@"0.7秒ごと",@"ランダムスライドショー")
                                action: @selector(slideshowRandom07) keyEquivalent: @"7"]setKeyEquivalentModifierMask:NSAlternateKeyMask|NSCommandKeyMask];
    [[RandomSlideshow addItemWithTitle: NSLocalizedString(@"0.8秒ごと",@"ランダムスライドショー")
                                action: @selector(slideshowRandom08) keyEquivalent: @"8"]setKeyEquivalentModifierMask:NSAlternateKeyMask|NSCommandKeyMask];
    [[RandomSlideshow addItemWithTitle: NSLocalizedString(@"0.9秒ごと",@"ランダムスライドショー")
                                action: @selector(slideshowRandom09) keyEquivalent: @"9"]setKeyEquivalentModifierMask:NSAlternateKeyMask|NSCommandKeyMask];
    [[RandomSlideshow addItemWithTitle: NSLocalizedString(@"1秒ごと",@"ランダムスライドショー")
                                action: @selector(slideshowRandom1) keyEquivalent: @"1"]setKeyEquivalentModifierMask:NSAlternateKeyMask];
    [[RandomSlideshow addItemWithTitle: NSLocalizedString(@"2秒ごと",@"ランダムスライドショー")
                                action: @selector(slideshowRandom2) keyEquivalent: @"2"]setKeyEquivalentModifierMask:NSAlternateKeyMask];
    [[RandomSlideshow addItemWithTitle: NSLocalizedString(@"3秒ごと",@"ランダムスライドショー")
                                action: @selector(slideshowRandom3) keyEquivalent: @"3"]setKeyEquivalentModifierMask:NSAlternateKeyMask];
    [[RandomSlideshow addItemWithTitle: NSLocalizedString(@"4秒ごと",@"ランダムスライドショー")
                                action: @selector(slideshowRandom4) keyEquivalent: @"4"]setKeyEquivalentModifierMask:NSAlternateKeyMask];
    [[RandomSlideshow addItemWithTitle: NSLocalizedString(@"5秒ごと",@"ランダムスライドショー")
                                action: @selector(slideshowRandom5) keyEquivalent: @"5"]setKeyEquivalentModifierMask:NSAlternateKeyMask];
    [[RandomSlideshow addItemWithTitle: NSLocalizedString(@"6秒ごと",@"ランダムスライドショー")
                                action: @selector(slideshowRandom6) keyEquivalent: @"6"]setKeyEquivalentModifierMask:NSAlternateKeyMask];
    [[RandomSlideshow addItemWithTitle: NSLocalizedString(@"7秒ごと",@"ランダムスライドショー")
                                action: @selector(slideshowRandom7) keyEquivalent: @"7"]setKeyEquivalentModifierMask:NSAlternateKeyMask];
    [[RandomSlideshow addItemWithTitle: NSLocalizedString(@"8秒ごと",@"ランダムスライドショー")
                                action: @selector(slideshowRandom8) keyEquivalent: @"8"]setKeyEquivalentModifierMask:NSAlternateKeyMask];
    [[RandomSlideshow addItemWithTitle: NSLocalizedString(@"9秒ごと",@"ランダムスライドショー")
                                action: @selector(slideshowRandom9) keyEquivalent: @"9"]setKeyEquivalentModifierMask:NSAlternateKeyMask];
    [[RandomSlideshow addItemWithTitle: NSLocalizedString(@"停止",@"ランダムスライドショー")
                                action: @selector(slideshow0) keyEquivalent: @"0"]setKeyEquivalentModifierMask:0];
    [RandomSlideshowItem setSubmenu: RandomSlideshow];
    [mainMenu addItem: RandomSlideshowItem];
    
    [mainMenu addItem: [NSMenuItem separatorItem]];
    
    [[mainMenu addItemWithTitle:NSLocalizedString(@"ページずれ補正",@"") action:@selector(onePageGo) keyEquivalent:@"g"] setKeyEquivalentModifierMask:0];
    [[mainMenu addItemWithTitle:NSLocalizedString(@"右開き/左開き",@"") action:@selector(migibirakiHidaribiraki) keyEquivalent:@"r"] setKeyEquivalentModifierMask:0];
    [[mainMenu addItemWithTitle:NSLocalizedString(@"1画面/2画面",@"") action:@selector(onePageDisplay) keyEquivalent:@"w"] setKeyEquivalentModifierMask:0];
    [[mainMenu addItemWithTitle:NSLocalizedString(@"サムネイル一覧",@"") action:@selector(thumbnail) keyEquivalent:@"t"] setKeyEquivalentModifierMask:0];
    
    NSMenuItem	*LoupeItem = [[[NSMenuItem alloc] init] autorelease];
    NSMenu *Loupe = [[[NSMenu alloc] init] autorelease];
    [LoupeItem setTitle:NSLocalizedString(@"ルーペ",@"")];
    [Loupe setTitle: NSLocalizedString(@"ルーペ",@"")];
    [[Loupe addItemWithTitle: NSLocalizedString(@"小さい",@"ルーペ")
                      action: @selector(loupeSmallOnOff) keyEquivalent: @"l"]setKeyEquivalentModifierMask:0];
    [Loupe addItemWithTitle: NSLocalizedString(@"大きい",@"ルーペ")
                     action: @selector(loupeLargeOnOff) keyEquivalent: @"l"];
    [LoupeItem setSubmenu: Loupe];
    [mainMenu addItem: LoupeItem];
    
    NSMenuItem	*BookmarkItem = [[[NSMenuItem alloc] init] autorelease];
    NSMenu *Bookmark = [[[NSMenu alloc] init] autorelease];
    [BookmarkItem setTitle:NSLocalizedString(@"ブックマーク",@"")];
    [Bookmark setTitle: NSLocalizedString(@"ブックマーク",@"")];
    [Bookmark addItem: [NSMenuItem separatorItem]];
    [[Bookmark addItemWithTitle:NSLocalizedString(@"前のブックマークに移動",@"") action:@selector(bookmarkPrev) keyEquivalent:@"b"] setKeyEquivalentModifierMask:NSShiftKeyMask];
    [Bookmark addItemWithTitle:NSLocalizedString(@"次のブックマークに移動",@"") action:@selector(bookmarkNext) keyEquivalent:@"b"];
    [Bookmark addItem: [NSMenuItem separatorItem]];
    [[Bookmark addItemWithTitle:NSLocalizedString(@"ブックマークに追加/削除",@"") action:@selector(bookmarkAddRemove) keyEquivalent:@"b"] setKeyEquivalentModifierMask:0];
    [Bookmark addItemWithTitle:NSLocalizedString(@"ブックマークをすべて削除",@"") action:@selector(bookmarkAllRemove) keyEquivalent:@""];
    [BookmarkItem setSubmenu: Bookmark];
    [mainMenu addItem: BookmarkItem];
    
    [[mainMenu addItemWithTitle:NSLocalizedString(@"右の画像を保存",@"") action:@selector(saveR) keyEquivalent:@"s"] setKeyEquivalentModifierMask:0];
    [mainMenu addItemWithTitle:NSLocalizedString(@"左の画像を保存",@"") action:@selector(saveL) keyEquivalent:@"s"];
    [mainMenu addItemWithTitle:NSLocalizedString(@"アーカイブをゴミ箱に入れる",@"") action:@selector(archiveDelete) keyEquivalent:@"⌫"];
    [[mainMenu addItemWithTitle:NSLocalizedString(@"背景色を変更",@"") action:@selector(changeBackgroundColor) keyEquivalent:@"c"] setKeyEquivalentModifierMask:0];
    
    [mainMenu addItem: [NSMenuItem separatorItem]];
    
    [[mainMenu addItemWithTitle:NSLocalizedString(@"フルスクリーンにする",@"") action:@selector(fullscreen) keyEquivalent:@"f"] setKeyEquivalentModifierMask:NSCommandKeyMask|NSControlKeyMask];
    [[mainMenu addItemWithTitle:NSLocalizedString(@"",@"") action:@selector(fullscreen) keyEquivalent:@"↩"] setKeyEquivalentModifierMask:0];
    
    [mainMenu addItem: [NSMenuItem separatorItem]];
    
    [mainMenu addItemWithTitle:NSLocalizedString(@"しまう",@"") action:@selector(hide) keyEquivalent:@"m"];
    [[mainMenu addItemWithTitle:NSLocalizedString(@"",@"") action:@selector(hide) keyEquivalent:@"m"] setKeyEquivalentModifierMask:0];
    
    [mainMenu addItem: [NSMenuItem separatorItem]];
    
    [mainMenu addItemWithTitle:NSLocalizedString(@"Mangaoを閉じる",@"") action:@selector(quit) keyEquivalent:@"q"];
    [mainMenu addItemWithTitle:NSLocalizedString(@"",@"") action:@selector(quit) keyEquivalent:@"w"];
    [[mainMenu addItemWithTitle:NSLocalizedString(@"",@"") action:@selector(quit) keyEquivalent:@"q"] setKeyEquivalentModifierMask:0];
    
    [mainMenuItem setSubmenu:mainMenu];
    
    //マウスカーソルの初期座標を設定
    //ImageCenterField上でのマウスカーソルの座標を取得
    app.cursor_onImageCenterField = [app.imageCenterField convertPoint:[[self viewWindow] convertScreenToBase:[NSEvent mouseLocation]] fromView:nil];
    
    //クリック、スクロール、スワイプ、ピンチ、キー入力をした時に呼び出される
    //クリック、右クリックで進む・戻る
    //スクロールで進む・戻る
    //二本指タップで大きいルーペon/off
    //スワイプで進む・戻る
    //ピンチで小さいルーペon/off
    //Escでフルスクリーンを解除
    //Shift+tabで10ページ戻る
    //tabで10ページ進む
    [NSEvent addLocalMonitorForEventsMatchingMask:(NSKeyDown | NSOtherMouseDownMask | NSScrollWheelMask | NSEventMaskSwipe | NSEventMaskMagnify | NSKeyDownMask)
                                          handler:^(NSEvent* event)
     {
         //ウィンドウがアクティブな場合
         if([viewWindow isKeyWindow])
         {
             //クリックイベントの場合
             if(([event type] == 1) || ([event type] == 3))
             {
                 //ウィンドウのサイズを取得
                 float windowX = self.viewWindow.frame.size.width;
                 float windowY = self.viewWindow.frame.size.height;
                 
                 //ウィンドウの縁以外をクリックした場合(ウィンドウの縁のマージンは上が25,右左下が12)
                 //もしくはフルスクリーンの時、ウィンドウの上以外をクリックした場合(ウィンドウの上のマージンは25)
                 if(((12 < app.cursor_onImageCenterField.x) && (app.cursor_onImageCenterField.x < windowX - 12) && (12 < app.cursor_onImageCenterField.y) && (app.cursor_onImageCenterField.y < windowY - 25)) || (![NSMenu menuBarVisible] && (cursor_onImageCenterField.y < windowY - 25)))
                 {
                     //左クリック([event type] == 1)なら進む、右クリック([event type] == 3)なら戻る
                     if([event type] == 1)
                     {
                         [self pageNext];
                     }
                     else if([event type] == 3)
                     {
                         [self pagePrev];
                     }
                 }
             }
             //スクロールイベントの場合
             else if([event type] == 22)
             {
                 //上スクロールなら進む
                 if([event deltaY] < 0)
                 {
                     //二本指タップのタイムスタンプをリセット
                     app.timestamp_tapWithTwoFingers = 0;
                     [self pageNext];
                 }
                 //下スクロールなら戻る
                 else if([event deltaY] > 0)
                 {
                     //二本指タップのタイムスタンプをリセット
                     app.timestamp_tapWithTwoFingers = 0;
                     [self pagePrev];
                 }
                 //二本指タップ
                 else if ([event phase] == 32)
                 {
                     //前回の二本指タップから1秒以内の場合
                     if([event timestamp] < app.timestamp_tapWithTwoFingers + 0.5)
                     {
                         //大きいルーペを起動・終了
                         [self loupeLargeOnOff];
                         //タイムスタンプをリセット
                         app.timestamp_tapWithTwoFingers = 0;
                     }
                     else
                     {
                         //現在のタイムスタンプを記録
                         app.timestamp_tapWithTwoFingers = [event timestamp];
                     }
                 }
             }
             //ホイールクリックイベントの場合
             else if([event type] == 25)
             {
                 //メインメニューを表示
                 [NSMenu popUpContextMenu:mainMenu withEvent:event forView:nil];
             }
             //スワイプイベントの場合
             else if([event type] == 31)
             {
                 //左開きの場合(『デフォルトで左開き』を考慮)
                 if(abs(app.hidaribirakiMode - [[[plistValue objectAtIndex:0] objectAtIndex:0] intValue]))
                 {
                     //左スワイプなら進む
                     if ([event deltaX] == 1.0)
                     {
                         [self pageNext];
                     }
                     //右スワイプなら戻る
                     else if ([event deltaX] == -1.0)
                     {
                         [self pagePrev];
                     }
                 }
                 //右開きの場合
                 else
                 {
                     //左スワイプなら戻る
                     if ([event deltaX] == 1.0)
                     {
                         [self pagePrev];
                     }
                     //右スワイプなら進む
                     else if ([event deltaX] == -1.0)
                     {
                         [self pageNext];
                     }
                 }
             }
             //ピンチイベントの場合
             else if([event type] == 30)
             {
                 //ルーペを起動中ではなくピンチアウトなら小さいルーペ起動
                 if ([event magnification] > 0)
                 {
                     if(!app.isLoupe)
                     {
                         //画面のサイズを取得
                         float screenX = [[NSScreen mainScreen]frame].size.width;
                         float screenY = [[NSScreen mainScreen]frame].size.height;
                         
                         //ルーペウィンドウのサイズを[画面の短い方の辺の5分の2×画面の短い方の辺の5分の2]にする
                         if(screenX < [[NSScreen mainScreen]frame].size.width)
                         {
                             [loupeWindow setFrame:NSMakeRect(0,0,screenX*2/5,screenX*2/5) display:NO];
                         }
                         else
                         {
                             [loupeWindow setFrame:NSMakeRect(0,0,screenY*2/5,screenY*2/5) display:NO];
                         }
                         
                         app.isLoupe = 1;
                         //マウスカーソルを隠す
                         [NSCursor hide];
                         [self loupe];
                     }
                 }
                 //ルーペを起動中でピンチインならルーペ終了
                 else if ([event magnification] < 0)
                 {
                     if(app.isLoupe)
                     {
                         app.isLoupe = 0;
                         //ルーペウィンドウを無効にする
                         [[self loupeWindow] orderOut:self];
                         //マウスカーソルを表示する
                         [NSCursor unhide];
                     }
                 }
             }
             //キー入力の場合
             else if([event type] == 10)
             {
                 //Escが入力された場合
                 if([event keyCode] == 53)
                 {
                     //フルスクリーンを解除
                     [self exitFullscreen];
                 }
                 //Shift+tabが入力された場合
                 else if([event keyCode] == 48 && [event modifierFlags] == 131330)
                 {
                     //10ページ戻る
                     [self page10Prev];
                 }
                 //tabが入力された場合
                 else if([event keyCode] == 48 && [event modifierFlags] == 256)
                 {
                     //10ページ進む
                     [self page10Next];
                 }
             }
         }

         //サムネイル一覧中
         if(isThumbnail)
         {
             //Esc入力・右クリック
             if(([event type] == 10 && [event keyCode] == 53) || ([event type] == 3))
             {
                 //サムネイル一覧を終了
                 [self exitThumbnail];
             }
         }
         
         return event;
     }];
    
    //0.01秒ごとに、
    //カーソルの位置を取得
    //ImageCenterFieldの高さを取得
    //ルーペの更新
    //フルスクリーン時のメニューバー表示
    [NSTimer scheduledTimerWithTimeInterval:0.01
                                     target:self
                                   selector:@selector(trackingMousePoint)
                                   userInfo:nil
                                    repeats:YES];
    
    //3秒ごとに、フルスクリーンならマウスカーソルを隠す
    [NSTimer scheduledTimerWithTimeInterval:3.0
                                     target:self
                                   selector:@selector(setHiddenUntilMouseMoves)
                                   userInfo:nil
                                    repeats:YES];
}

//文字コードを日本語に設定
- (void)SetcharacterEncodingJa
{
    [self SetcharacterEncoding:0];
}

//文字コードを中国語に設定
- (void)SetcharacterEncodingCh
{
    [self SetcharacterEncoding:1];
}

//文字コードを韓国語に設定
- (void)SetcharacterEncodingKo
{
    [self SetcharacterEncoding:2];
}

//文字コードを設定
- (void)SetcharacterEncoding:(int)witch
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        //日本語==0,中国語==1,韓国語==2
        [[plistValue objectAtIndex:0] replaceObjectAtIndex:7 withObject:[NSNumber numberWithInteger:witch]];

        //Mangaoについてメニューを削除
        [mainMenu removeItemAtIndex:0];
        
        NSMenuItem	*AboutMangaoItem = [[[NSMenuItem alloc] init] autorelease];
        NSMenu *AboutMangao = [[[NSMenu alloc] init] autorelease];
        [AboutMangaoItem setTitle:NSLocalizedString(@"Mangaoについて",@"")];
        [AboutMangao setTitle: NSLocalizedString(@"Mangaoについて",@"")];
        NSMenuItem	*CharacterEncodingItem = [[[NSMenuItem alloc] init] autorelease];
        NSMenu *CharacterEncoding = [[[NSMenu alloc] init] autorelease];
        [CharacterEncodingItem setTitle:NSLocalizedString(@"文字コード",@"")];
        [CharacterEncoding setTitle: NSLocalizedString(@"文字コード",@"")];
        NSMenuItem *NSMenuItemCharacterEncodingJa = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"日本語",@"") action:@selector(SetcharacterEncodingJa) keyEquivalent:@"j"];
        NSMenuItem *NSMenuItemCharacterEncodingCh = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"中国語",@"") action:@selector(SetcharacterEncodingCh) keyEquivalent:@"c"];
        NSMenuItem *NSMenuItemCharacterEncodingKo = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"韓国語",@"") action:@selector(SetcharacterEncodingKo) keyEquivalent:@"k"];
        [NSMenuItemCharacterEncodingJa setKeyEquivalentModifierMask:NSAlternateKeyMask|NSCommandKeyMask];
        [NSMenuItemCharacterEncodingCh setKeyEquivalentModifierMask:NSAlternateKeyMask|NSCommandKeyMask];
        [NSMenuItemCharacterEncodingKo setKeyEquivalentModifierMask:NSAlternateKeyMask|NSCommandKeyMask];
        //選択されている文字コードにチェックを付け消しする
        if([[[plistValue objectAtIndex:0] objectAtIndex:7] intValue] == 0)
        {
            [NSMenuItemCharacterEncodingJa setState:NSOnState];
            [NSMenuItemCharacterEncodingCh setState:NSOffState];
            [NSMenuItemCharacterEncodingKo setState:NSOffState];
            
        }
        else if([[[plistValue objectAtIndex:0] objectAtIndex:7] intValue] == 1)
        {
            [NSMenuItemCharacterEncodingJa setState:NSOffState];
            [NSMenuItemCharacterEncodingCh setState:NSOnState];
            [NSMenuItemCharacterEncodingKo setState:NSOffState];
        }
        else if([[[plistValue objectAtIndex:0] objectAtIndex:7] intValue] == 2)
        {
            [NSMenuItemCharacterEncodingJa setState:NSOffState];
            [NSMenuItemCharacterEncodingCh setState:NSOffState];
            [NSMenuItemCharacterEncodingKo setState:NSOnState];
        }
        [CharacterEncoding addItem: NSMenuItemCharacterEncodingJa];
        [CharacterEncoding addItem: NSMenuItemCharacterEncodingCh];
        [CharacterEncoding addItem: NSMenuItemCharacterEncodingKo];
        [CharacterEncodingItem setSubmenu: CharacterEncoding];
        [AboutMangao addItem: CharacterEncodingItem];
        [AboutMangao addItemWithTitle:NSLocalizedString(@"クレジット",@"") action:@selector(showCreditsPanel) keyEquivalent:@""];
        [AboutMangao addItemWithTitle:NSLocalizedString(@"Mangaoに寄付する",@"") action:@selector(donation) keyEquivalent:@""];
        [AboutMangaoItem setSubmenu: AboutMangao];
        
        //Mangaoについてメニューを追加
        [mainMenu insertItem:AboutMangaoItem atIndex:0];
        
        //アーカイブを開き直す
        //空でないことを確認
        if(app.listSize)
        {
            [self archiveOpen];
        }
    }
}

//クレジット
- (void)showCreditsPanel
{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://ryotaminami93.appspot.com/mangao-credits.html"]];
}

//Mangaoに寄付する
- (void)donation
{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://ryotaminami93.appspot.com/mangao.html"]];
}



//모든 이미지 효과를 끄기
- (void)SetImageEffectsOff
{
    [self SetImageEffects:0];
}

//자동 채색으로 설정
- (void)SetImageEffectsAutoColorize
{
    [self SetBrightness:0.0];
    [self SetContrast:1.0];
    [self SetImageEffects:1];
}

//자동 보정으로 설정
- (void)SetImageEffectsAutoImageEnhance
{
    [self SetBrightness:0.0];
    [self SetContrast:1.0];
    [self SetImageEffects:2];
}

//세피아 톤으로 설정
- (void)SetImageEffectsSepiaTone
{
    [self SetBrightness:0.0];
    [self SetContrast:1.0];
    [self SetImageEffects:3];
}

//그레이스케일로 설정
- (void)SetImageEffectsGrayscale
{
    [self SetBrightness:0.0];
    [self SetContrast:1.0];
    [self SetImageEffects:4];
}

//이미지 효과 설정
- (void)SetImageEffects:(int)witch
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        //NSLog(@"%d",witch);
        //효과 없음, 자동 채색, 자동 이미지 보정, 세피아톤, 그레이스케일
        [[plistValue objectAtIndex:0] replaceObjectAtIndex:8 withObject:[NSNumber numberWithInteger:witch]];

        //메뉴 삭제
        [mainMenu removeItemAtIndex:2];

        //Image Effects
        NSMenuItem	*ImageEffectsItem = [[[NSMenuItem alloc] init] autorelease];
        NSMenu *ImageEffects = [[[NSMenu alloc] init] autorelease];
        [ImageEffectsItem setTitle:NSLocalizedString(@"イメージ効果",@"")];
        [ImageEffects setTitle:NSLocalizedString(@"イメージ効果",@"")];
        
        NSMenuItem *NSMenuItemNone  = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"効果なし",@"") action:@selector(SetImageEffectsOff) keyEquivalent:@"n"];
        NSMenuItem *NSMenuItemAutoColorize  = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"自動着色",@"") action:@selector(SetImageEffectsAutoColorize) keyEquivalent:@"a"];
        NSMenuItem *NSMenuItemAutoImageEnhance  = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"自動イメージ補訂",@"") action:@selector(SetImageEffectsAutoImageEnhance) keyEquivalent:@"i"];
        NSMenuItem *NSMenuItemSepiaTone  = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"セピアトーン",@"") action:@selector(SetImageEffectsSepiaTone) keyEquivalent:@"e"];
        NSMenuItem *NSMenuItemGrayscale  = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"グレースケール",@"") action:@selector(SetImageEffectsGrayscale) keyEquivalent:@"g"];
        
        
        // 효과 없음, 자동 채색, 자동 이미지 보정, 세피아톤, 그레이스케일 설정에 따라 체크 유무 설정
        if([[[plistValue objectAtIndex:0] objectAtIndex:8] intValue] == 0)
        {
            [NSMenuItemNone setState:NSOnState];
            [NSMenuItemAutoColorize setState:NSOffState];
            [NSMenuItemAutoImageEnhance setState:NSOffState];
            [NSMenuItemSepiaTone setState:NSOffState];
            [NSMenuItemGrayscale setState:NSOffState];
        }
        else if([[[plistValue objectAtIndex:0] objectAtIndex:8] intValue] == 1)
        {
            [NSMenuItemNone setState:NSOffState];
            [NSMenuItemAutoColorize setState:NSOnState];
            [NSMenuItemAutoImageEnhance setState:NSOffState];
            [NSMenuItemSepiaTone setState:NSOffState];
            [NSMenuItemGrayscale setState:NSOffState];
        }
        else if([[[plistValue objectAtIndex:0] objectAtIndex:8] intValue] == 2)
        {
            [NSMenuItemNone setState:NSOffState];
            [NSMenuItemAutoColorize setState:NSOffState];
            [NSMenuItemAutoImageEnhance setState:NSOnState];
            [NSMenuItemSepiaTone setState:NSOffState];
            [NSMenuItemGrayscale setState:NSOffState];
        }
        else if([[[plistValue objectAtIndex:0] objectAtIndex:8] intValue] == 3)
        {
            [NSMenuItemNone setState:NSOffState];
            [NSMenuItemAutoColorize setState:NSOffState];
            [NSMenuItemAutoImageEnhance setState:NSOffState];
            [NSMenuItemSepiaTone setState:NSOnState];
            [NSMenuItemGrayscale setState:NSOffState];
        }
        else if([[[plistValue objectAtIndex:0] objectAtIndex:8] intValue] == 4)
        {
            [NSMenuItemNone setState:NSOffState];
            [NSMenuItemAutoColorize setState:NSOffState];
            [NSMenuItemAutoImageEnhance setState:NSOffState];
            [NSMenuItemSepiaTone setState:NSOffState];
            [NSMenuItemGrayscale setState:NSOnState];
        }
        
        [ImageEffects addItem:NSMenuItemNone];
        [ImageEffects addItem:NSMenuItemAutoColorize];
        [ImageEffects addItem:NSMenuItemAutoImageEnhance];
        [ImageEffects addItem:NSMenuItemSepiaTone];
        [ImageEffects addItem:NSMenuItemGrayscale];
        [ImageEffectsItem setSubmenu: ImageEffects];

        //메뉴 추가
        [mainMenu insertItem:ImageEffectsItem atIndex:2];

        if(app.listSize)
        {
            [self setImage];
        }

    }
}

/*
//自動着色
- (void)ImageEffects
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        if([[[plistValue objectAtIndex:0] objectAtIndex:8] intValue] == 1)
        {
            [[plistValue objectAtIndex:0] replaceObjectAtIndex:8 withObject:[NSNumber numberWithInteger:0]];
        }
        else
        {
            [[plistValue objectAtIndex:0] replaceObjectAtIndex:8 withObject:[NSNumber numberWithInteger:1]];
        }
        
        //自動着色がオン/オフに応じてメニューアイテムにチェックを付け外しする
        NSMenuItem *NSMenuItemAutoColorize  = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"自動着色",@"") action:@selector(autoColorize) keyEquivalent:@"a"];
        NSMenuItem *NSMenuItemAutoImageEnhance  = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"自動イメージ補訂",@"") action:@selector(AutoImageEnhance) keyEquivalent:@""];
        [NSMenuItemAutoColorize setKeyEquivalentModifierMask:0];
        if([[[plistValue objectAtIndex:0] objectAtIndex:8] intValue] == 1)
        {
            [NSMenuItemAutoColorize setState:NSOnState];
            [NSMenuItemAutoImageEnhance setState:NSOffState];
        }
        else
        {
            [NSMenuItemAutoColorize setState:NSOffState];
        }
        [mainMenu removeItemAtIndex:2];
        [mainMenu insertItem:NSMenuItemAutoColorize atIndex:2];
 
        //画面を更新
        //空でないことを確認
        if(app.listSize)
        {
            [self setImage];
        }
    }
}
  */

//밝기 기본
//모든 이미지 효과를 끄기
- (void)SetDefaultBrightness
{
    [self SetImageEffects:0];
    [self SetBrightness:0];
}

//밝기 밝게
- (void)SetPlusBrightness
{
    [self SetImageEffects:0];
    [self SetBrightness:0.05];
}

//밝기 어둡게
- (void)SetMinusBrightness
{
    [self SetImageEffects:0];
    [self SetBrightness:-0.05];
}

//밝기 설정
- (void)SetBrightness:(float)witch
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        if(!(witch == 0))
        {
            witch = [[[plistValue objectAtIndex:0] objectAtIndex:10] floatValue] + witch;
            //NSLog((@"witch:%f"), witch);
        }
        //범위 제한
        if(witch < -1)
        {
            witch = -1;
        }
        else if (witch > 1)
        {
            witch = 1;
        }
        
        //환경설정에 값을 써 넣는다
        //NSLog((@"final witch:%f"), witch);
        [[plistValue objectAtIndex:0] replaceObjectAtIndex:10 withObject:[NSNumber numberWithFloat:witch]];
        
        //메뉴 삭제
        [mainMenu removeItemAtIndex:3];
        
        //밝기 메뉴 추가
        NSMenuItem	*BrightnessItem = [[[NSMenuItem alloc] init] autorelease];
        NSMenu *Brightness = [[[NSMenu alloc] init] autorelease];
        [BrightnessItem setTitle:NSLocalizedString(@"明るさ",@"")];
        [Brightness setTitle:NSLocalizedString(@"明るさ",@"")];
        
        NSMenuItem *NSMenuItemDefaultBrightness  = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"デフォルト",@"") action:@selector(SetDefaultBrightness) keyEquivalent:@"/"];
        NSMenuItem *NSMenuItemMinusBrightness  = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"暗く",@"") action:@selector(SetMinusBrightness) keyEquivalent:@","];
        NSMenuItem *NSMenuItemPlusBrightness  = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"明るく",@"") action:@selector(SetPlusBrightness) keyEquivalent:@"."];
        [NSMenuItemDefaultBrightness setKeyEquivalentModifierMask:0];
        [NSMenuItemMinusBrightness setKeyEquivalentModifierMask:0];
        [NSMenuItemPlusBrightness setKeyEquivalentModifierMask:0];
        
        // 밝기 기본일 때 체크 유무 설정
        if([[[plistValue objectAtIndex:0] objectAtIndex:10] floatValue] == 0)
        {
            [NSMenuItemDefaultBrightness setState:NSOnState];
            [NSMenuItemMinusBrightness setState:NSOffState];
            [NSMenuItemPlusBrightness setState:NSOffState];
        }
        else
        {
            [NSMenuItemDefaultBrightness setState:NSOffState];
            [NSMenuItemMinusBrightness setState:NSOffState];
            [NSMenuItemPlusBrightness setState:NSOffState];
        }
        [Brightness addItem:NSMenuItemDefaultBrightness];
        [Brightness addItem:NSMenuItemMinusBrightness];
        [Brightness addItem:NSMenuItemPlusBrightness];
        [BrightnessItem setSubmenu: Brightness];

        
        //메뉴 추가
        [mainMenu insertItem:BrightnessItem atIndex:3];
        
        //화면 갱신
        if(app.listSize)
        {
            [self setImage];
        }
    }
}


//콘트라스트 기본
- (void)SetDefaultContrast
{
    [self SetImageEffects:0];
    [self SetContrast:1.0];
}

//콘트라스트 강하게
- (void)SetPlusContrast
{
    [self SetImageEffects:0];
    [self SetContrast:0.05];
}

//콘트라스트 낮게
- (void)SetMinusContrast
{
    [self SetImageEffects:0];
    [self SetContrast:-0.05];
}

//콘트라스트 설정
- (void)SetContrast:(float)witch
{
    //NSLog((@"witch:%f"), witch);
    
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        if(!(witch==1))
        {
        witch = [[[plistValue objectAtIndex:0] objectAtIndex:11] floatValue] + witch;
        }
        //범위 제한
        if(witch < 0)
        {
            witch = 0;
        }
        else if (witch > 2)
        {
            witch = 2;
        }
        
        //환경설정에 값을 써 넣는다
        //NSLog((@"final witch:%f"), witch);
        [[plistValue objectAtIndex:0] replaceObjectAtIndex:11 withObject:[NSNumber numberWithFloat:witch]];

        //메뉴 삭제
        [mainMenu removeItemAtIndex:4];

        //콘트라스트 메뉴 추가
        NSMenuItem	*ContrastItem = [[[NSMenuItem alloc] init] autorelease];
        NSMenu *Contrast = [[[NSMenu alloc] init] autorelease];
        [ContrastItem setTitle:NSLocalizedString(@"コントラスト",@"")];
        [Contrast setTitle:NSLocalizedString(@"コントラスト",@"")];
        
        NSMenuItem *NSMenuItemDefaultContrast  = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"デフォルト",@"") action:@selector(SetDefaultContrast) keyEquivalent:@"?"];
        NSMenuItem *NSMenuItemMinusContrast  = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"低く",@"") action:@selector(SetMinusContrast) keyEquivalent:@"<"];
        NSMenuItem *NSMenuItemPlusContrast  = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"高く",@"") action:@selector(SetPlusContrast) keyEquivalent:@">"];
        [NSMenuItemDefaultContrast setKeyEquivalentModifierMask:0];
        [NSMenuItemMinusContrast setKeyEquivalentModifierMask:0];
        [NSMenuItemPlusContrast setKeyEquivalentModifierMask:0];

        if(witch == 1)
        {

            [NSMenuItemDefaultContrast setState:NSOnState];
            [NSMenuItemMinusContrast setState:NSOffState];
            [NSMenuItemPlusContrast setState:NSOffState];
        }
        else
        {
            [NSMenuItemDefaultContrast setState:NSOffState];
            [NSMenuItemMinusContrast setState:NSOffState];
            [NSMenuItemPlusContrast setState:NSOffState];
        
        }

            [Contrast addItem:NSMenuItemDefaultContrast];
            [Contrast addItem:NSMenuItemMinusContrast];
            [Contrast addItem:NSMenuItemPlusContrast];
            [ContrastItem setSubmenu: Contrast];

            //메뉴 추가
            [mainMenu insertItem:ContrastItem atIndex:4];
    
        //화면 갱신
        if(app.listSize)
        {
            [self setImage];
        }
    }
}


//デフォルトで左開き
- (void)defaultHidaribiraki
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        if([[[plistValue objectAtIndex:0] objectAtIndex:0] intValue])
        {
            [[plistValue objectAtIndex:0] replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:0]];
        }
        else
        {
            [[plistValue objectAtIndex:0] replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:1]];
        }
        
        //デフォルトで左開きがオン/オフに応じてメニューアイテムにチェックを付け外しする
        NSMenuItem *NSMenuItemDefaultHidaribiraki = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"デフォルトで左開き",@"") action:@selector(defaultHidaribiraki) keyEquivalent:@""];
        if([[[plistValue objectAtIndex:0] objectAtIndex:0] intValue])
        {
            [NSMenuItemDefaultHidaribiraki setState:NSOnState];
        }
        else
        {
            [NSMenuItemDefaultHidaribiraki setState:NSOffState];
        }
        [mainMenu removeItemAtIndex:5];
        [mainMenu insertItem:NSMenuItemDefaultHidaribiraki atIndex:5];
        
        //左開きの場合(『デフォルトで左開き』を考慮)
        if(abs(app.hidaribirakiMode - [[[plistValue objectAtIndex:0] objectAtIndex:0] intValue]))
        {
            //画面を更新
            imageLeftFieldxxx = imageRightField;
            imageRightFieldxxx = imageLeftField;
            [self LniSet];
            [self RniSet];
            
            //ページ移動メニューを更新
            [self goPageMenuReload:1];
        }
        //右開きの場合
        else
        {
            //画面を更新
            imageLeftFieldxxx = imageLeftField;
            imageRightFieldxxx = imageRightField;
            [self LniSet];
            [self RniSet];
            
            //ページ移動メニューを更新
            [self goPageMenuReload:0];
        }
        //페이지넘버 갱신
        [self setWindowTitle];
    }
}

//デフォルトで1画面
- (void)defaultOnePageDisplay
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        //デフォルトで1画面の場合
        if([[[plistValue objectAtIndex:0] objectAtIndex:1] intValue])
        {
            [[plistValue objectAtIndex:0] replaceObjectAtIndex:1 withObject:[NSNumber numberWithInteger:0]];
        }
        //デフォルトで1画面ではない場合
        else
        {
            [[plistValue objectAtIndex:0] replaceObjectAtIndex:1 withObject:[NSNumber numberWithInteger:1]];
        }
        
        //デフォルトで1画面がオン/オフに応じてメニューアイテムにチェックを付け外しする
        NSMenuItem *NSMenuItemDefaultOnePageDisplay = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"デフォルトで1画面",@"") action:@selector(defaultOnePageDisplay) keyEquivalent:@""];
        if([[[plistValue objectAtIndex:0] objectAtIndex:1] intValue])
        {
            [NSMenuItemDefaultOnePageDisplay setState:NSOnState];
        }
        else
        {
            [NSMenuItemDefaultOnePageDisplay setState:NSOffState];
        }
        [mainMenu removeItemAtIndex:6];
        [mainMenu insertItem:NSMenuItemDefaultOnePageDisplay atIndex:6];
        
        //画面を更新
        //空でないことを確認
        if(app.listSize)
        {
            //1画面モードの場合(『デフォルトで1画面』を考慮)
            if(abs(app.onePageMode - [[[plistValue objectAtIndex:0] objectAtIndex:1] intValue]))
            {
                [self imageFieldReset];
                
                //左側が空の場合
                if(app.index+1 > app.listSize)
                {
                    app.index--;
                }
                app.imageCenter = [self readImage];
                [self CniSet];
            }
            //1画面モードではない場合
            else
            {
                [self setImage];
            }
        }
        //페이지넘버 갱신
        [self setWindowTitle];
    }
}

//デフォルトで右回転
- (void)defaultRotateRight
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        //デフォルトで右回転の場合
        if([[[plistValue objectAtIndex:0] objectAtIndex:2] intValue])
        {
            [[plistValue objectAtIndex:0] replaceObjectAtIndex:2 withObject:[NSNumber numberWithInteger:0]];
        }
        //デフォルトで右回転ではない場合
        else
        {
            [[plistValue objectAtIndex:0] replaceObjectAtIndex:2 withObject:[NSNumber numberWithInteger:1]];
            [[plistValue objectAtIndex:0] replaceObjectAtIndex:3 withObject:[NSNumber numberWithInteger:0]];
            //hide pagenumber
            pagenumberPrev.hidden = 1;
            pagenumberNext.hidden = 1;
        }
        
        [self defaultRotate];
    }
}

//デフォルトで左回転
- (void)defaultRotateLeft
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        //デフォルトで左回転の場合
        if([[[plistValue objectAtIndex:0] objectAtIndex:3] intValue])
        {
            [[plistValue objectAtIndex:0] replaceObjectAtIndex:3 withObject:[NSNumber numberWithInteger:0]];
        }
        //デフォルトで左回転ではない場合
        else
        {
            [[plistValue objectAtIndex:0] replaceObjectAtIndex:2 withObject:[NSNumber numberWithInteger:0]];
            [[plistValue objectAtIndex:0] replaceObjectAtIndex:3 withObject:[NSNumber numberWithInteger:1]];
            //hide pagenumber
            pagenumberPrev.hidden = 1;
            pagenumberNext.hidden = 1;

        }
        
        [self defaultRotate];
    }
}

//デフォルトで回転
- (void)defaultRotate
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //デフォルトで右・左回転がオン/オフに応じてメニューアイテムにチェックを付け外しする
    NSMenuItem *NSMenuItemDefaultRotateRight = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"デフォルトで右回転",@"") action:@selector(defaultRotateRight) keyEquivalent:@"]"];
    NSMenuItem *NSMenuItemDefaultRotateLeft = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"デフォルトで左回転",@"") action:@selector(defaultRotateLeft) keyEquivalent:@"["];
    [NSMenuItemDefaultRotateRight setKeyEquivalentModifierMask:0];
    [NSMenuItemDefaultRotateLeft setKeyEquivalentModifierMask:0];
    if([[[plistValue objectAtIndex:0] objectAtIndex:2] intValue])
    {
        [NSMenuItemDefaultRotateRight setState:NSOnState];
    }
    else
    {
        [NSMenuItemDefaultRotateRight setState:NSOffState];
    }
    if([[[plistValue objectAtIndex:0] objectAtIndex:3] intValue])
    {
        [NSMenuItemDefaultRotateLeft setState:NSOnState];
    }
    else
    {
        [NSMenuItemDefaultRotateLeft setState:NSOffState];
    }
    [mainMenu removeItemAtIndex:7];
    [mainMenu insertItem:NSMenuItemDefaultRotateRight atIndex:7];
    [mainMenu removeItemAtIndex:8];
    [mainMenu insertItem:NSMenuItemDefaultRotateLeft atIndex:8];
    
    //画面を更新
    //空でないことを確認
    if(app.listSize)
    {
        [self setImage];
    }
}

//フルスクリーン
- (void)fullscreen
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        //OSのバージョンを取得
        NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:@"/System/Library/CoreServices/SystemVersion.plist"];
        NSString *version = [dictionary objectForKey:@"ProductVersion"];
        
        float fullscreenVersion = 10.7;
        
        //〜10.6の場合
        if([version floatValue] < fullscreenVersion)
        {
            //フルスクリーンではない場合
            if(!app.isFullscreenFor106)
            {
                app.isFullscreenFor106 = 1;
                
                //ウィンドウのサイズ・位置を取得
                app.windowRectBeforeFullscreen = viewWindow.frame;
                
                //メニューバーを隠す
                [NSMenu setMenuBarVisible:NO];
                //タイトルバーを隠す
                [viewWindow setStyleMask:NSBorderlessWindowMask];
                
                //ウィンドウを画面と同じ大きさにする
                [viewWindow setFrame:[[NSScreen mainScreen]frame]display:YES animate:YES];
            }
            //フルスクリーンの場合
            else
            {
                app.isFullscreenFor106 = 0;
                
                //タイトルバーを表示する
                [viewWindow setStyleMask:NSTitledWindowMask | NSClosableWindowMask | NSResizableWindowMask | NSMiniaturizableWindowMask];
                //何かアーカイブを開いている場合
                if(app.listSize)
                {
                    //ウィンドウタイトルを再取得する
                    [self setWindowTitle];
                }
                //何もアーカイブを開いていない場合
                else
                {
                    //ウィンドウタイトルをリセットする
                    [self resetWindowTitle];
                }
                //メニューバーを表示する
                [NSMenu setMenuBarVisible:YES];
                
                //ウィンドウをフルスクリーン以前のサイズ・位置にする
                [viewWindow setFrame:app.windowRectBeforeFullscreen display:YES animate:YES];
            }
        }
        //10.7〜の場合
        else
        {
            [viewWindow toggleFullScreen:nil];
        }
    }
}

//フルスクリーンを解除
- (void)exitFullscreen
{
    //フルスクリーンの場合
    if(![NSMenu menuBarVisible])
    {
        [self fullscreen];
    }
}

//しまう
- (void)hide
{
    [[NSApplication sharedApplication] miniaturizeAll:nil];
}

//Mangaoを閉じる
- (void)quit
{
    [[NSApplication sharedApplication] terminate:nil];
}

//ルーペ
- (void)loupe
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        //ウィンドウのサイズを取得
        NSSize size_window = self.viewWindow.frame.size;
        //imageCenterFieldのサイズを取得
        NSSize size_imageField = self.imageCenterField.frame.size;
        
        NSArray *loupeArray = NULL;
        NSImage *loupeImage = NULL;
        float size_image_onField_X;
        float size_image_onField_Y;
        float cursor_onImage_onField_X;
        float cursor_onImage_onField_Y;
        
        //centerFieldに画像が表示されている場合
        if(app.imageCenter && (((0 < app.cursor_onImageCenterField.y) && (app.cursor_onImageCenterField.y < size_imageField.height))))
        {
            //ルーペの配列を取得
            loupeArray = [[Loupe alloc] loupe:app.isLoupe witchField:2 cursor_onImageField:app.cursor_onImageCenterField windowSize:size_window imageFieldSize:size_imageField image:app.imageCenter];
        }
        //centerField以外に画像が表示されている場合
        else
        {
            //LeftFieldに画像が表示されている場合(左開きの場合も考慮)
            if(app.imageLeft && (((!app.hidaribirakiMode) && (0 < cursor_onImageCenterField.x) && (cursor_onImageCenterField.x < size_imageField.width/2)) || ((app.hidaribirakiMode) && (size_imageField.width/2 < cursor_onImageCenterField.x) && (cursor_onImageCenterField.x < size_imageField.width))))
            {
                NSPoint cursor_onImageLeftField = [app.imageLeftFieldxxx convertPoint:[[self viewWindow] convertScreenToBase:[NSEvent mouseLocation]] fromView:nil];
                size_imageField = self.imageLeftFieldxxx.frame.size;
                
                //ルーペの配列を取得
                loupeArray = [[Loupe alloc] loupe:app.isLoupe witchField:1 cursor_onImageField:cursor_onImageLeftField windowSize:size_window imageFieldSize:size_imageField image:app.imageLeft];
            }
            //RightFieldに画像が表示されている場合(左開きの場合も考慮)
            else if(app.imageRight && (((!app.hidaribirakiMode) && (size_imageField.width/2 < cursor_onImageCenterField.x) && (app.cursor_onImageCenterField.x < size_imageField.width)) || ((app.hidaribirakiMode) && (0 < app.cursor_onImageCenterField.x) && (app.cursor_onImageCenterField.x < size_imageField.width/2))))
            {
                NSPoint cursor_onImageRightField = [app.imageRightFieldxxx convertPoint:[[self viewWindow] convertScreenToBase:[NSEvent mouseLocation]] fromView:nil];
                size_imageField = self.imageRightFieldxxx.frame.size;
                
                //ルーペの配列を取得
                loupeArray = [[Loupe alloc] loupe:app.isLoupe witchField:0 cursor_onImageField:cursor_onImageRightField windowSize:size_window imageFieldSize:size_imageField image:app.imageRight];
            }
        }
        
        //ルーペイメージが正常に取得できた場合
        if([loupeArray count] == 5)
        {
            loupeImage = [loupeArray objectAtIndex:0];
            size_image_onField_X = [[loupeArray objectAtIndex:1]floatValue];
            size_image_onField_Y = [[loupeArray objectAtIndex:2]floatValue];
            cursor_onImage_onField_X = [[loupeArray objectAtIndex:3]floatValue];
            cursor_onImage_onField_Y = [[loupeArray objectAtIndex:4]floatValue];
        }
        //ルーペイメージが正常に取得できなかった場合
        else
        {
            loupeImage = NULL;
        }
        
        //ルーペイメージが正常に取得できた場合
        if(loupeImage)
        {
            [loupeField setImage:loupeImage];
            
            //ルーペウィンドウを有効にする
            [[self loupeWindow] makeKeyAndOrderFront:self];
            //メニューバーより手前に表示
            [loupeWindow setLevel: NSStatusWindowLevel];
            
            //イメージのサイズを取得
            NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:[loupeImage TIFFRepresentation]];
            NSSize size_image = NSMakeSize([imageRep pixelsWide],[imageRep pixelsHigh]);
            
            //画面のサイズを取得
            float screenX = [[NSScreen mainScreen]frame].size.width;
            float screenY = [[NSScreen mainScreen]frame].size.height;
            
            //小さいルーペの場合
            if(app.isLoupe == 1)
            {
                //マウスカーソルを中心にルーペウィンドウを表示
                if(screenX < screenY)
                {
                    [loupeWindow setFrameOrigin:NSMakePoint([NSEvent mouseLocation].x-(screenX/5),[NSEvent mouseLocation].y-(screenX/5))];
                }
                else
                {
                    [loupeWindow setFrameOrigin:NSMakePoint([NSEvent mouseLocation].x-(screenY/5),[NSEvent mouseLocation].y-(screenY/5))];
                }
            }
            
            //左右端
            if(size_image.width < size_image.height)
            {
                //左端
                if((app.imageLeft || app.imageRight || app.imageCenter) && ((0 < cursor_onImage_onField_X) && (cursor_onImage_onField_X < size_image_onField_X/2)))
                {
                    //ルーペ画像を右に寄せる
                    [loupeField setImageAlignment:NSImageAlignRight];
                }
                //右端
                else
                {
                    //ルーペ画像を左に寄せる
                    [loupeField setImageAlignment:NSImageAlignLeft];
                }
            }
            //上下端
            else if(size_image.width > size_image.height)
            {
                //上端
                if(cursor_onImage_onField_Y > size_image_onField_Y/2)
                {
                    //ルーペ画像を下に寄せる
                    [loupeField setImageAlignment:NSImageAlignBottom];
                }
                //下端
                else
                {
                    //ルーペ画像を上に寄せる
                    [loupeField setImageAlignment:NSImageAlignTop];
                }
            }
        }
        //ルーペイメージが正常に取得できなかった場合
        else
        {
            //ルーペウィンドウを無効にする
            [[self loupeWindow] orderOut:self];
        }
    }
}

//カーソルの位置を取得
- (void)trackingMousePoint
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        NSPoint point = [app.imageCenterField convertPoint:[[self viewWindow] convertScreenToBase:[NSEvent mouseLocation]] fromView:nil];
        
        //前回取得時とカーソルの位置が変わっている場合のみ下記の処理を実行
        if(!(app.cursor_onImageCenterField.x == point.x) || !(app.cursor_onImageCenterField.y == point.y))
        {
            //ImageCenterField上でのマウスカーソルの座標を取得
            app.cursor_onImageCenterField = [app.imageCenterField convertPoint:[[self viewWindow] convertScreenToBase:[NSEvent mouseLocation]] fromView:nil];
            //ImageCenterFieldの高さを取得
            float imageCenterFieldY = self.imageCenterField.frame.size.height;
            
            //ルーペが有効でウィンドウがアクティブの場合
            if((app.isLoupe) && [viewWindow isKeyWindow])
            {
                //ルーペを起動
                [self loupe];
            }
            
            //フルスクリーン(〜10.6)中でルーペを使用していない時
            if((viewWindow.frame.size.height == [[NSScreen mainScreen]frame].size.height) && (viewWindow.frame.size.width == [[NSScreen mainScreen]frame].size.width) && app.windowRectBeforeFullscreen.size.width && !app.isLoupe)
            {
                //画面上部にカーソルを持って行ったらメニューバーを表示する
                if((imageCenterFieldY - app.cursor_onImageCenterField.y) < 10)
                {
                    [NSMenu setMenuBarVisible:YES];
                }
                //画面上部からカーソルを外したらメニューバーを隠す
                else
                {
                    [NSMenu setMenuBarVisible:NO];
                }
            }
        }
        //풀스크린시 페이지 번호 표시
        if(![NSMenu menuBarVisible])
        {
            [[pagenumberNext cell] setBezelStyle: NSTextFieldRoundedBezel];
            [pagenumberNext setAlphaValue:0.6];

            [[pagenumberPrev cell] setBezelStyle: NSTextFieldRoundedBezel];
            [pagenumberPrev setAlphaValue:0.6];
            

            //좌우로 긴 이미지일 때
            if (app.yokonaga)
            {
                if(app.hidaribirakiMode)
                {
                    pagenumberPrev.hidden = 0;
                    pagenumberNext.hidden = 1;
                }
                else
                {
                    pagenumberPrev.hidden = 1;
                    pagenumberNext.hidden = 0;
                }
            }
            //아닐 때
            else if((app.onePageMode)&&(!app.hidaribirakiMode))
            {
                pagenumberPrev.hidden = 1;
                pagenumberNext.hidden = 0;
                
            }
            else if((app.onePageMode)&&(app.hidaribirakiMode))
            {
                pagenumberPrev.hidden = 0;
                pagenumberNext.hidden = 1;
            }
            else
            {
                pagenumberPrev.hidden = 0;
                pagenumberNext.hidden = 0;
            }
        }
        else
        {
            //hide pagenumber
            pagenumberPrev.hidden = 1;
            pagenumberNext.hidden = 1;
        }
    }
}

//フルスクリーンならマウスカーソルを隠す
- (void)setHiddenUntilMouseMoves
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        //フルスクリーン時
        if(![NSMenu menuBarVisible])
        {
            [NSCursor setHiddenUntilMouseMoves: YES];
        }
    }
}


//最後のウィンドウを閉じた時、アプリケーションを完全に終了
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication*)theApplication
{
    return YES;
}

//アプリケーション終了時に、
//・key,valueを更新
//・NSNavLastRootDirectory(『開く』で最後に開いた場所),Sparkle関連のデータを削除
//・MangaoによってマウントしたTrueCryptボリュームをすべてアンマウント
- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication*)sender
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    [defaults removeObjectForKey:@"readme"];
    [defaults setObject:@"key:一番目は予約、2番目以降は一度開いたアーカイブ(フォルダも含む)へのフルパスをMD5化したもの value:一番目は(デフォルトで左開きフラグ,デフォルトで1画面フラグ,デフォルトで右回転フラグ,デフォルトで左回転フラグ,予約,予約,予約,文字コード,自動着色,背景色(0:デフォルト、1:白、2:黒))、2番目以降は(最後に開いたページ数,左開きフラグ,1画面フラグ,ページずれフラグ,ブックマークしたページ数のarray(一つもブックマークがない場合はNSNumber:0),予約,予約,予約,予約,予約)" forKey:@"readme"];
    //가장 마지막 파일 패스 plist값을 현재의 파일 패스로 변경
    [defaults removeObjectForKey:@"lastfile"];
    [defaults setObject:[app.fileListFullPathOfArchive objectAtIndex:app.indexOfArchive] forKey:@"lastfile"];
    [defaults removeObjectForKey:@"key"];
    [defaults removeObjectForKey:@"value"];
    [defaults setObject:app.plistKey forKey:@"key"];
    [defaults setObject:app.plistValue forKey:@"value"];
    
    [defaults removeObjectForKey:@"NSNavLastRootDirectory"];
    [defaults removeObjectForKey:@"SULastCheckTime"];
    [defaults removeObjectForKey:@"SUEnableAutomaticChecks"];
    [defaults removeObjectForKey:@"SUAutomaticallyUpdate"];
    [defaults removeObjectForKey:@"SUSendProfileInfo"];
    [defaults removeObjectForKey:@"SUHasLaunchedBefore"];
    [defaults removeObjectForKey:@"SUSkippedVersion"];
    [defaults removeObjectForKey:@"NSWindow Frame SUUpdateAlertFrame"];
    
    //コマンドラインでボリュームをアンマウント
    if([app.mountedTrueCryptVolume count])
    {
        for(int i = 0;i < [app.mountedTrueCryptVolume count];i++)
        {
            NSTask *task = [[NSTask alloc] init];
            [task setLaunchPath:@"/Applications/TrueCrypt.app/Contents/MacOS/TrueCrypt"];
            [task setArguments:[NSArray arrayWithObjects:@"--dismount",@"--force",[app.mountedTrueCryptVolume objectAtIndex:i],nil]];
            [task launch];
        }
    }
    
    return YES;
}

//右クリック、ダブルクリックから開いた時
- (BOOL)application:(NSApplication *)theApplication openFile:(NSString *)filename
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    app.filePath = filename;
    [self open];
    return YES;
}

//NSStringをMD5化したNSStringに変換
- (NSString*)NSString2MD5NSString:(NSString*)string
{
    const char *string_cstr = [string UTF8String];
    unsigned char stringMD5[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string_cstr, (CC_LONG)strlen(string_cstr), stringMD5);
    NSString *result = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",stringMD5[0],stringMD5[1],stringMD5[2],stringMD5[3],stringMD5[4],stringMD5[5],stringMD5[6], stringMD5[7],stringMD5[8],stringMD5[9],stringMD5[10],stringMD5[11],stringMD5[12],stringMD5[13],stringMD5[14],stringMD5[15]];
    
    return result;
}

//画像を取得
- (NSImage*)readImage
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    NSImage *image;
    
    //現在PDFファイルを開いている場合
    if(app.nowOpenPDF)
    {
        PDFPage *page = [PDFArray objectAtIndex:app.index];
        
        NSRect bounds = [page boundsForBox:kPDFDisplayBoxMediaBox];
        float dimension = 1400;
        float scale = 1 > (NSHeight(bounds) / NSWidth(bounds)) ? dimension / NSWidth(bounds) :  dimension / NSHeight(bounds);
        bounds.size = NSMakeSize(bounds.size.width*scale,bounds.size.height*scale);
        
        image = [[[NSImage alloc] initWithSize: bounds.size] autorelease];
        [image lockFocus];
        //高画質補間を行う
        [[NSGraphicsContext currentContext] setImageInterpolation: NSImageInterpolationHigh];
		[[NSColor whiteColor] set];
		NSRectFill(bounds );
		NSAffineTransform * scaleTransform = [NSAffineTransform transform];
		[scaleTransform scaleBy: scale];
		[scaleTransform concat];
		[page drawWithBox: kPDFDisplayBoxMediaBox];
        [image unlockFocus];
    }
    //現在ZIP・RAR・cvbdl・画像フォルダを開いている場合
    else
    {
        image = [app.imageArray objectAtIndex:app.index];
    }
    
    //画像が読めなかった場合
    if(image == NULL)
    {
        image = [NSImage imageNamed:@"CantReadThisImage"];
    }
    
    //画像回転がオンの場合
    if([[[plistValue objectAtIndex:0] objectAtIndex:2] intValue] || [[[plistValue objectAtIndex:0] objectAtIndex:3] intValue])
    {
        //ヨコナガ画像かつPDFではない場合
        CGImageRef image1 = [image CGImageForProposedRect:nil context:nil hints:nil];
        if((CGImageGetWidth(image1) > CGImageGetHeight(image1)))
        {
            //画像の半分のサイズのNSImageを2つ作る
            NSImage *yokonagaImageRight = [[[NSImage alloc] initWithSize:NSMakeSize(CGImageGetWidth(image1)/2,CGImageGetHeight(image1))]autorelease];
            NSImage *yokonagaImageLeft = [[[NSImage alloc] initWithSize:NSMakeSize(CGImageGetWidth(image1)/2,CGImageGetHeight(image1))]autorelease];
            
            //ヨコナガ画像を半分ずつに分ける
            CGImageRef yokonagaImageRefRight = CGImageCreateWithImageInRect(image1,CGRectMake(CGImageGetWidth(image1)/2,0,CGImageGetWidth(image1),CGImageGetHeight(image1)));
            CGImageRef yokonagaImageRefLeft = CGImageCreateWithImageInRect(image1,CGRectMake(0,0,CGImageGetWidth(image1)/2,CGImageGetHeight(image1)));
            
            //半分に分けた画像をNSBitmapImageRepに変換
            NSBitmapImageRep *yokonagaBitmapImageRight = [[NSBitmapImageRep alloc] initWithCGImage:yokonagaImageRefRight];
            NSBitmapImageRep *yokonagaBitmapImageLeft = [[NSBitmapImageRep alloc] initWithCGImage:yokonagaImageRefLeft];
            
            //yokonagaImageRightへの描画を開始
            [yokonagaImageRight lockFocus];
            //yokonagaBitmapImageRightの内容を書き込む
            [yokonagaBitmapImageRight drawInRect:NSMakeRect(0,0,CGImageGetWidth(image1)/2,CGImageGetHeight(image1))];
            //yokonagaImageRightへの描画を終了
            [yokonagaImageRight unlockFocus];
            
            //yokonagaImageLeftへの描画を開始
            [yokonagaImageLeft lockFocus];
            //yokonagaBitmapImageLeftの内容を書き込む
            [yokonagaBitmapImageLeft drawInRect:NSMakeRect(0,0,CGImageGetWidth(image1)/2,CGImageGetHeight(image1))];
            //yokonagaImageLeftへの描画を終了
            [yokonagaImageLeft unlockFocus];
            
            //PDFの場合
            if(app.nowOpenPDF)
            {
                //NSImageをPDFPageに変換
                PDFPage *yokonagaImageRightPDFPage = [[PDFPage alloc] initWithImage:yokonagaImageRight];
                PDFPage *yokonagaImageLeftPDFPage = [[PDFPage alloc] initWithImage:yokonagaImageLeft];
                
                //元のヨコナガ画像をPDFリストから削除
                [app.PDFArray removeObjectAtIndex:app.index];
                //分割した画像をPDFリストに追加
                [app.PDFArray insertObject:yokonagaImageRightPDFPage atIndex:app.index];
                [app.PDFArray insertObject:yokonagaImageLeftPDFPage atIndex:app.index+1];
            }
            else
            {
                //元のヨコナガ画像を画像リストから削除
                [app.imageArray removeObjectAtIndex:app.index];
                //分割した画像を画像リストに追加
                [app.imageArray insertObject:yokonagaImageRight atIndex:app.index];
                [app.imageArray insertObject:yokonagaImageLeft atIndex:app.index+1];
            }
            //結果的にページ数が1増えるのでlistSizeを1増やす
            app.listSize++;
            
            image = yokonagaImageRight;
        }
        
        //NSBitmapImageRepに変換
        NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:[image TIFFRepresentation]];
        //現在の画像のサイズを取得
        NSSize nowSize = NSMakeSize([imageRep pixelsWide],[imageRep pixelsHigh]);
        //新しい画像のサイズを作成
        NSSize newSize = NSMakeSize(nowSize.height,nowSize.width);
        //新しい画像を作成
        NSImage *newImage = [[[NSImage alloc] initWithSize:newSize] autorelease];
        
        [newImage lockFocus];
        NSAffineTransform *transform = [NSAffineTransform transform];
        //中心点を取得
        NSPoint centerPoint = NSMakePoint(newSize.width/2,newSize.height/2);
        //中心点を原点に移動
        [transform translateXBy:centerPoint.x yBy:centerPoint.y];
        //右回転
        if([[[plistValue objectAtIndex:0] objectAtIndex:2] intValue])
        {
            [transform rotateByDegrees:-90];
        }
        //左回転
        else
        {
            [transform rotateByDegrees:90];
        }
        //中心点を元に戻す
        [transform translateXBy:-centerPoint.y yBy:-centerPoint.x];
        //NSAffineTransformをnewImageに適用
        [transform concat];
        //NSBitmapImageRepを書き込む
        [imageRep drawInRect:NSMakeRect(0,0,newSize.height,newSize.width)];
        [newImage unlockFocus];
        
        //回転された画像をimageに入れる
        image = newImage;
    }
    
    //이펙트 판별
    int EffectNumber = [[[plistValue objectAtIndex:0] objectAtIndex:8] intValue];
    //NSLog(@"plistvalue of temp: %d", EffectNumber);
    
    if(EffectNumber == 1)
    {
        //自動着色がオンの場合
        //ユーザーがカラーマップを用意している場合
        if([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/.mangao/4color4.png",NSHomeDirectory()]])
        {
            image = [HTMangaColorize colorizeImage:image withMapImage:[[NSImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/.mangao/4color4.png",NSHomeDirectory()]] skipColoredSource:YES];
        }
        //ユーザーがカラーマップを用意していない場合
        else
        {
            image = [HTMangaColorize colorizeImage:image withMapImage:[NSImage imageNamed:@"4color4"] skipColoredSource:YES];
        }
    }
    else if(EffectNumber == 2)
    {
        //자동 화질 보정
        image = [AutoEnhance AutoEnhanceImage:image];
    }
    else if(EffectNumber == 3)
    {
        //세피아톤
        image = [SepiaTone SepiaTone:image];
    }

    //그레이스케일
    else if(EffectNumber == 4)
    {
        image = [Grayscale Grayscale:image];
    }

    //밝기 및 콘트라스트 판별
    float BrightnessValue = [[[plistValue objectAtIndex:0] objectAtIndex:10] floatValue];
    float ContrastValue = [[[plistValue objectAtIndex:0] objectAtIndex:11] floatValue];
    //NSLog(@"Brightness:%f", BrightnessValue);
    //NSLog(@"contrast:%f", ContrastValue);

    if (!((BrightnessValue == 0.0)&&(ContrastValue == 1.0)))
    {
        image = [BrightnessAndContrast BrightnessAndContrast:image Brightness:&BrightnessValue Contrast:&ContrastValue];
    }

    //ヨコナガ画像判定
    CGImageRef image1 = [image CGImageForProposedRect:nil context:nil hints:nil];
    if(CGImageGetWidth(image1) > CGImageGetHeight(image1))
    {
        app.yokonaga = 1;
    }
    else
    {
        app.yokonaga = 0;
    }
/*
    [image lockFocus];
    NSRect imageBounds = {NSZeroPoint, [image size]};
    [[NSGraphicsContext
      currentContext] setImageInterpolation:NSImageInterpolationHigh];
    [image drawInRect:imageBounds fromRect:NSZeroRect operation:NSCompositeCopy fraction:1.0];
    [image unlockFocus];
*/
    //CGImageRef imageFinal = [image CGImageForProposedRect:nil context:nil hints:nil];
    //NSBitmapImageRep *finalRep = [[NSBitmapImageRep alloc] initWithCGImage:imageFinal];

/*
    NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:[image TIFFRepresentation]];
    NSSize nowSize = NSMakeSize([imageRep pixelsWide],[imageRep pixelsHigh]);
    NSImage *finalImage = [[[NSImage alloc] initWithSize:nowSize] autorelease];
    NSRect targetFrame = NSMakeRect(0, 0, nowSize.width, nowSize.height);
    [finalImage lockFocus];
    [[NSGraphicsContext currentContext] setImageInterpolation: NSImageInterpolationHigh];
    [imageRep drawInRect:targetFrame
                fromRect:NSZeroRect       //portion of source image to draw
               operation:NSCompositeCopy  //compositing operation
                fraction:1.0              //alpha (transparency) value
          respectFlipped:YES              //coordinate system
                   hints:@{NSImageHintInterpolation:
                               [NSNumber numberWithInt:NSImageInterpolationHigh]}];
    [finalImage unlockFocus];
    image = finalImage;
<<<<<<< HEAD
    */
    
    /*    NSRect leftframe = [imageLeftField frame];
     NSLog(@"left frame width:%f", leftframe.size.width);
     NSLog(@"left frame width:%f", leftframe.size.height);
     
     NSRect rightframe = [imageRightField frame];
     NSLog(@"right frame width:%f", rightframe.size.width);
     NSLog(@"right frame width:%f", rightframe.size.height);
     */
     
=======
*/
 
>>>>>>> 590c66b8d80ef2e376ce1fabba82c74bde2ff8be
    return image;
}

//CをCantOpen
- (void)CwoCantOpen
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    app.imageCenter = [NSImage imageNamed:@"CantOpenThisArchive"];
    [self CniSet];
    
    app.index = 0;
    app.listSize = 0;
    //ウィンドウタイトルを現在開いている『アーカイブ名 現在のページ/総ページ』にする
    [self setWindowTitle];
    //ブックマークメニューを空にする
    [self bookmarkMenuClear];
}

//CをThisArchive
- (void)CwoThisArchive
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    app.imageCenter = [NSImage imageNamed:@"ThisArchiveHasNoImage"];
    [self CniSet];
    
    app.index = 0;
    app.listSize = 0;
    //ウィンドウタイトルを現在開いている『アーカイブ名 現在のページ/総ページ』にする
    [self setWindowTitle];
    //ブックマークメニューを空にする
    [self bookmarkMenuClear];
}

//イメージフィールドをリセット
- (void)imageFieldReset
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    app.imageRight = NULL;
    app.imageLeft = NULL;
    app.imageCenter = NULL;
    
    [self RniSet];
    [self LniSet];
    [self CniSet];
}

//Lにセット
- (void)LniSet
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    [imageLeftFieldxxx setImage:app.imageLeft];
}

//Rにセット
- (void)RniSet
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    [imageRightFieldxxx setImage:app.imageRight];
}

//Cにセット
- (void)CniSet
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    [imageCenterField setImage:app.imageCenter];
}

//開くメニュー
- (void)openMenu
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        //ルーペを無効化
        app.isLoupe = 0;
        //ルーペウィンドウを無効にする
        [[self loupeWindow] orderOut:self];
        //マウスカーソルを表示する
        [NSCursor unhide];
        
        NSOpenPanel *openPanel = [NSOpenPanel openPanel];
        
        //許可するファイル拡張子を設定
        NSArray *allowedFileTypes = [NSArray arrayWithObjects:@"jpg",@"jpeg",@"png",@"gif",@"bmp",@"tif",@"tiff",@"zip",@"cbz",@"rar",@"cbr",@"pdf",@"cvbdl",@"tc",@"cbtc",nil];
        [openPanel setAllowedFileTypes:allowedFileTypes];
        
        //フォルダを選択可能にする
        [openPanel setCanChooseDirectories:YES];
        
        NSInteger OK = [openPanel runModal];
        
        if(OK == NSOKButton)
        {
            NSURL *URL = [openPanel URL];
            app.filePath = [URL path];
            [self open];
        }
        else
        {
            return;
        }
    }
}

//가장 마지막에 열었던 파일 열기
- (void)openLastFile
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    NSLog(@"lastfile:%@", app.lastfile);

    //가장 마지막 파일 패스가 있는지 확인
    if (app.lastfile) {
        //サムネイル一覧を実行中ではない場合
        if(!app.isThumbnail)
        {
            //ルーペを無効化
            app.isLoupe = 0;
            //ルーペウィンドウを無効にする
            [[self loupeWindow] orderOut:self];
            //マウスカーソルを表示する
            [NSCursor unhide];
        
            //최근 파일 열기
            app.filePath = app.lastfile;
            [self open];
        }
        else
        {
            return;
        }
    }
}

//開いた時
- (void)open
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];

    app.folderPath = [app.filePath stringByDeletingLastPathComponent];
    //NSLog(@"currentfile:%@", app.filePath);
    
    //選択したのがTrueCryptボリュームの場合
    if([app.filePath hasSuffix:@".tc"] || [app.filePath hasSuffix:@".cbtc"] || [app.filePath hasSuffix:@".TC"] || [app.filePath hasSuffix:@".CBTC"])
    {
        //TrueCryptがインストールされている場合
        if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/TrueCrypt.app"])
        {
            //1つ目のボリュームの場合
            if(!app.mountedTrueCryptVolume)
            {
                //mountedTrueCryptVolumeを初期化
                app.mountedTrueCryptVolume = [NSMutableArray array];
            }
            //マウントしたファイル一覧に追加する
            [app.mountedTrueCryptVolume addObject:app.filePath];
            
            //コマンドラインでボリュームをマウント
            NSTask *task = [[NSTask alloc] init];
            [task setLaunchPath:@"/Applications/TrueCrypt.app/Contents/MacOS/TrueCrypt"];
            [task setArguments:[NSArray arrayWithObjects:@"--explore",app.filePath,nil]];
            [task launch];
        }
        //TrueCryptがインストールされていない場合
        else
        {
            app.imageCenter = [NSImage imageNamed:@"PleaseInstallTrueCrypt"];
            [self CniSet];
            
            app.index = 0;
            app.listSize = 0;
            //ウィンドウタイトルを『mangao ver.x.x.x』にする
            [self resetWindowTitle];
            //ブックマークメニューを空にする
            [self bookmarkMenuClear];
        }
    }
    //選択したのがアーカイブ・画像ファイル・フォルダの場合
    else
    {
        //選択したのが画像ファイルの場合
        if([app.filePath hasSuffix:@".jpg"] || [app.filePath hasSuffix:@".jpeg"] || [app.filePath hasSuffix:@".png"] || [app.filePath hasSuffix:@".gif"] || [app.filePath hasSuffix:@".bmp"] || [app.filePath hasSuffix:@".tif"] || [app.filePath hasSuffix:@".tiff"] || [app.filePath hasSuffix:@".JPG"] || [app.filePath hasSuffix:@".JPEG"] || [app.filePath hasSuffix:@".PNG"] || [app.filePath hasSuffix:@".GIF"] || [app.filePath hasSuffix:@".BMP"] || [app.filePath hasSuffix:@".TIF"] || [app.filePath hasSuffix:@".TIFF"])
        {
            //folderPathを選択した画像を含むフォルダを含むフォルダにする
            app.folderPath = [app.folderPath stringByDeletingLastPathComponent];
        }
        
        //選択したファイルと同ディレクトリ内のファイル・フォルダリストを取得
        NSArray *fileList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:app.folderPath error:nil];
        
        //アーカイブ及びフォルダのリストにする
        NSMutableArray *allowedArray = [NSMutableArray array];
        for(NSString *string in fileList)
        {
            //アーカイブの場合
            if([string hasSuffix:@".zip"] || [string hasSuffix:@".cbz"] || [string hasSuffix:@".rar"] || [string hasSuffix:@".cbr"] || [string hasSuffix:@".pdf"] || [string hasSuffix:@".cvbdl"] || [string hasSuffix:@".ZIP"] || [string hasSuffix:@".CBZ"] || [string hasSuffix:@".RAR"] || [string hasSuffix:@".CBR"] || [string hasSuffix:@".PDF"] || [string hasSuffix:@".CVBDL"])
            {
                //ファイルリストに追加する
                [allowedArray addObject:string];
            }
            //アーカイブ以外の場合
            else
            {
                //フルパスに変換
                NSString *fullPathString = [app.folderPath stringByAppendingPathComponent:string];
                
                BOOL isDirectory;
                
                //フォルダの場合
                if ([[NSFileManager defaultManager]fileExistsAtPath:fullPathString isDirectory:&isDirectory] && isDirectory)
                {
                    //ファイルリストに追加する
                    [allowedArray addObject:string];
                }
            }
        }
        
        //数値順でソート
        NSArray *sortedArray = [allowedArray sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
        
        //選択したのが画像ファイルの場合
        if([app.filePath hasSuffix:@".jpg"] || [app.filePath hasSuffix:@".jpeg"] || [app.filePath hasSuffix:@".png"] || [app.filePath hasSuffix:@".gif"] || [app.filePath hasSuffix:@".bmp"] || [app.filePath hasSuffix:@".tif"] || [app.filePath hasSuffix:@".tiff"] || [app.filePath hasSuffix:@".JPG"] || [app.filePath hasSuffix:@".JPEG"] || [app.filePath hasSuffix:@".PNG"] || [app.filePath hasSuffix:@".GIF"] || [app.filePath hasSuffix:@".BMP"] || [app.filePath hasSuffix:@".TIF"] || [app.filePath hasSuffix:@".TIFF"])
        {
            //選択した画像を含むフォルダがディレクトリ内で何番目のフォルダか取得(多重配列になる前に取得)
            app.indexOfArchive = [sortedArray indexOfObject:[[app.filePath stringByDeletingLastPathComponent] lastPathComponent]];
        }
        //選択したのがアーカイブ・フォルダの場合
        else
        {
            //選択したアーカイブ・フォルダがディレクトリ内で何番目のアーカイブか取得(多重配列になる前に取得)
            app.indexOfArchive = [sortedArray indexOfObject:[app.filePath lastPathComponent]];
        }
        
        //ディレクトリ内の要素数を取得
        app.listSizeOfArchive = [sortedArray count];
        
        //フルパスのリストに変換
        app.fileListFullPathOfArchive = [NSMutableArray array];
        for(NSString *string in sortedArray)
        {
            NSString *fullPath = [app.folderPath stringByAppendingPathComponent:string];
            
            [app.fileListFullPathOfArchive addObject:fullPath];
        }
        [self archiveOpen];
        [[NSDocumentController sharedDocumentController] noteNewRecentDocumentURL: [NSURL fileURLWithPath: app.filePath]];
    }
}

- (void)archiveOpen
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    app.nowOpenZIP = 0;
    app.nowOpenRAR = 0;
    app.nowOpenPDF = 0;
    app.nowOpenCvbdl = 0;
    app.nowOpenImageFolder = 0;
    
    [self imageFieldReset];
    
    //選択したアーカイブのフルパスをMD5に変換
    NSString *fullPathMD5 = [self NSString2MD5NSString:[app.fileListFullPathOfArchive objectAtIndex:app.indexOfArchive]];
<<<<<<< HEAD

    //Full Path 비교
    //NSString *fullPathMD5 = [app.fileListFullPathOfArchive objectAtIndex:app.indexOfArchive];

=======
    
>>>>>>> 590c66b8d80ef2e376ce1fabba82c74bde2ff8be
    //keyの中で何番目か検索
    app.plistKeyIndex = [plistKey indexOfObject:fullPathMD5];
    
    //未書き込みの場合
    if(app.plistKeyIndex == NSNotFound)
    {
        //keyにMD5化したフルパスを追加
        //valueに(index,左開きフラグ,1画面フラグ,ページずれフラグ,ブックマーク,予約,予約,予約,予約,予約)を追加
        [plistKey addObject:fullPathMD5];
        [plistValue addObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],nil]];
        
        //再度keyの中で何番目か検索
        app.plistKeyIndex = [plistKey indexOfObject:fullPathMD5];
        
        //indexを0にセット
        app.index = 0;
        //左開きフラグを0にセット
        app.hidaribirakiMode = 0;
        //1画面フラグを0にセット
        app.onePageMode = 0;
    }
    else
    {
        //indexを最後に表示したページにセット(NSNumberからintに変換)
        app.index = [[[plistValue objectAtIndex:plistKeyIndex] objectAtIndex:0]intValue];
        //左開きフラグを確認
        app.hidaribirakiMode = [[[plistValue objectAtIndex:plistKeyIndex] objectAtIndex:1]intValue];
        //1画面フラグを確認
        app.onePageMode = [[[plistValue objectAtIndex:plistKeyIndex] objectAtIndex:2]intValue];
    }
    
    //ブックマークメニューを再読込する
    [self bookmarkMenuReload];
    //左開きの場合(『デフォルトで左開き』を考慮)
    if(abs(app.hidaribirakiMode - [[[plistValue objectAtIndex:0] objectAtIndex:0] intValue]))
    {
        [self goPageMenuReload:1];
    }
    //右開きの場合
    else
    {
        [self goPageMenuReload:0];
    }
    
    //選択したのがZIP・CBZファイルの場合
    if([app.filePath hasSuffix:@".zip"] || [app.filePath hasSuffix:@".cbz"] || [app.filePath hasSuffix:@".ZIP"] || [app.filePath hasSuffix:@".CBZ"])
    {
        app.nowOpenZIP = 1;
        
        [self ZIP_RAR:0];
    }
    //選択したのがRAR・CBRファイルの場合
    else if([app.filePath hasSuffix:@".rar"] || [app.filePath hasSuffix:@".cbr"] || [app.filePath hasSuffix:@".RAR"] || [app.filePath hasSuffix:@".CBR"])
    {
        app.nowOpenRAR = 1;
        
        [self ZIP_RAR:1];
    }
    //選択したのがPDFファイルの場合
    else if([app.filePath hasSuffix:@".pdf"] || [app.filePath hasSuffix:@".PDF"])
    {
        app.nowOpenPDF = 1;
        
        [self PDFFile];
    }
    //選択したのがcvbdlフォルダの場合
    else if([app.filePath hasSuffix:@".cvbdl"] || [app.filePath hasSuffix:@".CVBDL"])
    {
        app.nowOpenCvbdl = 1;
        
        app.folderPath = [app.fileListFullPathOfArchive objectAtIndex:app.indexOfArchive];
        
        [self imageFolder];
    }
    //選択したのが画像ファイルの場合
    else if([app.filePath hasSuffix:@".jpg"] || [app.filePath hasSuffix:@".jpeg"] || [app.filePath hasSuffix:@".png"] || [app.filePath hasSuffix:@".gif"] || [app.filePath hasSuffix:@".bmp"] || [app.filePath hasSuffix:@".tif"] || [app.filePath hasSuffix:@".tiff"] || [app.filePath hasSuffix:@".JPG"] || [app.filePath hasSuffix:@".JPEG"] || [app.filePath hasSuffix:@".PNG"] || [app.filePath hasSuffix:@".GIF"] || [app.filePath hasSuffix:@".BMP"] || [app.filePath hasSuffix:@".TIF"] || [app.filePath hasSuffix:@".TIFF"])
    {
        app.nowOpenImageFolder = 1;
        
        app.folderPath = [app.fileListFullPathOfArchive objectAtIndex:app.indexOfArchive];
        
        [self imageFile:app.filePath];
        
        //archiveDelete時にfilePathを利用するので親フォルダを入れておく
        app.filePath = app.folderPath;
    }
    //選択したのがフォルダの場合
    else
    {
        app.nowOpenImageFolder = 1;
        
        app.folderPath = [app.fileListFullPathOfArchive objectAtIndex:app.indexOfArchive];
        
        [self imageFolder];
    }
}

//ZIP・RAR
//witchが0ならZIP、1ならRAR
- (void)ZIP_RAR:(int)witch
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];

    //アーカイブを開く
    ZipFile *zipFile = nil;
    RarFile *rarFile = nil;
    if(!witch)
    {
        zipFile = [[[ZipFile alloc] initWithFileAtPath:[app.fileListFullPathOfArchive objectAtIndex:app.indexOfArchive]] autorelease];
    }
    else
    {
        rarFile = [[[RarFile alloc] initWithFileAtPath:[app.fileListFullPathOfArchive objectAtIndex:app.indexOfArchive]] autorelease];
    }
    
    //アーカイブが開けなかった場合(これがないとエラー)
    if (![zipFile open] && ![rarFile open])
    {
        [self CwoCantOpen];
    }
    else
    {
        //アーカイブ内のファイルのリストを作る
        NSArray *fileList;
        if(!witch)
        {
            fileList = [zipFile fileNames:[[[plistValue objectAtIndex:0] objectAtIndex:7]intValue]];
        }
        else
        {
            fileList = [rarFile fileNames];
        }
        
        //許可した種類の画像のみのリストにする
        NSArray *allowedFileList = [fileList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"pathExtension IN %@",app.imageFileType]];
        
        //リソースフォークを取り除く
        //ZIP内のファイルへのフルパスはfogefoge.zipなら、"fogefoge/001.jpg"となるのでfolderPathをaddしない
        NSArray *array = [allowedFileList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"not self BEGINSWITH '__MACOSX'"]];
        
        //数値順でソート
        NSArray *sortedArray1 = [array sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
        
        //ディレクトリ内の要素数を取得
        app.listSize = [sortedArray1 count];
        
        //アーカイブ内の画像をapp.imageArrayに入れる
        app.imageArray = [NSMutableArray array];
        //ZIP
        if(!witch)
        {
            for(NSString *string in sortedArray1)
            {
                NSImage *image = [[[NSImage alloc] initWithData:[zipFile readWithFileName:string  maxLength:10000 * 10000 characterEncoding:[[[plistValue objectAtIndex:0] objectAtIndex:7]intValue]]] autorelease];
                //画像が読めなかった場合
                if(image == NULL)
                {
                    image = [NSImage imageNamed:@"CantReadThisImage"];
                }
                [app.imageArray addObject:image];
            }
        }
        //RAR
        else
        {
            for(NSString *string in sortedArray1)
            {
                NSImage *image = [[[NSImage alloc] initWithData:[rarFile readWithFileName:string  maxLength:10000 * 10000]] autorelease];
                //画像が読めなかった場合
                if(image == NULL)
                {
                    image = [NSImage imageNamed:@"CantReadThisImage"];
                }
                [app.imageArray addObject:image];
            }
        }
        
        //アーカイブが空の場合
        if(!app.listSize)
        {
            [self CwoThisArchive];
        }
        else
        {
            [self setImage];
        }
        
        //アーカイブを閉じる
        if(!witch)
        {
            [zipFile close];
        }
        else
        {
            [rarFile close];
        }
    }
}

//PDF
- (void)PDFFile
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //PDFへのパスをNSURLに変換
    NSURL *url = [NSURL fileURLWithPath: [app.fileListFullPathOfArchive objectAtIndex:app.indexOfArchive]];
    //NSURLからPDFを読み込み
    PDFDocument *pdf = [[PDFDocument alloc] initWithURL:url];
    
    //PDFファイルが開けなかった場合
    if (!pdf)
    {
        [self CwoCantOpen];
    }
    //PDFファイルが開けた場合
    else
    {
        //PDF内の要素数を取得
        app.listSize = [pdf pageCount];
        
        //PDFファイルが空の場合
        if(!app.listSize)
        {
            [self CwoThisArchive];
        }
        //PDFファイルが空ではない場合
        else
        {
            app.PDFArray = [NSMutableArray array];
            
            for(int i=0; i < app.listSize; i++)
            {
                //指定ページのPDFを読み込む
                PDFPage *page = [pdf pageAtIndex:i];
                
                [app.PDFArray addObject:page];
            }
            [self setImage];
        }
    }
}

//画像ファイル
- (void)imageFile:(NSString*)imageFilePath
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //フォルダ以下のすべてのファイルリストを取得
    NSMutableArray *fileList = [NSMutableArray array];
    NSDirectoryEnumerator *directoryEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:app.folderPath];
    NSString *string;
    while(string = [directoryEnumerator nextObject])
    {
        [fileList addObject:string];
    }
    
    //許可した種類の画像のみのリストにする
    NSArray *allowedFileList = [fileList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"pathExtension IN %@",app.imageFileType]];
    
    //数値順でソート
    NSArray *sortedArray1 = [allowedFileList sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
    
    //ディレクトリ内の要素数を取得
    app.listSize = [sortedArray1 count];
    
    //選択したファイルがディレクトリ内で何番目か取得
    app.index = [sortedArray1 indexOfObject:[imageFilePath lastPathComponent]];
    
    //ディレクトリ内の画像をapp.imageArrayに入れる
    app.ImageArray = [NSMutableArray array];
    for(NSString *string in sortedArray1)
    {
        NSImage *image = [[NSImage alloc] initWithContentsOfFile:[app.folderPath stringByAppendingPathComponent:string]];
        //画像が読めなかった場合
        if(image == NULL)
        {
            image = [NSImage imageNamed:@"CantReadThisImage"];
        }
        [app.imageArray addObject:image];
    }
    
    //フォルダが空の場合
    if(!app.listSize)
    {
        [self CwoThisArchive];
    }
    else
    {
        [self setImage];
    }
}

//フォルダ・cvbdl
- (void)imageFolder
{
    //別スレッドでフォルダ以下の全画像ファイル取得を実行
    [self performSelectorInBackground:@selector(loadImageFolder) withObject:nil];
}

//フォルダ・cvbdl
- (void)loadImageFolder
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    app.imageArray = [NSMutableArray array];
    
    //フォルダ以下のすべてのファイルリストを取得
    NSMutableArray *fileList = [NSMutableArray array];
    NSDirectoryEnumerator *directoryEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:app.folderPath];
    NSString *string;
    while(string = [directoryEnumerator nextObject])
    {
        [fileList addObject:[app.folderPath stringByAppendingPathComponent:string]];
    }
    
    //数値順でソート
    NSArray *sortedfileList = [fileList sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
    
    for(NSString *string in sortedfileList)
    {
        //画像ファイルの場合
        if([string hasSuffix:@".jpg"] || [string hasSuffix:@".jpeg"] || [string hasSuffix:@".png"] || [string hasSuffix:@".gif"] || [string hasSuffix:@".bmp"] || [string hasSuffix:@".tif"] || [string hasSuffix:@".tiff"] || [string hasSuffix:@".JPG"] || [string hasSuffix:@".JPEG"] || [string hasSuffix:@".PNG"] || [string hasSuffix:@".GIF"] || [string hasSuffix:@".BMP"] || [string hasSuffix:@".TIF"] || [string hasSuffix:@".TIFF"])
        {
            //app.imageArrayに追加
            NSImage *image = [[NSImage alloc] initWithContentsOfFile:string];
            //画像が読めなかった場合
            if(image == NULL)
            {
                image = [NSImage imageNamed:@"CantReadThisImage"];
            }
            [app.imageArray addObject:image];
        }
        //ZIP・RARの場合
        else if([string hasSuffix:@".zip"] || [string hasSuffix:@".cbz"] || [string hasSuffix:@".ZIP"] || [string hasSuffix:@".CBZ"] || [string hasSuffix:@".rar"] || [string hasSuffix:@".cbr"] || [string hasSuffix:@".RAR"] || [string hasSuffix:@".CBR"])
        {
            int witch;
            
            //ZIP
            if([string hasSuffix:@".zip"] || [string hasSuffix:@".cbz"] || [string hasSuffix:@".ZIP"] || [string hasSuffix:@".CBZ"])
            {
                witch = 0;
            }
            //RAR
            else
            {
                witch = 1;
            }
            
            //アーカイブを開く
            ZipFile *zipFile = nil;
            RarFile *rarFile = nil;
            if(!witch)
            {
                zipFile = [[[ZipFile alloc] initWithFileAtPath:string] autorelease];
            }
            else
            {
                rarFile = [[[RarFile alloc] initWithFileAtPath:string] autorelease];
            }
            
            //アーカイブが開けなかった場合(これがないとエラー)
            if (![zipFile open] && ![rarFile open])
            {
                [self CwoCantOpen];
            }
            else
            {
                //アーカイブ内のファイルのリストを作る
                NSArray *fileList;
                if(!witch)
                {
                    fileList = [zipFile fileNames:[[[plistValue objectAtIndex:0] objectAtIndex:7]intValue]];
                }
                else
                {
                    fileList = [rarFile fileNames];
                }
                
                //許可した種類の画像のみのリストにする
                NSArray *allowedFileList = [fileList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"pathExtension IN %@",app.imageFileType]];
                
                //リソースフォークを取り除く
                //ZIP内のファイルへのフルパスはfogefoge.zipなら、"fogefoge/001.jpg"となるのでfolderPathをaddしない
                NSArray *array = [allowedFileList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"not self BEGINSWITH '__MACOSX'"]];
                
                //数値順でソート
                NSArray *sortedArray1 = [array sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
                
                //ディレクトリ内の要素数を取得
                app.listSize = [sortedArray1 count];
                
                //アーカイブ内の画像をapp.imageArrayに入れる
                //ZIP
                if(!witch)
                {
                    for(NSString *string in sortedArray1)
                    {
                        NSImage *image = [[[NSImage alloc] initWithData:[zipFile readWithFileName:string  maxLength:10000 * 10000 characterEncoding:[[[plistValue objectAtIndex:0] objectAtIndex:7]intValue]]] autorelease];
                        //画像が読めなかった場合
                        if(image == NULL)
                        {
                            image = [NSImage imageNamed:@"CantReadThisImage"];
                        }
                        [app.imageArray addObject:image];
                    }
                }
                //RAR
                else
                {
                    for(NSString *string in sortedArray1)
                    {
                        NSImage *image = [[[NSImage alloc] initWithData:[rarFile readWithFileName:string  maxLength:10000 * 10000]] autorelease];
                        //画像が読めなかった場合
                        if(image == NULL)
                        {
                            image = [NSImage imageNamed:@"CantReadThisImage"];
                        }
                        [app.imageArray addObject:image];
                    }
                }
                
                //アーカイブを閉じる
                if(!witch)
                {
                    [zipFile close];
                }
                else
                {
                    [rarFile close];
                }
            }
        }
    }
    
    //要素数を取得
    app.listSize = [app.imageArray count];
    
    //フォルダが空の場合
    if(!app.listSize)
    {
        [self CwoThisArchive];
    }
    else
    {
        [self setImage];
    }
}

//現在のindexの画像をフィールドにセットする
- (void)setImage
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    [self imageFieldReset];
    
    //左開きフラグが立っている場合(『デフォルトで左開き』を考慮)
    if(abs(app.hidaribirakiMode - [[[plistValue objectAtIndex:0] objectAtIndex:0] intValue]))
    {
        imageLeftFieldxxx = imageRightField;
        imageRightFieldxxx = imageLeftField;
    }
    else
    {
        imageLeftFieldxxx = imageLeftField;
        imageRightFieldxxx = imageRightField;
    }
    
    //最後に表示したページが範囲外の場合(アーカイブ内のファイルが削除された場合の対策)
    if(app.index > app.listSize)
    {
        app.index = 0;
    }
    //最後に表示した状態が、空+最後のページではない場合
    if(app.index != app.listSize)
    {
        //1画面モードの場合(『デフォルトで1画面』を考慮)
        if(abs(app.onePageMode - [[[plistValue objectAtIndex:0] objectAtIndex:1] intValue]))
        {
            app.imageCenter = [self readImage];
            [self CniSet];
            
            goto end;
        }
        //2画面モード
        else
        {
            app.imageLeft = [self readImage];
            
            //ヨコナガ画像の場合
            if(app.yokonaga)
            {
                app.imageCenter = app.imageLeft;
                app.imageLeft = NULL;
                [self CniSet];
                
                goto end;
            }
            [self LniSet];
        }
    }
    //最後に表示したページが1ページ目ではない場合
    if(app.index)
    {
        app.index--;
        app.imageRight = [self readImage];
        
        //ヨコナガ画像の場合
        if(app.yokonaga)
        {
            //最後に表示した状態が左側にタテナガかつ最後のページで画像回転がオンの場合の対策
            if(app.imageLeft)
            {
                app.imageRight = NULL;
            }
            else
            {
                app.imageCenter = app.imageRight;
                app.imageRight = NULL;
                [self CniSet];
                
                goto end;
            }
        }
        [self RniSet];
        app.index++;
    }
    
end://左側の画像のIndexを最後に表示した画像として記録する
    [[plistValue objectAtIndex:plistKeyIndex] replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:app.index]];
    
    //ウィンドウタイトルを現在開いている『アーカイブ名 現在のページ/総ページ』にする
    [self setWindowTitle];
}

//前のページ
- (void)pagePrev
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        //表示中のファイルが1・2ページ目ではない、もしくは表示中のファイルが1ページ目かつRがNULLの場合
        if((app.index > 1) || ((app.index == 1) && (app.imageRight == NULL)))
        {
            [self imageFieldReset];
            
            //1画面モードの場合(『デフォルトで1画面』を考慮)
            if(abs(app.onePageMode - [[[plistValue objectAtIndex:0] objectAtIndex:1] intValue]))
            {
                app.index--;
                app.imageCenter = [self readImage];
                [self CniSet];
            }
            //2画面モード
            else
            {
                //現在ヨコナガ画像を表示中の場合
                if(app.yokonaga)
                {
                    app.index--;
                    app.imageLeft = [self readImage];
                    //ヨコナガ画像の場合
                    if(app.yokonaga)
                    {
                        app.imageCenter = app.imageLeft;
                        [self CniSet];
                    }
                    //タテナガ画像の場合
                    else
                    {
                        [self LniSet];
                        //Lのファイルが最初ではない場合
                        if(app.index)
                        {
                            app.index--;
                            app.imageRight = [self readImage];
                            app.index++;
                            
                            //ヨコナガ画像の場合
                            if(app.yokonaga)
                            {
                                app.imageRight = NULL;
                            }
                            [self RniSet];
                        }
                    }
                }
                else
                {
                    app.index--;
                    app.imageRight = [self readImage];
                    
                    //ヨコナガ画像の場合
                    if(app.yokonaga)
                    {
                        app.imageCenter = app.imageRight;
                        [self CniSet];
                    }
                    //タテナガ画像の場合
                    else
                    {
                        app.imageRight = NULL;
                        
                        //Rのファイルが最初ではない場合
                        if(app.index)
                        {
                            app.index--;
                            app.imageLeft = [self readImage];
                            
                            //ヨコナガ画像の場合
                            if(app.yokonaga)
                            {
                                app.imageCenter = app.imageLeft;
                                app.imageLeft = NULL;
                                [self CniSet];
                            }
                            //タテナガ画像の場合
                            else
                            {
                                [self LniSet];
                                
                                //Lのファイルが最初ではない場合
                                if(app.index)
                                {
                                    app.index--;
                                    app.imageRight = [self readImage];
                                    
                                    //ヨコナガ画像の場合
                                    if(app.yokonaga)
                                    {
                                        app.imageRight = NULL;
                                    }
                                    //タテナガ画像の場合
                                    else
                                    {
                                        [self RniSet];
                                    }
                                    app.index++;
                                }
                                //Lのファイルが最初の場合
                                else
                                {
                                    app.imageRight = NULL;
                                }
                            }
                        }
                        //Rのファイルが最初の場合
                        else
                        {
                            app.index++;
                        }
                    }
                }
            }
            
            //左側の画像のIndexを最後に表示した画像として記録する
            [[plistValue objectAtIndex:plistKeyIndex] replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:app.index]];
            
            //ウィンドウタイトルを現在開いている『アーカイブ名 現在のページ/総ページ』にする
            [self setWindowTitle];
        }
    }
}

//次のページ
- (void)pageNext
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        //表示中のファイルが最後ではない場合
        if(app.index < app.listSize-1)
        {
            [self imageFieldReset];
            
            //1画面モードの場合(『デフォルトで1画面』を考慮)
            if(abs(app.onePageMode - [[[plistValue objectAtIndex:0] objectAtIndex:1] intValue]))
            {
                app.index++;
                app.imageCenter = [self readImage];
                [self CniSet];
            }
            //2画面モード
            else
            {
                app.index++;
                app.imageRight = [self readImage];
                
                //ヨコナガ画像の場合
                if(app.yokonaga)
                {
                    app.imageCenter = app.imageRight;
                    app.imageRight = NULL;
                    [self CniSet];
                }
                //タテナガ画像の場合
                else
                {
                    [self RniSet];
                    
                    //Rのファイルが最後ではない場合
                    if(app.index+1 != app.listSize)
                    {
                        app.index++;
                        app.imageLeft = [self readImage];
                        
                        //ヨコナガ画像の場合
                        if(app.yokonaga)
                        {
                            app.imageLeft = NULL;
                            app.index--;
                        }
                        //タテナガ画像の場合
                        else
                        {
                            [self LniSet];
                        }
                    }
                    //Rのファイルが最後の場合
                    else
                    {
                        app.index++;
                    }
                }
            }
            
            //左側の画像のIndexを最後に表示した画像として記録する
            [[plistValue objectAtIndex:plistKeyIndex] replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:app.index]];
            
            //ウィンドウタイトルを現在開いている『アーカイブ名 現在のページ/総ページ』にする
            [self setWindowTitle];
        }
    }
}

//ページずれ補正
- (void)onePageGo
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        //ヨコナガ画像・1画面モード・空でないことを確認
        if((!app.imageCenter) && (app.listSize))
        {
            //ページずれフラグを変更
            if(![[[plistValue objectAtIndex:plistKeyIndex] objectAtIndex:3]intValue])
            {
                [[plistValue objectAtIndex:plistKeyIndex] replaceObjectAtIndex:3 withObject:[NSNumber numberWithInteger:1]];
            }
            else
            {
                [[plistValue objectAtIndex:plistKeyIndex] replaceObjectAtIndex:3 withObject:[NSNumber numberWithInteger:0]];
            }
            
            //表示中のファイルが1~2ページ目でなければ1ページ戻る
            //利用者の意図と異なる動作を避けるためタテナガ+ヨコナガになる場合にも特別な処理はしない
            if(app.index > 1)
            {
                app.index -= 2;
                app.imageRight = [self readImage];
                [self RniSet];
                
                app.index++;
                app.imageLeft = [self readImage];
                [self LniSet];
            }
            //表示中のファイルが1~2ページ目なら1ページ進む
            //利用者の意図と異なる動作を避けるためタテナガ+ヨコナガになる場合にも特別な処理はしない
            else if(app.index <= 1)
            {
                app.imageRight = [self readImage];
                [self RniSet];
                
                app.index++;
                app.imageLeft = [self readImage];
                [self LniSet];
            }
            
            //左側の画像のIndexを最後に表示した画像として記録する
            [[plistValue objectAtIndex:plistKeyIndex] replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:app.index]];
            
            //ウィンドウタイトルを現在開いている『アーカイブ名 現在のページ/総ページ』にする
            [self setWindowTitle];
        }
    }
}

//最初のページ
- (void)pageFirst
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        //空ではない場合
        if(app.listSize)
        {
            //ページずれフラグが立っている場合
            if([[[plistValue objectAtIndex:plistKeyIndex] objectAtIndex:3]intValue])
            {
                app.index = 1;
            }
            else
            {
                app.index = 0;
            }
            [self setImage];
            [self pagePrev];
        }
    }
}

//最後のページ
- (void)pageLast
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        //空ではない場合
        if(app.listSize)
        {
            //ページずれフラグが立っている場合
            if([[[plistValue objectAtIndex:plistKeyIndex] objectAtIndex:3]intValue])
            {
                app.index = app.listSize - 1;
            }
            else
            {
                app.index = app.listSize;
            }
            [self setImage];
            [self pageNext];
        }
    }
}

//10ページ戻る
- (void)page10Prev
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        //空ではない場合
        if(app.listSize)
        {
            //既読ページが10以下の場合
            if(app.index <= 10)
            {
                [self pageFirst];
            }
            //それ以外
            else
            {
                app.index = app.index - 10;
                [self setImage];
            }
        }
    }
}

//10ページ進む
- (void)page10Next
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        //空ではない場合
        if(app.listSize)
        {
            //未読ページが10ページ以下の場合
            if(app.listSize <= app.index + 9)
            {
                [self pageLast];
            }
            //それ以外
            else
            {
                app.index = app.index + 10;
                [self setImage];
            }
        }
    }
}

//ジャンプパネルを起動(ページ数)
- (void)openJumpPanelInt
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        [self openJumpPanel:0];
    }
}

//ジャンプパネルを起動(ページ％)
- (void)openJumpPanelPercent
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        [self openJumpPanel:1];
    }
}

//ジャンプパネル_移動ボタン
- (IBAction)JumpPanelJumpButton:(id)sender
{
    [self JumpPanelJumpButton];
}

//ジャンプパネルのテキストフィールドでエンター
- (IBAction)jumpPanel_enter:(id)sender
{
    [self JumpPanelJumpButton];
}

//ジャンプパネル_キャンセルボタン
- (IBAction)JumpPanelCancelButton:(id)sender
{
    [self JumpPanelCancelButton];
}

//ジャンプパネルを起動
- (void)openJumpPanel:(int)witch
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    NSString *witchJumpPanel;
    
    //ページ数
    if(!witch)
    {
        witchJumpPanel = @"number";
        
        //ジャンプパネルに現在のindexとlistSizeを設定
        if(app.index + 1 > app.listSize)
        {
            [jumpPanel_index setIntValue:app.index];
        }
        else
        {
            [jumpPanel_index setIntValue:app.index + 1];
        }
        [jumpPanel_listSize setStringValue:[NSString stringWithFormat:@"/%d",app.listSize]];
    }
    //ページ％
    else
    {
        witchJumpPanel = @"percent";
        
        //現在%を計算
        float indexPercent;
        int indexPercentInt;
        
        //最初のページ
        if(app.index == 0)
        {
            indexPercentInt = 0;
        }
        //最後のページ
        else if(app.index >= app.listSize - 1)
        {
            indexPercentInt = 10;
        }
        else
        {
            indexPercent = (app.index+1.0)/app.listSize*10;
            indexPercentInt = roundf(indexPercent);
        }
        
        [jumpPanel_index setIntValue:indexPercentInt];
        [jumpPanel_listSize setStringValue:@"0%"];
    }
    
    [[NSApplication sharedApplication]
     beginSheet:jumpPanel
     modalForWindow:viewWindow
     modalDelegate:self
     didEndSelector:@selector(panelClose:returnCode:contextInfo:)
     contextInfo:witchJumpPanel];
}

//ジャンプパネル_移動ボタン
- (void)JumpPanelJumpButton
{
    [[NSApplication sharedApplication]endSheet:jumpPanel returnCode:NSOKButton];
}

//ジャンプパネル_キャンセルボタン
- (void)JumpPanelCancelButton
{
    [[NSApplication sharedApplication]endSheet:jumpPanel returnCode:NSCancelButton];
}

//ジャンプパネルが閉じられた時
- (void)panelClose:(NSWindow*)panel returnCode:(int)returnCode contextInfo:(void*)contextInfo
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //パネルを閉じる
    [jumpPanel orderOut:self];
    
    //移動ボタンを押した場合
    if(returnCode == NSOKButton)
    {
        //ページ数モード
        if(contextInfo == @"number")
        {
            //0以下の値
            if([jumpPanel_index intValue] <= 0)
            {
                [self pageFirst];
            }
            //listSize以上の値
            else if(app.listSize <= [jumpPanel_index intValue])
            {
                [self pageLast];
            }
            //それ以外
            else
            {
                app.index = [jumpPanel_index intValue] - 1;
                [self setImage];
            }
        }
        //ページ％モード
        else if(contextInfo == @"percent")
        {
            //0%以下の値
            if([jumpPanel_index intValue] <= 0)
            {
                [self pageFirst];
            }
            //100%以上の値
            else if(10 <= [jumpPanel_index intValue])
            {
                [self pageLast];
            }
            //それ以外
            else
            {
                //総ページ数の10%を計算(floatにするため10.0)
                float tenPercent = app.listSize/10.0;
                //10%に0〜10のintをかける
                float indexFloat = tenPercent*[jumpPanel_index intValue];
                //四捨五入してindexに入れる
                app.index = roundf(indexFloat) - 1;
                if(app.index == -1)
                {
                    app.index = 0;
                }
                [self setImage];
            }
        }
    }
    //キャンセルボタンを押した場合
    else if(returnCode == NSCancelButton)
    {
        return;
    }
}

//スライドショーの開始
- (void)slideshowPlay:(float)interval random:(int)random
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        //空ではない場合
        if(app.listSize)
        {
            //スライドショーを実行中なら停止
            if(app.nowPlaySlideshow)
            {
                [slideshow invalidate];
                app.nowPlaySlideshow = 0;
            }
            
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithInteger:random],@"random", nil];
            
            app.slideshow = [NSTimer scheduledTimerWithTimeInterval:interval
                                                             target:self
                                                           selector:@selector(pageNext4Slideshow)
                                                           userInfo:dictionary
                                                            repeats:YES];
            
            app.nowPlaySlideshow = 1;
        }
    }
}

//スライドショーの停止
- (void)slideshowStop
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        //スライドショーを実行中なら停止
        if(app.nowPlaySlideshow)
        {
            [slideshow invalidate];
            app.nowPlaySlideshow = 0;
        }
    }
}

//スライドショー用のPageNext
- (void)pageNext4Slideshow
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //ランダムスライドショーならindexを0〜listSize-1のランダムな値に変更
    //ただしarc4random(unsigned int)をintにキャストしているので時々-1が返ってくることに注意
    if([[[slideshow userInfo] objectForKey:@"random"]intValue])
    {
        app.index = arc4random() % app.listSize-1;
    }
    
    //表示中のファイルが最後ではない場合
    if(app.index < app.listSize-1)
    {
        [self pageNext];
    }
    //表示中のファイルが最後の場合
    else
    {
        [self pageFirst];
    }
}

//ウィンドウタイトルを『mangao ver.x.x.x』にする
- (void)resetWindowTitle
{
    NSString *shortVersionString = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [self.viewWindow setTitle:[[NSString alloc] initWithFormat:@"Mangao ver.%@",shortVersionString]];
}

//ウィンドウタイトルを現在開いている『アーカイブ名 現在のページ/総ページ ブックマークされているかどうか』にする
- (void)setWindowTitle
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    NSString *title;
    //画像フォルダの場合
    if(app.nowOpenImageFolder)
    {
        title = [[app.folderPath lastPathComponent] stringByDeletingPathExtension];
    }
    //アーカイブの場合
    else
    {
        title = [[app.filePath lastPathComponent] stringByDeletingPathExtension];
    }
    
    NSString *nowIndex;
    //페이지넘버
    NSString *nowpagenumberPrev;
    NSString *nowpagenumberNext;
    //독 아이콘 뱃지 넘버
    NSString *dockIndex;
    if(app.index + 1 > app.listSize)
    {
        nowIndex = [NSString stringWithFormat:@" [%d/%d]",app.index,app.listSize];
        dockIndex = [NSString stringWithFormat:@"%d/%d",app.index,app.listSize];
        nowpagenumberPrev = [NSString stringWithFormat:@"%d",app.index - 1];
        nowpagenumberNext = [NSString stringWithFormat:@"%d",app.index];
     }
    else
    {
        nowIndex = [NSString stringWithFormat:@" [%d/%d]",app.index + 1,app.listSize];
        dockIndex = [NSString stringWithFormat:@"%d/%d",app.index + 1,app.listSize];
        nowpagenumberPrev = [NSString stringWithFormat:@"%d",app.index];
        nowpagenumberNext = [NSString stringWithFormat:@"%d",app.index + 1];
    }
    
    NSString *title_index = [title stringByAppendingString:nowIndex];
    NSString *title_index_bookmark;
    
    //pagenumber
    if(!app.hidaribirakiMode)
    {
        [pagenumberPrev setStringValue:[NSString stringWithFormat:@"%@",nowpagenumberPrev]];
        //[pagenumberNext setStringValue:[NSString stringWithFormat:@"%@/%d",nowpagenumberNext,app.listSize]];
        [pagenumberNext setStringValue:[NSString stringWithFormat:@"%@",nowpagenumberNext]];
    }
    else
    {
        //[pagenumberPrev setStringValue:[NSString stringWithFormat:@"%@/%d",nowpagenumberNext,app.listSize]];
        [pagenumberPrev setStringValue:[NSString stringWithFormat:@"%@",nowpagenumberNext]];
        [pagenumberNext setStringValue:[NSString stringWithFormat:@"%@",nowpagenumberPrev]];
    }
    
    //독 아이콘에 현재 페이지 뱃지로 표시
    [[[NSApplication sharedApplication] dockTile]setBadgeLabel:dockIndex];
   //ブックマークが空ではない場合
    if([[plistValue objectAtIndex:plistKeyIndex] objectAtIndex:4] != [NSNumber numberWithInteger:0])
    {
        //ブックマークの中で何番目か検索
        NSUInteger bookmarkIndex = [[[plistValue objectAtIndex:plistKeyIndex] objectAtIndex:4] indexOfObject:[NSNumber numberWithInteger:app.index+1]];
        
        //登録済みの場合
        if(bookmarkIndex != NSNotFound)
        {
            title_index_bookmark = [title_index stringByAppendingString:@"*"];
        }
        else
        {
            title_index_bookmark = title_index;
        }
    }
    else
    {
        title_index_bookmark = title_index;
    }
    
    [self.viewWindow setTitle:title_index_bookmark];
    
    //ルーペが起動中の場合
    if(app.isLoupe)
    {
        //ImageCenterField上でのマウスカーソルの座標を取得
        app.cursor_onImageCenterField = [app.imageCenterField convertPoint:[[self viewWindow] convertScreenToBase:[NSEvent mouseLocation]] fromView:nil];
        
        //ルーペ画像を更新
        [self loupe];
    }
}

//前のアーカイブ
- (void)archivePrev
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        //現在2つ以上アーカイブ・フォルダを開いている場合
        if(app.listSizeOfArchive >= 2)
        {
            //現在開いているアーカイブが最初ではない場合
            if(app.indexOfArchive > 0)
            {
                app.indexOfArchive = app.indexOfArchive-1;
            }
            //現在開いているアーカイブが最初の場合
            else
            {
                app.indexOfArchive = app.listSizeOfArchive-1;
            }
            app.filePath = [app.fileListFullPathOfArchive objectAtIndex:app.indexOfArchive];
            [self archiveOpen];
        }
    }
}

//次のアーカイブ
- (void)archiveNext
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        //現在2つ以上アーカイブ・フォルダを開いている場合
        if(app.listSizeOfArchive >= 2)
        {
            //現在開いているアーカイブが最後ではない場合
            if(app.indexOfArchive < app.listSizeOfArchive-1)
            {
                app.indexOfArchive = app.indexOfArchive+1;
            }
            //現在開いているアーカイブが最後の場合
            else
            {
                app.indexOfArchive = 0;
            }
            app.filePath = [app.fileListFullPathOfArchive objectAtIndex:app.indexOfArchive];
            [self archiveOpen];
        }
    }
}

//右開き/左開き
- (void)migibirakiHidaribiraki
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        //空ではない場合
        if(app.listSize)
        {
            //左開きの場合
            if(app.hidaribirakiMode)
            {
                app.hidaribirakiMode = 0;
                [[plistValue objectAtIndex:plistKeyIndex] replaceObjectAtIndex:1 withObject:[NSNumber numberWithInteger:0]];
            }
            //右開きの場合
            else
            {
                app.hidaribirakiMode = 1;
                [[plistValue objectAtIndex:plistKeyIndex] replaceObjectAtIndex:1 withObject:[NSNumber numberWithInteger:1]];
            }
            
            //左開きの場合(『デフォルトで左開き』を考慮)
            if(abs(app.hidaribirakiMode - [[[plistValue objectAtIndex:0] objectAtIndex:0] intValue]))
            {
                //좌우로 긴 이미지가 아닐 때에만 화면 갱신
                imageLeftFieldxxx = imageRightField;
                imageRightFieldxxx = imageLeftField;
                
                if(!app.yokonaga)
                {
                [self LniSet];
                [self RniSet];
                }
                //ページ移動メニューを更新
                [self goPageMenuReload:1];
            }
            //右開きの場合
            else
            {
                //좌우로 긴 이미지가 아닐 때에만 화면 갱신
                imageLeftFieldxxx = imageLeftField;
                imageRightFieldxxx = imageRightField;
                if(!app.yokonaga)
                {
                [self LniSet];
                [self RniSet];
                }
                //ページ移動メニューを更新
                [self goPageMenuReload:0];
            }
        }
    }
}

//1画面モード
- (void)onePageDisplay
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        //空でないことを確認
        if(app.listSize)
        {
            //1画面モードの場合
            if(app.onePageMode)
            {
                app.onePageMode = 0;
                [[plistValue objectAtIndex:plistKeyIndex] replaceObjectAtIndex:2 withObject:[NSNumber numberWithInteger:0]];
            }
            //1画面モードではない場合
            else
            {
                app.onePageMode = 1;
                [[plistValue objectAtIndex:plistKeyIndex] replaceObjectAtIndex:2 withObject:[NSNumber numberWithInteger:1]];
            }
            
            //画面を更新
            //1画面モードの場合(『デフォルトで1画面』を考慮)
            if(abs(app.onePageMode - [[[plistValue objectAtIndex:0] objectAtIndex:1] intValue]))
            {
                [self imageFieldReset];
                
                //左側が空の場合
                if(app.index+1 > app.listSize)
                {
                    app.index--;
                }
                app.imageCenter = [self readImage];
                [self CniSet];
            }
            //1画面モードではない場合
            else
            {
                [self setImage];
            }
        }
    }
}

//右の画像を保存
- (void)saveR
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        NSImage *selectImage;
        int selectIndex;
        
        //空ではない場合
        if(app.listSize)
        {
            //左開きの場合(『デフォルトで左開き』を考慮)
            if(abs(app.hidaribirakiMode - [[[plistValue objectAtIndex:0] objectAtIndex:0] intValue]))
            {
                selectImage = app.imageLeft;
                selectIndex = app.index + 1;
            }
            //右開きの場合
            else
            {
                selectImage = app.imageRight;
                selectIndex = app.index;
            }
            [self save:selectImage selectIndex:selectIndex];
        }
    }
}

//左の画像を保存
- (void)saveL
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        NSImage *selectImage;
        int selectIndex;
        
        //空ではない場合
        if(app.listSize)
        {
            //左開きの場合(『デフォルトで左開き』を考慮)
            if(abs(app.hidaribirakiMode - [[[plistValue objectAtIndex:0] objectAtIndex:0] intValue]))
            {
                selectImage = app.imageRight;
                selectIndex = app.index;
            }
            //右開きの場合
            else
            {
                selectImage = app.imageLeft;
                selectIndex = app.index + 1;
            }
            [self save:selectImage selectIndex:selectIndex];
        }
    }
}

//画像を保存
- (void)save:(NSImage*)selectImage selectIndex:(int)selectIndex
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    if((selectImage != NULL) || (app.imageCenter != NULL))
    {
        NSImage *image;
        
        if(selectImage == NULL)
        {
            image = app.imageCenter;
            selectIndex = app.index + 1;
        }
        else
        {
            image = selectImage;
        }
        
        NSSavePanel *savePanel	= [NSSavePanel savePanel];
        NSString *fileName;
        NSString *selectIndexNSString = [NSString stringWithFormat:@"_%d",selectIndex];
        
        if((app.nowOpenZIP) || (app.nowOpenRAR) || (app.nowOpenPDF) || (app.nowOpenCvbdl))
        {
            fileName = [[[app.filePath lastPathComponent] stringByDeletingPathExtension] stringByAppendingString:selectIndexNSString];
        }
        else
        {
            fileName = [[app.folderPath lastPathComponent] stringByAppendingString:selectIndexNSString];
        }
        
        [savePanel setAllowedFileTypes:[NSArray arrayWithObjects:@"tif",nil]];
        [savePanel setNameFieldStringValue:fileName];
        
        NSInteger OK = [savePanel runModal];
        if(OK == NSOKButton)
        {
            //TIFで保存
            [[image TIFFRepresentation] writeToFile:[[savePanel URL] path]
                                         atomically:YES];
        }
        else
        {
            return;
        }
    }
}

//アーカイブをゴミ箱に入れる
- (void)archiveDelete
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        //アーカイブのリストが空ではない場合
        if(app.listSizeOfArchive)
        {
            //アーカイブを閲覧中の場合
            if(!app.nowOpenImageFolder)
            {
                [[NSWorkspace sharedWorkspace] performFileOperation:NSWorkspaceRecycleOperation
                                                             source:@""
                                                        destination:@""
                                                              files:[NSArray arrayWithObject:app.filePath]
                                                                tag:nil];
                
                [app.fileListFullPathOfArchive removeObjectAtIndex:app.indexOfArchive];
                app.listSizeOfArchive = [app.fileListFullPathOfArchive count];
                app.indexOfArchive = app.indexOfArchive - 1;
                
                //アーカイブがまだある場合
                if(app.listSizeOfArchive)
                {
                    //現在開いているアーカイブが最後ではない場合
                    if(app.indexOfArchive < app.listSizeOfArchive-1)
                    {
                        app.indexOfArchive = app.indexOfArchive+1;
                    }
                    //現在開いているアーカイブが最後の場合
                    else
                    {
                        app.indexOfArchive = 0;
                    }
                    app.filePath = [app.fileListFullPathOfArchive objectAtIndex:app.indexOfArchive];
                    [self archiveOpen];
                }
                //削除したのが最後のアーカイブの場合
                else
                {
                    [self imageFieldReset];
                    app.imageCenter = [NSImage imageNamed:@"PleasePressO"];
                    [self CniSet];
                    
                    //ウィンドウタイトルを『mangao ver.x.x.x』にする
                    [self resetWindowTitle];
                    //ブックマークメニューを空にする
                    [self bookmarkMenuClear];
                    
                    app.index = 0;
                    app.listSize = 0;
                    
                    app.nowOpenZIP = 0;
                    app.nowOpenRAR = 0;
                    app.nowOpenPDF = 0;
                    app.nowOpenCvbdl = 0;
                    app.nowOpenImageFolder = 0;
                }
            }
            //フォルダを閲覧中の場合
            else
            {
                //確認パネルを起動
                [self openConfirmPanel:@"folderDelete"];
            }
        }
    }
}

//背景色の変更
- (void)changeBackgroundColor
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        if([[[plistValue objectAtIndex:0] objectAtIndex:9] intValue] == 2)
        {
            [[plistValue objectAtIndex:0] replaceObjectAtIndex:9 withObject:[NSNumber numberWithInteger:0]];
            [viewWindow setBackgroundColor:[NSColor windowBackgroundColor]];
            [loupeWindow setBackgroundColor:[NSColor windowBackgroundColor]];
        }
        else if([[[plistValue objectAtIndex:0] objectAtIndex:9] intValue])
        {
            [[plistValue objectAtIndex:0] replaceObjectAtIndex:9 withObject:[NSNumber numberWithInteger:2]];
            [viewWindow setBackgroundColor:[NSColor blackColor]];
            [loupeWindow setBackgroundColor:[NSColor blackColor]];
        }
        else
        {
            [[plistValue objectAtIndex:0] replaceObjectAtIndex:9 withObject:[NSNumber numberWithInteger:1]];
            [viewWindow setBackgroundColor:[NSColor whiteColor]];
            [loupeWindow setBackgroundColor:[NSColor whiteColor]];
        }
    }
}

//サムネイル一覧
- (void)thumbnail
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //空ではない場合
    if(app.listSize)
    {
        //サムネイル一覧を実行中の場合
        if(app.isThumbnail)
        {
            //サムネイル一覧を終了する
            [self exitThumbnail];
        }
        //サムネイル一覧を実行中ではない場合
        else
        {
            app.isThumbnail = 1;
            
            //ビューウィンドウを無効にする(thumbnailWindowはタイトルバーがないのでisKeyWindowがうまく動かない)
            [[self viewWindow] orderOut:self];
            //サムネイルウィンドウを画面と同じ大きさにする
            [thumbnailWindow setFrame:[[NSScreen mainScreen]frame]display:NO animate:NO];
            //サムネイルビューの背景色をビューウィンドウと同じにする
            if([[[plistValue objectAtIndex:0] objectAtIndex:9] intValue] == 2)
            {
                [thumbnailView setValue:[NSColor blackColor] forKey:IKImageBrowserBackgroundColorKey];
            }
            else if([[[plistValue objectAtIndex:0] objectAtIndex:9] intValue])
            {
                [thumbnailView setValue:[NSColor whiteColor] forKey:IKImageBrowserBackgroundColorKey];
            }
            else
            {
                [thumbnailView setValue:[NSColor colorWithDeviceRed:237/255.0f green:237/255.0f blue:237/255.0f alpha:1.0] forKey:IKImageBrowserBackgroundColorKey];
            }
            //サムネイルウィンドウを有効にする
            [[self thumbnailWindow] makeKeyAndOrderFront:self];
            //メニューバーより手前に表示
            [thumbnailWindow setLevel: NSStatusWindowLevel];
            
            //最後にサムネイル一覧を実行した時と異なるアーカイブを開いている場合
            if(!((!app.nowOpenImageFolder && app.thumbnailPath == app.filePath) || (app.nowOpenImageFolder && app.thumbnailPath == app.folderPath)))
            {
                //現在のアーカイブのパスを最後にサムネイル一覧を実行した時のパスとして記録する
                if(!app.nowOpenImageFolder)
                {
                    app.thumbnailPath = app.filePath;
                }
                else
                {
                    app.thumbnailPath = app.folderPath;
                }
                
                //サムネイル一覧の情報を初期化する
                [thumbnailController init];
                
                //PDFを開いている場合
                if(app.nowOpenPDF)
                {
                    for(PDFPage *page in PDFArray)
                    {
                        NSImage *thumbnailImage;
                        
                        NSRect bounds = [page boundsForBox:kPDFDisplayBoxMediaBox];
                        float dimension = 1400;
                        float scale = 1 > (NSHeight(bounds) / NSWidth(bounds)) ? dimension / NSWidth(bounds) :  dimension / NSHeight(bounds);
                        bounds.size = NSMakeSize(bounds.size.width*scale,bounds.size.height*scale);
                        
                        thumbnailImage = [[[NSImage alloc] initWithSize: bounds.size] autorelease];
                        [thumbnailImage lockFocus];
                        [[NSColor whiteColor] set];
                        NSRectFill(bounds );
                        NSAffineTransform * scaleTransform = [NSAffineTransform transform];
                        [scaleTransform scaleBy: scale];
                        [scaleTransform concat];
                        [page drawWithBox: kPDFDisplayBoxMediaBox];
                        [thumbnailImage unlockFocus];
                        
                        thumbnail *thumbnailItem = [thumbnail imageItemWithContentsOfNSImage:thumbnailImage];
                        [thumbnailController addObject:thumbnailItem];
                    }
                }
                //PDF以外を開いている場合
                else
                {
                    for(NSImage *thumbnailImage in imageArray)
                    {
                        thumbnail *thumbnailItem = [thumbnail imageItemWithContentsOfNSImage:thumbnailImage];
                        [thumbnailController addObject:thumbnailItem];
                    }
                }
            }
        }
    }
}

//サムネイル一覧の中の画像をダブルクリックした時
- (void)imageBrowser:(IKImageBrowserView *)aBrowser cellWasDoubleClickedAtIndex:(NSUInteger)selecetIndex
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    app.index = selecetIndex;
    [self setImage];
    
    //サムネイル一覧を終了する
    [self exitThumbnail];
}

//サムネイル一覧を終了する
- (void)exitThumbnail
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    app.isThumbnail = 0;
    
    //サムネイルウィンドウを無効にする
    [[self thumbnailWindow] orderOut:self];
    //ビューウィンドウを有効にする
    [[self viewWindow] makeKeyAndOrderFront:self];
}

//小さいルーペ
- (void)loupeSmallOnOff
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        //ImageCenterField上でのマウスカーソルの座標を取得
        app.cursor_onImageCenterField = [app.imageCenterField convertPoint:[[self viewWindow] convertScreenToBase:[NSEvent mouseLocation]] fromView:nil];
        
        //画面のサイズを取得
        float screenX = [[NSScreen mainScreen]frame].size.width;
        float screenY = [[NSScreen mainScreen]frame].size.height;
        
        //小さいルーペを起動中の場合
        if(app.isLoupe == 1)
        {
            app.isLoupe = 0;
            
            //ルーペウィンドウを無効にする
            [[self loupeWindow] orderOut:self];
            //マウスカーソルを表示する
            [NSCursor unhide];
        }
        //大きいルーペを起動中、もしくはルーペを起動中ではない場合
        else
        {
            app.isLoupe = 1;
            
            //ルーペウィンドウのサイズを[画面の短い方の辺の5分の2×画面の短い方の辺の5分の2]にする
            if(screenX < [[NSScreen mainScreen]frame].size.width)
            {
                [loupeWindow setFrame:NSMakeRect(0,0,screenX*2/5,screenX*2/5) display:NO];
            }
            else
            {
                [loupeWindow setFrame:NSMakeRect(0,0,screenY*2/5,screenY*2/5) display:NO];
            }
            
            //マウスカーソルを隠す
            [NSCursor hide];
            
            [self loupe];
        }
    }
}

//大きいルーペ
- (void)loupeLargeOnOff
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        //ImageCenterField上でのマウスカーソルの座標を取得
        app.cursor_onImageCenterField = [app.imageCenterField convertPoint:[[self viewWindow] convertScreenToBase:[NSEvent mouseLocation]] fromView:nil];
        
        //マウスカーソルを表示する
        [NSCursor unhide];
        
        //大きいルーペを起動中の場合
        if(app.isLoupe == 2)
        {
            app.isLoupe = 0;
            
            //ルーペウィンドウを無効にする
            [[self loupeWindow] orderOut:self];
        }
        //小さいルーペを起動中、もしくはルーペを起動中ではない場合
        else
        {
            app.isLoupe = 2;
            
            //ルーペウィンドウをビューウィンドウと同じサイズにする
            [loupeWindow setFrame:viewWindow.frame display:NO];
            
            [self loupe];
        }
    }
}

//ページ移動メニューの再読み込み
//witch==0なら右開き、witch==1なら左開き
- (void)goPageMenuReload:(int)witch
{
    //ページ移動メニューを削除
    [mainMenu removeItemAtIndex:14];
    
    NSMenuItem	*GoPageItem = [[[NSMenuItem alloc] init] autorelease];
    NSMenu *GoPage = [[[NSMenu alloc] init] autorelease];
    [GoPageItem setTitle:NSLocalizedString(@"ページ移動",@"")];
    [GoPage setTitle: NSLocalizedString(@"ページ移動",@"")];
    //右開きの場合
    if(!witch)
    {
        [[GoPage addItemWithTitle: NSLocalizedString(@"前のページ",@"")
                           action: @selector(pagePrev) keyEquivalent: @"→"]setKeyEquivalentModifierMask:0];
    }
    //左開きの場合
    else
    {
        [[GoPage addItemWithTitle: NSLocalizedString(@"前のページ",@"")
                           action: @selector(pagePrev) keyEquivalent: @"←"]setKeyEquivalentModifierMask:0];
    }
    [[GoPage addItemWithTitle: NSLocalizedString(@"",@"")
                       action: @selector(pagePrev) keyEquivalent: @"k"]setKeyEquivalentModifierMask:0];
    [[GoPage addItemWithTitle: NSLocalizedString(@"",@"")
                       action: @selector(pagePrev) keyEquivalent: @" "]setKeyEquivalentModifierMask:NSShiftKeyMask];
    [GoPage addItem: [NSMenuItem separatorItem]];
    //右開きの場合
    if(!witch)
    {
        [[GoPage addItemWithTitle: NSLocalizedString(@"次のページ",@"")
                           action: @selector(pageNext) keyEquivalent: @"←"]setKeyEquivalentModifierMask:0];
    }
    //左開きの場合
    else
    {
        [[GoPage addItemWithTitle: NSLocalizedString(@"次のページ",@"")
                           action: @selector(pageNext) keyEquivalent: @"→"]setKeyEquivalentModifierMask:0];
    }
    [[GoPage addItemWithTitle: NSLocalizedString(@"",@"")
                       action: @selector(pageNext) keyEquivalent: @"j"]setKeyEquivalentModifierMask:0];
    [[GoPage addItemWithTitle: NSLocalizedString(@"",@"")
                       action: @selector(pageNext) keyEquivalent: @" "]setKeyEquivalentModifierMask:0];
    [GoPage addItem: [NSMenuItem separatorItem]];
    //右開きの場合
    if(!witch)
    {
        [GoPage addItemWithTitle: NSLocalizedString(@"最初のページ",@"")
                          action: @selector(pageFirst) keyEquivalent: @"→"];
    }
    //左開きの場合
    else
    {
        [GoPage addItemWithTitle: NSLocalizedString(@"最初のページ",@"")
                          action: @selector(pageFirst) keyEquivalent: @"←"];
    }
    [GoPage addItemWithTitle: NSLocalizedString(@"",@"")
                      action: @selector(pageFirst) keyEquivalent: @"k"];
    [GoPage addItem: [NSMenuItem separatorItem]];
    //右開きの場合
    if(!witch)
    {
        [GoPage addItemWithTitle: NSLocalizedString(@"最後のページ",@"")
                          action: @selector(pageLast) keyEquivalent: @"←"];
    }
    //左開きの場合
    else
    {
        [GoPage addItemWithTitle: NSLocalizedString(@"最後のページ",@"")
                          action: @selector(pageLast) keyEquivalent: @"→"];
    }
    [GoPage addItemWithTitle: NSLocalizedString(@"",@"")
                      action: @selector(pageLast) keyEquivalent: @"j"];
    [GoPage addItem: [NSMenuItem separatorItem]];
    [[GoPage addItemWithTitle: NSLocalizedString(@"10ページ戻る",@"")
                       action: @selector(page10Prev) keyEquivalent: @"⇥"]setKeyEquivalentModifierMask:NSShiftKeyMask];
    [[GoPage addItemWithTitle: NSLocalizedString(@"10ページ進む",@"")
                       action: @selector(page10Next) keyEquivalent: @"⇥"]setKeyEquivalentModifierMask:0];
    [GoPage addItem: [NSMenuItem separatorItem]];
    [[GoPage addItemWithTitle: NSLocalizedString(@"ページ数を指定して移動",@"")
                       action: @selector(openJumpPanelInt) keyEquivalent: @"p"]setKeyEquivalentModifierMask:0];
    [GoPage addItemWithTitle: NSLocalizedString(@"ページ％を指定して移動",@"")
                      action: @selector(openJumpPanelPercent) keyEquivalent: @"p"];
    
    //ページ移動メニューを追加
    [GoPageItem setSubmenu: GoPage];
    [mainMenu insertItem:GoPageItem atIndex:14];
}

//ブックマークを追加/削除
- (void)bookmarkAddRemove
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        //空でないことを確認
        if(app.listSize)
        {
            //ブックマークが空の場合
            if([[plistValue objectAtIndex:plistKeyIndex] objectAtIndex:4] == [NSNumber numberWithInteger:0])
            {
                //ブックマークを登録
                [[plistValue objectAtIndex:plistKeyIndex] replaceObjectAtIndex:4 withObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInteger:app.index+1], nil]];
            }
            //ブックマークが空ではない場合
            else
            {
                //ブックマークの中で何番目か検索
                NSUInteger bookmarkIndex = [[[plistValue objectAtIndex:plistKeyIndex] objectAtIndex:4] indexOfObject:[NSNumber numberWithInteger:app.index+1]];
                
                //未登録の場合
                if(bookmarkIndex == NSNotFound)
                {
                    //ブックマークを登録
                    [[[plistValue objectAtIndex:plistKeyIndex] objectAtIndex:4] addObject:[NSNumber numberWithInteger:app.index+1]];
                }
                //登録済みの場合
                else
                {
                    //ブックマークを削除
                    [[[plistValue objectAtIndex:plistKeyIndex] objectAtIndex:4] removeObjectAtIndex:bookmarkIndex];
                    
                    //ブックマークが全て削除された場合
                    if(![[[plistValue objectAtIndex:plistKeyIndex] objectAtIndex:4] count])
                    {
                        //[NSNumber:0]に差し替え
                        [[plistValue objectAtIndex:plistKeyIndex] replaceObjectAtIndex:4 withObject:[NSNumber numberWithInteger:0]];
                    }
                }
            }
            //ウィンドウタイトルを再読込する
            [self setWindowTitle];
            //ブックマークメニューを再読込する
            [self bookmarkMenuReload];
        }
    }
}

//ブックマークメニューを再読込する
- (void)bookmarkMenuReload
{
    //ブックマークメニューを削除
    [mainMenu removeItemAtIndex:23];
    
    NSMenuItem	*bookmarkMenuItem = [[[NSMenuItem alloc] init] autorelease];
    NSMenu *bookmarkMenu = [[[NSMenu alloc] init] autorelease];
    [bookmarkMenuItem setTitle:NSLocalizedString(@"ブックマーク",@"")];
    [bookmarkMenu setTitle: NSLocalizedString(@"ブックマーク",@"")];
    
    //ブックマークが空ではない場合
    if([[plistValue objectAtIndex:plistKeyIndex] objectAtIndex:4] != [NSNumber numberWithInteger:0])
    {
        //ブックマークをソート
        NSArray *sortedArray = [[[plistValue objectAtIndex:plistKeyIndex] objectAtIndex:4] sortedArrayUsingSelector:@selector(compare:)];
        [[plistValue objectAtIndex:plistKeyIndex] replaceObjectAtIndex:4 withObject:[sortedArray mutableCopy]];
        
        //ブックマーク項目を追加
        for(NSNumber *bookmarkNumber in [[plistValue objectAtIndex:plistKeyIndex] objectAtIndex:4])
        {
            [bookmarkMenu addItemWithTitle:[bookmarkNumber stringValue] action:@selector(bookmarkOpen:) keyEquivalent:@""];
        }
    }
    
    //ブックマーク操作項目を追加
    [bookmarkMenu addItem: [NSMenuItem separatorItem]];
    [[bookmarkMenu addItemWithTitle:NSLocalizedString(@"前のブックマークに移動",@"") action:@selector(bookmarkPrev) keyEquivalent:@"b"] setKeyEquivalentModifierMask:NSShiftKeyMask];
    [bookmarkMenu addItemWithTitle:NSLocalizedString(@"次のブックマークに移動",@"") action:@selector(bookmarkNext) keyEquivalent:@"b"];
    [bookmarkMenu addItem: [NSMenuItem separatorItem]];
    [[bookmarkMenu addItemWithTitle:NSLocalizedString(@"ブックマークに追加/削除",@"") action:@selector(bookmarkAddRemove) keyEquivalent:@"b"] setKeyEquivalentModifierMask:0];
    [bookmarkMenu addItemWithTitle:NSLocalizedString(@"ブックマークをすべて削除",@"") action:@selector(bookmarkAllRemove) keyEquivalent:@""];
    
    //ブックマークメニューを追加
    [bookmarkMenuItem setSubmenu: bookmarkMenu];
    [mainMenu insertItem:bookmarkMenuItem atIndex:23];
}

//ブックマークメニューを空にする
- (void)bookmarkMenuClear
{
    //ブックマークメニューを削除
    [mainMenu removeItemAtIndex:23];
    
    NSMenuItem	*bookmarkMenuItem = [[[NSMenuItem alloc] init] autorelease];
    NSMenu *bookmarkMenu = [[[NSMenu alloc] init] autorelease];
    [bookmarkMenuItem setTitle:NSLocalizedString(@"ブックマーク",@"")];
    [bookmarkMenu setTitle: NSLocalizedString(@"ブックマーク",@"")];
    
    //ブックマーク操作項目を追加
    [bookmarkMenu addItem: [NSMenuItem separatorItem]];
    [[bookmarkMenu addItemWithTitle:NSLocalizedString(@"前のブックマークに移動",@"") action:@selector(bookmarkPrev) keyEquivalent:@"b"] setKeyEquivalentModifierMask:NSShiftKeyMask];
    [bookmarkMenu addItemWithTitle:NSLocalizedString(@"次のブックマークに移動",@"") action:@selector(bookmarkNext) keyEquivalent:@"b"];
    [bookmarkMenu addItem: [NSMenuItem separatorItem]];
    [[bookmarkMenu addItemWithTitle:NSLocalizedString(@"ブックマークに追加/削除",@"") action:@selector(bookmarkAddRemove) keyEquivalent:@"b"] setKeyEquivalentModifierMask:0];
    [bookmarkMenu addItemWithTitle:NSLocalizedString(@"ブックマークをすべて削除",@"") action:@selector(bookmarkAllRemove) keyEquivalent:@""];
    
    //ブックマークメニューを追加
    [bookmarkMenuItem setSubmenu: bookmarkMenu];
    [mainMenu insertItem:bookmarkMenuItem atIndex:23];
}

//ブックマーク項目をクリックした時
- (void)bookmarkOpen:(NSMenuItem*)menuItemString
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //メニューアイテム名からページ数を抜き出す
    NSString *str = [NSString stringWithFormat:@"%@",menuItemString];
    NSRange searchResult1 = [str rangeOfString:@" " options:NSBackwardsSearch];
    NSRange searchResult2 = [str rangeOfString:@">"];
    NSString *str1 = [str substringWithRange:NSMakeRange(searchResult1.location+1,searchResult2.location-searchResult1.location-1)];
    
    app.index = [str1 intValue]-1;
    
    //ブックマークが範囲外の場合(アーカイブ内のファイルが削除された場合の対策)
    if(app.index > app.listSize)
    {
        int nowIndex = app.index;
        //一度、app.indexに入れてからbookmarkAddRemoveを実行することで削除する。
        [self bookmarkAddRemove];
        //indexを元のページにセットする。
        app.index = nowIndex;
    }
    else
    {
        [self setImage];
    }
}

//前のブックマーク
- (void)bookmarkPrev
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        //空でないことを確認
        if(app.listSize)
        {
            //ブックマークが空ではない場合
            if([[plistValue objectAtIndex:plistKeyIndex] objectAtIndex:4] != [NSNumber numberWithInteger:0])
            {
                //ブックマークの中で何番目か検索
                NSUInteger bookmarkIndex = [[[plistValue objectAtIndex:plistKeyIndex] objectAtIndex:4] indexOfObject:[NSNumber numberWithInteger:app.index+1]];
                
                //未登録の場合
                if(bookmarkIndex == NSNotFound)
                {
                    //ブックマークが1つの場合
                    if([[[plistValue objectAtIndex:plistKeyIndex] objectAtIndex:4]count] == 1)
                    {
                        //そのブックマークに移動
                        app.index = [[[[plistValue objectAtIndex:plistKeyIndex] objectAtIndex:4]objectAtIndex:0]intValue]-1;
                    }
                    //ブックマークが2つ以上ある場合
                    else
                    {
                        //ブックマークの配列に現在のindexを加えた配列を作る
                        NSMutableArray *array = [[[plistValue objectAtIndex:plistKeyIndex] objectAtIndex:4] mutableCopy];
                        [array addObject:[NSNumber numberWithInteger:app.index+1]];
                        //配列をソート
                        NSArray *sortedArray = [array sortedArrayUsingSelector:@selector(compare:)];
                        array = [sortedArray mutableCopy];
                        //その配列の中で何番目か検索
                        NSUInteger arrayIndex = [array indexOfObject:[NSNumber numberWithInteger:app.index+1]];
                        //最初の場合
                        if(arrayIndex == 0)
                        {
                            //最後のブックマークに移動
                            app.index = [[array objectAtIndex:[array count]-1]intValue]-1;
                        }
                        //最初ではない場合
                        else
                        {
                            //前のブックマークに移動
                            app.index = [[array objectAtIndex:arrayIndex-1]intValue]-1;
                        }
                    }
                    [self setImage];
                }
                //登録済みの場合
                else
                {
                    //ブックマークが2つ以上ある場合
                    if([[[plistValue objectAtIndex:plistKeyIndex] objectAtIndex:4]count] > 1)
                    {
                        //最初のブックマークの場合
                        if(bookmarkIndex == 0)
                        {
                            //最後のブックマークに移動
                            app.index = [[[[plistValue objectAtIndex:plistKeyIndex] objectAtIndex:4]objectAtIndex:[[[plistValue objectAtIndex:plistKeyIndex] objectAtIndex:4]count]-1]intValue]-1;
                        }
                        //最初のブックマークではない場合
                        else
                        {
                            //前のブックマークに移動
                            app.index = [[[[plistValue objectAtIndex:plistKeyIndex] objectAtIndex:4]objectAtIndex:bookmarkIndex-1]intValue]-1;
                        }
                        [self setImage];
                    }
                }
                //ウィンドウタイトルを再読込する
                [self setWindowTitle];
            }
        }
    }
}

//次のブックマーク
- (void)bookmarkNext
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧を実行中ではない場合
    if(!app.isThumbnail)
    {
        //空でないことを確認
        if(app.listSize)
        {
            //ブックマークが空ではない場合
            if([[plistValue objectAtIndex:plistKeyIndex] objectAtIndex:4] != [NSNumber numberWithInteger:0])
            {
                //ブックマークの中で何番目か検索
                NSUInteger bookmarkIndex = [[[plistValue objectAtIndex:plistKeyIndex] objectAtIndex:4] indexOfObject:[NSNumber numberWithInteger:app.index+1]];
                
                //未登録の場合
                if(bookmarkIndex == NSNotFound)
                {
                    //ブックマークが1つの場合
                    if([[[plistValue objectAtIndex:plistKeyIndex] objectAtIndex:4]count] == 1)
                    {
                        //そのブックマークに移動
                        app.index = [[[[plistValue objectAtIndex:plistKeyIndex] objectAtIndex:4]objectAtIndex:0]intValue]-1;
                    }
                    //ブックマークが2つ以上ある場合
                    else
                    {
                        //ブックマークの配列に現在のindexを加えた配列を作る
                        NSMutableArray *array = [[[plistValue objectAtIndex:plistKeyIndex] objectAtIndex:4] mutableCopy];
                        [array addObject:[NSNumber numberWithInteger:app.index+1]];
                        //配列をソート
                        NSArray *sortedArray = [array sortedArrayUsingSelector:@selector(compare:)];
                        array = [sortedArray mutableCopy];
                        //その配列の中で何番目か検索
                        NSUInteger arrayIndex = [array indexOfObject:[NSNumber numberWithInteger:app.index+1]];
                        //最後の場合
                        if(arrayIndex == [array count]-1)
                        {
                            //最初のブックマークに移動
                            app.index = [[array objectAtIndex:0]intValue]-1;
                        }
                        //最後ではない場合
                        else
                        {
                            //次のブックマークに移動
                            app.index = [[array objectAtIndex:arrayIndex+1]intValue]-1;
                        }
                    }
                    [self setImage];
                }
                //登録済みの場合
                else
                {
                    //ブックマークが2つ以上ある場合
                    if([[[plistValue objectAtIndex:plistKeyIndex] objectAtIndex:4]count] > 1)
                    {
                        //最後のブックマークの場合
                        if(bookmarkIndex == [[[plistValue objectAtIndex:plistKeyIndex] objectAtIndex:4]count]-1)
                        {
                            //最初のブックマークに移動
                            app.index = [[[[plistValue objectAtIndex:plistKeyIndex] objectAtIndex:4]objectAtIndex:0]intValue]-1;
                        }
                        //最後のブックマークではない場合
                        else
                        {
                            //次のブックマークに移動
                            app.index = [[[[plistValue objectAtIndex:plistKeyIndex] objectAtIndex:4]objectAtIndex:bookmarkIndex+1]intValue]-1;
                        }
                        [self setImage];
                    }
                }
                //ウィンドウタイトルを再読込する
                [self setWindowTitle];
            }
        }
    }
}

//ブックマークをすべて削除
- (void)bookmarkAllRemove
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //空でないことを確認
    if(app.listSize)
    {
        //ブックマークが空ではない場合
        if([[plistValue objectAtIndex:plistKeyIndex] objectAtIndex:4] != [NSNumber numberWithInteger:0])
        {
            //確認パネルを起動
            [self openConfirmPanel:@"bookmarkAllRemove"];
        }
    }
}

//確認パネルを起動
- (void)openConfirmPanel:(NSString*)whatConfirm
{
    [[NSApplication sharedApplication]
     beginSheet:confirmPanel
     modalForWindow:viewWindow
     modalDelegate:self
     didEndSelector:@selector(confirmPanelClose:returnCode:contextInfo:)
     contextInfo:whatConfirm];
    
    //『ブックマークをすべて削除』の場合
    if([whatConfirm  isEqual: @"bookmarkAllRemove"])
    {
        [confirmPanel_text setStringValue:NSLocalizedString(@"すべてのブックマークを削除しますか？",@"")];
    }
    //『アーカイブをゴミ箱に入れる(フォルダ)』の場合
    else if([whatConfirm  isEqual: @"folderDelete"])
    {
        [confirmPanel_text setStringValue:NSLocalizedString(@"警告:これはフォルダです。\n本当に削除しますか？",@"")];
    }
}

//確認パネル_OKボタン
- (void)confirmPanelOKButton
{
    [[NSApplication sharedApplication]endSheet:confirmPanel returnCode:NSOKButton];
}

//確認パネル_キャンセルボタン
- (void)confirmPanelCancelButton
{
    [[NSApplication sharedApplication]endSheet:confirmPanel returnCode:NSCancelButton];
}

//確認パネルが閉じられた時
- (void)confirmPanelClose:(NSWindow*)panel returnCode:(int)returnCode contextInfo:(void*)contextInfo
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //パネルを閉じる
    [confirmPanel orderOut:self];
    
    //OKボタンを押した場合
    if(returnCode == NSOKButton)
    {
        //『ブックマークをすべて削除』の場合
        if(contextInfo == @"bookmarkAllRemove")
        {
            //[NSNumber:0]に差し替え
            [[plistValue objectAtIndex:plistKeyIndex] replaceObjectAtIndex:4 withObject:[NSNumber numberWithInteger:0]];
            
            //ウィンドウタイトルを再読込する
            [self setWindowTitle];
            //ブックマークメニューを再読込する
            [self bookmarkMenuReload];
        }
        //『アーカイブをゴミ箱に入れる(フォルダ)』の場合
        else if(contextInfo == @"folderDelete")
        {
            //app.nowOpenImageFolderを0に、app.nowOpenZIPを1にしてarchiveDeleteを実行することで、
            //結果的に現在のフォルダを削除する
            app.nowOpenImageFolder = 0;
            app.nowOpenZIP = 1;
            [self archiveDelete];
        }
    }
    //キャンセルボタンを押した場合
    else if(returnCode == NSCancelButton)
    {
        return;
    }
}



//確認パネル_OKボタン
- (IBAction)confirmPanelOKButton:(id)sender
{
    [self confirmPanelOKButton];
}

//確認パネル_キャンセルボタン
- (IBAction)confirmPanelCancelButton:(id)sender
{
    [self confirmPanelCancelButton];
}

//スライドショー関連
- (void)slideshow01
{
    [self slideshowPlay:0.1 random:0];
}

- (void)slideshow02
{
    [self slideshowPlay:0.2 random:0];
}

- (void)slideshow03
{
    [self slideshowPlay:0.3 random:0];
}

- (void)slideshow04
{
    [self slideshowPlay:0.4 random:0];
}

- (void)slideshow05
{
    [self slideshowPlay:0.5 random:0];
}

- (void)slideshow06
{
    [self slideshowPlay:0.6 random:0];
}

- (void)slideshow07
{
    [self slideshowPlay:0.7 random:0];
}

- (void)slideshow08
{
    [self slideshowPlay:0.8 random:0];
}

- (void)slideshow09
{
    [self slideshowPlay:0.9 random:0];
}

- (void)slideshow1
{
    [self slideshowPlay:1 random:0];
}

- (void)slideshow2
{
    [self slideshowPlay:2 random:0];
}

- (void)slideshow3
{
    [self slideshowPlay:3 random:0];
}

- (void)slideshow4
{
    [self slideshowPlay:4 random:0];
}

- (void)slideshow5
{
    [self slideshowPlay:5 random:0];
}

- (void)slideshow6
{
    [self slideshowPlay:6 random:0];
}

- (void)slideshow7
{
    [self slideshowPlay:7 random:0];
}

- (void)slideshow8
{
    [self slideshowPlay:8 random:0];
}

- (void)slideshow9
{
    [self slideshowPlay:9 random:0];
}

- (void)slideshowRandom01
{
    [self slideshowPlay:0.1 random:1];
}

- (void)slideshowRandom02
{
    [self slideshowPlay:0.2 random:1];
}

- (void)slideshowRandom03
{
    [self slideshowPlay:0.3 random:1];
}

- (void)slideshowRandom04
{
    [self slideshowPlay:0.4 random:1];
}

- (void)slideshowRandom05
{
    [self slideshowPlay:0.5 random:1];
}

- (void)slideshowRandom06
{
    [self slideshowPlay:0.6 random:1];
}

- (void)slideshowRandom07
{
    [self slideshowPlay:0.7 random:1];
}

- (void)slideshowRandom08
{
    [self slideshowPlay:0.8 random:1];
}

- (void)slideshowRandom09
{
    [self slideshowPlay:0.9 random:1];
}

- (void)slideshowRandom1
{
    [self slideshowPlay:1 random:1];
}

- (void)slideshowRandom2
{
    [self slideshowPlay:2 random:1];
}

- (void)slideshowRandom3
{
    [self slideshowPlay:3 random:1];
}

- (void)slideshowRandom4
{
    [self slideshowPlay:4 random:1];
}

- (void)slideshowRandom5
{
    [self slideshowPlay:5 random:1];
}

- (void)slideshowRandom6
{
    [self slideshowPlay:6 random:1];
}

- (void)slideshowRandom7
{
    [self slideshowPlay:7 random:1];
}

- (void)slideshowRandom8
{
    [self slideshowPlay:8 random:1];
}

- (void)slideshowRandom9
{
    [self slideshowPlay:9 random:1];
}

- (void)slideshow0
{
    [self slideshowStop];
}

@end
