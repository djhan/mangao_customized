//
//  HTMangaColorize.h
//  MangaColorize
//
//  MIT License. Copyright (c) 2013 hetima. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/CIFilter.h>


@interface HTMangaColorize : NSObject

#if !__has_feature(objc_arc)
{
    NSString* _mapPath;
    CIImage* _mapCI;
    BOOL _skipColoredSource;
}
#endif

//カラーマップの指定
//どれかひとつ実行すればよい。
//initWithMapFile:で指定しとけば自動でセットされる。
@property (nonatomic, strong) NSString* mapPath;
@property (nonatomic, strong) CIImage* mapCI;
- (void)setMapImage:(NSImage*)image;

- (id)initWithMapFile:(NSString*)filePath;

//カラー画像を無視するかどうか
//デフォルトはYES
//YES の場合カラーかどうかチェックするため処理が重くなる
//NO にすれば軽くなるが問答無用でカラーマップ適用する
@property (nonatomic) BOOL skipColoredSource;



//変換実行
- (NSImage*)colorizeImage:(NSImage*)srcImage;


//インスタンス作らずその都度変換も可
+ (NSImage*)colorizeImage:(NSImage*)srcImage withMapImage:(NSImage*)mapImage skipColoredSource:(BOOL)skipCS;

@end


