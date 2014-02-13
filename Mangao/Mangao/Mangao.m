//
//  Mangao.m
//  Mangao Kai
//
//  Created by Ryota Minami <RyotaMinami93@gmail.com> on 2014/01/09.
//  Modified by DJ.HAN http://djhan.ddanzimovie.com/ .
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
//
//  (NSImage*)readImage - if([[app.filePath lowercaseString] hasSuffix:@".pdf"]) function is:
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
#import "HTMangaColorize.h"
#import "AutoEnhance.h"
#import "BrightnessAndContrast.h"
#import "Grayscale.h"
#import "SepiaTone.h"
#import "AutoLevel.h"
//xadMaster
#import <XADMaster/XADArchive.h>
//audio 관련 coreaudio, avfoundation 임포트
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
//convert 함수 임포트
#import "PDFPageToImage.h"
//sparkle
#import <Sparkle/Sparkle.h>
//AudioInput
//#import "AudioInput.h"
//임시 파일 삭제 함수
#import "DeleteTempFile.h"
//pdfpage to imagearray 함수 도입
#import "importPDFPageArrayFromPDF.h"
<<<<<<< HEAD
//centerScrollingView 도입
#import "CenterScrollingView.h"
=======
>>>>>>> ef14c5b17f9fd6cae9c2351244ec0f3ccfeb08ad

@implementation Mangao

@synthesize viewWindow;
@synthesize mainMenu;
@synthesize mainMenuItem;
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
@synthesize thumbnailScrollView;
@synthesize thumbnailView;
//pagenumber 추가
@synthesize pagenumberPrev;
@synthesize pagenumberNext;
//xadarchive 관련 추가
//압축 파일의 종류
@synthesize archiveFileType;
//패스워드 선언
@synthesize password;
@synthesize passwordNotice;
@synthesize passwordField;
@synthesize passwordPanel;
@synthesize isPassword;
//@synthesize rightExtract;

//許可する画像の種類
@synthesize imageFileType;
//画像を選択して開いた場合、その画像のフルパス
@synthesize selectionImageFilePath;
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
//スライドショーのNSTimer
@synthesize slideshow;
//現在アーカイブを読込中かどうか
@synthesize isLoadingArchive;
//現在アーカイブを読込中で画像がセットされる前かどうか
@synthesize isLoadingArchiveNotSetImage;
//現在アーカイブ読み込みをキャンセル中かどうか
@synthesize isCancelLoadingArchive;
//開いた画像がヨコナガ
@synthesize isYokonaga;
//開いているアーカイブが左開きかどうか
@synthesize isHidaribiraki;
//썸네일 뷰의 좌철/우철 상태를 저장
@synthesize isHidaribirakiThumb;
//開いているアーカイブが1画面かどうか
@synthesize isOnePage;
//現在スライドショーを実行しているかどうか
@synthesize isSlideshow;
//現在フルスクリーンfor10.6を実行しているかどうか
@synthesize isFitToScreen;
//現在サムネイル一覧を実行しているかどうか
@synthesize isThumbnail;
//現在ルーペを使用しているかどうか(1==小さい,2==大きい)
@synthesize isLoupe;
//最後にサムネイル一覧を実行した時のパス
@synthesize thumbnailPath;
//현재 썸네일 넘버
@synthesize thumbnailNumber;
//MangaoによってマウントしたTrueCryptボリュームの一覧
@synthesize mountedTrueCryptVolume;
//『フルスクリーン』実行前のウィンドウのNSRect
@synthesize windowRectBeforeFullscreen;
//ImageCenterField上でのマウスカーソルの座標
@synthesize cursor_onImageCenterField;
//最後に二本指ダブルタップをした時間
@synthesize timestamp_tapWithTwoFingers;
//환경설정 변수
@synthesize defaults;
@synthesize plistKey;
@synthesize plistValue;
@synthesize plistKeyIndex;

//오디오 인풋 패널 설정
@synthesize audioInputPanel;
@synthesize isAudioInput;

<<<<<<< HEAD
//PDFview 선언
@synthesize leftPdfView;
@synthesize rightPdfView;
@synthesize centerPdfView;

//view setting
@synthesize viewSetting; //0은 fit to window, 1은 fit to width
@synthesize centerScrollView;

=======
>>>>>>> ef14c5b17f9fd6cae9c2351244ec0f3ccfeb08ad
- (void)dealloc
{
    [super dealloc];
}

//アプリケーション起動前に呼び出される
- (void)applicationWillFinishLaunching:(NSNotification *)aNotification
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //View Setting 초기 설정
    //0은 fit to window, 1은 fit to width
    viewSetting = 0;

    //メインメニューを構成
    [self buildMainMenu];
    
    //初期状態にする
    [self resetMangao];
    
    //ウインドウのサイズと場所を記憶するようにする
    [self.viewWindow setFrameAutosaveName:@"Autosave"];
    
    //plistを読み込み
    //この方法以外だと"mutating method sent to immutable object"になる
    app.defaults = [NSUserDefaults standardUserDefaults];
    app.plistKey = [[defaults objectForKey:@"key"]mutableCopy];
    app.plistValue = [[defaults objectForKey:@"value"]mutableCopy];
    
    //버그 회피를 위해 메뉴를 한 번 더 로딩한다
    [self reloadMainMenu];
    
    //썸네일 펼쳐보기 방향을 메인 윈도우 좌철/우철 보기와 싱크
    app.isHidaribirakiThumb = app.isHidaribiraki;

    //初回起動の場合
    if(!app.plistKey || !app.plistValue)
    {
        //plistKeyに@"00000000000000000000000000000000"を追加
        //plistValueに(0.넘기기 구분(좌철/우철), 1.기본으로 1장씩 열어보기, 2.기본으로 오른쪽 회전, 3.기본으로 왼쪽 회전, 4.자동 채색 / 이미지 보정 / 세피아톤 / 그레이스케일 설정에 따라 체크 유무 설정, 5.밝기, 6.대비, 7.오디오 인풋 볼륨,8.항상 처음부터 읽기 On/Off, 9.배경색)を追加
        app.plistKey = [NSMutableArray arrayWithObject:@"00000000000000000000000000000000"];
        app.plistValue = [NSMutableArray arrayWithObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:1],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],nil]];
    }
    
    //許可する画像の種類をセット
    app.imageFileType = [NSArray arrayWithObjects:@"jpg",@"JPG",@"jpeg",@"JPEG",@"png",@"PNG",@"gif",@"GIF",@"bmp",@"BMP",@"tif",@"TIF",@"tiff",@"TIFF",nil];

    //사용 가능한 압축 파일 종류 세팅
    app.archiveFileType = [NSArray arrayWithObjects:@"zip",@"cbz",@"rar",@"cbr",@"7z",@"cb7",@"lzh",@"lha",@"tar",@"gz",@"bz2",@"xz",@"cab",nil];

    //左開きに設定
    imageLeftFieldxxx = imageLeftField;
    imageRightFieldxxx = imageRightField;
    
    //マウスカーソルの初期座標を設定
    //ImageCenterField上でのマウスカーソルの座標を取得
    app.cursor_onImageCenterField = [app.imageCenterField convertPoint:[[self viewWindow] convertScreenToBase:[NSEvent mouseLocation]] fromView:nil];
    
    //썸네일 번호 텍스트필드 감추기
    thumbnailNumber.hidden = 1;
    //페이지넘버 텍스트필드 감추기
    pagenumberPrev.hidden = 1;
    pagenumberNext.hidden = 1;
    
    //메인 윈도우의 풀스크린 진입 체크
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowDidEnterFullScreen:) name:NSWindowDidEnterFullScreenNotification object:viewWindow];
    //메인 윈도우의 풀스크린 해제 체크
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowDidExitFullScreen:) name:NSWindowDidExitFullScreenNotification object:viewWindow];
    //입력 볼륨이 일정 이상 넘었을 경우 발생하는 notification을 체크
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptSound:) name:@"NCacceptSound" object:nil];
    //오디오 인풋 패널을 닫으라는 notification을 체크
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeAudioInputPanel:) name:@"NCcloseAudioInputPnael" object:nil];
    
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
                     if (viewSetting == 0)
                     {//二本指タップのタイムスタンプをリセット
                         app.timestamp_tapWithTwoFingers = 0;
                         [self pageNext];}
                     //else if (viewSetting == 1)
                     //{[self scrollDownScrollView:[event deltaY]];}
                 }
                 //下スクロールなら戻る
                 else if([event deltaY] > 0)
                 {
                     if (viewSetting == 0)
                     {//二本指タップのタイムスタンプをリセット
                     app.timestamp_tapWithTwoFingers = 0;
                         [self pagePrev];}
                     //else if (viewSetting == 1)
                     //{[self scrollUpScrollView:[event deltaY]];}
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
                 if(abs(app.isHidaribiraki - [[[app.plistValue objectAtIndex:0] objectAtIndex:0] intValue]))
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
                 //Shift+Tabが入力された場合
                 if([event keyCode] == 48 && [event modifierFlags] == 131330)
                 {
                     //10ページ戻る
                     [self page10Prev];
                 }
                 //Tabが入力された場合
                 else if([event keyCode] == 48 && [event modifierFlags] == 256)
                 {
                     //10ページ進む
                     [self page10Next];
                 }
             }
         }
         
         //Escが入力された場合
         if([event type] == 10 && [event keyCode] == 53)
         {
             //패스워드 창이 표시중일 때
             if(app.isPassword)
             {
                 [[NSApplication sharedApplication] endSheet:passwordPanel returnCode:NSOKButton];
             }
             //アーカイブ読み込み中
             else if(app.isLoadingArchive)
             {
                 //キーコードが残っているとフルスクリーンが解除されるのでeventをクリアする
                 event = NULL;
             
                 //アーカイブ読み込みをキャンセル
                 [self cancelLoadArchive];
             }
             //サムネイル一覧中かつアーカイブ読み込み中ではない場合
             else if(app.isThumbnail)
             {
                 //サムネイル一覧を終了
                 [self exitThumbnail];
             }
             //ルーペ中かつアーカイブ読み込み中・サムネイル一覧中ではない場合
             else if(app.isLoupe)
             {
                 //キーコードが残っているとフルスクリーンが解除されるのでeventをクリアする
                 event = NULL;
                 
                 //ルーペを終了
                 app.isLoupe = 0;
                 //マウスカーソルを表示する
                 [NSCursor unhide];
                 //ルーペウィンドウを無効にする
                 [[self loupeWindow] orderOut:self];
             }
             //フルスクリーン中かつアーカイブ読み込み中・サムネイル一覧中・ルーペ中ではない場合
             else if(![NSMenu menuBarVisible])
             {
                 //フルスクリーンを解除
                 [self fullscreen];
             }
         }
         
         //サムネイル一覧中
         if(app.isThumbnail)
         {
             //右クリック
             if(([event type] == 3))
             {
                 //サムネイル一覧を終了
                 [self exitThumbnail];
             }
             //휠 스크롤일 경우
             else if([event type] == 22)
             {
                 //上スクロールなら進む
                 if([event deltaY] < 0)
                 {
                     //二本指タップのタイムスタンプをリセット
                     app.timestamp_tapWithTwoFingers = 0;
                     if (app.isHidaribiraki)
                     {
                         [self thumbnailSelectNextItem];
                     }
                     else
                     {
                         [self thumbnailSelectPrevItem];
                     }
                     
                 }
                 //下スクロールなら戻る
                 else if([event deltaY] > 0)
                 {
                     //二本指タップのタイムスタンプをリセット
                     app.timestamp_tapWithTwoFingers = 0;
                     if (app.isHidaribiraki)
                     {
                         [self thumbnailSelectPrevItem];
                     }
                     else
                     {
                         [self thumbnailSelectNextItem];
                     }
                 }
             }
             
             //キー入力の場合
             if([event type] == 10)
             {
                 //装飾キー無しの場合
                 if([event modifierFlags] == 10486016 || [event modifierFlags] == 256)
                 {
                     //←가 입력된 경우 이전 아이템 선택, 우철(왼쪽 방향으로 보기)일 때는 다음 아이템 선택
                     if([event keyCode] == 123)
                     {
                         //前のアイテムを選択
                         //단일 입력만 받아들이는 건 일시 보류
                         if (![event isARepeat])
                         {
                             app.timestamp_tapWithTwoFingers = 0;
                             [self thumbnailSelectPrevItem];
                         }
                         //연속 입력시
                         else
                         {
                             app.timestamp_tapWithTwoFingers = 0;
                             [self thumbnailSelectRepeatPrevItem];
                         }
                     }
                     //→이 입력된 경우, 다음 아이템 선택, 우철(왼쪽 방향으로 보기)일 때는 이전 아이템 선택
                     else if([event keyCode] == 124)
                     {
                         //次のアイテムを選択
                         //단일 입력만 받아들이는 건 일시 보류
                         if (![event isARepeat])
                         {
                             app.timestamp_tapWithTwoFingers = 0;
                             [self thumbnailSelectNextItem];
                         }
                         //연속 입력시
                         else
                         {
                             app.timestamp_tapWithTwoFingers = 0;
                             [self thumbnailSelectRepeatNextItem];
                         }
                     }
                     //Tabが入力された場合
                     else if([event keyCode] == 48)
                     {
                         //次のページのアイテムを選択
                         if (app.isHidaribiraki)
                         {
                             [self thumbnailSelectNextPageItem];
                         }
                         else
                         {
                             [self thumbnailSelectPrevPageItem];
                         }
                     }
                     //Space가 입력된 경우
                     else if ([event keyCode] == 49)
                     {
                         //次のページのアイテムを選択
                             [self thumbnailSelectSpacePrevPageItem];
                     }
                     //j가 입력된 경우 이전 페이지로, 화살표 키와 분리 (이유는 중앙 포커스 때문)
                     else if([event keyCode] == 38)
                     {
                             [self thumbnailSelectPrevItem];
                     }
                     //k가 입력된 경우 다음 페이지로, 화살표 키와 분리 (이유는 중앙 포커스 때문)
                     else if([event keyCode] == 40)
                     {
                         [self thumbnailSelectNextItem];
                     }
                     //↓키 입력시, 다음 페이지로, 우철일 때도.
                     else if([event keyCode] == 125)
                     {
                         if (app.isHidaribiraki)
                         {
                             [self thumbnailSelectNextItem];
                         }
                         else
                         {
                             [self thumbnailSelectPrevItem];
                         }
                     }
                     //↑키 입력시, 이전 페이지로, 우철일 때도.
                     else if([event keyCode] == 126)
                     {
                         if (app.isHidaribiraki)
                         {
                             [self thumbnailSelectPrevItem];
                         }
                         else
                         {
                             [self thumbnailSelectNextItem];
                         }
                     }

                     //Enterが入力された場合
                     else if([event keyCode] == 36)
                     {
                         //選択されているアイテムを開く
                         [self thumbnailOpenSelectedItem];
                         //キーコードが残っていると(void)fullscreenが発生するのでeventをクリアする
                         event = NULL;
                     }
                 }
                 //Ctrlキーを同時に押している場合
                 else if([event modifierFlags] == 11534600 || [event modifierFlags] == 1048840)
                 {
                     //←,↑,k,hが入力された場合
                     if([event keyCode] == 123 || [event keyCode] == 126 || [event keyCode] == 40 || [event keyCode] == 4)
                     {
                         //最初のアイテムを選択
                         [self thumbnailSelectFirstItem];
                     }
                     //→,↓,j,lが入力された場合
                     else if([event keyCode] == 124 || [event keyCode] == 125 || [event keyCode] == 38 || [event keyCode] == 37)
                     {
                         //最後のアイテムを選択
                         [self thumbnailSelectLastItem];
                     }
                 }
                 //Shiftキーを同時に押している場合
                 else if([event modifierFlags] == 131330)
                 {
                     //Tab,Spaceが入力された場合
                     if([event keyCode] == 48)
                     {
                         if (app.isHidaribiraki)
                         {
                             //前のページのアイテムを選択
                             [self thumbnailSelectPrevPageItem];
                         }
                         else
                         {
                             [self thumbnailSelectNextPageItem];
                         }
                     }
                     //Space가 입력된 경우
                     else if ([event keyCode] == 49)
                     {
                         //次のページのアイテムを選択
                         if (app.isHidaribiraki)
                         {
                             [self thumbnailSelectSpacePrevPageItem];
                         }
                         else
                         {
                             [self thumbnailSelectSpaceNextPageItem];
                         }
                     }
                 }
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

//最後のウィンドウを閉じた時、アプリケーションを完全に終了

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication*)theApplication
{
    return YES;
}

//アプリケーション終了時に、
//・key,valueを更新
//・NSNavLastRootDirectory(『開く』で最後に開いた場所)を削除
//・MangaoによってマウントしたTrueCryptボリュームをすべてアンマウント
- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication*)sender
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    [defaults removeObjectForKey:@"key"];
    [defaults removeObjectForKey:@"value"];
    [defaults setObject:app.plistKey forKey:@"key"];
    [defaults setObject:app.plistValue forKey:@"value"];
    
    [defaults removeObjectForKey:@"NSNavLastRootDirectory"];
    
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
    
    //압축 파일 안의 압축 파일을 열기 위한 Temporary 파일의 확인 및 삭제
    NSString *deletedTempFolder = [NSString stringWithFormat:@"archivetemp"];
    [DeleteTempFile deleteTempFile:deletedTempFolder];
    
    return YES;
}

//압축 파일 안의 압축 파일을 열기 위한 Temporary 파일의 확인 및 삭제하는 함수 (새로운 파일 오픈시, 종료시 실행하도록 지정)
/*- (void)deleteTempFiles
{
    NSString *tempFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"/archivetemp"];
    if ([[NSFileManager defaultManager] contentsOfDirectoryAtPath:tempFilePath error:nil])
    {
        NSArray* tempFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:tempFilePath error:NULL];
        //NSLog(@"there is temp file");
        for (NSString *filename in tempFiles) {
            [[NSFileManager defaultManager] removeItemAtPath:[tempFilePath stringByAppendingPathComponent:filename] error:NULL];
        }
    }
    //디렉토리까지 삭제
    [[NSFileManager defaultManager] removeItemAtPath:tempFilePath error:NULL];
}*/

