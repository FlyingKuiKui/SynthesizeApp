//
//  WSKTextRestrict.m
//  SynthesizeApp
//
//  Created by 王盛魁 on 2017/3/28.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import "WSKTextRestrict.h"

@interface WSKTextRestrict ()
@property (nonatomic,readwrite) WSKRestrictType restrictType;
@end
@interface WSKNumberRestrict : WSKTextRestrict
@end

@interface WSKDecimalRestrict : WSKTextRestrict
@end

@interface WSKCharacterRestrict : WSKTextRestrict
@end


@implementation WSKTextRestrict
+ (instancetype)textRestrictWithRestrictType:(WSKRestrictType)restrictType{
    WSKTextRestrict *textRestrict;
    switch (restrictType) {
        case WSKRestrictTypeOnlyNumber:
            textRestrict = [[WSKNumberRestrict alloc]init];
            break;
        case WSKRestrictTypeOnlyDecimal:
            textRestrict = [[WSKDecimalRestrict alloc]init];
            break;
        case WSKRestrictTypeOnlyCharacter:
            textRestrict = [[WSKCharacterRestrict alloc]init];
            break;
        default:
            break;
    }
    textRestrict.maxLength = NSUIntegerMax;
    textRestrict.restrictType = restrictType;
    return textRestrict;
}
- (void)textDidChanged:(UITextField *)textField{}
- (NSString *)restrictMaxLength: (NSString *)text
{
    if (text.length > _maxLength) {
        text = [text substringToIndex: self.maxLength];
    }
    return text;
}
@end

static inline NSString *kFilterString(NSString *handleString,WSKStringFilter subStringFilter){
    NSMutableString *modifyString = handleString.mutableCopy;
    for (NSInteger idx = 0; idx <modifyString.length; ) {
        NSString *subString = [modifyString substringWithRange:NSMakeRange(idx, 1)];
        if (subStringFilter(subString)) {
            idx++;
        } else {
            [modifyString deleteCharactersInRange:NSMakeRange(idx, 1)];
        }
    }
    return modifyString;
}
static inline BOOL kMatchStringFormat(NSString *aString,NSString *matchFormat){
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",matchFormat];
    return [predicate evaluateWithObject:aString];
}

@implementation WSKNumberRestrict
- (void)textDidChanged:(UITextField *)textField{
    textField.text = kFilterString(textField.text,^BOOL(NSString *aString){
        return kMatchStringFormat(aString, @"^\\d$");
    });
}
@end

@implementation WSKDecimalRestrict
- (void)textDidChanged:(UITextField *)textField{
    textField.text = kFilterString(textField.text,^BOOL(NSString *aString){
        return kMatchStringFormat(aString, @"^[0-9.]$");
    });
}
@end

@implementation WSKCharacterRestrict
- (void)textDidChanged:(UITextField *)textField{
    textField.text = kFilterString(textField.text,^BOOL(NSString *aString){
        return kMatchStringFormat(aString, @"^[^[\\u4e00-\\u9fa5]]$");
    });
}
@end

@implementation WSKEmojiTextRestrict
- (void)textDidChanged:(UITextField *)textField{
    textField.text = kFilterString(textField.text,^BOOL(NSString *aString){
        return kMatchStringFormat(aString, @"^[\\ud83c\\udc00-\\ud83c\\udfff]|[\\ud83d\\udc00-\\ud83d\\udfff]|[\\u2600-\\u27ff]$");
    });
}
@end
