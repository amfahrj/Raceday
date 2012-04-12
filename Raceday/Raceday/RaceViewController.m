//
//  RDFirstViewController.m
//  Raceday
//
//  Created by Jeff Amfahr on 4/12/12.
//  Copyright (c) 2012 Seapine Software. All rights reserved.
//

#import "RaceViewController.h"
#import "CrumbPath.h"

@interface RaceViewController ()
@property (strong) CLLocationManager *locationManager;
@property (strong) CrumbPath *crumbs;

@end

@implementation RaceViewController
@synthesize mapView=_mapView;
@synthesize locationManager=_locationManager;
@synthesize crumbs=_crumbs;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self; 
	self.locationManager.desiredAccuracy =kCLLocationAccuracyBest;
        
    [self.locationManager startUpdatingLocation];
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    if (newLocation)
    {		
        if ((oldLocation.coordinate.latitude != newLocation.coordinate.latitude) &&
            (oldLocation.coordinate.longitude != newLocation.coordinate.longitude))
        {    
            if (!self.crumbs)
            {
                self.crumbs = [[CrumbPath alloc] initWithCenterCoordinate:newLocation.coordinate];
                [self.mapView addOverlay:self.crumbs];
                
                MKCoordinateRegion region = 
                MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 2000, 2000);
                [self.mapView setRegion:region animated:YES];
            }
            else
            {
                MKMapRect updateRect = [self.crumbs addCoordinate:newLocation.coordinate];
                
                if (!MKMapRectIsNull(updateRect))
                {
                    MKZoomScale currentZoomScale = (CGFloat)(self.mapView.bounds.size.width / self.mapView.visibleMapRect.size.width);
                    CGFloat lineWidth = MKRoadWidthAtZoomScale(currentZoomScale);
                    updateRect = MKMapRectInset(updateRect, -lineWidth, -lineWidth);
                    //[crumbView setNeedsDisplayInMapRect:updateRect];
                }
            }
        }
    }
}

//- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
//{
////    if (!crumbView)
////    {
////        crumbView = [[CrumbPathView alloc] initWithOverlay:overlay];
////    }
////    return crumbView;
//}

@end
