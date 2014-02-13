<<<<<<< HEAD
//  Created by DJ.HAN 2014/02/12
//  Copyright (c) 2014. DJ.HAN All rights reserved.

=======
>>>>>>> ef14c5b17f9fd6cae9c2351244ec0f3ccfeb08ad
#import "AudioInput.h"
//audio 관련 coreaudio, avfoundation 임포트
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import "DeleteTempFile.h"
#import "Mangao.h"

@interface AudioInput () <AVCaptureFileOutputDelegate, AVCaptureFileOutputRecordingDelegate>

//내부 사용 용도
@property (retain) NSArray *observers;
@property (retain) AVCaptureDeviceInput *audioDeviceInput;
@property (retain) AVCaptureMovieFileOutput *movieFileOutput;

@end

@implementation AudioInput

@synthesize audioDevices;
@synthesize audioLevelMeter;
@synthesize session;
@synthesize audioDeviceInput;
@synthesize observers;
@synthesize movieFileOutput;
@synthesize volumeLimiter;
@synthesize onOffButton;
@synthesize audioLevelMeterTimer;
@synthesize audioInput_comment;
@synthesize volumeLimiterSlider;

/*오디오 입력 기능 시작*/

- (IBAction)OnOffAudioInput:(id)sender;
{
    //NSLog(@"status:%ld", (long)[onOffButton state]);
    if ([onOffButton state])
    {
        [self audioInputOn];
    }
    else
    {
        [self audioInputOff];
    }
}

- (void)awakeFromNib
{
    //안내 텍스트 초기화
    [audioInput_comment setStringValue:NSLocalizedString(@"Limit値を超える音量が入力すれば次のページへ移動します", @"")];
 }

- (id)init
{
    self = [super init];
    
    //세션 초기화
    session = [[AVCaptureSession alloc] init];
    
    // Capture Notification Observers
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    id runtimeErrorObserver = [notificationCenter addObserverForName:AVCaptureSessionRuntimeErrorNotification
                                                              object:session
                                                               queue:[NSOperationQueue mainQueue]
                                                          usingBlock:^(NSNotification *note) {
                                                              dispatch_async(dispatch_get_main_queue(), ^(void) {
                                                                  NSLog(@"runtime Error");
                                                              });
                                                          }];
    id didStartRunningObserver = [notificationCenter addObserverForName:AVCaptureSessionDidStartRunningNotification
                                                                 object:session
                                                                  queue:[NSOperationQueue mainQueue]
                                                             usingBlock:^(NSNotification *note) {
                                                                 NSLog(@"did start running");
                                                             }];
    id didStopRunningObserver = [notificationCenter addObserverForName:AVCaptureSessionDidStopRunningNotification
                                                                object:session
                                                                 queue:[NSOperationQueue mainQueue]
                                                            usingBlock:^(NSNotification *note) {
                                                                NSLog(@"did stop running");
                                                            }];
    id deviceWasConnectedObserver = [notificationCenter addObserverForName:AVCaptureDeviceWasConnectedNotification
                                                                    object:nil
                                                                     queue:[NSOperationQueue mainQueue]
                                                                usingBlock:^(NSNotification *note) {
                                                                    [self refreshDevices];
                                                                }];
    id deviceWasDisconnectedObserver = [notificationCenter addObserverForName:AVCaptureDeviceWasDisconnectedNotification
                                                                       object:nil
                                                                        queue:[NSOperationQueue mainQueue]
                                                                   usingBlock:^(NSNotification *note) {
                                                                       [self refreshDevices];
                                                                   }];
    
    observers = [[NSArray alloc] initWithObjects:runtimeErrorObserver, didStartRunningObserver, didStopRunningObserver, deviceWasConnectedObserver, deviceWasDisconnectedObserver, nil];

    //AudioInputPanel이 열린 경우의 Notification을 접수하는 Observer 추가
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openAudioInputPanel:) name:@"NCopenAudioInputPanel" object:nil];
    
    session.sessionPreset = AVCaptureSessionPresetMedium;
    
    movieFileOutput = [[AVCaptureMovieFileOutput alloc] init];
    if ([session canAddOutput:movieFileOutput])
    {
        [session addOutput:movieFileOutput];}
    else
    {
        NSLog(@"can't add output file");
    }
    
    AVCaptureDevice *audioCaptureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    NSError *error = nil;
    AVCaptureDeviceInput *audioInput = [AVCaptureDeviceInput deviceInputWithDevice:audioCaptureDevice error:&error];
    if (audioInput) {
        [session addInput:audioInput];
    }
    else {
        //에러 발생시 에러 로그 표시
        NSLog(@"error:%@", error);
    }
    
    // Select devices if any exist
    AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    if (audioDevice) {
        [self setSelectedAudioDevice:[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio]];
    }
    
    //initial refresh
    [session startRunning];
    [self refreshDevices];
    
    return self;
}

