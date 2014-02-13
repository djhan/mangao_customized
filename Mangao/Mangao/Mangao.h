//
//  Mangao.h
//  Mangao Kai
//
//  Created by Ryota Minami <RyotaMinami93@gmail.com> on 2014/01/07.
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

#import <Cocoa/Cocoa.h>
//PDFkit
#import <Quartz/Quartz.h>
//MD5
#import <CommonCrypto/CommonDigest.h>

@interface Mangao : NSObject <NSApplicationDelegate,NSOpenSavePanelDelegate>
{
    NSArray *imageFileType;
    NSString *selectionImageFilePath;
    NSString *filePath;
    NSString *folderPath;
    NSMutableArray *fileListFullPathOfArchive;
    int index;
    int listSize;
    int indexOfArchive;
    int listSizeOfArchive;
    int isLoadingArchive;
    int isLoadingArchiveNotSetImage;
    int isCancelLoadingArchive;
    int isYokonaga;
    int isHidaribiraki;
    int isHidaribirakiThumb;
    int isOnePage;
    int isSlideshow;
    int isFitToScreen;
    int isThumbnail;
    int isLoupe;
    NSString *thumbnailPath;
    NSImage *imageLeft;
    NSImage *imageRight;
    NSImage *imageCenter;
    NSMutableArray *PDFArray;
    NSMutableArray *imageArray;
    NSTimer *slideshow;
    NSMutableArray *mountedTrueCryptVolume;
    NSRect windowRectBeforeFullscreen;
    NSPoint cursor_onImageCenterField;
    float timestamp_tapWithTwoFingers;
    NSUserDefaults *defaults;
    NSMutableArray *plistKey;
    NSMutableArray *plistValue;
    NSUInteger plistKeyIndex;
    
    NSWindow *viewWindow;
    NSMenu *mainMenu;
    NSMenuItem *mainMenuItem;
    NSImageView *imageRightField;
    NSImageView *imageLeftField;
    NSImageView *imageRightFieldxxx;
    NSImageView *imageLeftFieldxxx;
    NSImageView *imageCenterField;
    NSPanel *loupeWindow;
    NSImageView *loupeField;
    NSPanel *jumpPanel;
    NSTextField *jumpPanel_index;
    NSTextField *jumpPanel_listSize;
    NSPanel *confirmPanel;
    NSTextField *confirmPanel_text;
    
    NSArrayController *thumbnailController;
    NSWindow *thumbnailWindow;
    NSScrollView *thumbnailScrollView;
    IKImageBrowserView *thumbnailView;
    NSTextField *thumbnailNumber;
    //pagenumber 추가
    NSTextField *pagenumberPrev;
    NSTextField *pagenumberNext;
    
    //xadarchive 관련 추가
    NSArray *archiveFileType;
    //xadarchive 패스워드 관련
    NSPanel *passwordPanel;
    NSTextField *passwordNotice;
    NSTextField *passwordField;
    NSString *password;
    int isPassword;
    //압축 해제의 정합성 전역 변수(취소, 패스워드가 틀렸는지 여부를 확인)
    //int rightExtract;
    
    //오디오 인풋 패널
    NSPanel *audioInputPanel;
    int     isAudioInput;
    
    //PDFview
    PDFView *leftPdfView;
    PDFView *rightPdfView;
    PDFView *centerPdfView;

    //view setting
    int viewSetting; //0은 fit to window, 1은 fit to width
    NSScrollView *centerScrollView;
}

