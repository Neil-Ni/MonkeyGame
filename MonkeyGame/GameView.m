//
//  GameView.m
//  MonkeyGame
//
//  Created by Tzu-Yang Ni on 3/2/12.
//  Copyright (c) 2012 yoseka. All rights reserved.
//

#import "GameView.h"
#import <QuartzCore/CoreAnimation.h>
#import "ResultsView.h"
#import "ChoiseView.h"

@implementation GameView
@synthesize label = _label;
@synthesize FeedbackLabel = _FeedbackLabel;
@synthesize SimleSadFace=_SimleSadFace;
@synthesize GameOver = _GameOver;
@synthesize MonkeyWithTree=_MonkeyWithTree;
@synthesize BananaScores=_BananaScores,MonkeyScores=_MonkeyScores;
@synthesize ShowMonkey=_ShowMonkey;
@synthesize B5=_B5, B4=_B4, B3=_B3, B2=_B2, B1=_B1;
@synthesize T=_T, T5=_T5, T4=_T4, T3=_T3, T2=_T2, T1=_T1;
@synthesize BananaDictionary=_BananaDictionary, MonkeyDictionary=_MonkeyDictionary;
@synthesize DemoAlreadyShown, DoneTheFirstTwoTrials;
@synthesize MonkeyNumberArray=_MonkeyNumberArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)initializeDictionaries{
    
    self.MonkeyDictionary = [[NSMutableDictionary alloc] init];
    [self.MonkeyDictionary setObject:[UIImage imageNamed:@"M1.png"] forKey:[NSNumber numberWithInt:1]];
    [self.MonkeyDictionary setObject:[UIImage imageNamed:@"M2.png"] forKey:[NSNumber numberWithInt:2]];
    [self.MonkeyDictionary setObject:[UIImage imageNamed:@"M3.png"] forKey:[NSNumber numberWithInt:3]];
    [self.MonkeyDictionary setObject:[UIImage imageNamed:@"M4.png"] forKey:[NSNumber numberWithInt:4]];
    [self.MonkeyDictionary setObject:[UIImage imageNamed:@"M5.png"] forKey:[NSNumber numberWithInt:5]];
    self.BananaDictionary = [[NSMutableDictionary alloc] init];
    [self.BananaDictionary setObject:[UIImage imageNamed:@"B1.png"] forKey:[NSNumber numberWithInt:1]];
    [self.BananaDictionary setObject:[UIImage imageNamed:@"B2.png"] forKey:[NSNumber numberWithInt:2]];
    [self.BananaDictionary setObject:[UIImage imageNamed:@"B3.png"] forKey:[NSNumber numberWithInt:3]];
    [self.BananaDictionary setObject:[UIImage imageNamed:@"B4.png"] forKey:[NSNumber numberWithInt:4]];
    [self.BananaDictionary setObject:[UIImage imageNamed:@"B5.png"] forKey:[NSNumber numberWithInt:5]];
    
    self.BananaScores = [[NSMutableArray alloc] init];
    self.MonkeyScores = [[NSMutableArray alloc] init];
    
    self.MonkeyNumberArray = 
    [[NSMutableArray alloc] initWithObjects:
     [NSNumber numberWithInteger:1],
     [NSNumber numberWithInteger:2],
     [NSNumber numberWithInteger:3],
     [NSNumber numberWithInteger:4],
     [NSNumber numberWithInteger:5],
     [NSNumber numberWithInteger:1],
     [NSNumber numberWithInteger:2],
     [NSNumber numberWithInteger:3],
     [NSNumber numberWithInteger:4],
     [NSNumber numberWithInteger:5], nil];
    
}

-(void)ContinueGamesWithCorrectAnswer:(BOOL)Correct{
    if( NumberOfGames+1 > [self.MonkeyNumberArray count]){
        [self GameOverWithoutSwipe];
    }else{
        [self RestartTheGameAfter:3];
    }
}

