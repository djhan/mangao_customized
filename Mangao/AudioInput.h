//
//  AudioInput
//  Mangao Kai
//
//  Created by DJ.HAN <djhan@kbdmania.net> on 2014/02/12.
//  Copyright (c) 2014. DJ.HAN All rights reserved.
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