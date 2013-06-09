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
    [manager startUpdatingLocation];
    
    arView = (ARView *)self.view;
	// Create array of hard-coded places-of-interest, in this case some famous parks
   

	    
    get=[[MPGetPOI alloc] init];
    [get requestPOIFor:manager.location.coordinate];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    btn.frame = CGRectMake(0, 0, 50, 50);
     [self.view addSubview:btn];
     
     [btn addTarget:self action:@selector(pressed) forControlEvents:UIControlEventTouchDown];

    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(decodeResult)
                                                 name:@"Request Done"
                                               object:nil];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void) decodeResult{
    
    
    NSMutableArray *POINameList=[[NSMutableArray alloc] init];
    for (int i=0; i<[[[POIList objectForKey:@"response"] objectForKey:@"venues"] count]; i++) {
        [POINameList addObject:[[[[POIList objectForKey:@"response"] objectForKey:@"venues"] objectAtIndex:i] objectForKey:@"name"]];
    }
    
    int size=[[[POIList objectForKey:@"response"] objectForKey:@"venues"] count];
    CLLocationCoordinate2D poiCoords[size];

    for (int i=0; i<size; i++) {
        CLLocationCoordinate2D loc;
        loc.latitude=[[[[[[POIList objectForKey:@"response"] objectForKey:@"venues"] objectAtIndex:i] objectForKey:@"location"]objectForKey:@"lat"]doubleValue];
        loc.longitude=[[[[[[POIList objectForKey:@"response"] objectForKey:@"venues"] objectAtIndex:i] objectForKey:@"location"]objectForKey:@"lng"]doubleValue];
        
        poiCoords[i]=loc;
        
    }
    
	
    
    int numPois = sizeof(poiCoords) / sizeof(CLLocationCoordinate2D);
    
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
    NSLog(@"Done");
}

-(void) pressed{
    CLLocationCoordinate2D ge;
    ge.latitude=44.36;
    ge.longitude=9.18099999999999;
    [get requestPOIFor:ge];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(decodeResult)
                                                 name:@"Request Done"
                                               object:nil];

}
@end
