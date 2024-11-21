#import "ExceptionCatcher.h"

@implementation ExceptionCatcher
+ (nullable id)tryBlock:(id _Nullable(^)(void))block exception:(__autoreleasing NSException * _Nullable * _Nullable)exception {
    @try {
        return block();
    } @catch (NSException *e) {
        if (exception) {
            *exception = e;
        }
        return nil;
    }
}
@end
