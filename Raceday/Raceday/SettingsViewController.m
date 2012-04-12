//
//  RDSecondViewController.m
//  Raceday
//
//  Created by Jeff Amfahr on 4/12/12.
//  Copyright (c) 2012 Seapine Software. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize playlistLabel=_playlistLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setPlaylistLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)startRace:(id)sender {
}

- (IBAction)browsePlaylist:(id)sender {
}
@end
