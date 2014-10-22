//
//  WeatherModel.h
//  coreData和网络请求
//
//  Created by  on 14-8-30.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherModel : NSObject

@property(nonatomic, strong) NSString *days;
@property(nonatomic, strong) NSString *week;
@property(nonatomic, strong) NSString *citynm;
@property(nonatomic, strong) NSString *temperature;
@property(nonatomic, strong) NSString *weather;
@property(nonatomic, strong) NSString *weather_icon;
@property(nonatomic, strong) NSString *wind;
@end
