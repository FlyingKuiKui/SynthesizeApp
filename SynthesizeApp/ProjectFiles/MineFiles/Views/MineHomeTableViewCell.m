//
//  MineHomeTableViewCell.m
//  SynthesizeApp
//
//  Created by 王盛魁 on 2017/3/23.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import "MineHomeTableViewCell.h"

@interface MineHomeTableViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *leftImage;
@property (strong, nonatomic) IBOutlet UILabel *titleLbl;

@end

@implementation MineHomeTableViewCell
- (void)set_dataDic:(NSDictionary *)_dataDic{
    if (__dataDic != _dataDic) {
        __dataDic = _dataDic;
    }
    self.leftImage.image = [UIImage imageNamed:[__dataDic objectForKey:@"imgName"]];
    self.titleLbl.text = [__dataDic objectForKey:@"title"];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
