#import <Cocoa/Cocoa.h>

@class AVCaptureDevice;
@class AVCaptureSession;
@class AVCaptureMovieFileOutput;
@class AVCaptureDeviceInput;

@interface AudioInput : NSObject
{
    //오디오 인풋 디바이스 배열
    NSArray                     *audioDevices;
    NSLevelIndicator			*audioLevelMeter;
    AVCaptureSession			*session;
    AVCaptureMovieFileOutput	*movieFileOutput;
    AVCaptureDeviceInput		*audioDeviceInput;
	NSArray						*observers;
    float                       volumeLimiter;
    IBOutlet NSButton           *onOffButton;
    NSTimer                     *audioLevelMeterTimer;
    NSTextField                 *audioInput_comment;
    NSSlider                    *volumeLimiterSlider;
}

@property (nonatomic, retain) NSArray *audioDevices;
@property (assign) AVCaptureDevice *selectedAudioDevice;
@property (assign) IBOutlet NSLevelIndicator *audioLevelMeter;
@property (retain) AVCaptureSession *session;
@property (assign) float volumeLimiter;
@property (assign) IBOutlet NSButton *onOffButton;
@property (assign) NSTimer *audioLevelMeterTimer;
@property (assign) IBOutlet NSTextField *audioInput_comment;
@property (assign) IBOutlet NSSlider *volumeLimiterSlider;

- (IBAction)OnOffAudioInput:(id)sender;
- (IBAction)volumeLimiterSliderMover:(id)sender;

@end