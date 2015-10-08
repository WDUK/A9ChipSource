//
//  ViewController.m
//  A9ChipSource
//
//  Created by David Stockley on 29/09/2015.
//  Copyright © 2015 David Stockley. All rights reserved.
//

#import "ViewController.h"

#pragma mark - MobileGestalt

#include <CoreFoundation/CoreFoundation.h>
#if __cplusplus
extern "C" {
#endif
    CFPropertyListRef MGCopyAnswer(CFStringRef property);
#if __cplusplus
}
#endif

#pragma mark - View Controller

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *chipLabel;
@property (weak, nonatomic) IBOutlet UILabel *manufactureLabel;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CFStringRef val = (CFStringRef)MGCopyAnswer(CFSTR("HardwarePlatform"));
    NSString* chipIdentifier =(__bridge NSString * _Nullable)(val);
    
    if (chipIdentifier) {
        self.chipLabel.text = chipIdentifier;
        
        NSString* manufacturer = [self manufacturerFromChip:chipIdentifier];
        if (manufacturer) {
            self.manufactureLabel.text = manufacturer;
        }
    }
}

- (NSString*)manufacturerFromChip:(NSString*)chipIdentifier
{
    if ([chipIdentifier isEqualToString:@"s8000"]) {
        return @"Samsung";
    }
    else if ([chipIdentifier isEqualToString:@"s8003"]) {
        return @"TSMC";
    }
    else {
        return nil;
    }
}

@end