-(void)ContinueTrialsWithCorrectAnswer:(BOOL)Correct{
    
    if(Correct == TRUE){
        self.FeedbackLabel.hidden = NO;
        self.FeedbackLabel.text = @"Good Job!";
        
        if(NumberOfTrials == 2){
            NSLog(@"now start the real game");
            counter = 3;
            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(CountdownToStartTheGame:) userInfo:nil repeats:YES];
        }else{
            NumberOfTrials++;
            [self RestartTheTrailAfter:3];
        }
            
    }else{
        if(NumberOfChosenBanana> NumberOfMonkeys){
            self.FeedbackLabel.hidden = NO;
            self.FeedbackLabel.text = @"That is too many";
        }else{
            self.FeedbackLabel.hidden = NO;
            self.FeedbackLabel.text = @"That is not enough";
        }
        [self RestartTheTrailAfter:3];
    }
    
    
}

-(void)AnswerIsCorrect{
    if(DoneTheFirstTwoTrials == TRUE){
        [self ContinueGamesWithCorrectAnswer:YES];
    }
    if(DoneTheFirstTwoTrials != TRUE){
        self.SimleSadFace.image = [UIImage imageNamed:@"Smile.png"]; 
        self.SimleSadFace.hidden = NO;
//        self.view.backgroundColor = [UIColor greenColor];
        [self ContinueTrialsWithCorrectAnswer:YES];
    }    
}

-(void)AnswerIsWrong{
    if(DoneTheFirstTwoTrials == TRUE){
        [self ContinueGamesWithCorrectAnswer:NO];
    }
    if(DoneTheFirstTwoTrials != TRUE){
        self.SimleSadFace.image = [UIImage imageNamed:@"Sad.png"]; 
        self.SimleSadFace.hidden = NO;
//        self.view.backgroundColor = [UIColor redColor];
        [self ContinueTrialsWithCorrectAnswer:NO];
    }

}

-(void)Showface:(BOOL)decision{
    
    if(decision==YES){
        if(NumberOfChosenBanana == NumberOfMonkeys){
            [self AnswerIsCorrect];
        }
        if(NumberOfChosenBanana != NumberOfMonkeys){
            [self AnswerIsWrong];            
        }
    }
    if(decision==NO){
        self.SimleSadFace.hidden = YES; 
    }
}

//This is the loop for Trials With FeedBack
#pragma mark - Trial

-(void)TrialCountdown:(NSTimer *)timer{
    counter = counter-1;
    NSLog(@"Countdown %d", counter); 
    if(counter <0){
        self.label.hidden = YES;
        [timer invalidate]; 
        self.ShowMonkey.hidden = YES;
        NSLog(@"hiding monkeys");
        [self ShowTreeWithBananas:YES];
        NSLog(@"Showing monkeys with tree and bananas");
    }
}
-(void)TrailhideMonkeyafter:(NSInteger)seconds{
    counter = seconds;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(TrialCountdown:) userInfo:nil repeats:YES];
    
}

-(void)DoTheFirstTwoTrialsWtihFeedBack{    
    NSLog(@"Starting the trial");
    NumberOfTrials = 1; 
    NumberOfMonkeys = NumberOfTrials;
    NSLog(@"showing %d monkeys", NumberOfMonkeys);
    self.ShowMonkey.image = [self.MonkeyDictionary objectForKey:[NSNumber numberWithInt:NumberOfMonkeys]];
    [self animateMonkeytoshow:YES duration:0.5];
    
    [self TrailhideMonkeyafter:3];
    self.label.hidden = NO;

    NSLog(@"this is number %d test trials", NumberOfTrials);
}

-(void)CountdownAndRestartTrial:(NSTimer *)timer{
    counter = counter-1;
    NSLog(@"CountdownAndRestart %d", counter);
    if(counter<1 && DoneTheFirstTwoTrials ==FALSE){
        self.label.hidden = NO;
        self.label.text = @"Let's try again!";
        self.view.backgroundColor = [UIColor whiteColor];
    }
    if(counter <0){
        [timer invalidate]; 
        //make sure everything is all hidden again
        [self HideEverything];
        //now completely restart
        NumberOfMonkeys = NumberOfTrials;
        NSLog(@"showing %d monkeys", NumberOfMonkeys);
        self.ShowMonkey.image = [self.MonkeyDictionary objectForKey:[NSNumber numberWithInt:NumberOfMonkeys]];
        //show 
        [self animateMonkeytoshow:YES duration:0.5];
        
        //Monkeys go away after 2 seconds
        [self hideMonkeyafter:3];
        
        //number of trials
        
        NSLog(@"this is number %d trials", NumberOfTrials);
        
    }
}
-(void)RestartTheTrailAfter:(NSInteger)seconds{
    counter = seconds;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(CountdownAndRestartTrial:) userInfo:nil repeats:YES];
    
}



