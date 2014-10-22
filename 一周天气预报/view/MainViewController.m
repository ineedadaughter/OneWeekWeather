//
//  MainViewController.m
//  coreData和网络请求
//
//  Created by  on 14-8-30.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//


//http://api.k780.com:88/?app=weather.future&weaid=3&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json
//http://api.k780.com:88/?app=weather.city&format=xml  城市代码对应
#import "MainViewController.h"
#import "Connection.h"
#import "DetailTableViewController.h"
#import "AddServiceViewController.h"
#import "AddToDBController.h"
#import "CoreManager.h"

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"天气查询";
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    //接收来自connection中发送的通知，xml数据解析完成时发送的通知
    NSArray *dataArray;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(insertData:) name:kXMLDataLoad object:dataArray];
    
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor greenColor]];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
    label.userInteractionEnabled = YES;
    label.backgroundColor = [UIColor greenColor];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = UITextAlignmentLeft;
    label.text = @"仅支持北京、上海、广州、深圳、武汉的天气查询，增加支持城市请点击这里";
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    addButton.frame = CGRectMake(187, 37, 20, 20);
    addButton.tag = 1;
    [addButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [label addSubview:addButton];
    
    
    _citynm = [[UITextField alloc]initWithFrame:CGRectMake(60, 80, 200, 30)];
    _citynm.placeholder = @"请输入要查询的城市";
    _citynm.borderStyle = UITextBorderStyleRoundedRect;
    [_citynm setKeyboardType:UIKeyboardTypeNamePhonePad];
    _citynm.delegate = self;
    [self.view addSubview:_citynm];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(110, 120, 100, 40);
    button.tag = 2;
    [button setTitle:@"查询" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"add" style:UIBarButtonItemStyleBordered target:self action:@selector(onClick:)];
    barButtonItem.tag = 3;
    //self.navigationItem.rightBarButtonItem = barButtonItem;
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"加载数据" style:UIBarButtonItemStyleBordered target:self action:@selector(onClick:)];
    leftBarButtonItem.tag = 4;
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

//接收到通知后向数据库中插入数据
- (void)insertData:(NSNotification *)notification {

    NSArray *citis = [notification object];
    CoreManager *coreManager = [[CoreManager alloc]init];
    NSString *message = @"加载成功";
    BOOL result = [coreManager addCities:citis];
    if (!result) {
        message = @"加载失败";
    }
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    
}

//按钮事件处理
- (void)onClick:(UIButton *)button {

    switch (button.tag) {
        case 1:{//增值服务
            AddServiceViewController *addSeviceController = [[AddServiceViewController alloc]init];
            [self.navigationController pushViewController:addSeviceController animated:YES];
        }
            break;
        case 2:{//查询
            
            NSBundle *bundle = [NSBundle mainBundle];
            NSString *path = [bundle pathForResource:@"City" ofType:@"plist"];
            NSDictionary *cityDic = [NSDictionary dictionaryWithContentsOfFile:path];
            
            NSString *cityId = [cityDic objectForKey:_citynm.text];
            
            NSString *urlString = [NSString stringWithFormat:@"http://api.k780.com:88/?app=weather.future&weaid=%@&appkey=	11933&sign=ba70a4f0e794f8ed690dbe03e07fb6ec&format=json", cityId];
            NSURL *url = [NSURL URLWithString:urlString];
            
            Connection *connect = [[Connection alloc]init];
            [connect startRequest:url];
            
            DetailTableViewController *detailController = [[DetailTableViewController alloc]initWithStyle:UITableViewStylePlain];
            detailController.title = [NSString stringWithFormat:@"天气详情－%@", _citynm.text];
            [self.navigationController pushViewController:detailController animated:YES];
            _citynm.text = @"";
        }
            break;
        case 3:{//增加
            AddToDBController *controller = [[AddToDBController alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 4:{//加载数据到数据库
            //jiazai 
            NSString *urlString = @"http://api.k780.com:88/?app=weather.city&format=xml";
            NSURL *url = [NSURL URLWithString:urlString];
            Connection *connection = [[Connection alloc]init];
            [connection loadData:url];
            
        }
            break;
        default:
            break;
    }  
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UITextField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [textField resignFirstResponder];
    
    return YES;
}

@end