- (void)audioInputOn
{
    //movieoutput 파일 생성 (이미 같은 파일이 있을 때에는 회피)
    /*
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSString *outputpathofmovie = nil;
    int collision = 0;
    do {
        outputpathofmovie = [NSString stringWithFormat: @"/audiotemp/%i-audioInput.m4a", collision];
        outputpathofmovie = [NSTemporaryDirectory() stringByAppendingPathComponent: outputpathofmovie];
        ++collision;
    }
    while ([fileManager fileExistsAtPath: outputpathofmovie]);
    //NSString *outputpathofmovie = [[NSTemporaryDirectory() stringByAppendingPathComponent:@"/archivetemp/test"] stringByAppendingString:@".mp4"];
    NSURL *outputURL = [[NSURL alloc] initFileURLWithPath:outputpathofmovie];
    //NSLog(@"output path: %@", outputpathofmovie);
    [[self movieFileOutput] startRecordingToOutputFileURL:outputURL recordingDelegate:self];
    */
    
    audioLevelMeterTimer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(updateAudioLevels:) userInfo:nil repeats:YES];
    
    [onOffButton setTitle:@"Stop"];
    
    //오디오 인풋이 시작되어 패널을 닫으라는 notification 송출
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NCcloseAudioInputPnael" object:self];
}

- (void)dealloc
{
	[audioDevices release];
	[session release];
	[movieFileOutput release];
	[audioDeviceInput release];
	
	[super dealloc];
}

- (void)refreshDevices
{
	[self setAudioDevices:[AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio]];
	
	[session beginConfiguration];
	
    //NSLog(@"self audiodevices:%@", [self audioDevices]);
	if (![[self audioDevices] containsObject:[self selectedAudioDevice]])
		[self setSelectedAudioDevice:nil];
	
	[session commitConfiguration];
}


- (AVCaptureDevice *)selectedAudioDevice
{
    //NSLog(@"selected audio device : %@", [audioDeviceInput device]);
	return [audioDeviceInput device];
}

- (void)setSelectedAudioDevice:(AVCaptureDevice *)selectedAudioDevice
{
    //NSLog(@"selected audio device : %@", selectedAudioDevice);
    [session beginConfiguration];
    
    if ([self audioDeviceInput]) {
		// Remove the old device input from the session
		[session removeInput:[self audioDeviceInput]];
		[self setAudioDeviceInput:nil];
	}
	
	if (selectedAudioDevice) {
		NSError *error = nil;
		
		// Create a device input for the device and add it to the session
		AVCaptureDeviceInput *newAudioDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:selectedAudioDevice error:&error];
		if (newAudioDeviceInput == nil) {
			dispatch_async(dispatch_get_main_queue(), ^(void) {
				//에러 발생시 에러 로그 표시
                NSLog(@"error:%@", error);
			});
		} else {
			//if (![selectedAudioDevice supportsAVCaptureSessionPreset:[session sessionPreset]])
			//	[session setSessionPreset:AVCaptureSessionPresetHigh];
			
			[session addInput:newAudioDeviceInput];
			[self setAudioDeviceInput:newAudioDeviceInput];
		}
	}

	[session commitConfiguration];
}

