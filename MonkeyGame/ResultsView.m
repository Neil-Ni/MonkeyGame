//
//  ResultsView.m
//  MonkeyGame
//
//  Created by Tzu-Yang Ni on 3/2/12.
//  Copyright (c) 2012 yoseka. All rights reserved.
//

#import "ResultsView.h"
#import "AppDelegate.h"
#import "Name.h"
#import "Score.h"

@implementation ResultsView
@synthesize Delete;

@synthesize NoteTextView;
@synthesize NameTextField;
@synthesize TableView;
@synthesize ScoresTableView;
@synthesize BananaScores=_BananaScores,MonkeyScores=_MonkeyScores, Names=_Names, NamesScore=_NamesScore;
@synthesize app=_app;
@synthesize name;
@synthesize note;
@synthesize SaveButton;
@synthesize ResultNote;
@synthesize EditButton;
@synthesize context=_context;
@synthesize ShowOnlyTheScore;
@synthesize Resultnotelabel;

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}
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

 
-(void)SortTheScore{
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    for(Score *s in self.NamesScore){
        [temp addObject:s.banana];
    }
    NSMutableArray *temp2 = [[NSMutableArray alloc] init];
    for(Score *s in self.NamesScore){
        [temp2 addObject:s.monkey];
    }
    
    NSArray *sortedarray = [temp sortedArrayUsingSelector:@selector(compare:)];
    NSArray *sortedarray2 = [temp2 sortedArrayUsingSelector:@selector(compare:)];
    
    int i;
    for(i=0; i<[sortedarray count]; i++){
        NSLog(@"%d", [[sortedarray objectAtIndex:i] intValue]);
    }
    for(i=0; i<[sortedarray2 count]; i++){
        NSLog(@"%d", [[sortedarray2 objectAtIndex:i] intValue]);
    }
    self.MonkeyScores = [sortedarray2 mutableCopy];
    self.BananaScores = [sortedarray mutableCopy];
}
#pragma mark - View lifecycle

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    

    SaveOnlyOnce = FALSE;
    if(ShowOnlyTheScore == TRUE){
        self.TableView.hidden = YES;
        self.Resultnotelabel.hidden = YES;
        self.Delete.hidden = YES;
        self.EditButton.hidden = YES;
        
    }else{
        self.NameTextField.hidden = YES;
        self.NoteTextView.hidden = YES;
        self.name.hidden = YES;
        self.note.hidden = YES;
        self.SaveButton.hidden = YES;
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *cont = [delegate managedObjectContext];
    
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Name" inManagedObjectContext:cont];
        NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
        NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
        fetch.entity = entity;
        NSError *error;
    
        NSArray *arr = [NSArray arrayWithObject:sort];
    
        [fetch setSortDescriptors:arr];
    
        NSMutableArray *results = [[cont executeFetchRequest:fetch error:&error] mutableCopy];
    
        self.Names = [results mutableCopy];
    
        if(!results){
            NSLog(@"empty");
        }
        for(Name *n in results){
            NSLog(@"%@", n.name);
            NSSet *scoresfromname = n.score;
            self.NamesScore = [[scoresfromname allObjects] copy];
        }
        
    }
    // reload tableview
}


- (void)viewDidUnload
{
    [self setTableView:nil];
    [self setNameTextField:nil];
    [self setNoteTextView:nil];
    [self setBananaScores:nil];
    [self setMonkeyScores:nil];
    [self setNames:nil];
    [self setScoresTableView:nil];
    [self setName:nil];
    [self setNote:nil];
    [self setSaveButton:nil];
    [self setDelete:nil];
    [self setResultNote:nil];
    [self setEditButton:nil];
    [self setResultnotelabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}
//tableView
#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return [self.Names count]==0?[self.Names count]:1;
    return 1;
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(tableView == self.TableView){
        return @"Names";
    }else{
        return @"Scores";
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.TableView){
        return [self.Names count];
    }else{
        return [self.BananaScores count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.TableView){
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.text = [[self.Names objectAtIndex:indexPath.row] name];
        
        return cell;
    }else{
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
        int monkey = [[self.MonkeyScores objectAtIndex:indexPath.row]intValue]%1000;
        int banana = [[self.BananaScores objectAtIndex:indexPath.row] intValue]%1000;
        NSString *content = [[NSString alloc] initWithFormat:@"No.%d Monkey: %i Banana: %i", indexPath.row+1 , monkey, banana];
        NSLog(@"%@", content);
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.text = content;
        return cell;
    }
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedindex = indexPath;
    Name *n = [self.Names objectAtIndex:indexPath.row];
    NSSet *scoresfromname = n.score;
    self.NamesScore = [[scoresfromname allObjects] copy];
    self.ResultNote.text = n.note;
    [self SortTheScore];
    [self.ScoresTableView reloadData];
}

- (IBAction)BackToMainMenu:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)SaveTheResult:(id)sender {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(SaveOnlyOnce == FALSE){
        if(self.NameTextField.text.length >0){
            if([self.BananaScores count] >0){
                NSLog(@"SavingResult");
                NSManagedObjectContext *acontext = [delegate managedObjectContext];
                Name *n = [NSEntityDescription insertNewObjectForEntityForName:@"Name" inManagedObjectContext:acontext];
                n.name = self.NameTextField.text;
                n.note = self.NoteTextView.text;
                NSLog(@"%@", n.name);
                int i;
                for(i=0; i<[self.BananaScores count]; i++){
                    Score *score = (Score *)[NSEntityDescription insertNewObjectForEntityForName:   @"Score" inManagedObjectContext:acontext];
                    int temp = [[self.BananaScores objectAtIndex:i] intValue] + i*1000;
                    int temp2 = [[self.MonkeyScores objectAtIndex:i] intValue] + i*1000;
                
                    NSLog(@"%d", temp);
                    score.banana = [NSNumber numberWithInt:temp];
                    score.monkey = [NSNumber numberWithInt:temp2];                 
                    score.name = n;
                }
            }else{
                NSLog(@"Not Saving the Result because no scores was recorded.");
            }
        }
        delegate.BananaScores = self.BananaScores;  
        delegate.MonkeyScores = self.MonkeyScores;
    }else{
        
    }
    
    SaveOnlyOnce = TRUE;    
}

- (IBAction)DeleteTheResult:(id)sender {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *acontext = [delegate managedObjectContext];
    Name *n = [self.Names objectAtIndex:selectedindex.row];
    [acontext deleteObject:n];
    self.ResultNote.text = nil;
    [self.TableView reloadData];
    self.BananaScores = nil;
    self.MonkeyScores = nil;
    [self.ScoresTableView reloadData];
}
- (IBAction)EditTheResult:(id)sender {
        self.Resultnotelabel.hidden = NO;
        self.NameTextField.hidden = NO;
        self.NoteTextView.hidden = NO;
        self.name.hidden = NO;
        self.note.hidden = NO;
        self.SaveButton.hidden = NO;
    self.EditButton.hidden = YES;

    
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *acontext = [delegate managedObjectContext];
        Name *n = [self.Names objectAtIndex:selectedindex.row];
        [acontext deleteObject:n];
        
}

@end
