//
//  MainView.m
//  MonkeyGame
//
//  Created by Tzu-Yang Ni on 3/2/12.
//  Copyright (c) 2012 yoseka. All rights reserved.
//

#import "MainView.h"
#import "GameView.h"
#import "ResultsView.h"

@implementation MainView


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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{

    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (IBAction)LoadGame:(id)sender {
    GameView *aGameView = [[GameView alloc] initWithNibName:@"GameView" bundle:nil];
    [self.navigationController pushViewController:aGameView animated:YES];
}

- (IBAction)ViewResult:(id)sender {
    ResultsView *aResultView =  [[ResultsView alloc] initWithNibName:@"ResultsView" bundle:nil];
    aResultView.ShowOnlyTheScore = FALSE;
    [self.navigationController pushViewController:aResultView animated:YES];

}

- (IBAction)LoadGameWithoutDemo:(id)sender {
    GameView *aGameView = [[GameView alloc] initWithNibName:@"GameView" bundle:nil];
    aGameView.DemoAlreadyShown = TRUE;
    aGameView.DoneTheFirstTwoTrials = TRUE;
    [self.navigationController pushViewController:aGameView animated:YES];
}
@end