- (void)buildMainMenu
{
    mainMenu = [[NSMenu alloc] init];
    
    [mainMenu addItemWithTitle:NSLocalizedString(@"開く",@"") action:@selector(openMenu) keyEquivalent:@"o"];
    [[mainMenu addItemWithTitle:NSLocalizedString(@"",@"") action:@selector(openMenu) keyEquivalent:@"o"] setKeyEquivalentModifierMask:0];
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
    
    [mainMenu addItem: [NSMenuItem separatorItem]];
    
    [mainMenuItem setSubmenu:mainMenu];
}

//メインメニューを再構成
- (void)reloadMainMenu
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    if([mainMenu numberOfItems] != 4)
    {
    for(int i=0;i<32;i++)
        {
            //NSLog(@"removed item:%@", [mainMenu itemAtIndex:4]);
            [mainMenu removeItemAtIndex:4];
        }
    }
    
    NSMenuItem	*GoPageItem = [[[NSMenuItem alloc] init] autorelease];
    NSMenu *GoPage = [[[NSMenu alloc] init] autorelease];
    [GoPageItem setTitle:NSLocalizedString(@"ページ移動",@"")];
    [GoPage setTitle: NSLocalizedString(@"ページ移動",@"")];
    //右開きの場合(『デフォルトで左開き』を考慮)
    if(!(abs(app.isHidaribiraki - [[[app.plistValue objectAtIndex:0] objectAtIndex:0] intValue])))
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
    //右開きの場合(『デフォルトで左開き』を考慮)
    if(!(abs(app.isHidaribiraki - [[[app.plistValue objectAtIndex:0] objectAtIndex:0] intValue])))
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
    //右開きの場合(『デフォルトで左開き』を考慮)
    if(!(abs(app.isHidaribiraki - [[[app.plistValue objectAtIndex:0] objectAtIndex:0] intValue])))
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
    //右開きの場合(『デフォルトで左開き』を考慮)
    if(!(abs(app.isHidaribiraki - [[[app.plistValue objectAtIndex:0] objectAtIndex:0] intValue])))
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
    
    NSMenuItem *NSMenuItemDefaultRotateRight = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"右に回転",@"") action:@selector(defaultRotateRight) keyEquivalent:@"]"];
    NSMenuItem *NSMenuItemDefaultRotateLeft = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"左に回転",@"") action:@selector(defaultRotateLeft) keyEquivalent:@"["];
    [NSMenuItemDefaultRotateRight setKeyEquivalentModifierMask:0];
    [NSMenuItemDefaultRotateLeft setKeyEquivalentModifierMask:0];
    //デフォルトで右回転・左回転がオン・オフに応じてメニューアイテムにチェックを付け消しする
    if([[[app.plistValue objectAtIndex:0] objectAtIndex:2] intValue])
    {
        [NSMenuItemDefaultRotateRight setState:NSOnState];
    }
    else
    {
        [NSMenuItemDefaultRotateRight setState:NSOffState];
    }
    if([[[app.plistValue objectAtIndex:0] objectAtIndex:3] intValue])
    {
        [NSMenuItemDefaultRotateLeft setState:NSOnState];
    }
    else
    {
        [NSMenuItemDefaultRotateLeft setState:NSOffState];
    }
    [mainMenu addItem:NSMenuItemDefaultRotateRight];
    [mainMenu addItem:NSMenuItemDefaultRotateLeft];
    
    [mainMenu addItem: [NSMenuItem separatorItem]];
    NSMenuItem	*PreferenceItem = [[[NSMenuItem alloc] init] autorelease];
    NSMenu *Preference = [[[NSMenu alloc] init] autorelease];
    [PreferenceItem setTitle:NSLocalizedString(@"環境設定",@"")];
    [Preference setTitle: NSLocalizedString(@"環境設定",@"")];
    NSMenuItem *NSMenuItemDefaultHidaribiraki = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"デフォルトで左開き",@"") action:@selector(defaultHidaribiraki) keyEquivalent:@""];
    NSMenuItem *NSMenuItemDefaultOnePageDisplay = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"デフォルトで1画面",@"") action:@selector(defaultOnePageDisplay) keyEquivalent:@""];
    NSMenuItem *NSMenuItemDefaultReadFromFirstPage = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"いつも最初から読む",@"") action:@selector(defaultReadFromFirstPage) keyEquivalent:@"p"];
    [NSMenuItemDefaultReadFromFirstPage setKeyEquivalentModifierMask:NSAlternateKeyMask|NSCommandKeyMask];
    [NSMenuItemDefaultReadFromFirstPage setKeyEquivalentModifierMask:NSAlternateKeyMask|NSCommandKeyMask];
    //오디오 인풋 메뉴 추가
    NSMenuItem *NSMenuItemShowAudioInputPanel = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"Audio Input",@"") action:@selector(showAudioInputPanel) keyEquivalent:@"a"];
    [NSMenuItemShowAudioInputPanel setKeyEquivalentModifierMask:NSAlternateKeyMask|NSCommandKeyMask];
    
    //업데이트 메뉴 추가
    SUUpdater *suUpdater = [SUUpdater updaterForBundle:[NSBundle mainBundle]];
    NSMenuItem *NSMenuItemCheckUpdate = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"Check for update...",@"") action:@selector(checkForUpdates:) keyEquivalent:@""];
    [NSMenuItemCheckUpdate setTarget:suUpdater];

    //좌우 넘겨보기(좌철, 우철 구분), 1화면으로 보기, 항상 처음부터 읽기의 체크 유무 설정
    if([[[app.plistValue objectAtIndex:0] objectAtIndex:0] intValue])
    {
        [NSMenuItemDefaultHidaribiraki setState:NSOnState];
    }
    else
    {
        [NSMenuItemDefaultHidaribiraki setState:NSOffState];
    }
    if([[[app.plistValue objectAtIndex:0] objectAtIndex:1] intValue])
    {
        [NSMenuItemDefaultOnePageDisplay setState:NSOnState];
    }
    else
    {
        [NSMenuItemDefaultOnePageDisplay setState:NSOffState];
    }
    if([[[app.plistValue objectAtIndex:0] objectAtIndex:8] intValue])
    {
        [NSMenuItemDefaultReadFromFirstPage setState:NSOnState];
<<<<<<< HEAD
    }
    else
    {
        [NSMenuItemDefaultReadFromFirstPage setState:NSOffState];
    }
=======
    }
    else
    {
        [NSMenuItemDefaultReadFromFirstPage setState:NSOffState];
    }
>>>>>>> ef14c5b17f9fd6cae9c2351244ec0f3ccfeb08ad
    //오디오 인풋의 체크 유무 설정. 환경설정 대신 전역변수 isAudioInput의 값으로 체크
    if(isAudioInput)
    {
        [NSMenuItemShowAudioInputPanel setState:NSOnState];
    }
    else
    {
        [NSMenuItemShowAudioInputPanel setState:NSOffState];
    }
    [Preference addItem:NSMenuItemDefaultHidaribiraki];
    [Preference addItem:NSMenuItemDefaultOnePageDisplay];
    [Preference addItem:NSMenuItemDefaultReadFromFirstPage];
    [Preference addItem:NSMenuItemShowAudioInputPanel];
    [Preference addItem:NSMenuItemCheckUpdate];
    
    [[Preference addItemWithTitle:NSLocalizedString(@"背景色を変更",@"") action:@selector(changeBackgroundColor) keyEquivalent:@"c"] setKeyEquivalentModifierMask:0];
    [PreferenceItem setSubmenu: Preference];
    [mainMenu addItem: PreferenceItem];
    
    NSMenuItem	*ImageEffectsItem = [[[NSMenuItem alloc] init] autorelease];
    NSMenu *ImageEffects = [[[NSMenu alloc] init] autorelease];
    [ImageEffectsItem setTitle:NSLocalizedString(@"イメージ効果",@"")];
    [ImageEffects setTitle:NSLocalizedString(@"イメージ効果",@"")];
    
    NSMenuItem *NSMenuItemNone  = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"効果なし",@"") action:@selector(SetImageEffectsOff) keyEquivalent:@"n"];
    NSMenuItem *NSMenuItemAutoColorize  = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"自動着色",@"") action:@selector(SetImageEffectsAutoColorize) keyEquivalent:@"a"];
    NSMenuItem *NSMenuItemAutoImageEnhance  = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"自動イメージ補訂",@"") action:@selector(SetImageEffectsAutoImageEnhance) keyEquivalent:@"i"];
    NSMenuItem *NSMenuItemAutoLevelNormal  = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"自動コントラスト(普通に)",@"") action:@selector(SetImageEffectsAutoLevelNormal) keyEquivalent:@"c"];
    NSMenuItem *NSMenuItemAutoLevelStrong  = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"自動コントラスト(強く)",@"") action:@selector(SetImageEffectsAutoLevelStrong) keyEquivalent:@"C"];
    NSMenuItem *NSMenuItemSepiaTone  = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"セピアトーン",@"") action:@selector(SetImageEffectsSepiaTone) keyEquivalent:@"e"];
    NSMenuItem *NSMenuItemGrayscale  = [[NSMenuItem alloc]initWithTitle:NSLocalizedString(@"グレースケール",@"") action:@selector(SetImageEffectsGrayscale) keyEquivalent:@"g"];
    
    //Image Effects:
    //0==None
    //1==Auto Colorize
    //2==Auto Image Enchancement
    //3==Auto Contrast
    //4==Auto Contrast (Strong)
    //5==Sepia Tone
    //6==Grayscale
    [NSMenuItemNone setState:NSOffState];
    [NSMenuItemAutoColorize setState:NSOffState];
    [NSMenuItemAutoImageEnhance setState:NSOffState];
    [NSMenuItemAutoLevelNormal setState:NSOffState];
    [NSMenuItemAutoLevelStrong setState:NSOffState];
    [NSMenuItemSepiaTone setState:NSOffState];
    [NSMenuItemGrayscale setState:NSOffState];
    
    if([[[app.plistValue objectAtIndex:0] objectAtIndex:4] intValue] == 0)
    {
        [NSMenuItemNone setState:NSOnState];
    }
    else if([[[app.plistValue objectAtIndex:0] objectAtIndex:4] intValue] == 1)
    {
        [NSMenuItemAutoColorize setState:NSOnState];
    }
    else if([[[app.plistValue objectAtIndex:0] objectAtIndex:4] intValue] == 2)
    {
        [NSMenuItemAutoImageEnhance setState:NSOnState];
    }
    else if([[[app.plistValue objectAtIndex:0] objectAtIndex:4] intValue] == 3)
    {
        [NSMenuItemAutoLevelNormal setState:NSOnState];
    }
    else if([[[app.plistValue objectAtIndex:0] objectAtIndex:4] intValue] == 4)
    {
        [NSMenuItemAutoLevelStrong setState:NSOnState];
    }
    else if([[[app.plistValue objectAtIndex:0] objectAtIndex:4] intValue] == 5)
    {
        [NSMenuItemSepiaTone setState:NSOnState];
    }
    else if([[[app.plistValue objectAtIndex:0] objectAtIndex:4] intValue] == 6)
    {
        [NSMenuItemGrayscale setState:NSOnState];
    }
    
    [ImageEffects addItem:NSMenuItemNone];
    [ImageEffects addItem:NSMenuItemAutoColorize];
    [ImageEffects addItem:NSMenuItemAutoImageEnhance];
    [ImageEffects addItem:NSMenuItemAutoLevelNormal];
    [ImageEffects addItem:NSMenuItemAutoLevelStrong];
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
    [NSMenuItemDefaultBrightness setState:NSOffState];
    [NSMenuItemMinusBrightness setState:NSOffState];
    [NSMenuItemPlusBrightness setState:NSOffState];
    if([[[plistValue objectAtIndex:0] objectAtIndex:5] floatValue] == 0)
    {
        [NSMenuItemDefaultBrightness setState:NSOnState];
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
    [NSMenuItemDefaultContrast setState:NSOffState];
    [NSMenuItemMinusContrast setState:NSOffState];
    [NSMenuItemPlusContrast setState:NSOffState];
    if([[[plistValue objectAtIndex:0] objectAtIndex:6] floatValue] == 1)
    {
        [NSMenuItemDefaultContrast setState:NSOnState];
    }

    [Contrast addItem:NSMenuItemDefaultContrast];
    [Contrast addItem:NSMenuItemMinusContrast];
    [Contrast addItem:NSMenuItemPlusContrast];
    [ContrastItem setSubmenu: Contrast];
    [mainMenu addItem: ContrastItem];
    
    [[mainMenu addItemWithTitle:NSLocalizedString(@"サムネイル一覧",@"") action:@selector(thumbnail) keyEquivalent:@"t"] setKeyEquivalentModifierMask:0];
    
    NSMenuItem	*LoupeItem = [[[NSMenuItem alloc] init] autorelease];
    NSMenu *Loupe = [[[NSMenu alloc] init] autorelease];
    [LoupeItem setTitle:NSLocalizedString(@"ルーペ",@"")];
    [Loupe setTitle: NSLocalizedString(@"ルーペ",@"")];
    [[Loupe addItemWithTitle: NSLocalizedString(@"小さいルーペ",@"")
                      action: @selector(loupeSmallOnOff) keyEquivalent: @"l"]setKeyEquivalentModifierMask:0];
    [Loupe addItemWithTitle: NSLocalizedString(@"大きいルーペ",@"")
                     action: @selector(loupeLargeOnOff) keyEquivalent: @"l"];
    [LoupeItem setSubmenu: Loupe];
    [mainMenu addItem: LoupeItem];
    
    NSMenuItem	*BookmarkItem = [[[NSMenuItem alloc] init] autorelease];
    NSMenu *Bookmark = [[[NSMenu alloc] init] autorelease];
    [BookmarkItem setTitle:NSLocalizedString(@"ブックマーク",@"")];
    [Bookmark setTitle: NSLocalizedString(@"ブックマーク",@"")];
    //ブックマークが空ではない場合
    //파일이 열리지 않았을 때 메뉴 변경이 일어나면 죽는 문제를 해결하기 위해서 app.filepath를 체크
    if(([[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:4] != [NSNumber numberWithInteger:0])&& (app.filePath != nil))
    {
        //ブックマークをソート
        //NSLog(@"bookmark:%@",[[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:4]);
        NSArray *sortedArray = [[[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:4] sortedArrayUsingSelector:@selector(compare:)];
        [[app.plistValue objectAtIndex:app.plistKeyIndex] replaceObjectAtIndex:4 withObject:[sortedArray mutableCopy]];
        
        //ブックマーク項目を追加
        for(NSNumber *bookmarkNumber in [[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:4])
        {
            [Bookmark addItemWithTitle:[bookmarkNumber stringValue] action:@selector(bookmarkOpen:) keyEquivalent:@""];
        }
    }
    [Bookmark addItem: [NSMenuItem separatorItem]];
    [[Bookmark addItemWithTitle:NSLocalizedString(@"前のブックマークに移動",@"") action:@selector(bookmarkPrev) keyEquivalent:@"b"] setKeyEquivalentModifierMask:NSShiftKeyMask];
    [Bookmark addItemWithTitle:NSLocalizedString(@"次のブックマークに移動",@"") action:@selector(bookmarkNext) keyEquivalent:@"b"];
    [Bookmark addItem: [NSMenuItem separatorItem]];
    [[Bookmark addItemWithTitle:NSLocalizedString(@"ブックマークに追加/削除",@"") action:@selector(bookmarkAddRemove) keyEquivalent:@"b"] setKeyEquivalentModifierMask:0];
    [Bookmark addItemWithTitle:NSLocalizedString(@"ブックマークをすべて削除",@"") action:@selector(bookmarkAllRemove) keyEquivalent:@""];
    [BookmarkItem setSubmenu: Bookmark];
    [mainMenu addItem: BookmarkItem];
    
    [mainMenu addItem: [NSMenuItem separatorItem]];
    
    NSMenuItem	*SaveImageItem = [[[NSMenuItem alloc] init] autorelease];
    NSMenu *SaveImage = [[[NSMenu alloc] init] autorelease];
    [SaveImageItem setTitle:NSLocalizedString(@"ページをキャプチャ",@"")];
    [SaveImage setTitle: NSLocalizedString(@"ページをキャプチャ",@"")];
    [[SaveImage addItemWithTitle:NSLocalizedString(@"右のページをキャプチャ",@"") action:@selector(saveR) keyEquivalent:@"s"] setKeyEquivalentModifierMask:0];
    [SaveImage addItemWithTitle:NSLocalizedString(@"左のページをキャプチャ",@"") action:@selector(saveL) keyEquivalent:@"s"];
    [SaveImageItem setSubmenu: SaveImage];
    [mainMenu addItem: SaveImageItem];
    
    [mainMenu addItemWithTitle:NSLocalizedString(@"アーカイブをゴミ箱に入れる",@"") action:@selector(archiveDelete) keyEquivalent:@"⌫"];
    
    [mainMenu addItem: [NSMenuItem separatorItem]];
    
    [[mainMenu addItemWithTitle:NSLocalizedString(@"フルスクリーンにする",@"") action:@selector(fullscreen) keyEquivalent:@"f"] setKeyEquivalentModifierMask:NSCommandKeyMask|NSControlKeyMask];
    [[mainMenu addItemWithTitle:NSLocalizedString(@"",@"") action:@selector(fullscreen) keyEquivalent:@"↩"] setKeyEquivalentModifierMask:0];
    [[mainMenu addItemWithTitle:NSLocalizedString(@"画面にフィットする",@"") action:@selector(fitToScreen) keyEquivalent:@"f"] setKeyEquivalentModifierMask:NSCommandKeyMask|NSShiftKeyMask];
    
    [mainMenu addItem: [NSMenuItem separatorItem]];
    
    [mainMenu addItemWithTitle:NSLocalizedString(@"しまう",@"") action:@selector(hide) keyEquivalent:@"m"];
    [[mainMenu addItemWithTitle:NSLocalizedString(@"",@"") action:@selector(hide) keyEquivalent:@"m"] setKeyEquivalentModifierMask:0];
    
    [mainMenu addItem: [NSMenuItem separatorItem]];
    
    [mainMenu addItemWithTitle:NSLocalizedString(@"Mangaoを閉じる",@"") action:@selector(quit) keyEquivalent:@"q"];
    [mainMenu addItemWithTitle:NSLocalizedString(@"",@"") action:@selector(quit) keyEquivalent:@"w"];
    [[mainMenu addItemWithTitle:NSLocalizedString(@"",@"") action:@selector(quit) keyEquivalent:@"q"] setKeyEquivalentModifierMask:0];
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

//자동 콘트라스트(보통)으로 설정
- (void)SetImageEffectsAutoLevelNormal
{
    [self SetBrightness:0.0];
    [self SetContrast:1.0];
    [self SetImageEffects:3];
}

//자동 콘트라스트(강하게)로 설정
- (void)SetImageEffectsAutoLevelStrong
{
    [self SetBrightness:0.0];
    [self SetContrast:1.0];
    [self SetImageEffects:4];
}

//세피아 톤으로 설정
- (void)SetImageEffectsSepiaTone
{
    [self SetBrightness:0.0];
    [self SetContrast:1.0];
    [self SetImageEffects:5];
}

//그레이스케일로 설정
- (void)SetImageEffectsGrayscale
{
    [self SetBrightness:0.0];
    [self SetContrast:1.0];
    [self SetImageEffects:6];
}

//이미지 효과 설정
- (void)SetImageEffects:(int)witch
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //アーカイブ読み込み中もしくはサムネイル一覧実行中ではない場合
    if(!app.isLoadingArchive && !app.isThumbnail)
    {
        //효과 없음, 자동 채색, 자동 이미지 보정, 자동 콘트라스트(보통), 자동 콘트라스트(강하게), 세피아톤, 그레이스케일
        [[plistValue objectAtIndex:0] replaceObjectAtIndex:4 withObject:[NSNumber numberWithInteger:witch]];
        
        //メインメニューを再構成
        [self reloadMainMenu];
        
        if(app.listSize)
        {
            [self setImage];
        }
        
    }
}

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
    [self SetBrightness:0.02];
}

//밝기 어둡게
- (void)SetMinusBrightness
{
    [self SetImageEffects:0];
    [self SetBrightness:-0.02];
}

//밝기 설정
- (void)SetBrightness:(float)witch
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //アーカイブ読み込み中もしくはサムネイル一覧実行中ではない場合
    if(!app.isLoadingArchive && !app.isThumbnail)
    {
        if(!(witch == 0))
        {
            witch = [[[plistValue objectAtIndex:0] objectAtIndex:5] floatValue] + witch;
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
        [[plistValue objectAtIndex:0] replaceObjectAtIndex:5 withObject:[NSNumber numberWithFloat:witch]];
        
        //メインメニューを再構成
        [self reloadMainMenu];
        
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
    [self SetContrast:0.02];
}

//콘트라스트 낮게
- (void)SetMinusContrast
{
    [self SetImageEffects:0];
    [self SetContrast:-0.02];
}

//콘트라스트 설정
- (void)SetContrast:(float)witch
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //アーカイブ読み込み中もしくはサムネイル一覧実行中ではない場合
    if(!app.isLoadingArchive && !app.isThumbnail)
    {
        if(!(witch==1))
        {
            witch = [[[plistValue objectAtIndex:0] objectAtIndex:6] floatValue] + witch;
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
        
        [[plistValue objectAtIndex:0] replaceObjectAtIndex:6 withObject:[NSNumber numberWithFloat:witch]];

        //メインメニューを再構成
        [self reloadMainMenu];
        
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
    
    //アーカイブ読み込み中もしくはサムネイル一覧実行中ではない場合
    if(!app.isLoadingArchive && !app.isThumbnail)
    {
        if([[[app.plistValue objectAtIndex:0] objectAtIndex:0] intValue])
        {
            [[app.plistValue objectAtIndex:0] replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:0]];
        }
        else
        {
            [[app.plistValue objectAtIndex:0] replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:1]];
        }
        
        //左開きの場合(『デフォルトで左開き』を考慮)
        if(abs(app.isHidaribiraki - [[[app.plistValue objectAtIndex:0] objectAtIndex:0] intValue]))
        {
            imageLeftFieldxxx = imageRightField;
            imageRightFieldxxx = imageLeftField;
        }
        //右開きの場合
        else
        {
            imageLeftFieldxxx = imageLeftField;
            imageRightFieldxxx = imageRightField;
        }
        
        //画面を更新
        if(!app.isYokonaga)
        {
            [self LniSet];
            [self RniSet];
        }
        
        //メインメニューを再構成
        [self reloadMainMenu];
    }
}

//デフォルトで1画面
- (void)defaultOnePageDisplay
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //アーカイブ読み込み中もしくはサムネイル一覧実行中ではない場合
    if(!app.isLoadingArchive && !app.isThumbnail)
    {
        //デフォルトで1画面の場合
        if([[[app.plistValue objectAtIndex:0] objectAtIndex:1] intValue])
        {
            [[app.plistValue objectAtIndex:0] replaceObjectAtIndex:1 withObject:[NSNumber numberWithInteger:0]];
        }
        //デフォルトで1画面ではない場合
        else
        {
            [[app.plistValue objectAtIndex:0] replaceObjectAtIndex:1 withObject:[NSNumber numberWithInteger:1]];
        }
        
        //メインメニューを再構成
        [self reloadMainMenu];
        
        //画面を更新
        //空でないことを確認
        if(app.listSize)
        {
            //1画面表示の場合(『デフォルトで1画面』を考慮)
            if(abs(app.isOnePage - [[[app.plistValue objectAtIndex:0] objectAtIndex:1] intValue]))
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
            //1画面表示ではない場合
            else
            {
                [self setImage];
            }
        }
    }
}

//항상 처음부터 읽기 설정

- (void)defaultReadFromFirstPage
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    //디폴트로 켜진 경우
    if([[[app.plistValue objectAtIndex:0] objectAtIndex:8] intValue])
    {
        [[app.plistValue objectAtIndex:0] replaceObjectAtIndex:8 withObject:[NSNumber numberWithInteger:0]];
    }
    //디폴트가 꺼진 경우
    else
    {
        [[app.plistValue objectAtIndex:0] replaceObjectAtIndex:8 withObject:[NSNumber numberWithInteger:1]];
    }
    //메뉴 재구성
    [self reloadMainMenu];
}

