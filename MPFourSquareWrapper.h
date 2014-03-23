#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface MPFourSquareWrapper : NSObject

+ (void) requestForType:(NSString *)type method:(NSString *)method params:(NSDictionary *)params complentionHandler:(void(^)(NSDictionary *response))complentionHandler;


+ (void) requestPOIFor:(CLLocationCoordinate2D)coordinate complentionHandler:(void(^)(NSDictionary *response))complentionHandler;

+ (void) requestPlacePhotoForPlaceID:(NSString *)placeID complentionHandler:(void(^)(NSDictionary *response,NSArray *photoUrls))complentionHandler;

@end

