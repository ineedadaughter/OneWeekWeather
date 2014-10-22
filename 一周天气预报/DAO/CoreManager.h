//
//  CoreManager.h
//  一周天气预报
//
//  Created by  on 14-8-31.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityModel.h"

@interface CoreManager : NSObject


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


//增加
- (BOOL)addCity:(CityModel *)cityModel;
//根据城市名字查找
- (NSArray *)selectWithName:(NSString *)name;
//存入大量数据， 数组传过来
- (BOOL)addCities:(NSArray *)cities;
@end