//デフォルトで右回転
- (void)defaultRotateRight
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //アーカイブ読み込み中もしくはサムネイル一覧実行中ではない場合
    if(!app.isLoadingArchive && !app.isThumbnail)
    {
        //デフォルトで右回転の場合
        if([[[app.plistValue objectAtIndex:0] objectAtIndex:2] intValue])
        {
            [[app.plistValue objectAtIndex:0] replaceObjectAtIndex:2 withObject:[NSNumber numberWithInteger:0]];
        }
        //デフォルトで右回転ではない場合
        else
        {
            [[app.plistValue objectAtIndex:0] replaceObjectAtIndex:2 withObject:[NSNumber numberWithInteger:1]];
            [[app.plistValue objectAtIndex:0] replaceObjectAtIndex:3 withObject:[NSNumber numberWithInteger:0]];
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
    
    //アーカイブ読み込み中もしくはサムネイル一覧実行中ではない場合
    if(!app.isLoadingArchive && !app.isThumbnail)
    {
        //デフォルトで左回転の場合
        if([[[app.plistValue objectAtIndex:0] objectAtIndex:3] intValue])
        {
            [[app.plistValue objectAtIndex:0] replaceObjectAtIndex:3 withObject:[NSNumber numberWithInteger:0]];
        }
        //デフォルトで左回転ではない場合
        else
        {
            [[app.plistValue objectAtIndex:0] replaceObjectAtIndex:2 withObject:[NSNumber numberWithInteger:0]];
            [[app.plistValue objectAtIndex:0] replaceObjectAtIndex:3 withObject:[NSNumber numberWithInteger:1]];
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
    
    //メインメニューを再構成
    [self reloadMainMenu];
    
    //画面を更新
    //空でないことを確認
    if(app.listSize)
    {
        [self setImage];
    }
}

- (IBAction)fitToScreen:(id)sender
{
    [self fitToScreen];
}

//화면에 꽉 채우기 (10.6 스타일의 풀스크린)
- (void)fitToScreen
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];

        if(!app.isFitToScreen)
        {
            app.isFitToScreen = 1;
            
            //ウィンドウのサイズ・位置を取得
            app.windowRectBeforeFullscreen = viewWindow.frame;
            
            //メニューバーを隠す
            [NSMenu setMenuBarVisible:NO];
            //タイトルバーを隠す
            [viewWindow setStyleMask:NSBorderlessWindowMask];
            
            //ウィンドウを画面と同じ大きさにする
            [viewWindow setFrame:[[NSScreen mainScreen]frame]display:YES animate:YES];
            
             //페이지 넘버를 감췄다가 다시 그린다
             pagenumberPrev.hidden = 1;
             pagenumberNext.hidden = 1;
             [self showTextField:pagenumberPrev];
             [self showTextField:pagenumberNext];
        }
        //フルスクリーンの場合
        else
        {
            app.isFitToScreen = 0;
            
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
                //初期状態にする
                [self resetMangao];
            }
            //メニューバーを表示する
            [NSMenu setMenuBarVisible:YES];
            
            //ウィンドウをフルスクリーン以前のサイズ・位置にする
            [viewWindow setFrame:app.windowRectBeforeFullscreen display:YES animate:YES];

            //페이지 넘버를 감춘다
            [self hideTextField:pagenumberPrev];
            [self hideTextField:pagenumberNext];
        }
}

//フルスクリーン
- (void)fullscreen
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //サムネイル一覧実行中ではない場合
    if(!app.isThumbnail)
    {
        //OSのバージョンを取得
        NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:@"/System/Library/CoreServices/SystemVersion.plist"];
        NSString *version = [dictionary objectForKey:@"ProductVersion"];
        
        float fullscreenVersion = 10.7;
        
        //〜10.6の場合
        if([version floatValue] < fullscreenVersion)
        {
            [self fitToScreen];
        }
        //10.7〜の場合
        else
        {
            [viewWindow toggleFullScreen:nil];
        }
    }
}

//しまう
- (void)hide
{
    //フルスクリーンではない場合
    if([NSMenu menuBarVisible])
    {
        [[NSApplication sharedApplication] miniaturizeAll:nil];
    }
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
    
    //アーカイブ読み込み中もしくはサムネイル一覧実行中ではない場合
    if(!app.isLoadingArchive && !app.isThumbnail)
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
        
        //centerFieldに画像が表示されていてマウスカーソルが上にある場合
        if(app.imageCenter
           && (0 < app.cursor_onImageCenterField.y)
           && (app.cursor_onImageCenterField.y < size_imageField.height))
        {
            //ルーペの配列を取得
            loupeArray = [[Loupe alloc] loupe:app.isLoupe witchField:2 cursor_onImageField:app.cursor_onImageCenterField windowSize:size_window imageFieldSize:size_imageField image:app.imageCenter];
        }
        //centerField以外に画像が表示されている場合
        else
        {
            //左開きの場合
            if(app.isHidaribiraki)
            {
                //LeftFieldに画像が表示されていてマウスカーソルが上にある場合
                if(app.imageLeft
                   && (size_imageField.width/2 < cursor_onImageCenterField.x)
                   && (cursor_onImageCenterField.x < size_imageField.width))
                {
                    NSPoint cursor_onImageLeftField = [app.imageLeftFieldxxx convertPoint:[[self viewWindow] convertScreenToBase:[NSEvent mouseLocation]] fromView:nil];
                    size_imageField = self.imageLeftFieldxxx.frame.size;
                    
                    //ルーペの配列を取得
                    loupeArray = [[Loupe alloc] loupe:app.isLoupe witchField:0 cursor_onImageField:cursor_onImageLeftField windowSize:size_window imageFieldSize:size_imageField image:app.imageLeft];
                }
                //RightFieldに画像が表示されていてマウスカーソルが上にある場合
                else if(app.imageRight
                        && (0 < app.cursor_onImageCenterField.x)
                        && (app.cursor_onImageCenterField.x < size_imageField.width/2))
                {
                    NSPoint cursor_onImageRightField = [app.imageRightFieldxxx convertPoint:[[self viewWindow] convertScreenToBase:[NSEvent mouseLocation]] fromView:nil];
                    size_imageField = self.imageRightFieldxxx.frame.size;
                    
                    //ルーペの配列を取得
                    loupeArray = [[Loupe alloc] loupe:app.isLoupe witchField:1 cursor_onImageField:cursor_onImageRightField windowSize:size_window imageFieldSize:size_imageField image:app.imageRight];
                }
            }
            //右開きの場合
            else
            {
                //LeftFieldに画像が表示されていてマウスカーソルが上にある場合
                if(app.imageLeft
                   && (0 < cursor_onImageCenterField.x)
                   && (cursor_onImageCenterField.x < size_imageField.width/2))
                {
                    NSPoint cursor_onImageLeftField = [app.imageLeftFieldxxx convertPoint:[[self viewWindow] convertScreenToBase:[NSEvent mouseLocation]] fromView:nil];
                    size_imageField = self.imageLeftFieldxxx.frame.size;
                    
                    //ルーペの配列を取得
                    loupeArray = [[Loupe alloc] loupe:app.isLoupe witchField:1 cursor_onImageField:cursor_onImageLeftField windowSize:size_window imageFieldSize:size_imageField image:app.imageLeft];
                }
                //RightFieldに画像が表示されていいてマウスカーソルが上にある場合
                else if(app.imageRight
                        && (size_imageField.width/2 < cursor_onImageCenterField.x)
                        && (app.cursor_onImageCenterField.x < size_imageField.width))
                {
                    NSPoint cursor_onImageRightField = [app.imageRightFieldxxx convertPoint:[[self viewWindow] convertScreenToBase:[NSEvent mouseLocation]] fromView:nil];
                    size_imageField = self.imageRightFieldxxx.frame.size;
                    
                    //ルーペの配列を取得
                    loupeArray = [[Loupe alloc] loupe:app.isLoupe witchField:0 cursor_onImageField:cursor_onImageRightField windowSize:size_window imageFieldSize:size_imageField image:app.imageRight];
                }
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
            
            [loupeField setImage:loupeImage];
            
            //大きいルーペの場合
            if(app.isLoupe == 2)
            {
                //ルーペウィンドウをビューウィンドウと同じサイズにする
                [loupeWindow setFrame:viewWindow.frame display:NO];
            }
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
            loupeImage = NULL;
            
            //ルーペウィンドウを無効にする
            [[self loupeWindow] orderOut:self];
        }
    }
}

//カーソルの位置を取得
- (void)trackingMousePoint
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //アーカイブ読み込み中もしくはサムネイル一覧実行中ではない場合
    if(!app.isLoadingArchive && !app.isThumbnail)
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
    }
}

//フルスクリーンならマウスカーソルを隠す
- (void)setHiddenUntilMouseMoves
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //アーカイブ読み込み中もしくはサムネイル一覧実行中ではない場合
    if(!app.isLoadingArchive && !app.isThumbnail)
    {
        //フルスクリーン時
        if(![NSMenu menuBarVisible])
        {
            [NSCursor setHiddenUntilMouseMoves: YES];
        }
    }
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

//初期状態にする
- (void)resetMangao
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    [self imageFieldReset];
    
    //背景色を白に設定
    [viewWindow setBackgroundColor:[NSColor whiteColor]];
    
    //初期画像を設定
    app.imageCenter = [NSImage imageNamed:@"PleasePressO"];
    [self CniSet];
    
    //ウィンドウタイトルを『Mangao Kai ver.x.x.x』にする
    NSString *shortVersionString = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [self.viewWindow setTitle:[[NSString alloc] initWithFormat:@"Mangao Kai ver.%@",shortVersionString]];
    //メインメニューを再構成
    [self reloadMainMenu];
    
    app.index = 0;
    app.listSize = 0;
    app.listSizeOfArchive = 0;
}

/*오디오 입력 기능 시작*/

//오디오 입력 레벨이 일정 수준 이상을 넘었을 경우
- (void)acceptSound:(NSNotification*)notification;
{
    [self pageNext];
}

//오디오 입력 패널을 닫으라는 notification 접수시
- (void)closeAudioInputPanel:(NSNotification*)notification;
{
    [audioInputPanel orderOut:self];
    //isAudioInput 값을 변경
    if (isAudioInput == 0)
        isAudioInput = 1;
    else
        isAudioInput = 0;
    [self reloadMainMenu];
}

//오디오 패널 불러오기
- (void)showAudioInputPanel
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NCopenAudioInputPanel" object:self];
    [audioInputPanel makeKeyAndOrderFront:self];
}

/* 오디오 입력 기능 끝 */

//CをCantOpen
- (void)CwoCantOpen
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //背景色を白に設定
    [viewWindow setBackgroundColor:[NSColor whiteColor]];
    
    app.imageCenter = [NSImage imageNamed:@"CantOpenThisArchive"];
    [self CniSet];
    
    app.index = 0;
    app.listSize = 0;
    //ウィンドウタイトルを現在開いている『アーカイブ名 現在のページ/総ページ』にする
    [self setWindowTitle];
    //メインメニューを再構成
    [self reloadMainMenu];
}

//CをThisArchive
- (void)CwoThisArchive
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //背景色を白に設定
    [viewWindow setBackgroundColor:[NSColor whiteColor]];
    
    app.imageCenter = [NSImage imageNamed:@"ThisArchiveHasNoImage"];
    [self CniSet];
    
    app.index = 0;
    app.listSize = 0;
    //ウィンドウタイトルを現在開いている『アーカイブ名 現在のページ/総ページ』にする
    [self setWindowTitle];
    //メインメニューを再構成
    [self reloadMainMenu];
}

//CをPleaseInstallTrueCrypt
- (void)CwoPleaseInstallTrueCrypt
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //背景色を白に設定
    [viewWindow setBackgroundColor:[NSColor whiteColor]];
    
    app.imageCenter = [NSImage imageNamed:@"PleaseInstallTrueCrypt"];
    [self CniSet];
    
    app.index = 0;
    app.listSize = 0;
    //ウィンドウタイトルを現在開いている『アーカイブ名 現在のページ/総ページ』にする
    [self setWindowTitle];
    //メインメニューを再構成
    [self reloadMainMenu];
}

