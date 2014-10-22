//
//  Connection.h
//  天气预报
//
//  Created by  on 14-8-30.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Connection : NSObject<NSURLConnectionDataDelegate, NSURLConnectionDelegate, NSXMLParserDelegate>

{
    NSMutableData *_data;//json数据
    
    //xml解析数据
    NSMutableArray *cityInfo;
    NSString *currentTagName;
}

//同步请求图片数据
+ (NSData *)startSynchronousRequest:(NSURL *)url;
//异步请求天气数据
- (void)startRequest:(NSURL *)url;

//异步请求xml数据
- (void)loadData:(NSURL *)url;
@end
