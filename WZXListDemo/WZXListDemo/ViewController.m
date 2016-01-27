//
//  ViewController.m
//  WZXListDemo
//
//  Created by wordoor－z on 16/1/27.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "ViewController.h"
#import "NSString+PinYin.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UITableView * tableView;

@property(nonatomic,strong) NSMutableArray * dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self preData];
    [self createTableView];
}

- (void)preData
{
    _dataArr = [[NSMutableArray alloc]init];
    NSArray * carArr = @[@"宝马",@"奔驰",@"比亚迪",@"奥迪",@"玛莎拉蒂",@"上海一汽",@"丰田",@"本田",@"长城",@"路虎",@"奇瑞",@"法拉利",@"兰博基尼"];
    for (char i = 'A'; i <= 'Z'; i++)
    {
        
        NSString * str = [NSString stringWithFormat:@"%c",i];
        
        NSMutableArray * carMuArr = [[NSMutableArray alloc]init];
        
        for (NSString * carName in carArr)
        {
            if ([[carName getFirstLetter] isEqualToString:str])
            {
                [carMuArr addObject:carName];
            }
        }
        
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
        [dic setObject:str forKey:@"Title"];
        [dic setObject:carMuArr forKey:@"Arr"];
        
        [_dataArr addObject:dic];
    }
    NSLog(@"%@",_dataArr);
}

- (void)createTableView
{
    _tableView = ({
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView;
    });
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary * dic = _dataArr[section];
    NSArray * arr = dic[@"Arr"];
    return arr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"myCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSDictionary * dic = _dataArr[indexPath.section];
    NSArray * arr = dic[@"Arr"];
    cell.textLabel.text = arr[indexPath.row];
    return cell;
}

//设置组名
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
     NSDictionary * dic = _dataArr[section];
    return dic[@"Title"];
}

//设置索引名
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    tableView.sectionIndexColor = [UIColor blackColor];
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    for (NSDictionary * dic in _dataArr)
    {
        [arr addObject:dic[@"Title"]];
    }
    return arr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
