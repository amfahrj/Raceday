//
//  RDSecondViewController.h
//  Raceday
//
//  Created by Jeff Amfahr on 4/12/12.
//  Copyright (c) 2012 Seapine Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *playlistLabel;
- (IBAction)startRace:(id)sender;
- (IBAction)browsePlaylist:(id)sender;

@end
