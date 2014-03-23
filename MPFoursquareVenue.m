//
//  MPFoursquareVenue.m
//  AugmentedRealityNavigator
//
//  Created by Alex Manzella on 23/03/14.
//  Copyright (c) 2014 MPow. All rights reserved.
//

#import "MPFoursquareVenue.h"

@implementation MPFoursquareVenue

- (instancetype) initWithDictionary:(NSDictionary *)venueObject{
    
    if (self=[super init]) {
        
        self.name=[venueObject objectForKey:@"name"];
        self.contacts=[venueObject objectForKey:@"contact"];
        self.address=[[venueObject objectForKey:@"location"] objectForKey:@"address"];
        self.location=CLLocationCoordinate2DMake([[[venueObject objectForKey:@"location"] objectForKey:@"lat"] doubleValue], [[[venueObject objectForKey:@"location"] objectForKey:@"lng"] doubleValue]);
        self.categories=[venueObject objectForKey:@"categories"];
        self.rating=[[venueObject objectForKey:@"rating"] floatValue];
        self.description=[venueObject objectForKey:@"description"];
        self.url=[venueObject objectForKey:@"url"];
        self.foursquareURL=[venueObject objectForKey:@"canonicalUrl"];
        NSMutableArray *tmpPhoto=[[NSMutableArray alloc] init];
    }
    return self;
    
}

@end
