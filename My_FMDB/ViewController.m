//
//  ViewController.m
//  My_FMDB
//
//  Created by 张大亮 on 16/2/29.
//  Copyright © 2016年 张大亮. All rights reserved.
//

#import "ViewController.h"
#import "FMDBManager.h"
#import "AFNetworkingExtentionVC.h"
#import "ZdlModel.h"
#import "UIImageView+WebCache.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataArr;
    UITableView *_tableView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [[FMDBManager shareManager] creatTableWithName:@"userInfo(id integer primary key autoincrement,name varchar(256),text varchar(256),image blob)"];
    _dataArr=[[NSMutableArray alloc]init];

    if ([self selectAllModel].count>0) {
        NSLog(@"取出成功");
        [_dataArr addObjectsFromArray:[self selectAllModel]];
        [_tableView reloadData];
    }else{
        NSLog(@"取出失败");
        [self creatData];
    }
    
    
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
 
    
}
-(void)creatData
{
    [[AFNetworkingExtentionVC sharedManager] get:@"http://lib.wap.zol.com.cn/ipj/tip_fruit/tip_fruit_selected/index.php?page=0&v=1.0&vs=iph100" params:nil success:^(id responseObj) {
        
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
        NSDictionary *dict1=[dict objectForKey:@"news"];
        for (NSDictionary *dict in dict1) {
            ZdlModel *model=[[ZdlModel alloc]initWithJson:dict];
            NSString *insertSql = @"insert into userInfo(name,text,image) values(?,?,?)";
            
            BOOL isInsert = [[FMDBManager shareManager].fmdb executeUpdate:insertSql,model.userName,model.text,model.imageData];
            if (isInsert) {
                NSLog(@"存入成功");
            }else{
                NSLog(@"存入失败");
            }
            
            
            [_dataArr addObject:model];
        }
        [_tableView reloadData];
        NSLog(@"网络请求成功");
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败");
    }];
}
- (NSArray *)selectAllModel
{
    
    NSString *selectSql = @"select * from userInfo";
    
    //执行查询的sql，用set接收
    FMResultSet *set = [[FMDBManager shareManager].fmdb executeQuery:selectSql];
    
    NSMutableArray *tmpArr = [NSMutableArray array];
    
    //遍历查询结果
    while ([set next]) {
        //set会依次代表所有的数据
        ZdlModel *model = [[ZdlModel alloc] init];
        model.userName = [set stringForColumn:@"name"];
        model.text = [set stringForColumn:@"text"];
        model.imageData = [set dataForColumn:@"image"];
        [tmpArr addObject:model];
    }
    
    return tmpArr;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"zz"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"zz"];
    }
    ZdlModel *model=[_dataArr objectAtIndex:indexPath.row];
    
    cell.imageView.image=[UIImage imageWithData:model.imageData];
    cell.textLabel.text=model.userName;
    cell.detailTextLabel.text=model.text;
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
