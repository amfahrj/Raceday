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

@interface SettingsViewController () <MPMediaPickerControllerDelegate,PlaylistDelegate>
@property (strong) MPMusicPlayerController *musicPlayer;

@end

@implementation SettingsViewController
@synthesize playlistLabel=_playlistLabel;
@synthesize musicPlayer=_musicPlayer;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.musicPlayer = [MPMusicPlayerController iPodMusicPlayer];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
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
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ShowPlaylist"])
    {
        PlaylistViewController * controller = segue.destinationViewController;
        controller.delegate = self;
    }
}

- (IBAction)browsePlaylist:(id)sender {
    MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
    
    mediaPicker.delegate = self;
    mediaPicker.prompt = @"Choose your song:";
    mediaPicker.navigationController.toolbar.barStyle = UIBarStyleBlackOpaque;
    mediaPicker.allowsPickingMultipleItems = YES;
    
    [self presentModalViewController:mediaPicker animated:YES];
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
                //[self playOrStop: nil];
                break;
                
            case UIEventSubtypeRemoteControlPreviousTrack:
                //[self previousTrack: nil];
                break;
                
            case UIEventSubtypeRemoteControlNextTrack:
                //[self nextTrack: nil];
                break;
                
            default:
                break;
        }
    }
}

-(void)playlistSelected:(MPMediaPlaylist *)playlist sender:(id)sender
{
    self.playlistLabel.text = [playlist valueForProperty: MPMediaPlaylistPropertyName];
}

@end