#pragma mark - Real Game

-(void)StartTheGame{
    NSLog(@"Starting the real game");
    NumberOfGames = 0; 
    [self HideEverything];
    DoneTheFirstTwoTrials = TRUE;
    NumberOfMonkeys = [self DecideNumberOfMonkeys];
    NumberOfMonkeys = [[self.MonkeyNumberArray objectAtIndex:NumberOfGames] integerValue];
    
    
    NSLog(@"showing %d monkeys", NumberOfMonkeys);
    self.ShowMonkey.image = [self.MonkeyDictionary objectForKey:[NSNumber numberWithInt:NumberOfMonkeys]];
    [self animateMonkeytoshow:YES duration:0.5];
    [self hideMonkeyafter:3];
    NumberOfGames = 1;
    NSLog(@"this is number %d games", NumberOfGames);
}

-(void)CountdownAndRestart:(NSTimer *)timer{
    counter = counter-1;
    NSLog(@"CountdownAndRestart %d", counter);
    if(counter<1 && DoneTheFirstTwoTrials ==FALSE){
        self.label.hidden = NO;
        self.label.text = @"Let's try again!";
    }
    if(counter <0){
        [timer invalidate]; 
        //make sure everything is all hidden again
        [self HideEverything];
        self.SimleSadFace.hidden = YES;
        //now completely restart
        NumberOfMonkeys = [self DecideNumberOfMonkeys];
        NumberOfMonkeys = [[self.MonkeyNumberArray objectAtIndex:NumberOfGames] integerValue];

        NSLog(@"showing %d monkeys", NumberOfMonkeys);
        self.ShowMonkey.image = [self.MonkeyDictionary objectForKey:[NSNumber numberWithInt:NumberOfMonkeys]];
        //show 
        [self animateMonkeytoshow:YES duration:0.5];
        
        //Monkeys go away after 2 seconds
        [self hideMonkeyafter:3];
        
        //number of trials
        
        NumberOfGames++;
        
        NSLog(@"this is number %d game", NumberOfGames);
        
    }
}
-(void)RestartTheGameAfter:(NSInteger)seconds{
    counter = seconds;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(CountdownAndRestart:) userInfo:nil repeats:YES];
    
}

