//
//  CityEntity.h
//  一周天气预报
//
//  Created by  on 14-8-31.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CityEntity : NSManagedObject

@property (nonatomic, retain) NSString * citynm;
@property (nonatomic, retain) NSString * cityid;

@end
