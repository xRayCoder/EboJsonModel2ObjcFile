#import "JSONModel.h"
#import "EboApplications.h"

@protocol EboSubjects <NSObject>
@end

@interface EboSubjects : JSONModel
@property (nonatomic, strong) NSArray <EboApplications, Optional> * applications;
@property (nonatomic, copy) NSString <Optional> * desc_img;
@property (nonatomic, copy) NSString <Optional> * title;
@property (nonatomic, copy) NSString <Optional> * img;
@property (nonatomic, copy) NSString <Optional> * desc;
@property (nonatomic, copy) NSString <Optional> * date;
@end