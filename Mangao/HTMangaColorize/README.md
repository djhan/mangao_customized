#MangaColorize

HTMangaColorize はグレースケールの画像を着色する Objective-C クラスです。要はマンガの自動着色を行います。  
CIFilter の CIColorMap を使っています。  
処理速度はあんまり速くないと思います。

ARC・非ARC 両対応です。

##ビルド方法
- HTMangaColorize.m と HTMangaColorize.h をプロジェクトに追加
- QuartzCore.framework をリンク

##使い方
カラーマップの定義をセットして、処理したい NSImage を渡すと処理された NSImage が返ります。

```
    //生成
    HTMangaColorize* mc=[[HTMangaColorize alloc]init];
    [mc setMapPath:mapPath];
    
    //オプション設定
    [mc setSkipColoredSource:NO];
    
    //処理
    NSImage* output=[mc colorizeImage:inputImage];
```

あるいはインスタンスを生成せず1行で済ますこともできます。

```
//インスタンスを生成しない方法
NSImage* output=[HTMangaColorize colorizeImage:srcImg withMapImage:mapImg skipColoredSource:YES];
```

`skipColoredSource` が `YES` の場合、画像の彩度をチェックし、カラー画像と判定された場合は着色を行わずにそのまま返します。`NO` ではすべて着色します。

カラーマップ定義の画像ファイルは横方向にグラデーションされた細長いファイルを作ってください。左が黒、右が白に対応します。幅、高さは任意ですが幅は256や512や1024ピクセルあたりがよいかもしれません。高さは1ピクセルが推奨されているようですが、4ピクセルくらいあった方が作りやすいです。
同梱の `sampleMap.png` を使えばいわゆる4色塗りになります。あまり調整してないのでソースによっては望んだ結果にならないかもしれません。



サンプルのコマンドラインツールは
```
MangaColorize -c カラーマップ定義画像のファイルパス -i 画像のファイルパス
```
と実行すると着色された画像が「画像のファイルパス.color.tiff」に書き出されます。



# Author

http://hetima.com/  
https://twitter.com/hetima


# License

MangaColorize  
MIT License. Copyright (c) 2013 hetima
