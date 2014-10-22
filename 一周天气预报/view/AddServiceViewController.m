//
//  AddServiceViewController.m
//  coreData和网络请求
//
//  Created by  on 14-8-31.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "AddServiceViewController.h"
#import "CoreManager.h"
#import "CityModel.h"

@implementation AddServiceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"增值服务";
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
    [super viewDidLoad];
    
    _cityNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(60, 100, 200, 30)];
    _cityNameTextField.placeholder = @"请输入需要支持的城市";
    _cityNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _cityNameTextField.delegate = self;
    [self.view addSubview:_cityNameTextField];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(110, 150, 100, 40);
    [button setTitle:@"add" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)onClick {

    
    CoreManager *coreManager = [[CoreManager alloc]init];
    
    NSArray *cityArray = [coreManager selectWithName:_cityNameTextField.text];
    CityModel *city = [cityArray lastObject];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *filePath = [bundle pathForResource:@"City" ofType:@"plist"];
    NSMutableDictionary *cityDic = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    
    [cityDic setObject:city.cityid forKey:city.citynm];
    BOOL result = [cityDic writeToFile:(NSString *)filePath atomically:YES];
    NSString *message = @"增加成功";
    if (!result) {
        message = @"增加失败";
    }
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    
  
    //数据已经加入plist中
//    NSMutableDictionary *cities = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
//    NSLog(@"cities:%@", cities);
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
