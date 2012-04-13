//
//  PlaylistViewController.h
//  Raceday
//
//  Created by Jeff Amfahr on 4/13/12.
//  Copyright (c) 2012 Seapine Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@protocol PlaylistDelegate <NSObject>
@optional
-(void)playlistSelected:(MPMediaPlaylist *)playlist sender:(id)sender;
@end


@interface PlaylistViewController : UITableViewController
@property(weak) id<PlaylistDelegate> delegate;

@end
