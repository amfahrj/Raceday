//
//  RDSecondViewController.m
//  Raceday
//
//  Created by Jeff Amfahr on 4/12/12.
//  Copyright (c) 2012 Seapine Software. All rights reserved.
//

#import "SettingsViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "PlaylistViewController.h"

@interface SettingsViewController () <PlaylistDelegate>
@property (strong) MPMusicPlayerController *musicPlayer;
@property (strong) MPMediaPlaylist * playlist;
@end

@implementation SettingsViewController
@synthesize playlistLabel=_playlistLabel;
@synthesize musicPlayer=_musicPlayer;
@synthesize playlist=_playlist;

BOOL playing = NO;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setPlaylistLabel:nil];
    [super viewDidUnload];
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)startRace:(id)sender {
    self.musicPlayer = [MPMusicPlayerController iPodMusicPlayer];
    [self.musicPlayer setQueueWithItemCollection:self.playlist];
    [self.musicPlayer play];
    playing = YES;
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ShowPlaylist"])
    {
        PlaylistViewController * controller = segue.destinationViewController;
        controller.delegate = self;
    }
}

- (void) mediaPicker: (MPMediaPickerController *) mediaPicker didPickMediaItems: (MPMediaItemCollection *) mediaItemCollection
{
    if (mediaItemCollection) {
        
        [self.musicPlayer setQueueWithItemCollection: mediaItemCollection];
        [self.musicPlayer play];
    }
    
	[self dismissModalViewControllerAnimated: YES];
}


- (void) mediaPickerDidCancel: (MPMediaPickerController *) mediaPicker 
{
	[self dismissModalViewControllerAnimated: YES];
}

- (void) remoteControlReceivedWithEvent: (UIEvent *) receivedEvent {
    
    if (receivedEvent.type == UIEventTypeRemoteControl) {
        
        switch (receivedEvent.subtype) {
                
            case UIEventSubtypeRemoteControlTogglePlayPause:
                if (playing) {
                    [self.musicPlayer stop];
                }
                else {
                    [self.musicPlayer play];
                }
                playing = !playing;
                break;
                
            case UIEventSubtypeRemoteControlPreviousTrack:
                [self.musicPlayer skipToPreviousItem];
                break;
                
            case UIEventSubtypeRemoteControlNextTrack:
                [self.musicPlayer skipToNextItem];
                break;
                
            default:
                break;
        }
    }
}

-(void)playlistSelected:(MPMediaPlaylist *)playlist sender:(id)sender
{
    self.playlist = playlist;
    self.playlistLabel.text = [playlist valueForProperty: MPMediaPlaylistPropertyName];
}

@end
