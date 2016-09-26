//
//  FeedCell3.h
//  whistlester
//
//  Created by Aravind Thiyagarajan on 5/21/14.
//
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface FeedCell3 : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView* profileImageView;
@property (weak, nonatomic) IBOutlet UIButton *recycle;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *unlikeButton;

@property (weak, nonatomic) IBOutlet UIButton *flag;
@property (nonatomic, weak) IBOutlet UIImageView* picImageView;

@property (nonatomic, weak) IBOutlet UIView* picImageContainer;

@property (nonatomic, strong) IBOutlet UILabel* nameLabel;
@property (nonatomic, strong) IBOutlet UIButton* button;

@property (nonatomic, weak) IBOutlet UILabel* updateLabel;

@property (nonatomic, strong) IBOutlet UILabel* dateLabel;

@property (nonatomic, weak) IBOutlet UILabel* commentCountLabel;

@property (nonatomic, weak) IBOutlet UILabel* likeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *unlikeCountLable;







@property (weak, nonatomic) IBOutlet UILabel *groupName;
@property  NSInteger *tag;

@end
