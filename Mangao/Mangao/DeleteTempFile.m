#import "DeleteTempFile.h"

@implementation DeleteTempFile

//압축 파일 안의 압축 파일을 열기 위한 Temporary 파일의 확인 및 삭제하는 함수 (새로운 파일 오픈시, 종료시 실행하도록 지정)
+ (void)deleteTempFile:(NSString*)directory
{
    NSString *tempFilePath = [NSTemporaryDirectory() stringByAppendingString:directory];
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
}

@end
