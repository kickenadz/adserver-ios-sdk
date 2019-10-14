//
//  ViewController.m
//  ObjC Sample
//
//  Created by Ryuichi Saito on 11/8/16.
//  Copyright © 2016 kickenadz. All rights reserved.
//

@import kickenadz;
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)requestPlacementTapped:(id)sender {
    PlacementRequestConfig *config = [[PlacementRequestConfig alloc] initWithAccountId:153105 zoneId:214764 width:300 height:250 keywords:@[@"sample2"] click:nil];
    [kickenadz requestPlacementWithConfig:config success:^(NSString * _Nonnull status, NSArray<Placement *> * _Nonnull placements) {
        NSLog(@"status: %@\nplacements: %@", status, placements);
        
        if ([placements count] > 0) {
            Placement *placement = placements[0];
            [placement getImageView:^(UIImageView *imageView) {
                CGRect imageViewFrame = imageView.frame;
                imageViewFrame.origin.y = self.view.frame.size.height - imageViewFrame.size.height - 10;
                imageViewFrame.origin.x = (self.view.frame.size.width - imageViewFrame.size.width) / 2;
                imageView.frame = imageViewFrame;
                [self.view addSubview:imageView];
                [placement recordImpression];
            }];
        }
        
    } failure:^(NSNumber * _Nullable statusCode, NSString * _Nullable responseBody, NSError * _Nullable error) {
        // :)
    }];
}

- (IBAction)requestPlacementsTapped:(id)sender {
    NSArray<PlacementRequestConfig *> *configs = @[
                                                 [[PlacementRequestConfig alloc] initWithAccountId:153105 zoneId:214764 width:300 height:250 keywords:@[] click:nil],
                                                 [[PlacementRequestConfig alloc] initWithAccountId:153105 zoneId:214764 width:300 height:250 keywords:@[@"sample2"] click:nil],
                                                 ];
    [kickenadz requestPlacementsWithConfigs:configs success:^(NSString * _Nonnull status, NSArray<Placement *> * _Nonnull placements) {
        NSLog(@"status: %@\nplacements: %@", status, placements);
    } failure:^(NSNumber * _Nullable statusCode, NSString * _Nullable responseBody, NSError * _Nullable error) {
        // :)
    }];
}

- (IBAction)requestPixelTapped:(id)sender {
    [kickenadz requestPixelWithURL:[NSURL URLWithString:@"https://servedbykickenadz.com/default_banner.gif"]];
}

- (IBAction)recordImpressionTapped:(id)sender {
    Placement *placement = [self getSamplePlacement];
    [placement recordImpression];
}

- (IBAction)recordClickTapped:(id)sender {
    Placement *placement = [self getSamplePlacement];
    [placement recordClick];
}

- (Placement *)getSamplePlacement {
    return [[Placement alloc] initWithBannerId:519407754
                                   redirectUrl: @"https://servedbykickenadz.com/redirect.spark?MID=153105&plid=550986&setID=214764&channelID=0&CID=0&banID=519407754&PID=0&textadID=0&tc=1&mt=1480778998606477&hc=534448fb7fb5835eaca37f949e61a363d8237324&location="
                                      imageUrl: @"http://servedbykickenadz.com/default_banner.gif"
                                         width: 300
                                        height: 250
                                       altText: @""
                                        target: @"_blank"
                                 trackingPixel: @"http://servedbykickenadz.com/default_banner.gif?foo=bar&demo=fakepixel"
                                  accupixelUrl: @"https://servedbykickenadz.com/adserve.ibs/;ID=153105;size=1x1;type=pixel;setID=214764;plid=550986;BID=519407754;wt=1480779008;rnd=90858"
                                    refreshUrl:nil
                                   refreshTime:nil
                                          body:nil];
}

@end
