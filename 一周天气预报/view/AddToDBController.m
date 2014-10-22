//
//  AddToDBController.m
//  coreData和网络请求
//
//  Created by  on 14-8-31.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "AddToDBController.h"
#import "CityModel.h"
#import "CoreManager.h"

@implementation AddToDBController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"导入数据";
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
    
    _citynmTextField = [[UITextField alloc]initWithFrame:CGRectMake(60, 80, 200, 30)];
    _citynmTextField.placeholder = @"请输入城市名";
    _citynmTextField.borderStyle = UITextBorderStyleRoundedRect;
    _citynmTextField.delegate = self;
    [self.view addSubview:_citynmTextField];
    
    _cityidTextField = [[UITextField alloc]initWithFrame:CGRectMake(60, 120, 200, 30)];
    _cityidTextField.placeholder = @"请输入id";
    _cityidTextField.borderStyle = UITextBorderStyleRoundedRect;
    _cityidTextField.delegate = self;
    [self.view addSubview:_cityidTextField];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(110, 160, 100, 40);
    [button setTitle:@"导入" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)onClick {

    CityModel *cityModel = [[CityModel alloc]init];
    cityModel.citynm = _citynmTextField.text;
    cityModel.cityid = _cityidTextField.text;
    
    CoreManager *coreManager = [[CoreManager alloc]init];
    NSString *message = @"存入成功";
    if (![coreManager addCity:cityModel]) {
        message = @"存入失败";
    }
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
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
    
    return  YES;
}

@end
