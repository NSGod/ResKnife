#import <Foundation/Foundation.h>

@interface NSNumber (NGSRange)

- (BOOL)isWithinRange:(NSRange)range;				// location <= self <= location+length
- (BOOL)isExclusivelyWithinRange:(NSRange)range;	// location < self < location+length
- (BOOL)isBoundedByRange:(NSRange)range;			// location <= self < location+length

@end
