//
//  commentTableViewCell.h
//  whistlester
//
//  Created by Aravind Thiyagarajan on 6/26/14.
//
//

#import <UIKit/UIKit.h>

@interface WHcommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UIButton *delete;
@property (weak, nonatomic) IBOutlet UILabel *date;

@end
