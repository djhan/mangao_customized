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
    int isOnePage;
    int isSlideshow;
    int isFullscreenFor106;
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
    IKImageBrowserView *thumbnailView;
    //pagenumber 추가
    NSTextField *pagenumberPrev;
    NSTextField *pagenumberNext;
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
@property (nonatomic, assign) int isOnePage;
@property (nonatomic, assign) int isSlideshow;
@property (nonatomic, assign) int isFullscreenFor106;
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
@property (assign) IBOutlet IKImageBrowserView *thumbnailView;

//pagenumber 추가
@property (assign) IBOutlet NSTextField *pagenumberPrev;
@property (assign) IBOutlet NSTextField *pagenumberNext;

- (BOOL)application:(NSApplication *)sender openFile:(NSString *)filename;

@end
