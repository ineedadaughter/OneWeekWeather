//
//  WeatherCell.m
//  coreData和网络请求
//
//  Created by  on 14-8-30.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "WeatherCell.h"

//@property(nonatomic, strong) UILabel     *dateLabel;
//@property(nonatomic, strong) UIImageView *iconImage;
//@property(nonatomic, strong) UILabel     *temperatureLabel;
//@property(nonatomic, strong) UILabel     *weatherLabel;
//@property(nonatomic, strong) UILabel     *windLabel;

@implementation WeatherCell

@synthesize dateLabel, iconImageView, temperatureLabel, weatherLabel, windLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.dateLabel = [[UILabel alloc]init];
        self.iconImageView = [[UIImageView alloc]init];
        self.temperatureLabel = [[UILabel alloc]init];
        self.weatherLabel = [[UILabel alloc]init];
        self.windLabel = [[UILabel alloc]init];
        
        [self.contentView addSubview:dateLabel];
        [self.contentView addSubview:iconImageView];
        [self.contentView addSubview:temperatureLabel];
        [self.contentView addSubview:weatherLabel];
        [self.contentView addSubview:windLabel];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    //self.contentView.frame = 
    dateLabel.frame = CGRectMake(0, 0, 320, 30);
    temperatureLabel.frame = CGRectMake(self.dateLabel.frame.origin.x, self.dateLabel.frame.origin.y +32, 320, 30);
    iconImageView.frame = CGRectMake(80, 65, 28, 25);
    weatherLabel.frame = CGRectMake(108, 65, 152, 25);
    windLabel.frame = CGRectMake(60, 92, 200, 25);
}

@end
