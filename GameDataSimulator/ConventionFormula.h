//
//  ConventionFormula.h
//  GameDataSimulator
//
//  Created by Akira on 13-7-5.
//  Copyright (c) 2013年 Nothing. All rights reserved.
//

#import <Foundation/Foundation.h>
#define STRMAX 100.0;
#define AGIMAX 100.0;
#define WILMAX 100.0;
#define LUCKMAX 100.0;
@interface ConventionFormula : NSObject
-(float) HPFromStength:(float)strength;
-(float) HPRFromStength:(float)strength;
-(float) CRIFromStrength:(float)strength;
-(float) ATKFromStrength:(float)strength;

-(float) DEFFromAgility:(float)agility;
-(float) EvFromAgility:(float)agility;
-(float) CRI_RFromAgility:(float)agility;

-(float) MDEFFromWillpower:(float)willpower;
-(float) MATKFromWillpower:(float)willpower;
-(float) MPFromWillpower:(float)willpower;
@end
