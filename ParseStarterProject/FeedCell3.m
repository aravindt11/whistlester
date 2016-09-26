//
//  FeedCell3.m
//  whistlester
//
//  Created by Aravind Thiyagarajan on 5/21/14.
//
//

#import "FeedCell3.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+FlatUI.h"

#import "UIFont+FlatUI.h"


@implementation FeedCell3


@synthesize tag;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


-(void)awakeFromNib{
    
    //UIColor* mainColor = [UIColor colorWithRed:28.0/255 green:158.0/255 blue:121.0/255 alpha:1.0f];
   
   /* UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 215, 314, 3)];/// change size as you need.
    separatorLineView.backgroundColor = [UIColor peterRiverColor];// you can also put image here
    [self.contentView addSubview:separatorLineView];*/
       
    

    UIColor* neutralColor = [UIColor colorWithWhite:0.4 alpha:1.0];
    
    UIColor* mainColorLight = [UIColor colorWithRed:231.0/255 green:76.0/255 blue:60.0/255 alpha:0.4f];
   
    
    NSString* fontName = @"Avenir-Book";
   
    
    self.nameLabel.textColor =  [UIColor blackColor];
    self.nameLabel.font =  [UIFont boldFlatFontOfSize:14.0f];
   
    
    self.date.textColor=neutralColor;
    self.date.font= [UIFont flatFontOfSize:12.0f ];
    self.nameLabel.font =  [UIFont boldFlatFontOfSize:14.0f];
   
    
    self.likeButton.titleLabel.font=[UIFont boldFlatFontOfSize:16.0f];
    self.unlikeButton.titleLabel.font=[UIFont boldFlatFontOfSize:16.0f];
    
    
    self.updateLabel.textColor =  neutralColor;
    self.updateLabel.font =  [UIFont fontWithName:fontName size:12.0f];
    
    self.dateLabel.textColor = [UIColor blackColor];
    self.dateLabel.font =  [UIFont flatFontOfSize:15.0f ];
   
   
    self.commentCountLabel.textColor = neutralColor;
    self.commentCountLabel.font =  [UIFont italicFlatFontOfSize:10.0f];
    
   
    
    
    self.likeCountLabel.textColor = neutralColor;
    self.likeCountLabel.font =  [UIFont italicFlatFontOfSize:10.0f];
    
    self.unlikeCountLable.textColor=neutralColor;
    self.unlikeCountLable.font =  [UIFont italicFlatFontOfSize:10.0f];
    
    self.picImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.picImageView.clipsToBounds = YES;
    self.picImageView.layer.cornerRadius = 2.0f;
    
    self.picImageContainer.backgroundColor = [UIColor whiteColor];
    self.picImageContainer.layer.borderColor = [UIColor colorWithWhite:0.8f alpha:0.6f].CGColor;
    self.picImageContainer.layer.borderWidth = 1.0f;
    self.picImageContainer.layer.cornerRadius = 2.0f;
    
    
    self.profileImageView.clipsToBounds = YES;
   // self.profileImageView.layer.cornerRadius = 20.0f;
   // self.profileImageView.layer.borderWidth = 2.0f;
    self.profileImageView.layer.borderColor = mainColorLight.CGColor;
   
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
