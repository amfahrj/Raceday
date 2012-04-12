//
//  RDFirstViewController.h
//  Raceday
//
//  Created by Jeff Amfahr on 4/12/12.
//  Copyright (c) 2012 Seapine Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MKMapView.h>

@interface RaceViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
