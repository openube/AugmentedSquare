#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Header.h"
@interface MPGetPOI : NSObject{
    
    NSMutableDictionary* POI;

}


-(void) requestPOIFor:(CLLocationCoordinate2D)coordinate;

@end
