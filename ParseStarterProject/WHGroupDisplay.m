//
//  WHGroupDisplay.m
//  whistlester
//
//  Created by Aravind Thiyagarajan on 2/28/14.
//
//

#import "WHGroupDisplay.h"
#import "UIColor+FlatUI.h"

#import "UIFont+FlatUI.h"

@implementation WHGroupDisplay
@synthesize groupLogo,groupName,members,post,join;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    
   
  
        self.groupName.textColor =  [UIColor whiteColor];
    self.groupName.font =  [UIFont boldFlatFontOfSize:20];
    
    self.removeUser.clipsToBounds = YES;
    self.removeUser.layer.cornerRadius = self.removeUser.frame.size.height/2;
    self.removeUser.layer.borderWidth=.5;
    self.removeUser.layer.borderColor=[[UIColor alizarinColor]CGColor];
    

    
    self.members.textColor = [UIColor whiteColor];
    self.members.font =  [UIFont boldFlatFontOfSize:10.0f];
    
  
    
    
    
    
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
