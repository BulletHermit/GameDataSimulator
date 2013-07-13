//
//  Role.m
//  GameDataSimulator
//
//  Created by Akira on 13-7-5.
//  Copyright (c) 2013年 Nothing. All rights reserved.
//

#import "Role.h"

@implementation Role
@synthesize LV,STR,AGI,WIL,LUCK,HP,HPR,ATK,CRI,DEF,Ev,CRIR,MDEF,MP,MSTR;
-(id)init
{
    if (self = [super init]) {
        STRArray = new int[99];
        AGIArray = new int[99];
        WILArray = new int[99];
    }
    return self;
}
-(void) setInitDataWithLevel:(int )lv str:(int)s agi:(int)a wil:(int)w luc:(int)l
{
    LV = lv;
    LUCK = l;
    
    STRArray[0]=s;
    AGIArray[0] = a;
    WILArray[0] = w;
    
    
    for (int lv=1; lv<=99; ++lv) {
        STRArray[lv]= STRArray[lv -1] + (((log(lv)/log(10)))/100)*(STRArray[lv - 1]*(100-lv/7)/100) + 3;
        AGIArray[lv] =  AGIArray[lv-1] + (((log(lv+1)/log(10)))/100)*( AGIArray[lv-1]*(100-(lv+1)/7)/100) + 3;
        //Willpower array
        WILArray[lv] = WILArray[lv -1] + (((log(lv)/log(10)))/100)*(WILArray[lv - 1]*(100-lv/7)/100) + 3;
        
    }
    
    STR = [self STRFromLevel:lv];
    AGI = [self AGIFromLevel:lv];
    WIL  = [self WILFromLevel:lv];
    
    HP = [self HPFromStength:STR];
    HPR = [self HPFromStength:STR];
    ATK = [self ATKFromStrength:STR];
    CRI = [self CRIFromStrength:STR];
    
    DEF = [self DEFFromAgility:AGI];
    Ev = [self EvFromAgility:AGI];
    CRIR = [self CRI_RFromAgility:AGI];
    
    MDEF = [self MDEFFromWillpower:WIL];
    MSTR = [self MSTRFromWillpower:WIL];
    MP = [self MPFromWillpower:WIL];
}
-(void) resetHPMP
{
        HP = [self HPFromStength:STR];
    MP = [self MPFromWillpower:WIL];
}

-(int) STRFromLevel:(int)level
{
    if (level>=1 && level<= 99) {
        return STRArray[level];
    }
    NSLog(@"level isn't excepted");
    return 0;
}
-(float) HPFromStength:(float)strength
{
    return round(strength/1.3)+50;
}
-(float) HPRFromStength:(float)strength
{
    return ((((log(LV)/log(10)))/100)*(STRArray[LV-1]*(100-LV/7)/100) + 3);
}
-(float) CRIFromStrength:(float)strength
{
    return 120 + (strength - 100)/10;
}
-(float) ATKFromStrength:(float)strength
{
    return (strength - 2*LV)/4;
}


-(int) AGIFromLevel:(int) level
{
    if (level>=1 && level<= 99) {
        return AGIArray[level];
    }
    NSLog(@"level isn't excepted");
    return 0;
}
-(float) DEFFromAgility:(float)agility
{
    return agility/50;
}
-(float) EvFromAgility:(float)agility
{
    return agility/45;
}
-(float) CRI_RFromAgility:(float)agility
{
    return (agility/1300)*100;
}

-(int) WILFromLevel:(int) level
{
    if (level>=1 && level<= 99) {
        return WILArray[level];
    }
    NSLog(@"level isn't excepted");
    return 0;
}
-(float) MDEFFromWillpower:(float)willpower
{
    return willpower/10;
}
-(float) MSTRFromWillpower:(float)willpower
{
    return (willpower-LV*4)/4;
}
-(float) MPFromWillpower:(float)willpower
{
    return pow(willpower,2)/1000+20;
}

@end
