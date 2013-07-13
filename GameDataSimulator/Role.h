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
#define LVMAX 99;
@interface Role : NSObject
{
    int *STRArray;
    int *AGIArray;
    int *WILArray;
    
    int LV;
    
    int STR;
    int HP;
    int HPR;
    float CRI;
    int ATK;
    
    int AGI;
    int DEF;
    float Ev;
    float CRIR;
    
    int WIL;
    int MDEF;
    int MSTR;
    int MP;
    
    int LUCK;
    
}

-(void) setInitDataWithLevel:(int )lv str:(int)s agi:(int)a wil:(int)w luc:(int)l;
-(void) resetHPMP;
@property (nonatomic,assign) int LV;
@property (nonatomic,assign) int STR;
@property (nonatomic,assign) int HP;
@property (nonatomic,assign) int HPR;
@property (nonatomic,assign) float CRI;
@property (nonatomic,assign) int ATK;

@property (nonatomic,assign) int AGI;
@property (nonatomic,assign) int DEF;
@property (nonatomic,assign) float Ev;
@property (nonatomic,assign) float CRIR;

@property (nonatomic,assign) int WIL;
@property (nonatomic,assign) int MDEF;
@property (nonatomic,assign) int MSTR;
@property (nonatomic,assign) int MP;

@property (nonatomic,assign) int LUCK;




@end
