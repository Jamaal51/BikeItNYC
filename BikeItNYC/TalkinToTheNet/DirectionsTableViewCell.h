//
//  DirectionsTableViewCell.h
//  TalkinToTheNet
//
//  Created by Jamaal Sedayao on 9/24/15.
//  Copyright © Jamaal Sedayao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DirectionsTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *directionImage;
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet UILabel *directionsLabel;
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *durationLabel;


@end