-(void)CountdownToStartTheGame:(NSTimer *)timer{
    counter = counter -1;
    NSLog(@"CountdownToStartTheGame %d", counter); 
    if(counter <1 && DoneTheFirstTwoTrials ==FALSE){
        self.label.hidden = NO;
        self.label.text = @"Real Game Starting";
        self.view.backgroundColor = [UIColor whiteColor];
    }
    if(counter <0){
        
        [timer invalidate];
        [self StartTheGame];
    }
    
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"viewWillAppear");
    if(!DoneTheFirstTwoTrials){
        NSLog(@"setting DoneTheFirstTwoTrials to False");
        DoneTheFirstTwoTrials = FALSE;
    }
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    // DemoAlreadyShown DoneTheFirstTwoTrials two boolean to decide which mode to start
    if (DemoAlreadyShown == TRUE) {
        [self initializeDictionaries];
        if(DoneTheFirstTwoTrials == TRUE){
            [self StartTheGame];
        }
        else{
            [self DoTheFirstTwoTrialsWtihFeedBack];
        }
    }
    else{
        [self ShowChoiseView];
        DemoAlreadyShown = TRUE;
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(GameOver:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.GameOver addGestureRecognizer:swipe];
    
    NSLog(@"viewDidLoad");

}
- (void)viewDidUnload
{
    [self setT:nil];
    [self setT1:nil];
    [self setT2:nil];
    [self setT3:nil];
    [self setT4:nil];
    [self setT5:nil];
    [self setB1:nil];
    [self setB2:nil];
    [self setB3:nil];
    [self setB4:nil]; 
    [self setB5:nil];
    [self setShowMonkey:nil];
    [self setMonkeyWithTree:nil];
    [self setSimleSadFace:nil];
    [self setLabel:nil];
    [self setFeedbackLabel:nil];
    [self setGameOver:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

-(void)ShowChoiseView{
    ChoiseView *aChoiseView = [[ChoiseView alloc] initWithNibName:@"ChoiseView" bundle:nil];
    [self.navigationController presentModalViewController:aChoiseView animated:YES];
    
}


- (void) animateMonkeytoshow:(BOOL)show duration:(NSTimeInterval)duration {
	if (show==NO) { 
		self.ShowMonkey.hidden=YES;
	} else {
        self.ShowMonkey.hidden=YES;
        [UIView animateWithDuration:0
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:(void (^)(void)) ^{
                             
                             self.ShowMonkey.transform = CGAffineTransformMakeScale(0.01, 0.01);
                         }
                         completion:^(BOOL finished){
                             self.ShowMonkey.hidden = NO;
                             [UIView animateWithDuration:duration
                                                   delay:0
                                                 options:UIViewAnimationOptionBeginFromCurrentState
                                              animations:(void (^)(void)) ^{
                                                  self.ShowMonkey.transform = CGAffineTransformMakeScale(1, 1);
                                              }
                                              completion:^(BOOL finished){
                                                  self.ShowMonkey.transform = CGAffineTransformIdentity;
                                                  
                                              }];
                         }];
	}
    
}

- (void)moveImage:(UIImageView *)image duration:(NSTimeInterval)duration
            curve:(int)curve x:(CGFloat)x y:(CGFloat)y
{
    // Setup the animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    // The transform matrix
    CGAffineTransform transform = CGAffineTransformMakeTranslation(x, y);
    image.transform = transform;
    
    // Commit the changes
    [UIView commitAnimations];
}

-(void)enableTapping{
    
    UIGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1banana:)];
    UIGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2banana:)];
    UIGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap3banana:)];
    UIGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap4banana:)];
    UIGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap5banana:)];
    
    [self.B1 addGestureRecognizer:tap1];
    [self.B2 addGestureRecognizer:tap2];
    [self.B3 addGestureRecognizer:tap3];
    [self.B4 addGestureRecognizer:tap4];
    [self.B5 addGestureRecognizer:tap5];
    
}

-(void)ShowTreeWithBananas:(BOOL)decision{
    if(decision == YES){
        self.T.hidden = NO;
        self.T1.hidden = NO;
        self.T2.hidden = NO;
        self.T3.hidden = NO;
        self.T4.hidden = NO;
        self.T5.hidden = NO;
        
        self.B1.hidden = NO;
        self.B2.hidden = NO;
        self.B3.hidden = NO;
        self.B4.hidden = NO;
        self.B5.hidden = NO;
        
        self.MonkeyWithTree.image = [self.MonkeyDictionary objectForKey:[NSNumber numberWithInt:NumberOfMonkeys]];
        self.MonkeyWithTree.hidden = YES;
        NSLog(@"enabling taps");
        [self enableTapping];
    }
    if(decision == NO){
        self.T.hidden = YES;
        self.T1.hidden = YES;
        self.T2.hidden = YES;
        self.T3.hidden = YES;
        self.T4.hidden = YES;
        self.T5.hidden = YES;
        
        self.B1.hidden = YES;
        self.B2.hidden = YES;
        self.B3.hidden = YES;
        self.B4.hidden = YES;
        self.B5.hidden = YES;
        
        
    }
    
}

