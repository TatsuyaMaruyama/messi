//
//  ImageNoteViewCell.h
//  CamBinder
//
//  Created by 松本拓真 on 2014/09/06.
//  Copyright (c) 2014年 MatsumotoTakuma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageNoteViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *_imageView;
@property (weak, nonatomic) IBOutlet UILabel *labelImageDate;

+ (CGFloat)rowHeight;

@end
