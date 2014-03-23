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
    
    self.title=@"POI List";

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

-(void) decodeResult:(NSDictionary *)POIList_{
    
    
    NSMutableArray *POINameList=[[NSMutableArray alloc] init];
    for (int i=0; i<[[[POIList_ objectForKey:@"response"] objectForKey:@"venues"] count]; i++) {
        [POINameList addObject:[[[[POIList_ objectForKey:@"response"] objectForKey:@"venues"] objectAtIndex:i] objectForKey:@"name"]];
    }
    
    NSUInteger size=[[[POIList_ objectForKey:@"response"] objectForKey:@"venues"] count];
    CLLocationCoordinate2D poiCoords[size];

    for (int i=0; i<size; i++) {
        CLLocationCoordinate2D loc;
        loc.latitude=[[[[[[POIList_ objectForKey:@"response"] objectForKey:@"venues"] objectAtIndex:i] objectForKey:@"location"]objectForKey:@"lat"]doubleValue];
        loc.longitude=[[[[[[POIList_ objectForKey:@"response"] objectForKey:@"venues"] objectAtIndex:i] objectForKey:@"location"]objectForKey:@"lng"]doubleValue];
        
        poiCoords[i]=loc;
        
    }
    
	
    
    NSInteger numPois = sizeof(poiCoords) / sizeof(CLLocationCoordinate2D);
    
	NSMutableArray *placesOfInterest = [NSMutableArray arrayWithCapacity:numPois];
	for (int i = 0; i < numPois; i++) {

		UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:[POINameList objectAtIndex:i] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.5f];
        button.tag=i;
        [button addTarget:self action:@selector(pressedPOI:) forControlEvents:UIControlEventTouchUpInside];
		button.center = CGPointMake(200.0f, 200.0f);
		[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		CGSize size = [button.titleLabel.text sizeWithFont:button.titleLabel.font];
		button.bounds = CGRectMake(0.0f, 0.0f, size.width, size.height);
        button.transform = CGAffineTransformMakeRotation(M_PI_2*-0.5);
        if(i+1==numPois)
        [self pressedPOI:button];
        
        PlaceOfInterest *poi = [PlaceOfInterest placeOfInterestWithView:button at:[[CLLocation alloc] initWithLatitude:poiCoords[i].latitude longitude:poiCoords[i].longitude]];
		[placesOfInterest insertObject:poi atIndex:i];
	}
	[arView setPlacesOfInterest:placesOfInterest];
}

-(void) pressedPOI:(UIButton *)sender{
    MPDetailPOIViewController * detailVC=[[MPDetailPOIViewController alloc] init];
    detailVC.title=[[[[POIList objectForKey:@"response"] objectForKey:@"venues"] objectAtIndex:sender.tag] objectForKey:@"name"];
    detailVC.placeID=[[[[POIList objectForKey:@"response"] objectForKey:@"venues"] objectAtIndex:sender.tag] objectForKey:@"id"];
    [self.navigationController pushViewController:detailVC animated:YES];

}

-(void)locationManager:(CLLocationManager *)manager_ didUpdateLocations:(NSArray *)locations{
    if(locations.count)
    [MPFourSquareWrapper requestPOIFor:manager_.location.coordinate complentionHandler:^(NSDictionary *dict) {
        POIList=dict;
        [self decodeResult:POIList];
    }];
    
    [manager_ stopUpdatingLocation];
    
    [NSTimer timerWithTimeInterval:120 target:manager_ selector:@selector(startUpdatingLocation) userInfo:nil repeats:NO];
}
@end
