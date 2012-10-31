//
//  ChoiseView.h
//  MonkeyGame
//
//  Created by Tzu-Yang Ni on 3/2/12.
//  Copyright (c) 2012 yoseka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoiseView : UIViewController{
    int counter;
    int count;
}

@property (strong, nonatomic) IBOutlet UILabel *label;

@property (strong, nonatomic) IBOutlet UIImageView *MainDisplay;
@property (strong, nonatomic) IBOutlet UIImageView *IceCram;
@property (strong, nonatomic) IBOutlet UIImageView *IceCreamface;
@property (strong, nonatomic) IBOutlet UIImageView *hotdog;
@property (strong, nonatomic) IBOutlet UIImageView *hotdogface;
@property (strong, nonatomic) IBOutlet UIImageView *pizza;
@property (strong, nonatomic) IBOutlet UIImageView *pizzaface;
@property (strong, nonatomic) IBOutlet UIImageView *banana;


@property (strong, nonatomic) IBOutlet UIImageView *MonkeyWithTree;

//This part is for tree
@property (strong, nonatomic) IBOutlet UIImageView *T;
@property (strong, nonatomic) IBOutlet UIImageView *T1;
@property (strong, nonatomic) IBOutlet UIImageView *T2;
@property (strong, nonatomic) IBOutlet UIImageView *T3;
@property (strong, nonatomic) IBOutlet UIImageView *T4;
@property (strong, nonatomic) IBOutlet UIImageView *T5;
//For the bananas on the tree
@property (strong, nonatomic) IBOutlet UIImageView *B5;
@property (strong, nonatomic) IBOutlet UIImageView *B4;
@property (strong, nonatomic) IBOutlet UIImageView *B3;
@property (strong, nonatomic) IBOutlet UIImageView *B2;
@property (strong, nonatomic) IBOutlet UIImageView *B1;


@end