//Cをloading
- (void)CwoLoading:(NSString*)loadingFilePath
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //このメソッドが呼ばれた時と同じアーカイブを読み込み中の場合
    if(app.isLoadingArchiveNotSetImage && (app.filePath == loadingFilePath))
    {
        //背景色を白に設定
        [viewWindow setBackgroundColor:[NSColor whiteColor]];
        
        app.imageCenter = [NSImage imageNamed:@"loading"];
        [self CniSet];
    }
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
//fit to width 에 맞춰 소스 추가
- (void)CniSet
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    [imageCenterField setImage:app.imageCenter];
}

//윈도우 크기에 맞추기
//0은 fit to window, 1은 fit to width
- (IBAction)fitToWindow:(id)sender
{
    if (viewSetting == 1)
    {
        [centerScrollView isFlipped];
        viewSetting = 0;    
    }
    //if (!isThumbnail)
    [self setImage];
    [centerScrollView setNeedsDisplay:YES];
}

//윈도우 폭에 맞추기
//0은 fit to window, 1은 fit to width
- (IBAction)fitToWidth:(id)sender
{
    if (viewSetting == 0)
    {
        viewSetting = 1;
    }
    [self setImage];
}
/*
- (void)scrollDownScrollView: (float)deltaY
{
    //NSLog(@"deltay:%f", deltaY);
    NSPoint origin = [[centerScrollView contentView] bounds].origin;
    NSLog(@"old point x/y:%f,%f", origin.x,origin.y);
}

- (void)scrollUpScrollView: (float)deltaY
{
    //NSLog(@"deltay:%f", deltaY);
    NSPoint origin = [[centerScrollView contentView] bounds].origin;
    NSLog(@"old point x/y:%f,%f", origin.x,origin.y);
}*/

// viewsetting 값에 따라 메뉴 업데이트
- (BOOL)validateMenuItem:(NSMenuItem *)menuItem
{
    BOOL valid = YES;
    int state;
    if([menuItem tag] == 100)
    {
        if (viewSetting == 0) {
            state = NSOnState;
        }
        else state = NSOffState;
        [menuItem setState:state];
    }
    if([menuItem tag] == 101)
    {
        if (viewSetting == 1) {
            state = NSOnState;
        }
        else state = NSOffState;
        [menuItem setState:state];
    }
    return valid;
}

//일단 여기까지
//fit to width에 맞춰 소스 변경 종료

//開くメニュー
- (void)openMenu
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //アーカイブ読み込み中もしくはサムネイル一覧実行中ではない場合
    if(!app.isLoadingArchive && !app.isThumbnail)
    {
        //ルーペを無効化
        app.isLoupe = 0;
        //ルーペウィンドウを無効にする
        [[self loupeWindow] orderOut:self];
        //マウスカーソルを表示する
        [NSCursor unhide];
        
        NSOpenPanel *openPanel = [NSOpenPanel openPanel];
        
        //許可するファイル拡張子を設定
        NSArray *allowedFileTypes = [NSArray arrayWithObjects:@"jpg",@"jpeg",@"png",@"gif",@"bmp",@"tif",@"tiff",@"zip",@"cbz",@"rar",@"cbr",@"7z",@"cb7",@"lha",@"lzh",@"tar",@"gz",@"bz2",@"xz",@"cab",@"pdf",@"cvbdl",@"tc",@"cbtc",nil];
        [openPanel setAllowedFileTypes:allowedFileTypes];
        
        //フォルダを選択可能にする
        [openPanel setCanChooseDirectories:YES];
        
        NSInteger OK = [openPanel runModal];
        
        if(OK == NSOKButton)
        {
            NSURL *URL = [openPanel URL];
            
            //選択したファイル・フォルダをapp.filePathに入れる
            app.filePath = [URL path];
            
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
    
    //選択したのがTrueCryptボリュームの場合
    if([[app.filePath lowercaseString] hasSuffix:@".tc"] || [[app.filePath lowercaseString] hasSuffix:@".cbtc"])
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
            //CをPleaseInstallTrueCrypt
            [self CwoPleaseInstallTrueCrypt];
        }
    }
    //選択したのがアーカイブ・画像ファイル・フォルダの場合
    else
    {
        //選択したのが画像ファイルの場合
        if([[app.filePath lowercaseString] hasSuffix:@".jpg"] || [[app.filePath lowercaseString] hasSuffix:@".jpeg"] || [[app.filePath lowercaseString] hasSuffix:@".png"] || [[app.filePath lowercaseString] hasSuffix:@".gif"] || [[app.filePath lowercaseString] hasSuffix:@".bmp"] || [[app.filePath lowercaseString] hasSuffix:@".tif"] || [[app.filePath lowercaseString] hasSuffix:@".tiff"])
        {
            app.selectionImageFilePath = app.filePath;
            
            //app.filePathを『選択した画像を含むフォルダ』にする
            app.filePath = [app.filePath stringByDeletingLastPathComponent];
        }
        else
        {
            app.selectionImageFilePath = NULL;
        }
        
        //app.folderPathを選択したアーカイブ・フォルダを含むフォルダ(画像を選択した場合は、その画像を含むフォルダを含むフォルダ)にする
        app.folderPath = [app.filePath stringByDeletingLastPathComponent];
        
        //アーカイブリストを更新
        [self reloadFileListFullPathOfArchive];
        
        [self loadArchive];
    }
    
    //압축 파일 안의 압축 파일을 열기 위한 Temporary 파일의 확인 및 삭제
    NSString *deletedTempFolder = [NSString stringWithFormat:@"archivetemp"];
    [DeleteTempFile deleteTempFile:deletedTempFolder];
}

//アーカイブ読み込みを別スレッドで実行する
- (void)loadArchive
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    [self imageFieldReset];
    
    app.isLoadingArchive = 1;
    app.isLoadingArchiveNotSetImage = 1;

    //アーカイブ読み込みを別スレッドで実行する
    [self performSelectorInBackground:@selector(loadArchiveInBackground) withObject:nil];

    //ウィンドウタイトルを『読み込み中のアーカイブ名 [Loading...]』にする
    //画像フォルダの場合
    BOOL isDirectory;
    if ([[NSFileManager defaultManager]fileExistsAtPath:app.filePath isDirectory:&isDirectory] && isDirectory)
    {
        [self.viewWindow setTitle:[NSString stringWithFormat:@"%@ [Loading...]",[app.filePath lastPathComponent]]];
    }
    //アーカイブの場合
    else
    {
        [self.viewWindow setTitle:[NSString stringWithFormat:@"%@ [Loading...]",[[app.filePath lastPathComponent] stringByDeletingPathExtension]]];
    }
    
    //독 아이콘에 loading 표시
    [[[NSApplication sharedApplication] dockTile]setBadgeLabel:@"Loading"];
    
    //0.5秒後にCをLoading
    [self performSelector:@selector(CwoLoading:) withObject:app.filePath afterDelay:0.5];
}

//アーカイブ読み込みをキャンセルする
- (void)cancelLoadArchive
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    app.isCancelLoadingArchive = 1;
    
    //初期状態にする
    [self resetMangao];
}

//アーカイブ読み込み(別スレッド)
- (void)loadArchiveInBackground
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //選択したアーカイブを最近使った項目に追加
    [[NSDocumentController sharedDocumentController] noteNewRecentDocumentURL: [NSURL fileURLWithPath:app.filePath]];

    //選択したアーカイブのフルパスをMD5に変換
    NSString *fullPathMD5 = [self NSString2MD5NSString:app.filePath];
    
    //app.plistKeyの中で何番目か検索
    app.plistKeyIndex = [app.plistKey indexOfObject:fullPathMD5];
    
    //未書き込みの場合
    if(app.plistKeyIndex == NSNotFound)
    {
        //app.plistKeyにMD5化したフルパスを追加
        //app.plistValueに(最後に開いたページ,左開きフラグ,1画面フラグ,ページずれフラグ,ブックマーク,予約,予約,予約,予約,予約)を追加
        [app.plistKey addObject:fullPathMD5];
        [app.plistValue addObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],nil]];
        
        //再度app.plistKeyの中で何番目か検索
        app.plistKeyIndex = [app.plistKey indexOfObject:fullPathMD5];
    }
    
    //app.indexを最後に表示したページにセット(NSNumberからintに変換)
    //단, 항상 처음부터 읽기가 켜진 경우에는 0으로 세팅
    //NSLog(@"항상 처음부터 읽기: %i", [[[app.plistValue objectAtIndex:0] objectAtIndex:8] intValue]);
    if ([[[app.plistValue objectAtIndex:0] objectAtIndex:8] intValue])
    {
        app.index = 0;
    }
    else
    {
        app.index = [[[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:0]intValue];
    }
    
    //左開きフラグを確認
    app.isHidaribiraki = [[[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:1]intValue];
    //1画面フラグを確認
    app.isOnePage = [[[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:2]intValue];
    
    //メインメニューを再構成
    [self reloadMainMenu];
    
    //아카이브 파일 선택시
    if([[app.filePath lowercaseString] hasSuffix:@".zip"]
       || [[app.filePath lowercaseString] hasSuffix:@".cbz"]
       || [[app.filePath lowercaseString] hasSuffix:@".rar"]
       || [[app.filePath lowercaseString] hasSuffix:@".cbr"]
       || [[app.filePath lowercaseString] hasSuffix:@".7z"]
       || [[app.filePath lowercaseString] hasSuffix:@".cb7"]
       || [[app.filePath lowercaseString] hasSuffix:@".lha"]
       || [[app.filePath lowercaseString] hasSuffix:@".lzh"]
       || [[app.filePath lowercaseString] hasSuffix:@".tar"]
       || [[app.filePath lowercaseString] hasSuffix:@".gz"]
       || [[app.filePath lowercaseString] hasSuffix:@".bz2"]
       || [[app.filePath lowercaseString] hasSuffix:@".xz"]
       || [[app.filePath lowercaseString] hasSuffix:@".cab"])
    {
        [self unarchiveFile];
    }
    //選択したのがPDFファイルの場合
    else if([[app.filePath lowercaseString] hasSuffix:@".pdf"])
    {
        [self PDFFile];
    }
    //選択したのが画像ファイルの場合
    else if([[app.selectionImageFilePath lowercaseString] hasSuffix:@".jpg"] || [[app.selectionImageFilePath lowercaseString] hasSuffix:@".jpeg"] || [[app.selectionImageFilePath lowercaseString] hasSuffix:@".png"] || [[app.selectionImageFilePath lowercaseString] hasSuffix:@".gif"] || [[app.selectionImageFilePath lowercaseString] hasSuffix:@".bmp"] || [[app.selectionImageFilePath lowercaseString] hasSuffix:@".tif"] || [[app.selectionImageFilePath lowercaseString] hasSuffix:@".tiff"])
    {
        [self imageFile:app.selectionImageFilePath];
    }
    //選択したのがcvbdlフォルダ・フォルダの場合
    else
    {
        [self imageFolder];
    }
    
end:app.isLoadingArchive = 0;
    app.isLoadingArchiveNotSetImage = 0;
    app.isCancelLoadingArchive = 0;
}

//同フォルダ内のアーカイブリストを再度取得する
- (void)reloadFileListFullPathOfArchive
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //app.folderPath内のファイル・フォルダリスト(フルパスではない)を取得
    NSArray *fileList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:app.folderPath error:nil];
    //数値順でソート
    NSArray *sortedArray = [fileList sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
    //アーカイブ及びフォルダのリストにする
    app.fileListFullPathOfArchive = [NSMutableArray array];
    for(NSString *string in sortedArray)
    {
        //フルパスに変換
        NSString *fullPathString = [app.folderPath stringByAppendingPathComponent:string];
        
        //アーカイブの場合
        if([[fullPathString lowercaseString] hasSuffix:@".zip"]
           || [[fullPathString lowercaseString] hasSuffix:@".cbz"]
           || [[fullPathString lowercaseString] hasSuffix:@".rar"]
           || [[fullPathString lowercaseString] hasSuffix:@".cbr"]
           || [[fullPathString lowercaseString] hasSuffix:@".7z"]
           || [[fullPathString lowercaseString] hasSuffix:@".cb7"]
           || [[fullPathString lowercaseString] hasSuffix:@".lha"]
           || [[fullPathString lowercaseString] hasSuffix:@".lzh"]
           || [[fullPathString lowercaseString] hasSuffix:@".tar"]
           || [[fullPathString lowercaseString] hasSuffix:@".gz"]
           || [[fullPathString lowercaseString] hasSuffix:@".bz2"]
           || [[fullPathString lowercaseString] hasSuffix:@".xz"]
           || [[fullPathString lowercaseString] hasSuffix:@".cab"]
           || [[fullPathString lowercaseString] hasSuffix:@".pdf"]
           || [[fullPathString lowercaseString] hasSuffix:@".cvbdl"])
        {
            //リストに追加する
            [app.fileListFullPathOfArchive addObject:fullPathString];
        }
        //フォルダの場合
        BOOL isDirectory;
        if ([[NSFileManager defaultManager]fileExistsAtPath:fullPathString isDirectory:&isDirectory] && isDirectory)
        {
            //リストに追加する
            [app.fileListFullPathOfArchive addObject:fullPathString];
        }
    }
    
    //リストの要素数を取得
    app.listSizeOfArchive = [app.fileListFullPathOfArchive count];
}

/* 패스워드 다이얼로그 박스 */
//패스워드가 필요한 아카이브의 경우
-(void)archiveNeedsPassword:(XADArchive *)archive
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    //패스워드 값 리셋
    app.password = nil;

    //NSLog(@"need password");
    
    [self passwordForArchive];
    
    [archive setPassword:app.password];
}

//패스워드 확인 루틴, 모달 쉬트로 띄운다
//모달 쉬트 표시
-(void)passwordForArchive
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    //패스워드 창 변수 1로 설정 (패스워드 창이 현재 표시중이란 뜻)
    app.isPassword = 1;

    //텍스트필드 리셋
    [passwordField setStringValue:@""];
    
    [passwordNotice setStringValue:NSLocalizedString(@"アーカイブファイルのパスワードの入力してください。",@"")];

    //패스워드 창을 쉬트로 표시
    [[NSApplication sharedApplication]
     beginSheet:passwordPanel
     modalForWindow:viewWindow
     modalDelegate:self
     didEndSelector:@selector(passwordPanelClose:returnCode:)
     contextInfo:NULL];

    //모달 시작, 값이 입력되거나 취소될 때까지 백그라운드 작업을 일시 중지
    [[NSApplication sharedApplication] runModalForWindow:passwordPanel];
}

- (IBAction)passwordPanel_CancelButton:(id)sender
{
    [[NSApplication sharedApplication] endSheet:passwordPanel returnCode:NSCancelButton];
}

- (IBAction)passwordPanel_OKButton:(id)sender
{
    [[NSApplication sharedApplication] endSheet:passwordPanel returnCode:NSOKButton];
}

- (IBAction)passwordPanel_Enter:(id)sender
{
    [[NSApplication sharedApplication] endSheet:passwordPanel returnCode:NSOKButton];
}

//패스워드 패널을 닫을 때 : 취소시에 대한 대처 필요
- (void)passwordPanelClose:(NSWindow*)panel returnCode:(int)returnCode
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    if(returnCode == NSOKButton)
    {
        app.password = [passwordField stringValue];
    }
    
    //캔슬 버튼을 누른 경우
    else if(returnCode == NSCancelButton)
    {
        [self CwoCantOpen];
    }
    // 모달 종료
    [[NSApplication sharedApplication] stopModal];
    [passwordPanel orderOut:self];
    //패스워드창 표시중 변수 0으로 설정
    app.isPassword = 0;
    app.isLoadingArchive = 0;
    app.isLoadingArchiveNotSetImage = 0;
    app.isCancelLoadingArchive = 0;
}

//아카이브 파일 Path로부터 이미지 파일만 추출, MutableArray로 반환하는 함수
//재귀함수로 작동하며, 압축 파일 안에 압축 파일이 있는 경우 계속해서 추가한다
- (NSMutableArray*)imageArrayFromArchive:(NSString*)archivePath
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //아카이브 패스의 출력
    //NSLog(@"filename: %@", archivePath);
    
    //필요한 변수 선언
    NSData *xadFileData;
    NSMutableArray *xadFileTempList = [[NSMutableArray alloc] init];
    NSString *fileName = nil;
    NSArray *xadFileList;
    NSMutableDictionary *xadRawFileDict = [[NSMutableDictionary alloc] init];

    //xadarchive로 아카이브 변수 archive 선언
    XADArchive * archive = [[XADArchive alloc] initWithFile:archivePath delegate:self error:NULL];

    //counter 변수와 archivedFilesCount 변수 = archive의 파일 갯수와 동일
 	int counter, archivedFilesCount = [archive numberOfEntries];
    
    for (counter = 0; counter < archivedFilesCount; ++counter)
    {
        fileName = [archive nameOfEntry: counter];
        //NSLog(@"filename:%@", fileName);

        if (fileName)
        {
            [xadFileTempList addObject:fileName];
        }
        else
        {
            break;
        }
        
        xadFileData = [archive contentsOfEntry: counter];
        if (xadFileData)
        {
            [xadRawFileDict setObject:xadFileData forKey:fileName];
        }
        else
        {
            break;
        }
        
        if(app.isCancelLoadingArchive)
        {
            break;
        }
    }
    
    //sortedarray1로 사용가능한 이미지 파일 네임을 걸러낸다
    xadFileList = [NSArray arrayWithArray:xadFileTempList];
    
    NSArray *allowedFileList = [xadFileList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"pathExtension IN %@",app.imageFileType]];
    NSArray *allowedArray = [allowedFileList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"not self BEGINSWITH '__MACOSX'"]];
    NSArray *sortedArray = [allowedArray sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
    
    NSMutableArray *finalImageArray = [[NSMutableArray alloc]init];

    //sortedarray2로 사용가능한 압축파일 네임을 걸러낸다
    NSArray *allowedArchiveList = [xadFileList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"pathExtension IN %@",app.archiveFileType]];
    
    //압축파일이 있는 경우
    if ([allowedArchiveList count] > 0)
    {
        NSArray *array2 = [allowedArchiveList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"not self BEGINSWITH '__MACOSX'"]];
        NSArray *sortedArray2 = [array2 sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
        NSData *archiveFileData;
        
        NSString *archivePath = nil;
        NSFileManager * fileManager = [NSFileManager defaultManager];
        int collision = 0;
        
        //포함된 압축파일 개수 확인 로그
        //NSLog(@"archive files number in archive :%lu", (unsigned long)[sortedArray2 count]);
        
        for(NSString *string in sortedArray2)
        {
            archiveFileData = [[[NSData alloc] initWithData:[xadRawFileDict objectForKey:string]] autorelease];
            //archiveFileName 출력
            //NSLog(@"archive file name : %@", string);
            
            do {
                archivePath = [NSString stringWithFormat: @"/archivetemp/%i-%@", collision, string];
                archivePath = [NSTemporaryDirectory() stringByAppendingPathComponent: archivePath];
                ++collision;
            }
            while ([fileManager fileExistsAtPath: archivePath]);
            
            //archivePath 출력
            //NSLog(@"archive Path at : %@", archivePath);
            
            [[NSFileManager defaultManager] createDirectoryAtPath: [archivePath stringByDeletingLastPathComponent]
                                      withIntermediateDirectories: YES
                                                       attributes: nil
                                                            error: NULL];
            [[NSFileManager defaultManager] createFileAtPath: archivePath contents: archiveFileData attributes: nil];
            
            NSMutableArray *archiveInArchiveArray = [self imageArrayFromArchive:archivePath];
            for (int i = 0; i < [archiveInArchiveArray count]; ++i)
            {
                [finalImageArray addObject:[archiveInArchiveArray objectAtIndex:i]];
            }
        }
    }

    for(NSString *string in sortedArray)
    {
        //NSLog(@"string : %@", string);
        //NSLog(@"image: %@", [xadRawFileDict objectForKey:string]);
        NSImage *xadImage = [[[NSImage alloc] initWithData:[xadRawFileDict objectForKey:string]] autorelease];
        
        // 이미지가 없을 때, 읽을 수 없다는 이미지 삽입, 모든 이미지가 NULL인 경우를 판별
        if(xadImage == NULL)
        {
            xadImage = [NSImage imageNamed:@"CantReadThisImage"];
        }
        
        [finalImageArray addObject:xadImage];
        //NSLog(@"xadImage:%@", xadImage);
    }
    
    app.listSize = app.listSize + [sortedArray count];
    //NSLog(@"archive files number in archive :%lu / app.listsize : %i", (unsigned long)[sortedArray count], app.listSize);

    //그 외의 경우, 즉 정상적으로 이미지를 읽었을 때에는 값을 리턴
    return finalImageArray;
}

