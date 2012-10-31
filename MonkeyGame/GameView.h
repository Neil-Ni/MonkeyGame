//
//  GameView.h
//  MonkeyGame
//
//  Created by Tzu-Yang Ni on 3/2/12.
//  Copyright (c) 2012 yoseka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameView : UIViewController{
    int counter;
    NSMutableDictionary *MonkeyDictionary;
    NSMutableDictionary *BananaDictionary;
    NSMutableArray *MonkeyScores;
    NSMutableArray *BananaScores;
    NSMutableArray *MonkeyNumberArray;
    int NumberOfMonkeys; 
    int NumberOfChosenBanana;
    int NumberOfTrials;
    int NumberOfGames;
    BOOL DemoAlreadyShown;
    BOOL DoneTheFirstTwoTrials;
}
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UILabel *FeedbackLabel;

//the first-shown monkeys
@property (strong, nonatomic) IBOutlet UIImageView *ShowMonkey;
//the monkeys showon-with-tree
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

@property (strong, nonatomic) IBOutlet UIImageView *SimleSadFace;
@property (strong, nonatomic) IBOutlet UIButton *GameOver;

@property (strong, nonatomic) NSMutableDictionary *MonkeyDictionary;
@property (strong, nonatomic) NSMutableDictionary *BananaDictionary;
@property (strong, nonatomic) NSMutableArray *MonkeyScores;
@property (strong, nonatomic) NSMutableArray *BananaScores;
@property (strong, nonatomic) NSMutableArray *MonkeyNumberArray;

@property BOOL DemoAlreadyShown;
@property BOOL DoneTheFirstTwoTrials;
- (void) animateMonkeytoshow:(BOOL)show duration:(NSTimeInterval)duration;

-(void)initializeDictionaries;
-(void)ShowChoiseView; 
-(void)enableTapping;
-(void)HideEverything;
-(void)CountdownAndRestart:(NSTimer *)timer;
-(void)RestartTheGameAfter:(NSInteger)seconds;
-(void)enableTapping; 
-(void)Showface:(BOOL)decision;
-(void)ShowTreeWithBananas:(BOOL)decision;
-(void)tap1banana:(UITapGestureRecognizer *)recognizer;
-(void)tap2banana:(UITapGestureRecognizer *)recognizer;
-(void)tap3banana:(UITapGestureRecognizer *)recognizer;
-(void)tap4banana:(UITapGestureRecognizer *)recognizer;
-(void)tap5banana:(UITapGestureRecognizer *)recognizer;
-(void)Countdown:(NSTimer *)timer;
-(void)hideMonkeyafter:(NSInteger)seconds; 
-(int)DecideNumberOfMonkeys;
-(void)RestartTheTrailAfter:(NSInteger)seconds;
-(void)CountdownAndRestartTrial:(NSTimer *)timer;
-(void)GameOverWithoutSwipe;
- (void)GameOver:(UISwipeGestureRecognizer *)swipe; 

@end
