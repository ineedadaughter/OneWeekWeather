//
//  WeatherCell.h
//  coreData和网络请求
//
//  Created by  on 14-8-30.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

//@property(nonatomic, strong) NSString *days;
//@property(nonatomic, strong) NSString *week;
//@property(nonatomic, strong) NSString *citynm;
//@property(nonatomic, strong) NSString *temperature;
//@property(nonatomic, strong) NSString *weather;
//@property(nonatomic, strong) NSString *weather_icon;
//@property(nonatomic, strong) NSString *wind;

//{
//    
//    "days": "2014-08-31",
//    "week": "星期日",
//    "citynm": "武汉",
//    "temperature": "29℃/22℃",
//    "weather": "小雨转多云",
//    "weather_icon": "http://api.k780.com:88/upload/weather/d/7.gif",
//    "wind": "无持续风向",
//},
@interface WeatherCell : UITableViewCell

@property(nonatomic, strong) UILabel     *dateLabel;
@property(nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic, strong) UILabel     *temperatureLabel;
@property(nonatomic, strong) UILabel     *weatherLabel;
@property(nonatomic, strong) UILabel     *windLabel;
@end