//unarchiveFile 파일인 경우의 압축 해제
- (void)unarchiveFile
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];

    //listsize의 초기화
    app.listSize = 0;
    
    NSMutableArray *imageArray1 = [self imageArrayFromArchive:app.filePath];

    //NSLog(@"app.listsize:%i // imagearray1 count:%lu", app.listSize, (unsigned long)[imageArray1 count]);
    //ESC 키로 취소 요청이 들어왔을 때
    if(app.isCancelLoadingArchive)
    {
        goto end;
    }
    //무언가의 문제로 리스트 사이즈와 imagearray의 파일 숫자가 다른 경우
    else if (app.listSize != [imageArray1 count])
    {
        goto end;
    }
    //그 외의 경우, 즉 정상적으로 이미지를 읽었을 때
    else
    {
        //이미지 배열 추가
        app.imageArray = [NSMutableArray arrayWithArray:imageArray1];
        
        //アーカイブが空の場合
        if(!app.listSize)
        {
            [self CwoThisArchive];
        }
        else
        {
            //NSLog(@"image array index1:%@", [app.imageArray objectAtIndex:1]);
            [self setImage];
        }
    }
    return;
    
    //로딩 중단시의 화면 리셋
end:
    {
        [self resetMangao];
        [[[NSApplication sharedApplication] dockTile]setShowsApplicationBadge:NO];
    }
}

//PDF
- (void)PDFFile
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //PDFへのパスをNSURLに変換
    NSURL *url = [NSURL fileURLWithPath:app.filePath];
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
                //アーカイブ読み込みがキャンセルされた場合
                if(app.isCancelLoadingArchive)
                {
                    goto end;
                }
                
                //指定ページのPDFを読み込む
                PDFPage *page = [pdf pageAtIndex:i];
                
                [app.PDFArray addObject:page];
            }
            [self setImage];
            
        end:app.index = app.index;
        }
    }
}

//画像ファイル
- (void)imageFile:(NSString*)imageFilePath
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //選択した画像と同じフォルダ内のファイル・フォルダリスト(フルパスではない)を取得
    NSArray *fileList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:app.filePath error:nil];
    
    //許可した種類の画像のみのリストにする
    NSArray *allowedFileList = [fileList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"pathExtension IN %@",app.imageFileType]];
    
    //数値順でソート
    NSArray *sortedArray = [allowedFileList sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
    
    NSMutableArray *fileListFullPath = [NSMutableArray array];
    for(NSString *string in sortedArray)
    {
        //フルパスに変換
        NSString *fullPathString = [app.filePath stringByAppendingPathComponent:string];
        
        //リストに追加する
        [fileListFullPath addObject:fullPathString];
    }

    //ディレクトリ内の要素数を取得
    app.listSize = [fileListFullPath count];
    
    //選択したファイルがディレクトリ内で何番目か取得
    app.index = [fileListFullPath indexOfObject:imageFilePath];
    
    //ディレクトリ内の画像をapp.imageArrayに入れる
    app.ImageArray = [NSMutableArray array];
    for(NSString *string in fileListFullPath)
    {
        //アーカイブ読み込みがキャンセルされた場合
        if(app.isCancelLoadingArchive)
        {
            goto end;
        }
        
        NSImage *image = [[NSImage alloc] initWithContentsOfFile:string];
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
    
end:app.selectionImageFilePath = NULL;
}

//폴더 및 cvbdl을 여는 루틴
- (void)imageFolder
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //listsize의 초기화
    app.listSize = 0;

    app.imageArray = [NSMutableArray array];
    
    //フォルダ・cvbdl以下のすべてのファイルリストを取得
    NSMutableArray *fileList = [NSMutableArray array];
    NSDirectoryEnumerator *directoryEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:app.filePath];
    NSString *string;
    while(string = [directoryEnumerator nextObject])
    {
        //アーカイブ読み込みがキャンセルされた場合
        if(app.isCancelLoadingArchive)
        {
            goto end;
        }
        
        //フルパスにしてリストに追加する
        [fileList addObject:[app.filePath stringByAppendingPathComponent:string]];
    }
    
    //数値順でソート
    NSArray *sortedfileList = [fileList sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
    
    for(NSString *string in sortedfileList)
    {
        //アーカイブ読み込みがキャンセルされた場合
        if(app.isCancelLoadingArchive)
        {
            goto end;
        }
        
        //画像ファイルの場合
        if([[string lowercaseString] hasSuffix:@".jpg"] || [[string lowercaseString] hasSuffix:@".jpeg"] || [[string lowercaseString] hasSuffix:@".png"] || [[string lowercaseString] hasSuffix:@".gif"] || [[string lowercaseString] hasSuffix:@".bmp"] || [[string lowercaseString] hasSuffix:@".tif"] || [[string lowercaseString] hasSuffix:@".tiff"])
        {
            //NSImageとして読み込み
            NSImage *image = [[NSImage alloc] initWithContentsOfFile:string];
            
            //画像が読めなかった場合
            if(image == NULL)
            {
                image = [NSImage imageNamed:@"CantReadThisImage"];
            }
            
            //app.imageArrayに追加
            [app.imageArray addObject:image];

            //app.listsize는 현재의 app.imagearray 배열의 객체 숫자와 동일
            app.listSize = [app.imageArray count];
        }
        //Archiveの場合
        else if([[string lowercaseString] hasSuffix:@".zip"]
                || [[string lowercaseString] hasSuffix:@".cbz"]
                || [[string lowercaseString] hasSuffix:@".rar"]
                || [[string lowercaseString] hasSuffix:@".cbr"]
                || [[string lowercaseString] hasSuffix:@".7z"]
                || [[string lowercaseString] hasSuffix:@".cb7"]
                || [[string lowercaseString] hasSuffix:@".lha"]
                || [[string lowercaseString] hasSuffix:@".lzh"]
                || [[string lowercaseString] hasSuffix:@".tar"]
                || [[string lowercaseString] hasSuffix:@".gz"]
                || [[string lowercaseString] hasSuffix:@".bz2"]
                || [[string lowercaseString] hasSuffix:@".xz"]
                || [[string lowercaseString] hasSuffix:@".cab"]
                )
        {
            //imageArray 배열 선언
            NSMutableArray *imageArray1 = [self imageArrayFromArchive:string];

            //리스트 사이즈 추가
            //app.listSize = app.listSize + [sortedArray1 count];

            if(app.isCancelLoadingArchive)
            {
                goto end;
            }
            else
            {
                //이미지 배열을 기존 imagearray 배열에 추가
                [app.imageArray addObjectsFromArray:imageArray1];
            }
        }
    }

    //app.listsize 출력
    //NSLog(@"app.listsize: %i", app.listSize);

    //フォルダが空の場合
    if(!app.listSize)
    {
        [self CwoThisArchive];
    }
    else
    {
        [self setImage];
    }
    
    return;
    
    //중단시의 조치
end:
    app.index = app.index;
    [[[NSApplication sharedApplication] dockTile]setShowsApplicationBadge:NO];
}

//現在のindexの画像をフィールドにセットする
- (void)setImage
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    app.isLoadingArchiveNotSetImage = 0;
    
    [self imageFieldReset];
    [self setBackgroundColor];
    
    //左開きフラグが立っている場合(『デフォルトで左開き』を考慮)
    if(abs(app.isHidaribiraki - [[[app.plistValue objectAtIndex:0] objectAtIndex:0] intValue]))
    {
        imageLeftFieldxxx = imageRightField;
        imageRightFieldxxx = imageLeftField;
    }
    else
    {
        imageLeftFieldxxx = imageLeftField;
        imageRightFieldxxx = imageRightField;
    }
    
    //指定されたページが範囲外の場合(アーカイブ内のファイルが削除された場合の対策)
    if(app.index > app.listSize)
    {
        app.index = 0;
    }
    
    //指定された状態が、空+最後のページではない場合
    if(app.index != app.listSize)
    {
        //화면 폭에 맞춰 보기, viewsetting =1 , fit to width가 On인 경우
        if (viewSetting == 1)
        {
            app.imageCenter = [self readImage];
            [self CniSet];
            
            goto end;
        }
        //1画面表示の場合(『デフォルトで1画面』を考慮)
        else if(abs(app.isOnePage - [[[app.plistValue objectAtIndex:0] objectAtIndex:1] intValue]))
        {
            app.imageCenter = [self readImage];
            [self CniSet];
            
            goto end;
        }
        //2画面表示
        else
        {
            app.imageLeft = [self readImage];
            
            //ヨコナガ画像の場合
            if(app.isYokonaga)
            {
                app.imageCenter = app.imageLeft;
                app.imageLeft = NULL;
                [self CniSet];
                
                goto end;
            }
            
            [self LniSet];
        }
    }
    
    //指定されたページが1ページ目ではない場合
    if(app.index)
    {
        app.index--;
        app.imageRight = [self readImage];
        
        //ヨコナガ画像の場合
        if(app.isYokonaga)
        {
            if(app.imageLeft)
            {
                app.imageRight = NULL;
            }
            //指定された状態が空+最後のページで画像回転がオンの場合、
            //先のif(app.index != app.listSize)が呼ばれないため表示が空になることへの対策
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
    [[app.plistValue objectAtIndex:app.plistKeyIndex] replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:app.index]];
    
    //ウィンドウタイトルを現在開いている『アーカイブ名 現在のページ/総ページ』にする
    [self setWindowTitle];
}

