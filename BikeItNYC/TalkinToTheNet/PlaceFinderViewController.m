//
//  PlaceFinderViewController.m
//  TalkinToTheNet
//
//  Created by Jamaal Sedayao on 3/30/16.
//  Copyright © 2016 Mike Kavouras. All rights reserved.
//

#import "PlaceFinderViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <INTULocationManager/INTULocationManager.h>

@interface PlaceFinderViewController () <GMSAutocompleteViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *originButton;
@property (strong, nonatomic) IBOutlet UIButton *destinationButton;

//Variables
@property (nonatomic) NSString *origin;
@property (nonatomic) NSString *destination;
@property (nonatomic) BOOL returnOrigin;
@property (nonatomic) BOOL returnDestination;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation PlaceFinderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.returnOrigin = FALSE;
    self.returnDestination = FALSE;
    
    [self getCurrentLocation];
    
}

- (void)getCurrentLocation {
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]){
        [self.locationManager requestAlwaysAuthorization];
    }
    
    INTULocationManager *locationMgr = [INTULocationManager sharedInstance];
    
    [locationMgr requestLocationWithDesiredAccuracy:INTULocationAccuracyCity
                                            timeout:10.0 block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
                                                if (status == INTULocationStatusSuccess){

                                                    self.origin = [NSString stringWithFormat:@"ll=%f,%f",currentLocation.coordinate.latitude, currentLocation.coordinate.longitude];
                                                    
                                                    NSLog(@"Our Location: %@",self.origin);
                                                    
                                                } else if (status == INTULocationStatusTimedOut){
                                                    
                                                } else {
                                                    NSLog(@"Error");
                                                }
                                            }];
}



// Present the autocomplete view controller when the button is pressed.
- (IBAction)callAutoCompleteVC:(id)sender {
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    [self presentViewController:acController animated:YES completion:nil];
    if (sender == self.originButton){
        self.returnOrigin = TRUE;
        self.returnDestination = FALSE;
        
    } else if (sender == self.destinationButton){
        self.returnDestination = TRUE;
        self.returnOrigin = FALSE;
    }
    
    
}
// Handle the user's selection.
- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {
    [self dismissViewControllerAnimated:YES completion:nil];
    // Do something with the selected place.
    
    if (self.returnOrigin == TRUE){
        self.origin = place.name;
        [self.originButton setTitle: self.origin forState:UIControlStateNormal];
        NSLog(@"Origin: %@", self.origin);
        NSLog(@"Origin Address: %@", place.formattedAddress);
    } else if (self.returnDestination == TRUE){
        self.destination = place.name;
        [self.destinationButton setTitle:self.destination forState:UIControlStateNormal];
        NSLog(@"Destination: %@", self.destination);
        NSLog(@"Destination Address: %@", place.formattedAddress);
    }
//    NSLog(@"Place name %@", place.name);
//    NSLog(@"Place address %@", place.formattedAddress);
//    NSLog(@"Place attributions %@", place.attributions.string);
}

- (void)viewController:(GMSAutocompleteViewController *)viewController
didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}

// User canceled the operation.
- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Turn the network activity indicator on and off again.
- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
