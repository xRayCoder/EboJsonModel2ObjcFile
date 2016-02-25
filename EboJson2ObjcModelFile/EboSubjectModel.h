#import "JSONModel.h"
#import "EboSubjects.h"

@interface EboSubjectModel : JSONModel
@property (nonatomic, strong) NSArray <EboSubjects, Optional> * subjects;
@end