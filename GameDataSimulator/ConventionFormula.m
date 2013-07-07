//
//  ConventionFormula.m
//  GameDataSimulator
//
//  Created by Akira on 13-7-5.
//  Copyright (c) 2013年 Nothing. All rights reserved.
//

#import "ConventionFormula.h"

@implementation ConventionFormula
-(float) HPFromStength:(float)strength
{
    return strength*20;
}
-(float) HPRFromStength:(float)strength
{
    return strength*0.1;
}
-(float) CRIFromStrength:(float)strength
{
    return 1+strength*0.02;
}
-(float) ATKFromStrength:(float)strength
{
    return strength*15;
}


-(float) DEFFromAgility:(float)agility
{
    return agility*10;
}
-(float) EvFromAgility:(float)agility
{
    return agility*0.6/AGIMAX;
}
-(float) CRI_RFromAgility:(float)agility
{
    return agility*0.8/AGIMAX;
}

-(float) MDEFFromWillpower:(float)willpower
{
    return willpower*15;
}
-(float) MATKFromWillpower:(float)willpower
{
    return 1+willpower*0.02;
}
-(float) MPFromWillpower:(float)willpower
{
    return willpower*20;
}
@end
