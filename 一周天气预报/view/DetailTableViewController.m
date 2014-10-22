//
//  DetailTableViewController.m
//  coreData和网络请求
//
//  Created by  on 14-8-30.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "DetailTableViewController.h"
#import "WeatherCell.h"
#import "WeatherModel.h"
#import "Connection.h"

@implementation DetailTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
       // self.title = @"天气详情";
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

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.rowHeight = 120;
    
    NSArray *data;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadData:) name:kLoadDataNotification object:data];
}

#pragma mark - 加载数据
- (void)loadData:(NSNotification *)notification {

    _dataArray = [notification object];
    
    [self.tableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    WeatherCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[WeatherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    WeatherModel *weatherModel = [_dataArray objectAtIndex:indexPath.row];
    NSString *dateLabelString = [NSString stringWithFormat:@"%@   %@", weatherModel.days, weatherModel.week];
    cell.dateLabel.text = dateLabelString;
    cell.dateLabel.textAlignment = UITextAlignmentCenter;
    NSString *temperatureString = [NSString stringWithFormat:@"%@   %@", weatherModel.citynm, weatherModel.temperature];
    cell.temperatureLabel.text = temperatureString;
    cell.temperatureLabel.textAlignment = UITextAlignmentCenter;
    cell.weatherLabel.text = weatherModel.weather;
    cell.weatherLabel.textAlignment = UITextAlignmentCenter;
    cell.windLabel.text = weatherModel.wind;
    cell.windLabel.textAlignment = UITextAlignmentCenter;
   // cell.contentView.backgroundColor = [UIColor grayColor];
    
    NSString *urlString = weatherModel.weather_icon;
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *imageData = [Connection startSynchronousRequest:url];
    UIImage *image = [UIImage imageWithData:imageData];
    cell.iconImageView.image = image;
    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
