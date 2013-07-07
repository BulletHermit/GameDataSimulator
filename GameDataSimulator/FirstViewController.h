//
//  FirstViewController.h
//  GameDataSimulator
//
//  Created by Akira on 13-7-3.
//  Copyright (c) 2013年 Nothing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConventionFormula.h"


@interface FirstViewController : UIViewController
{

    NSString* resultString;
    ConventionFormula* conventionFormula;
    int round;
    bool isStrikeback;
    
}
@property (strong,nonatomic) IBOutlet UITextView* result;

@property (strong,nonatomic) IBOutlet UITextField* offStrength;
@property (strong,nonatomic) IBOutlet UITextField* offAgility;
@property (strong,nonatomic) IBOutlet UITextField* offWillpower;
@property (strong,nonatomic) IBOutlet UITextField* offLuck;
@property (strong,nonatomic) IBOutlet UITextField* offMagicalAttack;
@property (strong,nonatomic) IBOutlet UILabel* offHP;
@property (strong,nonatomic) IBOutlet UILabel* offMP;
@property (strong,nonatomic) IBOutlet UILabel* offState;

@property (strong,nonatomic) IBOutlet UITextField* defStrength;
@property (strong,nonatomic) IBOutlet UITextField* defAgility;
@property (strong,nonatomic) IBOutlet UITextField* defWillpower;
@property (strong,nonatomic) IBOutlet UITextField* defLuck;
@property (strong,nonatomic) IBOutlet UITextField* defMagicalAttack;
@property (strong,nonatomic) IBOutlet UILabel* defHP;
@property (strong,nonatomic) IBOutlet UILabel* defMP;
@property (strong,nonatomic) IBOutlet UILabel* defState;

@end
