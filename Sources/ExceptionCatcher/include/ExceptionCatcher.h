#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExceptionCatcher : NSObject
+ (nullable id)tryBlock:(id _Nullable(^)(void))block exception:(__autoreleasing NSException * _Nullable * _Nullable)exception;
@end

NS_ASSUME_NONNULL_END
