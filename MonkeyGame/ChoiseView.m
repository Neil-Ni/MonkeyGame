//
//  ChoiseView.m
//  MonkeyGame
//
//  Created by Tzu-Yang Ni on 3/2/12.
//  Copyright (c) 2012 yoseka. All rights reserved.
//

#import "ChoiseView.h"
#import <QuartzCore/CoreAnimation.h>


@implementation ChoiseView
@synthesize label=_label;
@synthesize MainDisplay=_MainDisplay;
@synthesize IceCram=_IceCram;
@synthesize IceCreamface=_IceCreamface;
@synthesize hotdog=_hotdog;
@synthesize hotdogface=_hotdogface;
@synthesize pizza=_pizza;
@synthesize pizzaface=_pizzaface;
@synthesize banana=_banana;
@synthesize B5=_B5, B4=_B4, B3=_B3, B2=_B2, B1=_B1;
@synthesize T=_T, T5=_T5, T4=_T4, T3=_T3, T2=_T2, T1=_T1;
@synthesize MonkeyWithTree=_MonkeyWithTree;

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
-(void)move{
    
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

-(void)UnHiddenDemo{
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
    self.MonkeyWithTree.hidden = NO;
}
-(void)ReturnToGameView:(NSTimer *)timer{
    counter = counter-1;
    if(counter <0){
        [timer invalidate];
        self.B3.hidden = YES;

        [self dismissModalViewControllerAnimated:YES];
    }
}

-(void)CountdownToNextDemo:(NSTimer *)timer{
    counter = counter-1;
    if(counter <0){
        [timer invalidate];
        self.B1.hidden = YES;
        self.MonkeyWithTree.image = [UIImage imageNamed:@"M3.png"];
        [self moveImage:self.B3 duration:2.0 curve:UIViewAnimationCurveLinear x:400.0 y:202.5];
        counter = 4;
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(ReturnToGameView:) userInfo:nil repeats:YES];
        
    }
}
-(void) ShowDemo{
    self.label.text = @"We’re going to feed our monkey friends just enough bananas!";
    [self UnHiddenDemo];

    self.MonkeyWithTree.image = [UIImage imageNamed:@"M1.png"];
    [self moveImage:self.B1 duration:2.0 curve:UIViewAnimationCurveLinear x:411.0 y:-15.5];
    NSLog(@"B1 x: %f y:%f", self.B1.center.x, self.B1.center.y );
    NSLog(@"B3 x: %f y:%f", self.B3.center.x, self.B3.center.y );
    NSLog(@"x: %f y:%f", self.MonkeyWithTree.center.x, self.MonkeyWithTree.center.y );
    counter = 4;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(CountdownToNextDemo:) userInfo:nil repeats:YES];
    
    
    
}
-(void)CountdownAndGoBackToGameView:(NSTimer *)timer{
    counter = counter-1;
    if(counter <0){
        [timer invalidate];
        for (UIView *subview in [self.view subviews]) {
            if (subview.tag == 1) {
                [subview removeFromSuperview];
            }
        }
        self.MainDisplay.hidden = YES;
        [self ShowDemo];
        
    }
}
-(void)HideAllPictures{
    self.IceCreamface.hidden = YES;
    self.hotdogface.hidden = YES;
    self.pizzaface.hidden = YES;
    self.pizza.hidden = YES; 
    self.IceCram.hidden = YES;
    self.hotdog.hidden = YES;
    self.banana.hidden = YES;
    self.MainDisplay.hidden = YES;
}
-(void)Hideallfaces{
    self.IceCreamface.hidden = YES;
    self.hotdogface.hidden = YES;
    self.pizzaface.hidden = YES;
}

-(void)animateimage: (UIImageView *)myImageView{
    [UIView animateWithDuration:0
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:(void (^)(void)) ^{
                         
                         myImageView.transform = CGAffineTransformMakeScale(0.01, 0.01);
                     }
                     completion:^(BOOL finished){
                                                myImageView.hidden = NO;
                                                [UIView animateWithDuration:1
                                               delay:0
                                             options:UIViewAnimationOptionBeginFromCurrentState
                                          animations:(void (^)(void)) ^{
                                              myImageView.transform = CGAffineTransformMakeScale(1, 1);
                                          }
                                          completion:^(BOOL finished){
                                              myImageView.transform = CGAffineTransformIdentity;
                                              
                                          }];
                    }];
    
    
    
}
-(void)tapicecream:(UITapGestureRecognizer *)recognizer{
    [self Hideallfaces];
    NSLog(@"icecram");
    //self.IceCreamface.hidden = NO; 
    self.IceCreamface.image = [UIImage imageNamed:@"Sad.png"];
    [self animateimage:self.IceCreamface];
}
-(void)taphotdog:(UITapGestureRecognizer *)recognizer{
    [self Hideallfaces];
    NSLog(@"hd");
    //self.hotdogface.hidden = NO;
    self.hotdogface.image = [UIImage imageNamed:@"Sad.png"];
    [self animateimage:self.hotdogface];

}
-(void)tappizza:(UITapGestureRecognizer *)recognizer{
    [self Hideallfaces];
    NSLog(@"piza");
    //self.pizzaface.hidden = NO;
    self.pizzaface.image = [UIImage imageNamed:@"Sad.png"];
    [self animateimage:self.pizzaface];    
}
-(void)tapbanana:(UITapGestureRecognizer *)recognizer{
    [self HideAllPictures];
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(424, 241, 350, 350)];
    image.image = [UIImage imageNamed:@"Smile.png"];
    image.tag = 1;
    image.hidden = YES;
    [self.view addSubview:image];
    [self animateimage:image];
    //self.MainDisplay.image = [UIImage imageNamed:@"Smile.png"];
    //self.MainDisplay.hidden = YES;
    self.label.text = @"You’re right! We’re going to feed our monkey friends just enough bananas!";
    counter = 4;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(CountdownAndGoBackToGameView:) userInfo:nil repeats:YES];
}
-(void)enableTapping{
    UIGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapicecream:)];
    UIGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taphotdog:)];
    UIGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappizza:)];
    UIGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapbanana:)];
    
    [self.IceCram addGestureRecognizer:tap1];
    [self.hotdog addGestureRecognizer:tap2];
    [self.pizza addGestureRecognizer:tap3];
    [self.banana addGestureRecognizer:tap4];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self enableTapping];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setMainDisplay:nil];
    [self setIceCram:nil];
    [self setIceCreamface:nil];
    [self setHotdog:nil];
    [self setHotdogface:nil];
    [self setPizza:nil];
    [self setPizzaface:nil];
    [self setLabel:nil];
    [self setBanana:nil];
    [self setMonkeyWithTree:nil];
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
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
