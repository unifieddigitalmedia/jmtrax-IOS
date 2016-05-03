//
//  CustomTableViewCell.m
//  JM Transfers
//
//  Created by Machel Slack on 05/12/2015.
//  Copyright © 2015 Just Computers Parts. All rights reserved.
//
#import "HomePageBackgroundView.h"

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    if (highlighted) {
        
        self.textLabel.textColor = [UIColor whiteColor];
        
    } else {
        
        self.textLabel.textColor = [UIColor blackColor];
        
    }
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  
    
    // self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    
   
    
    
    if (self) {
       
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        [self setHighlighted:YES animated:YES];
        
        //self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_keyboard_arrow_right"]];
        
        [self setTintColor:[UIColor blackColor]];
        
        self.backgroundView = [[UIView alloc] init];
        
        UIColor *myColor = [UIColor colorWithRed:90.0f/255.0f green:90.0f/255.0f blue:90.0f/255.0f alpha:1.0f];
        
        [self.backgroundView setBackgroundColor:myColor];
        
        UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
        
        separatorLineView.backgroundColor = [UIColor blackColor];
        
        [self.contentView addSubview:separatorLineView];
        
        

        
    }
    
    return self;
}


@end
