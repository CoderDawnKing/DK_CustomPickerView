//
//  AddressFMDBManager.h
//  DK_CustomPickerView
//
//  Created by apple on 17/4/18.
//  Copyright © 2017年 DeamonKing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
@interface AddressFMDBManager : NSObject
{
    FMDatabase *_cityData;
}
@property (nonatomic,strong)NSMutableArray *provinceArray;//存放省的数组
@property (nonatomic,strong)NSMutableArray *cityArray;    //存放市的数组
@property (nonatomic,strong)NSMutableArray *districtArray;//存放区的数组

@property (nonatomic,assign)NSInteger cityId;//记录城市的id


+ (AddressFMDBManager *)sharedAddressFMDBManager;

//查询表数据:省的数组
- (NSArray *)selectAllProvince;

//查询表数据:市的数组
- (NSArray *)selectAllCityFrom:(NSInteger)provinceId;
//根据市名查找市对应的id
- (NSInteger)selectIdFromCityWith:(NSString *)name;

//查询表数据:区的数组
- (NSArray *)selectAllDistrictFrom:(NSInteger)cityId;



@end
