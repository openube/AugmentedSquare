//
//  MPDetailPOIViewController.m
//  AugmentedRealityNavigator
//
//  Created by Alex Manzella on 23/03/14.
//  Copyright (c) 2014 MPow. All rights reserved.
//

#import "MPDetailPOIViewController.h"
#import "MPFourSquareWrapper.h"

@interface MPDetailPOIViewController ()

@end

@implementation MPDetailPOIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [MPFourSquareWrapper requestPlaceDetailForPlaceID:self.placeID complentionHandler:^(NSDictionary *response, MPFoursquareVenue *venue) {
        
        for (NSString* urlStr in venue.photoUrls) {

            UIImageView *photo=[[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
            photo.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]]];
            photo.contentMode=UIViewContentModeScaleAspectFit;
            photo.backgroundColor=[UIColor whiteColor];
            [self.view addSubview:photo];
            //just one for the test
            return ;
        }
    }];
}


@end
