//
//  MPViewController.m
//  AugmentedRealityNavigator
//
//  Created by iCracker on 20/04/13.
//  Copyright (c) 2013 MPow. All rights reserved.
//

#import "MPViewController.h"

@interface MPViewController ()

@end

@implementation MPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    manager=[[CLLocationManager alloc] init];
    manager.desiredAccuracy=kCLLocationAccuracyBest;
    manager.delegate=self;
    [manager startUpdatingLocation];
    
    arView = (ARView *)self.view;

}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	arView = (ARView *)self.view;
	[arView start];
}
- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
	arView = (ARView *)self.view;
	[arView stop];
}

-(void) decodeResult:(NSDictionary *)POIList{
    
    
    NSMutableArray *POINameList=[[NSMutableArray alloc] init];
    for (int i=0; i<[[[POIList objectForKey:@"response"] objectForKey:@"venues"] count]; i++) {
        [POINameList addObject:[[[[POIList objectForKey:@"response"] objectForKey:@"venues"] objectAtIndex:i] objectForKey:@"name"]];
    }
    
    NSUInteger size=[[[POIList objectForKey:@"response"] objectForKey:@"venues"] count];
    CLLocationCoordinate2D poiCoords[size];

    for (int i=0; i<size; i++) {
        CLLocationCoordinate2D loc;
        loc.latitude=[[[[[[POIList objectForKey:@"response"] objectForKey:@"venues"] objectAtIndex:i] objectForKey:@"location"]objectForKey:@"lat"]doubleValue];
        loc.longitude=[[[[[[POIList objectForKey:@"response"] objectForKey:@"venues"] objectAtIndex:i] objectForKey:@"location"]objectForKey:@"lng"]doubleValue];
        
        poiCoords[i]=loc;
        
    }
    
	
    
    NSInteger numPois = sizeof(poiCoords) / sizeof(CLLocationCoordinate2D);
    
	NSMutableArray *placesOfInterest = [NSMutableArray arrayWithCapacity:numPois];
	for (int i = 0; i < numPois; i++) {
		UILabel *label = [[UILabel alloc] init];
		label.adjustsFontSizeToFitWidth = NO;
		label.opaque = NO;
		label.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.5f];
		label.center = CGPointMake(200.0f, 200.0f);
		label.textAlignment = NSTextAlignmentCenter;
		label.textColor = [UIColor whiteColor];
		label.text = [POINameList objectAtIndex:i];
		CGSize size = [label.text sizeWithFont:label.font];
		label.bounds = CGRectMake(0.0f, 0.0f, size.width, size.height);
        label.transform = CGAffineTransformMakeRotation(M_PI_2*-0.5);
		PlaceOfInterest *poi = [PlaceOfInterest placeOfInterestWithView:label at:[[CLLocation alloc] initWithLatitude:poiCoords[i].latitude longitude:poiCoords[i].longitude]];
		[placesOfInterest insertObject:poi atIndex:i];
	}
	[arView setPlacesOfInterest:placesOfInterest];
}

-(void) pressed{


}

-(void)locationManager:(CLLocationManager *)manager_ didUpdateLocations:(NSArray *)locations{
    if(locations.count)
    [MPGetPOI requestPOIFor:manager_.location.coordinate complentionHandler:^(NSDictionary *dict) {
        [self decodeResult:dict];
    }];
    
    [manager_ stopUpdatingLocation];
    
    [NSTimer timerWithTimeInterval:120 target:manager_ selector:@selector(startUpdatingLocation) userInfo:nil repeats:NO];
}
@end
