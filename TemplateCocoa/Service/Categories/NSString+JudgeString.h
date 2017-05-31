//
//  NSString+JudgeString.h
//  开店宝
//
//  Created by turkeyaa on 14-5-11.
//  Copyright (c) 2014年 baichang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JudgeString)


/**
 *	@brief	判断是否为邮件地址
 *
 *	@return	bool
 */
- (BOOL)isValidateEmail;

/**
 *	@brief	判断是否为手机号码
 *
 *	@return bool
 */
- (BOOL) isValidateMobile;

/**
 *	@brief	判断是否为车牌号码
 *
 *	@return bool
 */
- (BOOL)isValidateCarNo;

/**
 *	@brief	判断是否为QQ号码
 *
 *	@return bool
 */
- (BOOL)isValidateQQNumber;

- (BOOL) isValidNumber;

/**
 *	@brief	判断是否为int型 可用于号码输入
 *
 *	@return bool
 */
- (BOOL)isPureInt2;

/**
 *	@brief	判断是否为float型 可用于价格输入
 *
 *	@return bool
 */
- (BOOL)isPureFloat2;

/**
 *	@brief	判断是否信用卡卡号
 *
 *	@return	bool
 */
- (BOOL) isValidCreditNumber;

/*
 *  @brief 判断是否为银行卡号
 *
 *  @return bool
 */
- (BOOL) isValidBankNumber;

/**
 *	@brief	判断是否为有效浮点数
 *
 *  @param intLength 小数点前有效位数
 *  @param floatLength 小数点后有效位数
 *
 *	@return bool
 */
- (BOOL)isValidFloat:(NSUInteger)intLength floatLength:(NSUInteger)floatLength;

/**
 *	@brief	判断是否是全汉字
 *
 *	@return bool
 */
- (BOOL) isAllChinese;

/**
 *	@brief	判断是否存在汉字
 *
 *	@return bool
 */
- (BOOL) hasChinese;
/**
 *	@brief	判断是否数字和字母
 *
 *	@return bool
 */
- (BOOL)isValidateAscII;



@end