//画像を取得
- (NSImage*)readImage
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    NSImage *image;
    
    //現在PDFファイルを開いている場合
    if([[app.filePath lowercaseString] hasSuffix:@".pdf"])
    {
        PDFPage *page = [PDFArray objectAtIndex:app.index];
        image = [[PDFPageToImage alloc]PDFPageToImage:page pageNumber:app.index];
    }

    //現在ZIP・RAR・cvbdl・画像フォルダを開いている場合
    else
    {
        image = [app.imageArray objectAtIndex:app.index];
        //NSLog(@"image: %@", image);
    }
    
    //画像が読めなかった場合
    if(image == NULL)
    {
        image = [NSImage imageNamed:@"CantReadThisImage"];
    }
    
    //画像回転がオンの場合
    if([[[app.plistValue objectAtIndex:0] objectAtIndex:2] intValue] || [[[app.plistValue objectAtIndex:0] objectAtIndex:3] intValue])
    {
        //ヨコナガ画像の場合
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
            if([[app.filePath lowercaseString] hasSuffix:@".pdf"])
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
        if([[[app.plistValue objectAtIndex:0] objectAtIndex:2] intValue])
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
    int EffectNumber = [[[plistValue objectAtIndex:0] objectAtIndex:4] intValue];
    
    if(EffectNumber == 1)
    {
        NSImage *mapImage;
        
        //ユーザーがカラーマップを用意している場合
        //~/Library/Application Support/Mangao/4color4.png
        if([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/Library/Application Support/Mangao/4color4.png",NSHomeDirectory()]])
        {
            mapImage = [[NSImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Library/Application Support/Mangao/4color4.png",NSHomeDirectory()]];
        }
        //~/.mangao/4color4.png
        else if([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/.mangao/4color4.png",NSHomeDirectory()]])
        {
            mapImage = [[NSImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/.mangao/4color4.png",NSHomeDirectory()]];
        }
        //ユーザーがカラーマップを用意していない場合
        else
        {
            mapImage =  [NSImage imageNamed:@"4color4"];
        }
        
        image = [HTMangaColorize colorizeImage:image withMapImage:mapImage skipColoredSource:YES];
    }
    else if(EffectNumber == 2)
    {
        //자동 화질 보정
        image = [AutoEnhance AutoEnhanceImage:image];
    }
    else if(EffectNumber == 3)
    {
        //자동 콘트라스트 (보통)
        image = [AutoLevel AutoLevel:image black:0.5 white:1 gamma:0.5];
    }
    else if(EffectNumber == 4)
    {
        //자동 콘트라스트 (강하게)
        image = [AutoLevel AutoLevel:image black:1 white:1 gamma:0.8];
    }
    else if(EffectNumber == 5)
    {
        //세피아톤
        image = [SepiaTone SepiaTone:image];
    }
    
    //그레이스케일
    else if(EffectNumber == 6)
    {
        image = [Grayscale Grayscale:image];
    }
    
    //밝기 및 콘트라스트 판별
    float BrightnessValue = [[[plistValue objectAtIndex:0] objectAtIndex:5] floatValue];
    float ContrastValue = [[[plistValue objectAtIndex:0] objectAtIndex:6] floatValue];
    
    if (!((BrightnessValue == 0.0)&&(ContrastValue == 1.0)))
    {
        image = [BrightnessAndContrast BrightnessAndContrast:image Brightness:&BrightnessValue Contrast:&ContrastValue];
    }
    
    //ヨコナガ画像判定
    CGImageRef image1 = [image CGImageForProposedRect:nil context:nil hints:nil];
    if(CGImageGetWidth(image1) > CGImageGetHeight(image1))
    {
        app.isYokonaga = 1;
    }
    else
    {
        app.isYokonaga = 0;
    }
    
    return image;
}

//前のページ
- (void)pagePrev
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //アーカイブ読み込み中もしくはサムネイル一覧実行中ではない場合
    if(!app.isLoadingArchive && !app.isThumbnail)
    {
        //表示中のファイルが1・2ページ目ではない、もしくは表示中のファイルが1ページ目かつRがNULLの場合
        if((app.index > 1) || ((app.index == 1) && (app.imageRight == NULL)))
        {
            [self imageFieldReset];
            
            //화면 폭에 맞춰 보기, viewsetting =1 , fit to width가 On인 경우
            if (viewSetting == 1)
            {
                app.index--;
                app.imageCenter = [self readImage];
                [self CniSet];
            }
            //1画面表示の場合(『デフォルトで1画面』を考慮)
            else if(abs(app.isOnePage - [[[app.plistValue objectAtIndex:0] objectAtIndex:1] intValue]))
            {
                app.index--;
                app.imageCenter = [self readImage];
                [self CniSet];
            }
            //2画面表示
            else
            {
                //現在ヨコナガ画像を表示中の場合
                if(app.isYokonaga)
                {
                    app.index--;
                    app.imageLeft = [self readImage];
                    //ヨコナガ画像の場合
                    if(app.isYokonaga)
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
                            if(app.isYokonaga)
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
                    if(app.isYokonaga)
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
                            if(app.isYokonaga)
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
                                    if(app.isYokonaga)
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
            [[app.plistValue objectAtIndex:app.plistKeyIndex] replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:app.index]];
            
            //ウィンドウタイトルを現在開いている『アーカイブ名 現在のページ/総ページ』にする
            [self setWindowTitle];
        }
    }
}

//次のページ
- (void)pageNext
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //アーカイブ読み込み中もしくはサムネイル一覧実行中ではない場合
    if(!app.isLoadingArchive && !app.isThumbnail)
    {
        //表示中のファイルが最後ではない場合
        if(app.index < app.listSize-1)
        {
            [self imageFieldReset];
            
            //화면 폭에 맞춰 보기, viewsetting =1 , fit to width가 On인 경우
            if (viewSetting == 1)
            {
                app.index++;
                app.imageCenter = [self readImage];
                [self CniSet];
            }
            //1画面表示の場合(『デフォルトで1画面』を考慮)
            else if(abs(app.isOnePage - [[[app.plistValue objectAtIndex:0] objectAtIndex:1] intValue]))
            {
                app.index++;
                app.imageCenter = [self readImage];
                [self CniSet];
            }
            //2画面表示
            else
            {
                app.index++;
                app.imageRight = [self readImage];
                
                //ヨコナガ画像の場合
                if(app.isYokonaga)
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
                        if(app.isYokonaga)
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
            [[app.plistValue objectAtIndex:app.plistKeyIndex] replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:app.index]];
            
            //ウィンドウタイトルを現在開いている『アーカイブ名 現在のページ/総ページ』にする
            [self setWindowTitle];
        }
    }
}

//10ページ戻る
- (void)page10Prev
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //アーカイブ読み込み中もしくはサムネイル一覧実行中ではない場合
    if(!app.isLoadingArchive && !app.isThumbnail)
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
    
    //アーカイブ読み込み中もしくはサムネイル一覧実行中ではない場合
    if(!app.isLoadingArchive && !app.isThumbnail)
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

//最初のページ
- (void)pageFirst
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //アーカイブ読み込み中もしくはサムネイル一覧実行中ではない場合
    if(!app.isLoadingArchive && !app.isThumbnail)
    {
        //空ではない場合
        if(app.listSize)
        {
            //ページずれフラグが立っている場合
            if([[[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:3]intValue])
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
    
    //アーカイブ読み込み中もしくはサムネイル一覧実行中ではない場合
    if(!app.isLoadingArchive && !app.isThumbnail)
    {
        //空ではない場合
        if(app.listSize)
        {
            //ページずれフラグが立っている場合
            if([[[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:3]intValue])
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

//ページずれ補正
- (void)onePageGo
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //アーカイブ読み込み中もしくはサムネイル一覧実行中ではない場合
    if(!app.isLoadingArchive && !app.isThumbnail)
    {
        //ヨコナガ画像・1画面表示・空でないことを確認
        if((!app.imageCenter) && (app.listSize))
        {
            //ページずれフラグを変更
            if(![[[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:3]intValue])
            {
                [[app.plistValue objectAtIndex:app.plistKeyIndex] replaceObjectAtIndex:3 withObject:[NSNumber numberWithInteger:1]];
            }
            else
            {
                [[app.plistValue objectAtIndex:app.plistKeyIndex] replaceObjectAtIndex:3 withObject:[NSNumber numberWithInteger:0]];
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
            [[app.plistValue objectAtIndex:app.plistKeyIndex] replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:app.index]];
            
            //ウィンドウタイトルを現在開いている『アーカイブ名 現在のページ/総ページ』にする
            [self setWindowTitle];
        }
    }
}

//ジャンプパネルを起動(ページ数)
- (void)openJumpPanelInt
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //アーカイブ読み込み中もしくはサムネイル一覧実行中ではない場合
    if(!app.isLoadingArchive && !app.isThumbnail)
    {
        [self openJumpPanel:0];
    }
}

//ジャンプパネルを起動(ページ％)
- (void)openJumpPanelPercent
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //アーカイブ読み込み中もしくはサムネイル一覧実行中ではない場合
    if(!app.isLoadingArchive && !app.isThumbnail)
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
    
    //ルーペを無効化
    app.isLoupe = 0;
    //ルーペウィンドウを無効にする
    [[self loupeWindow] orderOut:self];
    //マウスカーソルを表示する
    [NSCursor unhide];
    
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
    
    //アーカイブ読み込み中もしくはサムネイル一覧実行中ではない場合
    if(!app.isLoadingArchive && !app.isThumbnail)
    {
        //空ではない場合
        if(app.listSize)
        {
            //スライドショーを実行中なら停止
            if(app.isSlideshow)
            {
                [slideshow invalidate];
                app.isSlideshow = 0;
            }
            
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithInteger:random],@"random", nil];
            
            app.slideshow = [NSTimer scheduledTimerWithTimeInterval:interval
                                                             target:self
                                                           selector:@selector(pageNext4Slideshow)
                                                           userInfo:dictionary
                                                            repeats:YES];
            
            app.isSlideshow = 1;
        }
    }
}

//スライドショーの停止
- (void)slideshowStop
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //アーカイブ読み込み中もしくはサムネイル一覧実行中ではない場合
    if(!app.isLoadingArchive && !app.isThumbnail)
    {
        //スライドショーを実行中なら停止
        if(app.isSlideshow)
        {
            [app.slideshow invalidate];
            app.isSlideshow = 0;
        }
    }
}

//スライドショー用のPageNext
- (void)pageNext4Slideshow
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //ランダムスライドショーならindexを0〜listSize-1のランダムな値に変更
    //ただしarc4random(unsigned int)をintにキャストしているので時々-1が返ってくることに注意
    if([[[app.slideshow userInfo] objectForKey:@"random"]intValue])
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

//ウィンドウタイトルを現在開いている『アーカイブ名 現在のページ/総ページ ブックマークされているかどうか』にする
- (void)setWindowTitle
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    NSString *title;
    //画像フォルダの場合
    BOOL isDirectory;
    if ([[NSFileManager defaultManager]fileExistsAtPath:app.filePath isDirectory:&isDirectory] && isDirectory)
    {
        title = [app.filePath lastPathComponent];
    }
    //アーカイブの場合
    else
    {
        title = [[app.filePath lastPathComponent] stringByDeletingPathExtension];
    }
    
    //list size 확인
    //NSLog(@"list size: %i", app.listSize);
    
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
    if(!app.isHidaribiraki)
    {
        [pagenumberPrev setStringValue:[NSString stringWithFormat:@"%@",nowpagenumberPrev]];
        [pagenumberNext setStringValue:[NSString stringWithFormat:@"%@",nowpagenumberNext]];
    }
    else
    {
        [pagenumberPrev setStringValue:[NSString stringWithFormat:@"%@",nowpagenumberNext]];
        [pagenumberNext setStringValue:[NSString stringWithFormat:@"%@",nowpagenumberPrev]];
    }
    
    //독 아이콘에 현재 페이지 뱃지로 표시
    [[[NSApplication sharedApplication] dockTile]setBadgeLabel:dockIndex];
    
    //ブックマークが空ではない場合
    if([[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:4] != [NSNumber numberWithInteger:0])
    {
        //ブックマークの中で何番目か検索
        NSUInteger bookmarkIndex = [[[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:4] indexOfObject:[NSNumber numberWithInteger:app.index+1]];
        
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
    
    //타이틀 바에 경로 추가 (파일명 및 페이지 번호 추가보다 앞으로 오면 크래쉬 발생)
    //[self.viewWindow setRepresentedFilename: app.filePath];
    //타이틀 바에 파일명 및 페이지 번호 추가
    [self.viewWindow setTitle:title_index_bookmark];
    //타이틀 바에 파일 패스 추가
    [self.viewWindow setRepresentedURL:[NSURL fileURLWithPath:app.filePath]];
    
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
    
    //アーカイブ読み込み中もしくはサムネイル一覧実行中ではなくアーカイブのリストが空ではない場合
    if(!app.isLoadingArchive && !app.isThumbnail && app.listSizeOfArchive)
    {
        //アーカイブリストを更新
        [self reloadFileListFullPathOfArchive];
        
        //アーカイブのリストが空ではない場合
        if(app.listSizeOfArchive)
        {
            //閲覧中のアーカイブがリスト内で何番目にあるか取得
            int indexOfArchiveTemp = (int)[app.fileListFullPathOfArchive indexOfObject:app.filePath];

            //存在しなかった場合
            if(indexOfArchiveTemp < 0)
            {
                //現在のapp.indexOfArchiveが範囲内の場合
                if(app.indexOfArchive < app.listSizeOfArchive)
                {
                    //そのままにする
                    app.indexOfArchive = app.indexOfArchive;
                }
                //現在のapp.indexOfArchiveが範囲外の場合
                else
                {
                    //最後のアーカイブを選択
                    app.indexOfArchive = app.listSizeOfArchive - 1;
                }
            }
            //現在開いているアーカイブが最初の場合
            else if(indexOfArchiveTemp == 0)
            {
                //最後のアーカイブを選択
                app.indexOfArchive = app.listSizeOfArchive - 1;
            }
            //現在開いているアーカイブが最初ではない場合
            else if(indexOfArchiveTemp > 0)
            {
                //1つ前のアーカイブを選択
                app.indexOfArchive = indexOfArchiveTemp - 1;
            }
            
            //現在開いているアーカイブと開こうとしているアーカイブが異なる場合のみ開く
            //(例えば『a,bがありbを閲覧中にbを削除しアーカイブ移動を実行した場合aを開くため』に
            //アーカイブ移動の制限を[アーカイブが２つ以上あること]から[アーカイブが存在すること]に緩和したが
            //そのせいで1つしかアーカイブがない場合でもアーカイブ移動をするとアーカイブが再度読み込まれるようになったため)
            if(![app.filePath isEqualToString:[app.fileListFullPathOfArchive objectAtIndex:app.indexOfArchive]])
            {
                app.filePath = [app.fileListFullPathOfArchive objectAtIndex:app.indexOfArchive];
                
                [self loadArchive];
            }
        }
        //アーカイブのリストが空の場合
        else
        {
            //初期状態にする
            [self resetMangao];
        }
    }
}

//次のアーカイブ
- (void)archiveNext
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //アーカイブ読み込み中もしくはサムネイル一覧実行中ではなくアーカイブのリストが空ではない場合
    if(!app.isLoadingArchive && !app.isThumbnail && app.listSizeOfArchive)
    {
        //アーカイブリストを更新
        [self reloadFileListFullPathOfArchive];
        
        //アーカイブのリストが空ではない場合
        if(app.listSizeOfArchive)
        {
            //閲覧中のアーカイブがリスト内で何番目にあるか取得
            int indexOfArchiveTemp = (int)[app.fileListFullPathOfArchive indexOfObject:app.filePath];
            
            //存在しなかった場合
            if(indexOfArchiveTemp < 0)
            {
                //現在のapp.indexOfArchiveが範囲内の場合
                if(app.indexOfArchive < app.listSizeOfArchive)
                {
                    //そのままにする
                    app.indexOfArchive = app.indexOfArchive;
                }
                //現在のapp.indexOfArchiveが範囲外の場合
                else
                {
                    //最初のアーカイブを選択
                    app.indexOfArchive = 0;
                }
            }
            //現在開いているアーカイブが最後の場合
            else if(indexOfArchiveTemp == app.listSizeOfArchive - 1)
            {
                ///最初のアーカイブを選択
                app.indexOfArchive = 0;
            }
            //現在開いているアーカイブが最後ではない場合
            else if(indexOfArchiveTemp < app.listSizeOfArchive - 1)
            {
                //次のアーカイブを選択
                app.indexOfArchive = indexOfArchiveTemp + 1;
            }
            
            //現在開いているアーカイブと開こうとしているアーカイブが異なる場合のみ開く
            //(例えば『a,bがありbを閲覧中にbを削除しアーカイブ移動を実行した場合aを開くため』に
            //アーカイブ移動の制限を[アーカイブが２つ以上あること]から[アーカイブが存在すること]に緩和したが
            //そのせいで1つしかアーカイブがない場合でもアーカイブ移動をするとアーカイブが再度読み込まれるようになったため)
            if(![app.filePath isEqualToString:[app.fileListFullPathOfArchive objectAtIndex:app.indexOfArchive]])
            {
                app.filePath = [app.fileListFullPathOfArchive objectAtIndex:app.indexOfArchive];
                
                [self loadArchive];
            }
        }
        //アーカイブのリストが空の場合
        else
        {
            //初期状態にする
            [self resetMangao];
        }
    }
}

//右開き/左開き
- (void)migibirakiHidaribiraki
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //アーカイブ読み込み中もしくはサムネイル一覧実行中ではない場合
    if(!app.isLoadingArchive && !app.isThumbnail)
    {
        //空ではない場合
        if(app.listSize)
        {
            //左開きの場合
            if(app.isHidaribiraki)
            {
                app.isHidaribiraki = 0;
                [[app.plistValue objectAtIndex:app.plistKeyIndex] replaceObjectAtIndex:1 withObject:[NSNumber numberWithInteger:0]];
            }
            //右開きの場合
            else
            {
                app.isHidaribiraki = 1;
                [[app.plistValue objectAtIndex:app.plistKeyIndex] replaceObjectAtIndex:1 withObject:[NSNumber numberWithInteger:1]];
            }
            
            //左開きの場合(『デフォルトで左開き』を考慮)
            if(abs(app.isHidaribiraki - [[[app.plistValue objectAtIndex:0] objectAtIndex:0] intValue]))
            {
                imageLeftFieldxxx = imageRightField;
                imageRightFieldxxx = imageLeftField;
            }
            //右開きの場合
            else
            {
                imageLeftFieldxxx = imageLeftField;
                imageRightFieldxxx = imageRightField;
            }
            
            //画面を更新
            if(!app.isYokonaga)
            {
                [self LniSet];
                [self RniSet];
            }
            
            //メインメニューを再構成
            [self reloadMainMenu];
        }
    }
}

//1画面表示
- (void)onePageDisplay
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //アーカイブ読み込み中もしくはサムネイル一覧実行中ではない場合
    if(!app.isLoadingArchive && !app.isThumbnail)
    {
        //空でないことを確認
        if(app.listSize)
        {
            //1画面表示の場合
            if(app.isOnePage)
            {
                app.isOnePage = 0;
                [[app.plistValue objectAtIndex:app.plistKeyIndex] replaceObjectAtIndex:2 withObject:[NSNumber numberWithInteger:0]];
            }
            //1画面表示ではない場合
            else
            {
                app.isOnePage = 1;
                [[app.plistValue objectAtIndex:app.plistKeyIndex] replaceObjectAtIndex:2 withObject:[NSNumber numberWithInteger:1]];
            }
            
            //画面を更新
            //1画面表示の場合(『デフォルトで1画面』を考慮)
            if(abs(app.isOnePage - [[[app.plistValue objectAtIndex:0] objectAtIndex:1] intValue]))
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
            //1画面表示ではない場合
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
    
    //アーカイブ読み込み中もしくはサムネイル一覧実行中ではない場合
    if(!app.isLoadingArchive && !app.isThumbnail)
    {
        NSImage *selectImage;
        int selectIndex;
        
        //空ではない場合
        if(app.listSize)
        {
            //左開きの場合(『デフォルトで左開き』を考慮)
            if(abs(app.isHidaribiraki - [[[app.plistValue objectAtIndex:0] objectAtIndex:0] intValue]))
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
    
    //アーカイブ読み込み中もしくはサムネイル一覧実行中ではない場合
    if(!app.isLoadingArchive && !app.isThumbnail)
    {
        NSImage *selectImage;
        int selectIndex;
        
        //空ではない場合
        if(app.listSize)
        {
            //左開きの場合(『デフォルトで左開き』を考慮)
            if(abs(app.isHidaribiraki - [[[app.plistValue objectAtIndex:0] objectAtIndex:0] intValue]))
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
        
        //フォルダを開いている場合
        BOOL isDirectory;
        if ([[NSFileManager defaultManager]fileExistsAtPath:app.filePath isDirectory:&isDirectory] && isDirectory)
        {
            fileName = [[app.filePath lastPathComponent] stringByAppendingString:selectIndexNSString];
        }
        //アーカイブを開いている場合
        else
        {
            fileName = [[[app.filePath lastPathComponent] stringByDeletingPathExtension] stringByAppendingString:selectIndexNSString];
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
    
    //アーカイブ読み込み中もしくはサムネイル一覧実行中ではない場合
    if(!app.isLoadingArchive && !app.isThumbnail)
    {
        //アーカイブのリストが空ではない場合
        if(app.listSizeOfArchive)
        {
            //フォルダを閲覧中の場合
            BOOL isDirectory;
            if ([[NSFileManager defaultManager]fileExistsAtPath:app.filePath isDirectory:&isDirectory] && isDirectory)
            {
                //確認パネルを起動
                [self openConfirmPanel:@"folderDelete"];
            }
            //アーカイブを閲覧中の場合
            else
            {
                //アーカイブをゴミ箱に入れる
                [self archiveDelete1];
            }
        }
        //アーカイブのリストが空の場合
        else
        {
            //初期状態にする
            [self resetMangao];
        }
    }
}

//実際にアーカイブをゴミ箱に入れる
- (void)archiveDelete1
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //アーカイブリストを更新
    [self reloadFileListFullPathOfArchive];
    
    //閲覧中のアーカイブがリスト内で何番目にあるか取得
    int indexOfArchiveTemp = (int)[app.fileListFullPathOfArchive indexOfObject:app.filePath];

    //存在しなかった場合
    if(indexOfArchiveTemp < 0)
    {
        //アーカイブがまだある場合
        if(app.listSizeOfArchive)
        {
            app.indexOfArchive = 0;
            app.filePath = [app.fileListFullPathOfArchive objectAtIndex:app.indexOfArchive];
            [self loadArchive];
        }
        //アーカイブが存在しない場合
        else
        {
            //初期状態にする
            [self resetMangao];
        }
    }
    //存在した場合
    else
    {
        //ゴミ箱に入れる
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
                app.indexOfArchive = app.indexOfArchive + 1;
            }
            //現在開いているアーカイブが最後の場合
            else
            {
                app.indexOfArchive = 0;
            }
            app.filePath = [app.fileListFullPathOfArchive objectAtIndex:app.indexOfArchive];
            [self loadArchive];
        }
        //削除したのが最後のアーカイブの場合
        else
        {
            //初期状態にする
            [self resetMangao];
        }
    }
}

//背景色の変更
- (void)changeBackgroundColor
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //『空・アーカイブ読み込み中・サムネイル一覧実行中』ではない場合
    if(app.listSize && !app.isLoadingArchive && !app.isThumbnail)
    {
        //黒色→灰色→白色
        if([[[app.plistValue objectAtIndex:0] objectAtIndex:9] intValue] == 2)
        {
            [[app.plistValue objectAtIndex:0] replaceObjectAtIndex:9 withObject:[NSNumber numberWithInteger:0]];
        }
        else if([[[app.plistValue objectAtIndex:0] objectAtIndex:9] intValue])
        {
            [[app.plistValue objectAtIndex:0] replaceObjectAtIndex:9 withObject:[NSNumber numberWithInteger:2]];
        }
        else
        {
            [[app.plistValue objectAtIndex:0] replaceObjectAtIndex:9 withObject:[NSNumber numberWithInteger:1]];
        }
        
        //実際に適用する
        [self setBackgroundColor];
        
        //풀스크린 여부 판별
        if(![NSMenu menuBarVisible])
        {
            //페이지 넘버를 감췄다가 다시 그린다
            pagenumberPrev.hidden = 1;
            pagenumberNext.hidden = 1;
            [self showTextField:pagenumberPrev];
            [self showTextField:pagenumberNext];
        }
    }
}

//背景色の適用
- (void)setBackgroundColor
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //0→灰色、1→白色、2→黒色
    if([[[app.plistValue objectAtIndex:0] objectAtIndex:9] intValue] == 2)
    {
        [viewWindow setBackgroundColor:[NSColor blackColor]];
    }
    else if([[[app.plistValue objectAtIndex:0] objectAtIndex:9] intValue])
    {
        [viewWindow setBackgroundColor:[NSColor whiteColor]];
    }
    else if(![[[app.plistValue objectAtIndex:0] objectAtIndex:9] intValue])
    {
        [viewWindow setBackgroundColor:[NSColor windowBackgroundColor]];
    }
}

//풀스크린 진입 확인, 페이지 넘버 표시
- (void)windowDidEnterFullScreen:(NSNotification *)notification
{
    //NSLog(@"enter fullscreen");
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    //풀스크린시 페이지 번호 표시
    //좌우로 긴 이미지일 때
    if (app.isYokonaga)
    {
        if(app.isHidaribiraki)
        {
            [self showTextField:pagenumberPrev];
            pagenumberNext.hidden = 1;
        }
        else
        {
            pagenumberPrev.hidden = 1;
            [self showTextField:pagenumberNext];
        }
    }
    //화면 폭으로 맞춰 보기 On(viewsetting 1) 또는 1페이지 보기가 활성화된 상태에서 왼쪽으로 넘겨보기가 아닌 경우
    else if(((app.isOnePage)&&(!app.isHidaribiraki)) || ((app.viewSetting)&&(!app.isHidaribiraki)))
    {
        pagenumberPrev.hidden = 1;
        [self showTextField:pagenumberNext];
    }
    //화면 폭으로 맞춰 보기 On(viewsetting 1) 또는 1페이지 보기가 활성화된 상태에서 왼쪽으로 넘겨보기 상태인 경우
    else if(((app.isOnePage)&&(app.isHidaribiraki))  || ((app.viewSetting)&&(app.isHidaribiraki)))
    {
        [self showTextField:pagenumberPrev];
        pagenumberNext.hidden = 1;
    }
    else
    {
        [self showTextField:pagenumberPrev];
        [self showTextField:pagenumberNext];
    }
}

//풀스크린 해제, 페이지 넘버 감추기
- (void)windowDidExitFullScreen:(NSNotification *)notification
{
    //NSLog(@"exit fullscreen");
    [self hideTextField:pagenumberPrev];
    [self hideTextField:pagenumberNext];
}

//메인 윈도우의 리사이징을 nsnotificatiocenter를 통해서 확인, 리스트 썸네일 뷰의 리사이징
- (void)windowDidResize:(NSNotification *)notification {
    if (isThumbnail && viewSetting) {
        [self setListThumbnailView];
    }
    else if (isThumbnail) {
        [self setListThumbnailView];
    }
    else if (viewSetting) {
    }
}

//메인 윈도우의 움직임을 nsnotificatiocenter를 통해서 확인, 리스트 썸네일 뷰의 리사이징
// -> addchildwindow로 변경후 소스코드 삭제
/*
- (void)windowDidMove:(NSNotification *)notification {
    [self setListThumbnailView];
}*/

- (void)setListThumbnailView
{
    NSRect windowRect = [[self viewWindow] frame];
    //썸네일 이미지의 높이 설정
    int thumbLength = windowRect.size.height / 5;
    NSRect thumbFrame = NSMakeRect(windowRect.origin.x, windowRect.origin.y, windowRect.size.width, thumbLength + 24);
    [thumbnailWindow setFrame:thumbFrame display:NO animate:YES];
    //관성을 없음으로 설정
    [thumbnailScrollView setHorizontalScrollElasticity:1];
    //다이나믹 스크롤 없음
    [thumbnailScrollView setScrollsDynamically:NO];
    //스크롤 바 표시 On
    [thumbnailScrollView setHasHorizontalScroller:YES];
    //스크롤러 스타일을 overlay로 설정
    [thumbnailScrollView setScrollerStyle:1];
    //scroller know 스타일을 light로 설정
    [thumbnailScrollView setScrollerKnobStyle:2];
    [thumbnailScrollView setVerticalLineScroll:0.0];
    [thumbnailScrollView setVerticalPageScroll:0.0];
    
    [thumbnailView setValue:[NSColor clearColor] forKey:IKImageBrowserBackgroundColorKey];
    [thumbnailView setContentResizingMask:NSViewWidthSizable];
    NSSize thumbCellSize;
    thumbCellSize.width = thumbLength;
    thumbCellSize.height = thumbLength;
    [thumbnailView setCellSize:thumbCellSize];
    
    [thumbnailWindow setAlphaValue:0.8];
}

//サムネイル一覧
- (void)thumbnail
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //메인 윈도우의 리사이징 및 이동 여부를 체크
    //->childwindow로 바꾸면서 이동 여부는 체크 안 하고 리사이징 여부만 체크하도록 변경
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowDidResize:) name:NSWindowDidResizeNotification object:viewWindow];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowDidMove:) name:NSWindowDidMoveNotification object:viewWindow];
    
    //空ではない場合
    if(app.listSize)
    {
        //アーカイブ読み込み中もしくはサムネイル一覧実行中ではない場合
        if(!app.isLoadingArchive && !app.isThumbnail)
        {
            app.isThumbnail = 1;
            
            //ビューウィンドウを無効にする(thumbnailWindowはタイトルバーがないのでisKeyWindowがうまく動かない)
            //[[self viewWindow] orderOut:self];

            //サムネイルウィンドウを画面と同じ大きさにする
            //메인 윈도우를 리사이즈 불가로 놓는다, 움직이지 못하게 한다
            //[[self viewWindow] setStyleMask:[[self viewWindow] styleMask] & ~NSResizableWindowMask & ~NSMiniaturizableWindowMask & ~NSClosableWindowMask];
            //[[self viewWindow] setMovable:NO];
            //[[[self viewWindow] standardWindowButton:NSWindowFullScreenButton] setHidden:YES];
            /*
            NSRect windowRect = [[self viewWindow] frame];
            //썸네일 이미지의 높이 설정
            int thumbLength = windowRect.size.height / 5;
            NSRect thumbFrame = NSMakeRect(windowRect.origin.x, windowRect.origin.y, windowRect.size.width, thumbLength + 24);
            [thumbnailWindow setFrame:thumbFrame display:NO animate:YES];
             */
            //サムネイルビューの背景色をビューウィンドウと同じにする
            /*
             if([[[app.plistValue objectAtIndex:0] objectAtIndex:9] intValue] == 2)
             {
             [thumbnailView setValue:[NSColor blackColor] forKey:IKImageBrowserBackgroundColorKey];
             }
             else if([[[app.plistValue objectAtIndex:0] objectAtIndex:9] intValue])
             {
             [thumbnailView setValue:[NSColor whiteColor] forKey:IKImageBrowserBackgroundColorKey];
             }
             else
             {
             [thumbnailView setValue:[NSColor colorWithDeviceRed:237/255.0f green:237/255.0f blue:237/255.0f alpha:1.0] forKey:IKImageBrowserBackgroundColorKey];
             }
             */
            [self setListThumbnailView];
            //サムネイルウィンドウを有効にする
            [viewWindow addChildWindow:thumbnailWindow ordered:NSWindowAbove];
            //[[self thumbnailWindow] makeKeyAndOrderFront:self];
            //メニューバーより手前に表示
            [thumbnailWindow setLevel: NSStatusWindowLevel];
            
            //NSLog(@"main hidaribiraki:%i", app.isHidaribiraki);
            //NSLog(@"thumbnail hidaribiraki:%i", app.isHidaribirakiThumb);
            
            //最後にサムネイル一覧を実行した時と異なるアーカイブを開いている場合
            if(app.thumbnailPath != app.filePath)
            {
                //現在のアーカイブのパスを最後にサムネイル一覧を実行した時のパスとして記録する
                app.thumbnailPath = app.filePath;
                [self makeThumbnailController];
                app.isHidaribirakiThumb = app.isHidaribiraki;
            }

            else if (app.isHidaribirakiThumb != app.isHidaribiraki)
            {
                //現在のアーカイブのパスを最後にサムネイル一覧を実行した時のパスとして記録する
                app.thumbnailPath = app.filePath;
                [self makeThumbnailController];
                app.isHidaribirakiThumb = app.isHidaribiraki;
            }
            
            int itemIndex;
            //右側に最後のページを表示中ではない場合
            if(app.index != app.listSize)
            {
                itemIndex = app.index;
            }
            //右側に最後のページを表示中の場合
            else
            {
                itemIndex = app.index - 1;
            }
            //アイテムを選択する
            //NSLog(@"self itemIndex:%d", itemIndex);
            [self thumbnailSelectedItem:itemIndex];
            
            //썸네일 번호 표시
            [self showTextField:thumbnailNumber];
        }
        
        //サムネイル一覧を実行中の場合
        else
        {
            //サムネイル一覧を終了する
            [self exitThumbnail];
        }
    }
}

//썸네일 번호를 애니메이션으로 표시
- (void)showTextField:(NSTextField*)TextField
{
    //썸네일 번호 텍스트필드 표시
    [TextField setAlphaValue:0.0];
    TextField.hidden = 0 ;
    
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:1];
    [[TextField animator] setAlphaValue:0.9];
    [NSAnimationContext endGrouping];
    
    /* 자동 감추기 코드. 일단 하지 않음
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(hideThumbnailNumber)
                                   userInfo:nil
                                    repeats:NO];
     */
}

//썸네일 번호를 애니메이션으로 감추기
- (void)hideTextField:(NSTextField*)TextField
{
    //썸네일 번호 텍스트필드 감추기
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:1];
    [[TextField animator] setAlphaValue:0.0];
    [NSAnimationContext endGrouping];

    //썸네일 넘버 감추기
    if (TextField.alphaValue == 0.0)
    {
        TextField.hidden = 1;
    }
}


- (void)makeThumbnailController
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];

    //サムネイル一覧の情報を初期化する
    [thumbnailController init];
    
    //PDFを開いている場合
    if([[app.filePath lowercaseString] hasSuffix:@".pdf"])
    {
        //for(PDFPage *page in PDFArray)
        if (app.isHidaribiraki)
        {
            for(int i = 0; i < app.listSize ; i++)
            {
                PDFPage *page = [PDFArray objectAtIndex:i];
                NSImage *thumbnailImage = [self makePDFThumbnail:page];
                thumbnail *thumbnailItem = [thumbnail imageItemWithContentsOfNSImage:thumbnailImage];
                [thumbnailController addObject:thumbnailItem];
            }
        }
        else
        {
            for(int i = app.listSize-1; i >= 0 ; i--)
            {
                PDFPage *page = [PDFArray objectAtIndex:i];
                NSImage *thumbnailImage = [self makePDFThumbnail:page];
                thumbnail *thumbnailItem = [thumbnail imageItemWithContentsOfNSImage:thumbnailImage];
                [thumbnailController addObject:thumbnailItem];
            }
        }
    }
    //PDF以外を開いている場合
    else
    {
        //우철(오른쪽넘기기)일 때 좌측 페이지 넘기기로
        NSArray *thumbImageArray;
        if (app.isHidaribiraki)
        {
            thumbImageArray = imageArray;
        }
        else
        {
            thumbImageArray = [[imageArray reverseObjectEnumerator] allObjects];
        }
        for(NSImage *thumbnailImage in thumbImageArray)
        {
            thumbnail *thumbnailItem = [thumbnail imageItemWithContentsOfNSImage:thumbnailImage];
            [thumbnailController addObject:thumbnailItem];
        }
    }

}

