//
//  ViewController.h
//  GeoLocation
//
//  Created by Andre Lucas Ota on 26/02/15.
//  Copyright (c) 2015 Andre Lucas Ota. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
//
//@protocol mapController
//
//- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations;
//- (void) requestAlwaysAuthorization;
//
//@end

@interface ViewController : UIViewController <CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
}

@property (strong, nonatomic) IBOutlet MKMapView *map;
@property (strong, nonatomic) CLLocationManager *locationManager;

- (IBAction)atualizar:(id)sender;

@end

