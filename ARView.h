
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>


@interface ARView : UIView  <CLLocationManagerDelegate> {
}

@property (nonatomic) NSArray *placesOfInterest;

- (void)start;
- (void)stop;

@end