//PDF 썸네일 만드는 부분을 함수로 분리
- (NSImage*)makePDFThumbnail:(PDFPage*)PDFImage
{
    NSRect bounds = [PDFImage boundsForBox:kPDFDisplayBoxMediaBox];
    float dimension = 1400;
    float scale = 1 > (NSHeight(bounds) / NSWidth(bounds)) ? dimension / NSWidth(bounds) :  dimension / NSHeight(bounds);
    bounds.size = NSMakeSize(bounds.size.width*scale,bounds.size.height*scale);
    
    NSImage *tempThumbnailImage = [[[NSImage alloc] initWithSize: bounds.size] autorelease];
    [tempThumbnailImage lockFocus];
    [[NSColor whiteColor] set];
    NSRectFill(bounds );
    NSAffineTransform * scaleTransform = [NSAffineTransform transform];
    [scaleTransform scaleBy: scale];
    [scaleTransform concat];
    [PDFImage drawWithBox: kPDFDisplayBoxMediaBox];
    [tempThumbnailImage unlockFocus];
    return tempThumbnailImage;
}

//サムネイルビューの前のアイテムを選択する
- (void)thumbnailSelectPrevItem
{
/*    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    //썸네일 인덱스 번호 재선언, 우철(왼쪽으로 넘기기)일 때는 전체 페이지 수에서 현재 아이템 수를 뺀다
    long thumbIndex=0.0;
    if (app.isHidaribiraki)
    {
        thumbIndex = app.listSize - [thumbnailView selectionIndexes].firstIndex;
    }
    else
    {
        thumbIndex = [thumbnailView selectionIndexes].firstIndex;
    }
    NSLog(@"select prev app list size : %d", app.listSize);
    NSLog(@"select prev index number : %ld", (unsigned long)[thumbnailView selectionIndexes].firstIndex);
    NSLog(@"select prev thumbIndex : %ld", thumbIndex);
*/
    long thumbIndex = [thumbnailView selectionIndexes].firstIndex;
    //現在、最初のアイテムを選択中ではない場合
    if(thumbIndex != 0)
    {
        //前のアイテムを選択
        long itemIndex = thumbIndex - 1;
        
        //アイテムを選択する
        [self thumbnailSelectItem:itemIndex];
    }
}

//サムネイルビューの次のアイテムを選択する
- (void)thumbnailSelectNextItem
{
/*    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    //썸네일 인덱스 번호 재선언, 우철(왼쪽으로 넘기기)일 때는 전체 페이지 수에서 현재 아이템 수를 뺀다
    long thumbIndex=0.0;
    if (app.isHidaribiraki)
    {
        thumbIndex = app.listSize - [thumbnailView selectionIndexes].firstIndex;
    }
    else
    {
        thumbIndex = [thumbnailView selectionIndexes].firstIndex;
    }
    NSLog(@"select next app list size : %d", app.listSize);
    NSLog(@"select next index number : %ld", (unsigned long)[thumbnailView selectionIndexes].firstIndex);
    NSLog(@"select next thumbIndex : %ld", thumbIndex);
 */
    long thumbIndex = [thumbnailView selectionIndexes].firstIndex;
    //現在最後のアイテムを選択中でない場合
    if(thumbIndex < [[thumbnailController arrangedObjects]count] - 1.0)
    {
        //次のアイテムを選択する
        long itemIndex = thumbIndex + 1;
        
        //アイテムを選択する
        [self thumbnailSelectItem:itemIndex];
    }
}

/* 썸네일 뷰에서의 커서 키 관련 이벤트들  */
//커서 키를 연속으로 눌러 이전 아이템 썸네일 선택시
- (void)thumbnailSelectRepeatPrevItem
{
    long thumbIndex = [thumbnailView selectionIndexes].firstIndex;
    //現在、最初のアイテムを選択中ではない場合
    if(thumbIndex != 0)
    {
        //前のアイテムを選択
        long toIndex = thumbIndex - 1;
        
        //アイテムを選択する
        [self thumbnailSelectRepeatItem:thumbIndex to:toIndex];
    }
}

//커서 키로 다음 아이템 썸네일 선택시
- (void)thumbnailSelectRepeatNextItem
{
    long thumbIndex = [thumbnailView selectionIndexes].firstIndex;
    //現在最後のアイテムを選択中でない場合
    if(thumbIndex < [[thumbnailController arrangedObjects]count] - 1.0)
    {
        //次のアイテムを選択する
        long toIndex = thumbIndex + 1;
        
        //アイテムを選択する
        [self thumbnailSelectRepeatItem:thumbIndex to:toIndex];
    }
}

//썸네일 번호 입력 및 표시
- (void)setThumbnailIndex:(unsigned long)indexNumber
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    [thumbnailNumber setStringValue:[NSString stringWithFormat:@"%lu/%d", indexNumber, app.listSize]];
    //썸네일 번호와 전체 페이지 번호 길이에 맞춰 텍스트 필드 길이 변화
    [thumbnailNumber sizeToFit];
}

//커서 키로 이동시 썸네일 스크롤
- (void)thumbnailSelectRepeatItem:(long)beforeIndex to:(long)itemIndex
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    [thumbnailView setSelectionIndexes:[NSIndexSet indexSetWithIndex:itemIndex] byExtendingSelection:NO];
    //アイテムが表示される位置にスクロールする
    //썸네일 인덱스 번호 재선언, 우철(왼쪽으로 넘기기)일 때는 전체 페이지 수에서 현재 아이템 수를 뺀다
    unsigned long thumbFinalIndex;
    if (app.isHidaribiraki)
    {
        thumbFinalIndex = itemIndex;
    }
    else
    {
        thumbFinalIndex = [[thumbnailController arrangedObjects]count] - itemIndex - 1;
    }
    
    //현재 썸네일 넘버 입력, 표시
    //[thumbnailNumber setStringValue:[NSString stringWithFormat:@"%lu", thumbFinalIndex + 1]];
    [self setThumbnailIndex:(thumbFinalIndex -1)];
    int halfNumberOfItem = ([self viewWindow].frame.size.width / [thumbnailView cellSize].width) / 2;
    
    //finalIndex 1차 정의
    long finalIndex;
    if (beforeIndex < itemIndex)
    {
        finalIndex = itemIndex + halfNumberOfItem;
    }
    else
    {
        finalIndex = itemIndex - halfNumberOfItem;
    }

    //finalIndex 2차 정의
    if (finalIndex < halfNumberOfItem)
    {
        finalIndex = 0;
    }
    else if (finalIndex > [[thumbnailController arrangedObjects]count])
    {
        finalIndex = [[thumbnailController arrangedObjects]count] - 1;
    }
    
    [thumbnailView scrollIndexToVisible:finalIndex];
}