-(void)HideEverything{
    
    self.T.hidden = YES;
    self.T1.hidden = YES;
    self.T2.hidden = YES;
    self.T3.hidden = YES;
    self.T4.hidden = YES;
    self.T5.hidden = YES;
    
    self.B1.hidden = YES;
    [self moveImage:self.B1 duration:0 curve:UIViewAnimationCurveLinear x:(176.0-self.B1.center.x) y:(646.5-self.B1.center.y)];
    self.B2.hidden = YES;
    [self moveImage:self.B2 duration:0 curve:UIViewAnimationCurveLinear x:(217.5-self.B2.center.x) y:(539.5-self.B2.center.y)];
    self.B3.hidden = YES;
    [self moveImage:self.B3 duration:0 curve:UIViewAnimationCurveLinear x:(267.5-self.B3.center.x) y:(433.5-self.B3.center.y)];
    self.B4.hidden = YES;
    [self moveImage:self.B4 duration:0 curve:UIViewAnimationCurveLinear x:(310.5-self.B4.center.x) y:(325.5-self.B4.center.y)];
    self.B5.hidden = YES;
    [self moveImage:self.B5 duration:0 curve:UIViewAnimationCurveLinear x:(373.0-self.B5.center.x) y:(218.5-self.B5.center.y)];
    
    self.MonkeyWithTree.hidden = YES;
    self.label.hidden = YES;
    self.SimleSadFace.hidden = YES;
    self.FeedbackLabel.hidden = YES;
    
}


-(void)ResultBarButtonPressed:(id)sender{
    ResultsView *aResultView =  [[ResultsView alloc] initWithNibName:@"ResultsView" bundle:nil];
    aResultView.BananaScores = self.BananaScores;
    aResultView.MonkeyScores = self.MonkeyScores;
    aResultView.title = @"Result";
    [self.navigationController pushViewController:aResultView animated:YES];
    
}
-(void)AddResultBariTem{
    UIBarButtonItem *Result = [[UIBarButtonItem alloc] initWithTitle:@"Show Result" style:UIBarButtonItemStylePlain target:self action:@selector(ResultBarButtonPressed:)];
    self.navigationItem.rightBarButtonItem = Result;
    
}   

-(void)UpdateScores{
    [self.BananaScores addObject:[NSNumber numberWithInt:NumberOfChosenBanana]];
    [self.MonkeyScores addObject:[NSNumber numberWithInt:NumberOfMonkeys]];
}

-(void)tap1banana:(UITapGestureRecognizer *)recognizer{
    NSLog(@"1 bananas");
    NumberOfChosenBanana = 1;
    [self UpdateScores];
    [self ShowTreeWithBananas:NO];
    self.ShowMonkey.hidden = NO;
     self.B1.hidden = NO;
    NSLog(@"B1 x: %f y:%f", self.B1.center.x, self.B1.center.y );
    [self moveImage:self.B1 duration:2 curve:UIViewAnimationCurveLinear x:(self.ShowMonkey.center.x-self.B1.center.x) y:(self.ShowMonkey.center.y-self.B1.center.y)];
    [self Showface:YES];
}
-(void)tap2banana:(UITapGestureRecognizer *)recognizer{
    NSLog(@"2 bananas");
    NumberOfChosenBanana = 2;
    [self UpdateScores]; 
    [self ShowTreeWithBananas:NO];
    self.ShowMonkey.hidden = NO; 
     self.B2.hidden = NO;
    NSLog(@"B2 x: %f y:%f", self.B2.center.x, self.B2.center.y );
    [self moveImage:self.B2 duration:2 curve:UIViewAnimationCurveLinear x:(self.ShowMonkey.center.x-self.B2.center.x) y:(self.ShowMonkey.center.y-self.B2.center.y)];
    
    [self Showface:YES];
}
-(void)tap3banana:(UITapGestureRecognizer *)recognizer{
    NSLog(@"3 bananas");
    NumberOfChosenBanana = 3; 
    [self UpdateScores];
    [self ShowTreeWithBananas:NO];
    self.ShowMonkey.hidden = NO; 
     self.B3.hidden = NO;
    NSLog(@"B3 x: %f y:%f", self.B3.center.x, self.B3.center.y );
    [self moveImage:self.B3 duration:2 curve:UIViewAnimationCurveLinear x:(self.ShowMonkey.center.x-self.B3.center.x) y:(self.ShowMonkey.center.y-self.B3.center.y)];
    
    [self Showface:YES];
}
-(void)tap4banana:(UITapGestureRecognizer *)recognizer{
    NSLog(@"4 bananas");
    NumberOfChosenBanana = 4;
    [self UpdateScores];
    [self ShowTreeWithBananas:NO];
    self.ShowMonkey.hidden = NO; 
     self.B4.hidden = NO;
    NSLog(@"B4 x: %f y:%f", self.B4.center.x, self.B4.center.y );
    [self moveImage:self.B4 duration:2 curve:UIViewAnimationCurveLinear x:(self.ShowMonkey.center.x-self.B4.center.x) y:(self.ShowMonkey.center.y-self.B4.center.y)];
    
    [self Showface:YES];
}
-(void)tap5banana:(UITapGestureRecognizer *)recognizer{
    NSLog(@"5 bananas");
    NumberOfChosenBanana = 5;
    [self UpdateScores];
    [self ShowTreeWithBananas:NO];
    self.ShowMonkey.hidden = NO; 
     self.B5.hidden = NO;
    NSLog(@"B1 x: %f y:%f", self.B5.center.x, self.B5.center.y );
    [self moveImage:self.B5 duration:2 curve:UIViewAnimationCurveLinear x:(self.ShowMonkey.center.x-self.B5.center.x) y:(self.ShowMonkey.center.y-self.B5.center.y)];
    [self Showface:YES];
}



