//
//  ResultsView.h
//  MonkeyGame
//
//  Created by Tzu-Yang Ni on 3/2/12.
//  Copyright (c) 2012 yoseka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"



@interface ResultsView : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate> {
    NSMutableArray *MonkeyScores;
    NSMutableArray *BananaScores;
    NSMutableArray *Names;
    NSMutableArray *NamesScore;
    BOOL ShowOnlyTheScore;
    BOOL SaveOnlyOnce;
    NSIndexPath *selectedindex;

}
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *note;
@property (strong, nonatomic) IBOutlet UIButton *SaveButton;
@property (strong, nonatomic) IBOutlet UILabel *ResultNote;
@property (strong, nonatomic) IBOutlet UIButton *EditButton;

@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) AppDelegate *app;
@property (strong, nonatomic) IBOutlet UITextView *NoteTextView;
@property (strong, nonatomic) IBOutlet UITextField *NameTextField;
@property (strong, nonatomic) IBOutlet UITableView *TableView;
@property (strong, nonatomic) IBOutlet UITableView *ScoresTableView;
@property (strong, nonatomic) NSMutableArray *MonkeyScores;
@property (strong, nonatomic) NSMutableArray *BananaScores;
@property (strong, nonatomic) NSMutableArray *Names;
@property (strong, nonatomic) NSMutableArray *NamesScore;
@property BOOL ShowOnlyTheScore;
@property (strong, nonatomic) IBOutlet UILabel *Resultnotelabel;

- (IBAction)EditTheResult:(id)sender;
- (IBAction)SaveTheResult:(id)sender;
- (IBAction)BackToMainMenu:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *Delete;
- (IBAction)DeleteTheResult:(id)sender;


@end
