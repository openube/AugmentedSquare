#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface MPGetPOI : NSObject


+ (void) requestPOIFor:(CLLocationCoordinate2D)coordinate complentionHandler:(void(^)(NSDictionary *))complentionHandler;

@end