-(void)Countdown:(NSTimer *)timer{
    counter = counter-1;
    NSLog(@"Countdown %d", counter); 
    if(counter <0){
        self.label.hidden = YES;
        [timer invalidate]; 
        self.ShowMonkey.hidden = YES;
        NSLog(@"hiding monkeys");
        [self ShowTreeWithBananas:YES];
        NSLog(@"Showing monkeys with tree and bananas");
    }
}
-(void)hideMonkeyafter:(NSInteger)seconds{
    counter = seconds;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(Countdown:) userInfo:nil repeats:YES];
    
}
-(int)DecideNumberOfMonkeys{
    NumberOfMonkeys=0;
    while(NumberOfMonkeys==0){
        NumberOfMonkeys = arc4random()%6;
    }
    return NumberOfMonkeys;
}
-(void)GameOverWithoutSwipe{
    NSLog(@"Game Over"); 
    [self HideEverything];
    //[self AddResultBariTem];
    //[self.navigationController setNavigationBarHidden:NO animated:YES];
    
    /*Logging the result*/
    
    int c = [self.BananaScores count];
    for(int i = 0; i<c; i++){
        NSLog(@"No.%d trial Monkey: %i Banana: %i", i+1, [[self.MonkeyScores objectAtIndex:i]intValue],  [[self.BananaScores objectAtIndex:i] intValue]);
    }
    ResultsView *aResultView =  [[ResultsView alloc] initWithNibName:@"ResultsView" bundle:nil];
    aResultView.BananaScores = self.BananaScores;
    aResultView.MonkeyScores = self.MonkeyScores;
    aResultView.title = @"Result";
    [self.navigationController pushViewController:aResultView animated:YES];
}

- (void)GameOver:(UISwipeGestureRecognizer *)swipe {
    NSLog(@"Game Over"); 
    [self HideEverything];
    //[self AddResultBariTem];
    //[self.navigationController setNavigationBarHidden:NO animated:YES];
    
    /*Logging the result*/
    
    int c = [self.BananaScores count];
    for(int i = 0; i<c; i++){
        NSLog(@"No.%d trial Monkey: %i Banana: %i", i+1, [[self.MonkeyScores objectAtIndex:i]intValue],  [[self.BananaScores objectAtIndex:i] intValue]);
    }
    ResultsView *aResultView =  [[ResultsView alloc] initWithNibName:@"ResultsView" bundle:nil];
    aResultView.ShowOnlyTheScore = TRUE;
    aResultView.BananaScores = self.BananaScores;
    aResultView.MonkeyScores = self.MonkeyScores;
    aResultView.title = @"Result";
    [self.navigationController pushViewController:aResultView animated:YES];
}
@end
