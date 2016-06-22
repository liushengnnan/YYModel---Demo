//
//  BGTableViewController.m
//  Demo-YYModel
//
//  Created by 郭彬 on 16/6/20.
//  Copyright © 2016年 walker. All rights reserved.
//

#import "BGTableViewController.h"
#import "Book.h"
#import "User.h"
#import "DifferentJSONKey.h"
#import "BlacklistAndWhitelist.h"
#import "YGXModel.h"
#import "latestExpireBonusModel.h"
#import "ContainerModel.h"


@interface BGTableViewController ()
@property(nonatomic,strong)NSArray *demoArray;

@property(nonatomic,strong) NSArray *listArray;     //listArray
@end

@implementation BGTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.demoArray = @[@"SimpleModel(简答的数据模型)",@"DoubleModel(双模型)",@"DifferentJSONKey(键值和属性不同)",@"Container property(容器模型)",@"whiteList&blackList(黑白名单)",@"liyangTest"];
 
    self.tableView.backgroundColor = [UIColor redColor];
    self.tableView.tableFooterView = [[UITableViewHeaderFooterView alloc]init];
    self.tableView.rowHeight = 100;
    self.tableView.estimatedRowHeight = 10;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.demoArray.count;
}

// cell的数据源方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 实例化cell
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    
    cell.textLabel.text = self.demoArray[indexPath.row];
    
    return cell;
}

#pragma mark - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self simpleModelJsonModelConvert];
            break;
        case 1:
            [self DoubleModelJsonModelConvert];
        case 2:
            [self DifferentJSONKeyModelConvert];
        case 3:
            [self containerJsonModelConvert];
        case 4:
//            [self BlacklistAndWhitelistModelConvert];
        case 5:
            [self liyangTest];
        default:
            break;
    }
}

#pragma mark - custom Method
//读取本地json,获取json数据
- (NSDictionary *) getJsonWithJsonName:(NSString *)jsonName {
    //从本地读取json数据（这一步你从网络里面请求）
    NSString *path = [[NSBundle mainBundle]pathForResource:jsonName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
}

- (NSArray *) getJsonArrayWithJsonName:(NSString *)jsonName {
    //从本地读取json数据（这一步你从网络里面请求）
    NSString *path = [[NSBundle mainBundle]pathForResource:jsonName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
}

- (void) simpleModelJsonModelConvert {
    NSDictionary *json = [self getJsonWithJsonName:@"SimpleModel"];
    // Convert json to model:
    User *user = [User yy_modelWithJSON:json];
    NSLog(@"%@",user);

    // Convert model to json:
    NSDictionary *jsonConvert = [user yy_modelToJSONObject];
    NSLog(@"%@",jsonConvert);
}

- (void) DoubleModelJsonModelConvert {
    NSDictionary *json = [self getJsonWithJsonName:@"DoubleModel"];
    
    // Convert json to model:
    Book *book = [Book yy_modelWithJSON:json];
    NSLog(@"book ===== %@",book);

    // Convert model to json:
    NSDictionary *jsonDict = [book yy_modelToJSONObject];
    NSLog(@"jsonDict ===== %@",jsonDict);
}

- (void) DifferentJSONKeyModelConvert {
    NSDictionary *json = [self getJsonWithJsonName:@"DifferentJSONKey"];
    
    // Convert json to model:
    DifferentJSONKey *differentJsonKey = [DifferentJSONKey yy_modelWithJSON:json];
    
   // Convert model to json:
    NSDictionary *jsonDict = [differentJsonKey yy_modelToJSONObject];
    NSLog(@"jsonDict ===== %@",jsonDict);
}

- (void) containerJsonModelConvert {
    NSDictionary *json =[self getJsonWithJsonName:@"ContainerModel"];

    ContainerModel *containModel = [ContainerModel yy_modelWithDictionary:json];
    
    NSDictionary *dataDict = [containModel valueForKey:@"data"];

    self.listArray = [dataDict valueForKey:@"list"];
//    NSLog(@"%@",self.listArray);
    [self.listArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *listDict = obj;
        
        List *listModel = [List yy_modelWithDictionary:listDict];
        NSString *count = [listModel valueForKey:@"count"];
        NSString *id = [listModel valueForKey:@"id"];
        
        NSLog(@"++++%@,------%@",count,id);
        
        
    }];
}

//- (void) BlacklistAndWhitelistModelConvert {
//    NSDictionary *json = [self getJsonWithJsonName:@"BlacklistAndWhitelist"];
//    
//    // Convert json to model:
//    BlacklistAndWhitelist *BlacklistAndWhitelist = [BlacklistAndWhitelist yy_modelWithJSON:json];
//    
//    // Convert model to json:
//    NSDictionary *jsonDict = [BlacklistAndWhitelist yy_modelToJSONObject];
//    NSLog(@"jsonDict ===== %@",jsonDict);
//}

- (void) liyangTest {
//    NSArray *json = [self getJsonArrayWithJsonName:@"ContainerModel"];

//    DataModelArray *dataArray = [[DataModelArray alloc]init];
//    [dataArray fillWithJSONObejct:json];
//    NSArray *inlineDataArray = dataArray[1];
//    NSLog(@"%@",inlineDataArray);
//    + (id)dataModelWithJSONString:(NSString *)jsonString;
//    + (id)dataModelWithJSONObject:(id)jsonObject;
//
//    - (void)fillWithJSONObejct:(NSDictionary *)jsonObject;
//
//    - (NSString *)toJSONString;
//    - (NSDictionary *)toJSONObject;
    
//    NSDictionary *json =[self getJsonWithJsonName:@"ContainerModel"];
//    DataModelArray *dataArray = [[DataModelArray alloc]init];

}

@end