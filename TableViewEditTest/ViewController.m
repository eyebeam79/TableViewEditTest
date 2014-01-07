//
//  ViewController.m
//  TableViewEditTest
//
//  Created by Jinho Son on 2014. 1. 6..
//  Copyright (c) 2014년 STD1. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    NSMutableArray *data;
}
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ViewController

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
{
    // 입력문자열 길이가 2보다 클때만 추가가능
    NSString *inputStr = [alertView textFieldAtIndex:0].text;

    return [inputStr length]>2;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // TODO
    NSLog(@"Clicked button in AlertView");
    
    
    NSString *cellName = [alertView textFieldAtIndex:0].text;
    
    // 데이터추가
    [data addObject:cellName];
    // 테이블에 셀추가
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([data count]-1) inSection:0];
    NSArray *row = [NSArray arrayWithObject:indexPath];
    [self.table insertRowsAtIndexPaths:row withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

- (IBAction)togleEdit:(id)sender
{
    self.table.editing = !self.table.editing;

}

// 각 스타일을 번갈아가면서 사용
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 3 == 0)
    {
        return UITableViewCellEditingStyleNone;
    }
    else if (indexPath.row % 3 == 1)
    {
        return UITableViewCellEditingStyleDelete;
    }
    else
    {
        return UITableViewCellEditingStyleInsert;
    }
}

// 삭제/추가작업 - 로그로 확인
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // 데이터삭제
        NSLog(@"%d번째 삭제", indexPath.row);
        [data removeObjectAtIndex:indexPath.row];
        // 테이블셀삭제
        NSArray *rowList = [NSArray arrayWithObject:indexPath];
        [tableView deleteRowsAtIndexPaths:rowList withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else
    {
        NSLog(@"%d번째 추가", indexPath.row);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"추가" message:nil delegate:self cancelButtonTitle:@"취소" otherButtonTitles:@"확인", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert show];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL_ID" forIndexPath:indexPath];
    cell.textLabel.text = data[indexPath.row];
    
    return cell;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    data = [[NSMutableArray alloc] initWithObjects:@"Item0", @"Item1", @"Item2", @"Item3", @"Item4", @"Item5", @"Item6", @"Item7", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
