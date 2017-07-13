//
//  WSKTextRestrict.h
//  SynthesizeApp
//
//  Created by 王盛魁 on 2017/3/28.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL(^WSKStringFilter)(NSString *aString);

typedef NS_ENUM(NSInteger,WSKRestrictType)
{
    WSKRestrictTypeOnlyNumber = 1, ///< only input numbers
    WSKRestrictTypeOnlyDecimal = 2,  ///< only input real numbers，includ "."
    WSKRestrictTypeOnlyCharacter = 3, ///< only input non Chinese character
};

@interface WSKTextRestrict : NSObject

@property (nonatomic,assign) NSUInteger maxLength;
@property (nonatomic,readonly) WSKRestrictType restrictType; ///< input restrict type

+ (instancetype)textRestrictWithRestrictType:(WSKRestrictType)restrictType;
- (void)textDidChanged:(UITextField *)textField;

@end


@interface WSKEmojiTextRestrict : WSKTextRestrict

@end
