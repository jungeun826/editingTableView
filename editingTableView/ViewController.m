//
//  ViewController.m
//  editingTableView
//
//  Created by SDT-1 on 2014. 1. 6..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"
#define CELL_ID @"CELL_ID"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *data;
    int addIndex;
}
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ViewController
-(IBAction)toggleEdit:(id)sender{
    self.table.editing =!self.table.editing;
}
-(BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView{
    NSString *inputStr = [alertView textFieldAtIndex:0].text;
    return [inputStr length] > 2;
}
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *inputStr = [alertView textFieldAtIndex:0].text;
    
    if(buttonIndex == alertView.firstOtherButtonIndex){
        [data insertObject:inputStr atIndex:addIndex];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:addIndex inSection:0];
        NSArray *rowList = [NSArray arrayWithObject:indexPath];
        [self.table insertRowsAtIndexPaths:rowList withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row %3 == 0)
        return UITableViewCellEditingStyleNone;
    else if(indexPath.row %3 == 1)
        return UITableViewCellEditingStyleDelete;
    else
        return UITableViewCellEditingStyleInsert;
}
-(void)tableView:tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        NSLog(@"%d번째 삭제", (int)indexPath.row);
        [data removeObjectAtIndex:indexPath.row];
        NSArray *rowList = [NSArray arrayWithObject:indexPath];
        [tableView deleteRowsAtIndexPaths:rowList withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else{
        NSLog(@"%d번째 추가", (int)indexPath.row);
        addIndex = (int)indexPath.row;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"추가" message:nil delegate:self cancelButtonTitle:@"취소" otherButtonTitles:@"확인", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert show];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [data count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID forIndexPath:indexPath];
    cell.textLabel.text = data[indexPath.row];
    
    return cell;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    data = [[NSMutableArray alloc] initWithObjects:@"Item1",@"Item2",@"Item3",@"Item4",@"Item5",@"Item6",@"Item7",nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
