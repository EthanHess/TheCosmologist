//
//  ToggleTableViewController.m
//  Cosmologist
//
//  Created by Ethan Hess on 7/18/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

#import "ToggleTableViewController.h"
#import "SlideItemCell.h"

@interface ToggleTableViewController ()

@end

@implementation ToggleTableViewController {
    NSArray *items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //, @"3D", @"AR"
    
    items = @[@"Title", @"Home" ,@"Sounds", @"Mars Photos", @"Asteroids", @"Earth Photos", @"Space Station", @"Credits"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tableViewBG"]];
    [self.tableView setBackgroundView:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Can also be segue names? Will replace original items
- (NSArray *)cellTitles {
    return @[@"Home", @"3D Tour", @"AR", @"Sounds", @"Mars Photos", @"Asteroids", @"Earth Photos", @"Space Station", @"Credits"];
}

- (UIImage *)backgroundForContentView {
    return [UIImage imageNamed:@"cosCellBackground"];
}

- (UIImage *)backgroundForHeader {
    return [UIImage imageNamed:@""];
}

//- (NSArray *)colorsArray {
//    //TODO add.
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return items.count;
    return section == 0 ? 1 : [self cellTitles].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellID = @"ItemCell";
    //NSString *cellID = items[indexPath.row];
    if (indexPath.section == 1) {
        SlideItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
        cell.theLabel.text = [self cellTitles][indexPath.row];
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Title"];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 90;
    } else {
        return 60;
    }
}

// Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        return;
    }
    if (indexPath.row == 1 || indexPath.row == 2) {
        //TODO. add Aux class for global alerts
        return;
    }
    NSString *segueID = [self cellTitles][indexPath.row];
    [self performSegueWithIdentifier:segueID sender:nil];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UINavigationController *destinationViewController = (UINavigationController*)segue.destinationViewController;
    
    destinationViewController.title = [[items objectAtIndex:indexPath.row] capitalizedString];
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        //do stuff
    }
}


@end
