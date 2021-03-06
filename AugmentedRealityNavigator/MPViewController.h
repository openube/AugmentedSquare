//
//  MPViewController.h
//  AugmentedRealityNavigator
//
//  Created by iCracker on 20/04/13.
//  Copyright (c) 2013 MPow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceOfInterest.h"
#import "ARView.h"
#import <CoreLocation/CoreLocation.h>
#import "MPFourSquareWrapper.h"
#import "MPDetailPOIViewController.h"

@interface MPViewController : UIViewController<CLLocationManagerDelegate>
{
    CLLocationManager* manager;
    MPFourSquareWrapper* poiGetter;
    ARView *arView;
    
    NSDictionary* POIList;
}
@end