//サムネイルビューの前のページのアイテムを選択する
- (void)thumbnailSelectPrevPageItem
{
    //現在、最初のアイテムを選択中ではない場合
    if([thumbnailView selectionIndexes].firstIndex != 0)
    {
        //컬럼에 표시되는 아이템 갯수 확인
        int numberOfItemInColumn = [self viewWindow].frame.size.width / [thumbnailView cellSize].width;
        //NSLog(@"number of item in columm:%i", numberOfItemInColumn);

        long itemIndex = [thumbnailView selectionIndexes].firstIndex - numberOfItemInColumn;
        
        //範囲外の場合、最初のアイテムを選択
        if(itemIndex < 0)
        {
            itemIndex = 0;
        }
        
        //アイテムを選択する
        [self thumbnailSelectItem:itemIndex];
    }
}

//サムネイルビューの次のページのアイテムを選択する
- (void)thumbnailSelectNextPageItem
{
    //現在最後のアイテムを選択中でない場合
    if([thumbnailView selectionIndexes].firstIndex < [[thumbnailController arrangedObjects]count] - 1)
    {
        //컬럼에 표시되는 아이템 갯수 확인
        int numberOfItemInColumn = [self viewWindow].frame.size.width / [thumbnailView cellSize].width;
        //NSLog(@"number of item in columm:%i", numberOfItemInColumn);
        
        long itemIndex = [thumbnailView selectionIndexes].firstIndex + numberOfItemInColumn;
        
        //範囲外の場合、最後のアイテムを選択
        if(itemIndex >= [[thumbnailController arrangedObjects]count])
        {
            itemIndex = [[thumbnailController arrangedObjects]count] - 1;
        }
        
        //アイテムを選択する
        [self thumbnailSelectItem:itemIndex];
    }
}

//스페이스바로 이전 썸네일 목록 화면 이동시
- (void)thumbnailSelectSpacePrevPageItem
{
    //現在、最初のアイテムを選択中ではない場合
    if([thumbnailView selectionIndexes].firstIndex != 0)
    {
        //컬럼에 표시되는 아이템 갯수 확인
        int numberOfItemInColumn = [self viewWindow].frame.size.width / [thumbnailView cellSize].width;
        //NSLog(@"number of item in columm:%i", numberOfItemInColumn);
        
        long thumbIndex = [thumbnailView selectionIndexes].firstIndex;
        long itemIndex = [thumbnailView selectionIndexes].firstIndex - numberOfItemInColumn;
        
        //範囲外の場合、最初のアイテムを選択
        if(itemIndex < 0)
        {
            itemIndex = 0;
        }
        
        //アイテムを選択する
        [self thumbnailSelectRepeatItem:thumbIndex to:itemIndex];
    }
}

//스페이스바로 다음 썸네일 목록 화면 이동시
- (void)thumbnailSelectSpaceNextPageItem
{
    //現在最後のアイテムを選択中でない場合
    if([thumbnailView selectionIndexes].firstIndex < [[thumbnailController arrangedObjects]count] - 1)
    {
        //컬럼에 표시되는 아이템 갯수 확인
        int numberOfItemInColumn = [self viewWindow].frame.size.width / [thumbnailView cellSize].width;
        //NSLog(@"number of item in columm:%i", numberOfItemInColumn);

        long thumbIndex = [thumbnailView selectionIndexes].firstIndex;
        long itemIndex = [thumbnailView selectionIndexes].firstIndex + numberOfItemInColumn;
        
        //範囲外の場合、最後のアイテムを選択
        if(itemIndex >= [[thumbnailController arrangedObjects]count])
        {
            itemIndex = [[thumbnailController arrangedObjects]count] - 1;
        }
        
        //アイテムを選択する
        [self thumbnailSelectRepeatItem:thumbIndex to:itemIndex];
    }
}

//サムネイルビューの最初のアイテムを選択する
- (void)thumbnailSelectFirstItem
{
    //現在、最初のアイテムを選択中ではない場合
    if([thumbnailView selectionIndexes].firstIndex != 0)
    {
        //最初のアイテムを選択する
        long itemIndex = 0;
        
        //アイテムを選択する
        [self thumbnailSelectItem:itemIndex];
    }
}

//サムネイルビューの最後のアイテムを選択する
- (void)thumbnailSelectLastItem
{
    //現在最後のアイテムを選択中でない場合
    if([thumbnailView selectionIndexes].firstIndex < [[thumbnailController arrangedObjects]count] - 1)
    {
        //最後のアイテムを選択する
        long itemIndex = [[thumbnailController arrangedObjects]count] - 1;;
        
        //アイテムを選択する
        [self thumbnailSelectItem:itemIndex];
    }
}

//썸네일 뷰 아이템 선택시 썸네일 스크롤
- (void)thumbnailSelectItem:(long)itemIndex
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    [thumbnailView setSelectionIndexes:[NSIndexSet indexSetWithIndex:itemIndex] byExtendingSelection:NO];
    //アイテムが表示される位置にスクロールする
    //썸네일 인덱스 번호 재선언, 우철(왼쪽으로 넘기기)일 때는 전체 페이지 수에서 현재 아이템 수를 뺀다
    unsigned long thumbIndex;
    if (app.isHidaribiraki)
    {
        thumbIndex = itemIndex;
    }
    else
    {
        thumbIndex = [[thumbnailController arrangedObjects]count] - itemIndex - 1;
    }
    
    //현재 썸네일 넘버 입력, 표시
    //[thumbnailNumber setStringValue:[NSString stringWithFormat:@"%lu",thumbIndex + 1]];
    [self setThumbnailIndex:(thumbIndex + 1)];

    //스크롤 좌표 계산
    NSPoint oldScrollOrigin;
    NSPoint newScrollOrigin;
    float numberOfItem = [self viewWindow].frame.size.width / [thumbnailView cellSize].width;
    //현재 선택된 아이템의 좌표 확인 (oldScrollOrigin)
    if (app.isHidaribiraki)
    {
        //scrollPoint = (thumbnailView.frame.size.width * thumbIndex / [[thumbnailController arrangedObjects]count]) - (numberOfItem / 2 * [thumbnailView cellSize].width) + ([thumbnailView cellSize].width / 2);
        oldScrollOrigin = [thumbnailView itemFrameAtIndex:thumbIndex].origin;
    }
    else
    {
        //scrollPoint = (thumbnailView.frame.size.width * itemIndex / [[thumbnailController arrangedObjects]count]) - (numberOfItem / 2 * [thumbnailView cellSize].width) + ([thumbnailView cellSize].width / 2);
        //선택된 아이템의 좌표 확인
        oldScrollOrigin = [thumbnailView itemFrameAtIndex:itemIndex].origin;
    }
    //NSLog(@"old origin x: %f", oldScrollOrigin.x);
    
    //신규 스크롤 좌표 계산
    float scrollPoint = oldScrollOrigin.x - (numberOfItem / 2 * [thumbnailView cellSize].width) + ([thumbnailView cellSize].width /2 );
    newScrollOrigin = NSMakePoint(scrollPoint, 0.0);
    //NSLog(@"new origin x: %f", newScrollOrigin.x);
    [[thumbnailScrollView documentView] scrollPoint:newScrollOrigin];

    //NSLog(@"itemIndex : %lu", itemIndex);
    //NSLog(@"thumbIndex : %lu", thumbIndex);
    //NSLog(@"viewwindow frame : %f", thumbnailView.frame.size.width);
    //NSLog(@"cell width : %f", [thumbnailView cellSize].width);
    //NSLog(@"new select scrollpoint : %f", scrollPoint);
    
    //컨텐트뷰 좌표 계산, 포기
    /*
    NSPoint currentScrollPostion = [[thumbnailScrollView contentView] bounds].origin;
    NSSize currentScrollViewSize = [[thumbnailScrollView documentView] bounds].size;
    float documentCellSize = [[thumbnailScrollView documentView] bounds].size.width / [[thumbnailController arrangedObjects]count];
    NSLog(@"content view bounds scrollpoint: %f", currentScrollPostion.x);
    //NSLog(@"content view bounds width: %f", currentScrollViewSize.width);
    NSLog(@"document Cell Size: %f", documentCellSize);
    
    float newScrollPositionX = (itemIndex - numberOfItem / 2 ) * documentCellSize;
    //float newScrollPosistionX = [[thumbnailController arrangedObjects]count] * [thumbnailView cellSize].width;
    NSLog(@"content view bounds new scrollpoint: %f", newScrollPositionX);
    NSPoint newScrollPostion = NSMakePoint(newScrollPositionX, 0.0);
    
    //アイテムが表示される位置にスクロールする
    //[thumbnailView scrollIndexToVisible:thumbIndex];
     */
}

//썸네일 뷰 표시시 썸네일 스크롤
- (void)thumbnailSelectedItem:(long)itemIndex
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    //때때로 올바른 번호로 이동하지 않는 버그 때문에 일부러 NSLog 를 남겨놓음
    //NSLog(@"item index:%ld", itemIndex);
    //썸네일 인덱스 번호 재선언, 우철(왼쪽으로 넘기기)일 때는 전체 페이지 수에서 현재 아이템 수를 뺀다
    unsigned long thumbIndex;
    if (app.isHidaribiraki)
    {
        thumbIndex = itemIndex;
    }
    else
    {
        thumbIndex = [[thumbnailController arrangedObjects]count] - itemIndex - 1;
    }
    //NSLog(@"app list size : %d", app.listSize);
    //NSLog(@"selectedItem index number : %ld", itemIndex);
    //NSLog(@"selectedItem thumbIndex : %ld", thumbIndex);
    
    //썸네일 넘버 표시
    //[thumbnailNumber setStringValue:[NSString stringWithFormat:@"%lu",itemIndex + 1]];
    [self setThumbnailIndex:(itemIndex + 1)];

    [thumbnailView setSelectionIndexes:[NSIndexSet indexSetWithIndex:thumbIndex] byExtendingSelection:NO];
    
    //스크롤 좌표 계산
    NSPoint oldScrollOrigin;
    NSPoint newScrollOrigin;
    float numberOfItem = [self viewWindow].frame.size.width / [thumbnailView cellSize].width;
    oldScrollOrigin = [thumbnailView itemFrameAtIndex:thumbIndex].origin;
    float scrollPoint = oldScrollOrigin.x - (numberOfItem / 2 * [thumbnailView cellSize].width) + ([thumbnailView cellSize].width /2 );
    //float scrollPoint = (thumbnailView.frame.size.width * thumbIndex / [[thumbnailController arrangedObjects]count]) - (numberOfItem / 2 * [thumbnailView cellSize].width) + ([thumbnailView cellSize].width / 2);
    //NSLog(@"viewwindow frame : %f", thumbnailView.frame.size.width);
    //NSLog(@"selected scrollpoint : %f", scrollPoint);
    newScrollOrigin = NSMakePoint(scrollPoint, 0.0);
    //アイテムが表示される位置にスクロールする
    //
    [[thumbnailScrollView documentView] scrollPoint:newScrollOrigin];
}

//サムネイルビューの選択されているアイテムを開く
- (void)thumbnailOpenSelectedItem
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    app.index = [thumbnailView selectionIndexes].firstIndex;
    if (app.isHidaribiraki)
    {
        app.index = app.index;
    }
    else
    {
        app.index = [[thumbnailController arrangedObjects]count] - app.index;
    }
    
    //NSLog(@"open Selected Item app.index : %ld", app.index);
    
    [self setImage];
    
    //サムネイル一覧を終了する
    [self exitThumbnail];
}

//サムネイル一覧の中の画像をダブルクリックした時
- (void)imageBrowser:(IKImageBrowserView *)aBrowser cellWasDoubleClickedAtIndex:(NSUInteger)selecetIndex
{
    //アイテムを選択する
    [thumbnailView setSelectionIndexes:[NSIndexSet indexSetWithIndex:selecetIndex] byExtendingSelection:NO];
    
    [self thumbnailOpenSelectedItem];
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
    //메인 윈도우를 원래 상태대로 복귀시킨다
    [[self viewWindow] setStyleMask:[[self viewWindow] styleMask] | NSResizableWindowMask | NSMiniaturizableWindowMask | NSClosableWindowMask];
    [[self viewWindow] setMovable:YES];
    [[[self viewWindow] standardWindowButton:NSWindowFullScreenButton] setHidden:NO];
    //썸네일 넘버 감추기 애니메이션
    [self hideTextField:thumbnailNumber];

    //썸네일 넘버 초기화
    if (thumbnailNumber.alphaValue == 0)
    {
        [thumbnailNumber setStringValue:@""];
    }
    
    //메인 윈도우의 라이브 리사이징 체크 및 이동 여부 체크를 중단
    //-> addchildwindow로 변경후 리사이즈 여부 체크만 함. 이동은 중단
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSWindowDidResizeNotification object:viewWindow];
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:NSWindowDidMoveNotification object:viewWindow];
}

//小さいルーペ
- (void)loupeSmallOnOff
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //アーカイブ読み込み中もしくはサムネイル一覧実行中ではない場合
    if(!app.isLoadingArchive && !app.isThumbnail)
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
        //メインメニューを再構成する
        [self reloadMainMenu];
    }
}

//大きいルーペ
- (void)loupeLargeOnOff
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //アーカイブ読み込み中もしくはサムネイル一覧実行中ではない場合
    if(!app.isLoadingArchive && !app.isThumbnail)
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
        //メインメニューを再構成する
        [self reloadMainMenu];
    }
}

//ブックマークを追加/削除
- (void)bookmarkAddRemove
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    
    //アーカイブ読み込み中もしくはサムネイル一覧実行中ではない場合
    if(!app.isLoadingArchive && !app.isThumbnail)
    {
        //空でないことを確認
        if(app.listSize)
        {
            //ブックマークが空の場合
            if([[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:4] == [NSNumber numberWithInteger:0])
            {
                //ブックマークを登録
                [[app.plistValue objectAtIndex:app.plistKeyIndex] replaceObjectAtIndex:4 withObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInteger:app.index+1], nil]];
            }
            //ブックマークが空ではない場合
            else
            {
                //ブックマークの中で何番目か検索
                NSUInteger bookmarkIndex = [[[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:4] indexOfObject:[NSNumber numberWithInteger:app.index+1]];
                
                //未登録の場合
                if(bookmarkIndex == NSNotFound)
                {
                    //ブックマークを登録
                    [[[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:4] addObject:[NSNumber numberWithInteger:app.index+1]];
                }
                //登録済みの場合
                else
                {
                    //ブックマークを削除
                    [[[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:4] removeObjectAtIndex:bookmarkIndex];
                    
                    //ブックマークが全て削除された場合
                    if(![[[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:4] count])
                    {
                        //[NSNumber:0]に差し替え
                        [[app.plistValue objectAtIndex:app.plistKeyIndex] replaceObjectAtIndex:4 withObject:[NSNumber numberWithInteger:0]];
                    }
                }
            }
            //ウィンドウタイトルを再読込する
            [self setWindowTitle];
            //メインメニューを再構成する
            [self reloadMainMenu];
        }
    }
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
    
    //アーカイブ読み込み中もしくはサムネイル一覧実行中ではない場合
    if(!app.isLoadingArchive && !app.isThumbnail)
    {
        //空でないことを確認
        if(app.listSize)
        {
            //ブックマークが空ではない場合
            if([[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:4] != [NSNumber numberWithInteger:0])
            {
                //ブックマークの中で何番目か検索
                NSUInteger bookmarkIndex = [[[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:4] indexOfObject:[NSNumber numberWithInteger:app.index+1]];
                
                //未登録の場合
                if(bookmarkIndex == NSNotFound)
                {
                    //ブックマークが1つの場合
                    if([[[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:4]count] == 1)
                    {
                        //そのブックマークに移動
                        app.index = [[[[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:4]objectAtIndex:0]intValue]-1;
                    }
                    //ブックマークが2つ以上ある場合
                    else
                    {
                        //ブックマークの配列に現在のindexを加えた配列を作る
                        NSMutableArray *array = [[[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:4] mutableCopy];
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
                    if([[[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:4]count] > 1)
                    {
                        //最初のブックマークの場合
                        if(bookmarkIndex == 0)
                        {
                            //最後のブックマークに移動
                            app.index = [[[[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:4]objectAtIndex:[[[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:4]count]-1]intValue]-1;
                        }
                        //最初のブックマークではない場合
                        else
                        {
                            //前のブックマークに移動
                            app.index = [[[[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:4]objectAtIndex:bookmarkIndex-1]intValue]-1;
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
    
    //アーカイブ読み込み中もしくはサムネイル一覧実行中ではない場合
    if(!app.isLoadingArchive && !app.isThumbnail)
    {
        //空でないことを確認
        if(app.listSize)
        {
            //ブックマークが空ではない場合
            if([[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:4] != [NSNumber numberWithInteger:0])
            {
                //ブックマークの中で何番目か検索
                NSUInteger bookmarkIndex = [[[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:4] indexOfObject:[NSNumber numberWithInteger:app.index+1]];
                
                //未登録の場合
                if(bookmarkIndex == NSNotFound)
                {
                    //ブックマークが1つの場合
                    if([[[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:4]count] == 1)
                    {
                        //そのブックマークに移動
                        app.index = [[[[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:4]objectAtIndex:0]intValue]-1;
                    }
                    //ブックマークが2つ以上ある場合
                    else
                    {
                        //ブックマークの配列に現在のindexを加えた配列を作る
                        NSMutableArray *array = [[[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:4] mutableCopy];
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
                    if([[[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:4]count] > 1)
                    {
                        //最後のブックマークの場合
                        if(bookmarkIndex == [[[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:4]count]-1)
                        {
                            //最初のブックマークに移動
                            app.index = [[[[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:4]objectAtIndex:0]intValue]-1;
                        }
                        //最後のブックマークではない場合
                        else
                        {
                            //次のブックマークに移動
                            app.index = [[[[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:4]objectAtIndex:bookmarkIndex+1]intValue]-1;
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
        if([[app.plistValue objectAtIndex:app.plistKeyIndex] objectAtIndex:4] != [NSNumber numberWithInteger:0])
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
            [[app.plistValue objectAtIndex:app.plistKeyIndex] replaceObjectAtIndex:4 withObject:[NSNumber numberWithInteger:0]];
            
            //ウィンドウタイトルを再読込する
            [self setWindowTitle];
            //メインメニューを再構成
            [self reloadMainMenu];
        }
        //『アーカイブをゴミ箱に入れる(フォルダ)』の場合
        else if(contextInfo == @"folderDelete")
        {
            //フォルダをゴミ箱に入れる
            [self archiveDelete1];
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