@property (nonatomic, retain) NSArray *imageFileType;
@property (nonatomic, retain) NSString *selectionImageFilePath;
@property (nonatomic, retain) NSString *filePath;
@property (nonatomic, retain) NSString *folderPath;
@property (nonatomic, retain) NSMutableArray *fileListFullPathOfArchive;
@property (nonatomic, assign) int index;
@property (nonatomic, assign) int listSize;
@property (nonatomic, assign) int indexOfArchive;
@property (nonatomic, assign) int listSizeOfArchive;
@property (nonatomic, assign) int isLoadingArchive;
@property (nonatomic, assign) int isLoadingArchiveNotSetImage;
@property (nonatomic, assign) int isCancelLoadingArchive;
@property (nonatomic, assign) int isYokonaga;
@property (nonatomic, assign) int isHidaribiraki;
@property (nonatomic, assign) int isHidaribirakiThumb;
@property (nonatomic, assign) int isOnePage;
@property (nonatomic, assign) int isSlideshow;
@property (nonatomic, assign) int isFitToScreen;
@property (nonatomic, assign) int isThumbnail;
@property (nonatomic, assign) int isLoupe;
@property (nonatomic, retain) NSString *thumbnailPath;
@property (nonatomic, retain) NSImage *imageLeft;
@property (nonatomic, retain) NSImage *imageRight;
@property (nonatomic, retain) NSImage *imageCenter;
@property (nonatomic, retain) NSMutableArray *PDFArray;
@property (nonatomic, retain) NSMutableArray *imageArray;
@property (nonatomic, assign) NSTimer *slideshow;
@property (nonatomic, retain) NSMutableArray *mountedTrueCryptVolume;
@property (nonatomic, assign) NSRect windowRectBeforeFullscreen;
@property (nonatomic, assign) NSPoint cursor_onImageCenterField;
@property (nonatomic, assign) float timestamp_tapWithTwoFingers;
@property (nonatomic, assign) NSUserDefaults *defaults;
@property (nonatomic, retain) NSMutableArray *plistKey;
@property (nonatomic, retain) NSMutableArray *plistValue;
@property (nonatomic, assign) NSUInteger plistKeyIndex;

@property (assign) IBOutlet NSWindow *viewWindow;
@property (assign) IBOutlet NSMenu *mainMenu;
@property (assign) IBOutlet NSMenuItem *mainMenuItem;
@property (assign) IBOutlet NSImageView *imageRightField;
@property (assign) IBOutlet NSImageView *imageLeftField;
@property (assign) IBOutlet NSImageView *imageRightFieldxxx;
@property (assign) IBOutlet NSImageView *imageLeftFieldxxx;
@property (assign) IBOutlet NSImageView *imageCenterField;
@property (assign) IBOutlet NSPanel *loupeWindow;
@property (assign) IBOutlet NSImageView *loupeField;
@property (assign) IBOutlet NSPanel *jumpPanel;
@property (assign) IBOutlet NSTextField *jumpPanel_index;
@property (assign) IBOutlet NSTextField *jumpPanel_listSize;
@property (assign) IBOutlet NSPanel *confirmPanel;
@property (assign) IBOutlet NSTextField *confirmPanel_text;

@property (assign) IBOutlet NSArrayController *thumbnailController;
@property (assign) IBOutlet NSWindow *thumbnailWindow;
@property (assign) IBOutlet NSScrollView *thumbnailScrollView;
@property (assign) IBOutlet IKImageBrowserView *thumbnailView;
@property (assign) IBOutlet NSTextField *thumbnailNumber;

//pagenumber 추가
@property (assign) IBOutlet NSTextField *pagenumberPrev;
@property (assign) IBOutlet NSTextField *pagenumberNext;

//xadarchive 관련 추가
@property (nonatomic, retain) NSArray *archiveFileType;
//xadarchive 패스워드 관련
@property (nonatomic, retain) NSString *password;
@property (assign) IBOutlet NSPanel *passwordPanel;
@property (assign) IBOutlet NSTextField *passwordNotice;
@property (assign) IBOutlet NSTextField *passwordField;
//압축 해제의 정합성 확인
//@property (nonatomic, assign) int rightExtract;
//archive 파일의 password 창 표시 여부
@property (nonatomic, assign) int isPassword;

//오디오 인풋 패널
@property (assign) IBOutlet NSPanel *audioInputPanel;
@property (assign) int isAudioInput;

//PDFview
@property (nonatomic, retain) PDFView *leftPdfView;
@property (nonatomic, retain) PDFView *rightPdfView;
@property (nonatomic, retain) PDFView *centerPdfView;

//view setting
@property (nonatomic, assign) int viewSetting; //0은 fit to window, 1은 fit to width
@property (assign) IBOutlet NSScrollView *centerScrollView;

- (BOOL)application:(NSApplication *)sender openFile:(NSString *)filename;

//사운드 인풋이 일정 레벨 이상 넘었다는 걸 인지하는 notification 선언
- (void)acceptSound:(NSNotification*)notification;

//view setting 변경
- (IBAction)fitToWindow:(id)sender; //윈도우 크기에 맞추기
- (IBAction)fitToWidth:(id)sender; //윈도우 폭에 맞추기

@end

