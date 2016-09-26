//
//  commentTableViewCell.m
//  whistlester
//
//  Created by Aravind Thiyagarajan on 6/26/14.
//
//

#import "WHcommentTableViewCell.h"
#import "UIColor+FlatUI.h"

#import "UIFont+FlatUI.h"

@implementation WHcommentTableViewCell

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
    
        UIColor* neutralColor = [UIColor colorWithWhite:0.4 alpha:1.0];
    
   
       
    self.nickname.textColor =  [UIColor blackColor];
    self.nickname.font =  [UIFont boldFlatFontOfSize:12];
    
    
   
    self.date.textColor=neutralColor;
    self.date.font= [UIFont flatFontOfSize:8.0f ];
    
    self.comment.textColor = neutralColor;
    self.comment.font =  [UIFont flatFontOfSize:12.0f ];
    
    
    
    
    self.image.clipsToBounds = YES;
    //self.image.layer.cornerRadius = 20.0f;
    //self.image.layer.borderWidth = 2.0f;
    //self.image.layer.borderColor = [[UIColor peterRiverColor]CGColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
