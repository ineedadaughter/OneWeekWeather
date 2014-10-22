//
//  Connection.m
//  天气预报
//
//  Created by  on 14-8-30.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "Connection.h"
#import "WeatherModel.h"
#import "CityModel.h"

@implementation Connection

//同步请求图片数据
+ (NSData *)startSynchronousRequest:(NSURL *)url {

    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    
    NSData *imageData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    return imageData;
}

//异步请求（代理）
- (void)startRequest:(NSURL *)url {

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
    
}

//异步请求xml数据
- (void)loadData:(NSURL *)url {

    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        //解析xml格式数据
        NSXMLParser *parser = [[NSXMLParser alloc]initWithData:data];
        parser.delegate = self;
        [parser parse];
    }];
}

#pragma mark - NSXMLParser delegate
//开始解析
- (void)parserDidStartDocument:(NSXMLParser *)parser {

    cityInfo = [NSMutableArray array];
}
//遇到标签触发
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    currentTagName = elementName;

    if ([currentTagName isEqualToString:@"weaid"]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [cityInfo addObject:dict];
    }
        
   // }
}
//标签中的数据
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {

    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([string isEqualToString:@""]) {
        return;
    }
    
    NSMutableDictionary *dict = [cityInfo lastObject];
    
    if ([currentTagName isEqualToString:@"weaid"] && dict) {
        
        [dict setObject:string forKey:@"weaid"];
    }
    
    
    if ([currentTagName isEqualToString:@"citynm"] && dict) {
        [dict setObject:string forKey:@"citynm"];
    }
}
//结束标签触发
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    currentTagName = nil;
}
//结束时
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    
    NSMutableArray *cityModelArray = [NSMutableArray array];
    [cityInfo enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
       
        NSDictionary *dic = obj;
        CityModel *cityModel = [[CityModel alloc]init];
        cityModel.citynm = [dic objectForKey:@"citynm"];
        cityModel.cityid = [dic objectForKey:@"weaid"];
        
        [cityModelArray addObject:cityModel];
        
    }];
    
    //向MainViewController中接收通知
    [[NSNotificationCenter defaultCenter]postNotificationName:kXMLDataLoad object:cityModelArray];
}

#pragma mark - NSURLConnection delegate
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {

    NSLog(@"网络请求出错%@", error);
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {

    _data = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {

    [_data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {

    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingAllowFragments error:nil];
    if (dataDic.count) {
        NSMutableArray *weatherModelArray = [NSMutableArray array];
        
        NSArray *dataArray = [dataDic objectForKey:@"result"];        
        [dataArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
           
            NSDictionary *weatherData = obj;
            WeatherModel *weatherModel = [[WeatherModel alloc]init];
            weatherModel.days = [weatherData objectForKey:@"days"];
            weatherModel.week = [weatherData objectForKey:@"week"];
            weatherModel.citynm = [weatherData objectForKey:@"citynm"];
            weatherModel.temperature = [weatherData objectForKey:@"temperature"];
            weatherModel.weather = [weatherData objectForKey:@"weather"];
            weatherModel.weather_icon = [weatherData objectForKey:@"weather_icon"];
            weatherModel.wind = [weatherData objectForKey:@"wind"];
            
            [weatherModelArray addObject:weatherModel];
        }];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:kLoadDataNotification object:weatherModelArray];
    }
}
@end
