#import "MPGetPOI.h"

@implementation MPGetPOI



-(void) requestPOIFor:(CLLocationCoordinate2D)coordinate{
    
    NSString* URLforRequest=[NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?ll=%f,%f&oauth_token=FJAW0UIVK5Y04MB0QJZTWQAQDK4HYJEXS3RQIGNYJMQ5SWVW&v=20130420",coordinate.latitude,coordinate.longitude];
    
        NSLog(@"%@",URLforRequest);
    
        NSURLRequest *requests = [NSURLRequest requestWithURL:[NSURL URLWithString:URLforRequest]];
        
        [NSURLConnection sendAsynchronousRequest:requests queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
            
            if (error==nil && data) {
                NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                POI = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                if (error) {
                    NSLog(@"%@",error);
                }
                
                POIList=POI;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"Request Done" object:nil];

            }
        }];
   
}

@end