- (void)updateAudioLevels:(NSTimer *)timer
{

	NSInteger channelCount = 0;
	float decibels = 0.f;
	
	// Sum all of the average power levels and divide by the number of channels
	for (AVCaptureConnection *connection in [[self movieFileOutput] connections]) {
		for (AVCaptureAudioChannel *audioChannel in [connection audioChannels]) {
			decibels += [audioChannel averagePowerLevel];
			channelCount += 1;
		}
	}
	
	decibels /= channelCount;
	int finalDecibels = pow(10.f, 0.05f * decibels) * 20.0f;
    //NSLog(@"final Decibels: %d", finalDecibels);
	[[self audioLevelMeter] setFloatValue:finalDecibels];

    //오디오 입력후 일시 정지하는 시간 설정 (0.5초)
    NSDate *future = [NSDate dateWithTimeIntervalSinceNow: 0.5 ];
    
    if (finalDecibels > volumeLimiter)
    {
        //NSLog(@"volume limiter:%i", volumeLimiter);
        //입력 음량이 리미터 한계치를 넘은 경우 Notification 발생
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NCacceptSound" object:self];
        //오디오 입력후 연속 입력이 안되도록 일시 정지
        [NSThread sleepUntilDate:future];
    }
}

- (BOOL)captureOutputShouldProvideSampleAccurateRecordingStart:(AVCaptureOutput *)captureOutput
{
    // We don't require frame accurate start when we start a recording. If we answer YES, the capture output
    // applies outputSettings immediately when the session starts previewing, resulting in higher CPU usage
    // and shorter battery life.
    return NO;
}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)recordError
{
	if (recordError != nil && [[[recordError userInfo] objectForKey:AVErrorRecordingSuccessfullyFinishedKey] boolValue] == NO) {
		[[NSFileManager defaultManager] removeItemAtURL:outputFileURL error:nil];
		dispatch_async(dispatch_get_main_queue(), ^(void) {
			NSLog(@"%@", recordError);
		});
	}
}

- (IBAction)volumeLimiterSliderMover:(id)sender;
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];

    //환경설정에 volume limiter 값을 써 넣는다
    [[app.plistValue objectAtIndex:0] replaceObjectAtIndex:7 withObject:[NSNumber numberWithFloat:volumeLimiter]];
    //NSLog(@"plistvalue: %@", [[app.plistValue objectAtIndex:0] objectAtIndex:7]);
}

- (void)audioInputOff
{
    //오디오 레벨 미터 정지
    [audioLevelMeterTimer invalidate];
    audioLevelMeterTimer = nil;
    [onOffButton setTitle:@"Start"];
    //오디오 인풋이 정지, 패널을 닫으라는 notification 송출
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NCcloseAudioInputPnael" object:self];
}

//오디오 인풋 패널이 열린 걸 감지하고 환경설정을 읽는다
-(void)openAudioInputPanel:(NSNotification*)notification;
{
    Mangao *app = (Mangao *)[[NSApplication sharedApplication] delegate];
    //volumelimiter 값을 환경설정에서 가져온다
    [self setValue:[[app.plistValue objectAtIndex:0] objectAtIndex:7] forKey:@"volumeLimiter" ];
}

/*
- (void)windowWillClose:(NSNotification *)notification
{
    // Stop the session
	[[self session] stopRunning];
	
	// Set movie file output delegate to nil to avoid a dangling pointer
	[[self movieFileOutput] setDelegate:nil];
	
	// Remove Observers
	NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
	for (id observer in [self observers])
		[notificationCenter removeObserver:observer];
	[observers release];
    
    //압축 파일 안의 압축 파일을 열기 위한 Temporary 파일의 확인 및 삭제
    //NSString *deletedTempFolder = [NSString stringWithFormat:@"archivetemp"];
    //[DeleteTempFile deleteTempFile:deletedTempFolder];
}*/

@end
