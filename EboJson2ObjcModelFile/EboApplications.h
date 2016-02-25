#import "JSONModel.h"

@protocol EboApplications <NSObject>
@end

@interface EboApplications : JSONModel
@property (nonatomic, copy) NSString <Optional> * starOverall;
@property (nonatomic, copy) NSString <Optional> * applicationId;
@property (nonatomic, copy) NSString <Optional> * downloads;
@property (nonatomic, copy) NSString <Optional> * iconUrl;
@property (nonatomic, copy) NSString <Optional> * name;
@property (nonatomic, copy) NSString <Optional> * ratingOverall;
@end