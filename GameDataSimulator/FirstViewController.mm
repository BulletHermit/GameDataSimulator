//
//  FirstViewController.m
//  GameDataSimulator
//
//  Created by Akira on 13-7-3.
//  Copyright (c) 2013年 Nothing. All rights reserved.
//

#import "FirstViewController.h"

#define decayRatio 0.9
@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize offAgility,offHP,offLuck,offMagicalAttack,offMP,offState,offStrength,offWillpower;
@synthesize defAgility,defHP,defLuck,defMagicalAttack,defMP,defState,defStrength,defWillpower;
@synthesize result;

- (void)viewDidLoad
{
    [super viewDidLoad];
    conventionFormula=[[ConventionFormula alloc] init] ;
    resultString = @"战斗开始！\n";
    isStrikeback=YES;
    round=1;
	// Do ny additional setup after loading the view, typically from a nib.
    offStrength.text=[NSString stringWithFormat:@"15"];
    offWillpower.text=[NSString stringWithFormat:@"15"];
    offAgility.text=[NSString stringWithFormat:@"15"];
    offLuck.text=[NSString stringWithFormat:@"15"];
    offMagicalAttack.text=[NSString stringWithFormat:@"15"];
    
    defStrength.text=[NSString stringWithFormat:@"15"];
    defWillpower.text=[NSString stringWithFormat:@"15"];
    defAgility.text=[NSString stringWithFormat:@"15"];
    defLuck.text=[NSString stringWithFormat:@"15"];
    defMagicalAttack.text=[NSString stringWithFormat:@"15"];
    
    offHP.text= [NSString stringWithFormat:@"%.1f",[conventionFormula HPFromStength:15]];
    defHP.text= [NSString stringWithFormat:@"%.1f",[conventionFormula HPFromStength:15]];
    offMP.text= [NSString stringWithFormat:@"%.1f",[conventionFormula HPFromStength:15]];
    defMP.text= [NSString stringWithFormat:@"%.1f",[conventionFormula HPFromStength:15]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)attack:(id)sender
{
    resultString = [resultString stringByAppendingFormat:@"\n第%d回合",round++];
    //1.offensive strike
    [self strike];

    
    //2.defender strike
    if (isStrikeback && [defHP.text floatValue]>0) {
        [self strikeback];
    }
}
-(void) strike
{
    //1.judge the evsion
    float defAGI = [defAgility.text floatValue];
    float defEv = [conventionFormula EvFromAgility:defAGI];
    float random = arc4random()%100/100.0;
    
    if (random <=defEv) {
        
        resultString=[resultString stringByAppendingFormat:@"\n守方闪避了攻方的普通攻击"];
        result.text = resultString;
        return;
    }
    
    //2.get attack value
    float offSTR = [offStrength.text floatValue];
    float offATK = [conventionFormula ATKFromStrength:offSTR];
    float actualATK = offATK;
    //3.judge the crical attack
    random = arc4random()%100/100.0;
    float offAGI = [offAgility.text floatValue];
    float offCRI_R = [conventionFormula CRI_RFromAgility:offAGI];
    NSLog(@"offCir_r:%.2f",offCRI_R);
    NSLog(@"%.2f",random);
    if (random<=offCRI_R) {
        float offCRI = [conventionFormula CRIFromStrength:offSTR];
        actualATK = actualATK*offCRI;
        resultString=[resultString stringByAppendingFormat:@"\n攻方暴击：%.2f",actualATK];
    }
    else
    {
        resultString=[resultString stringByAppendingFormat:@"\n攻方普通攻击：%.2f",actualATK ];
        
    }
    
    //4.the value minus defend to get the delta HP
    float defDEF=[conventionFormula DEFFromAgility:defAGI];
    float deltaHP = actualATK - defDEF;
    if (deltaHP<0) {
        deltaHP=0;
    }
    resultString=[resultString stringByAppendingFormat:@"\n攻方伤害：%.2f,守方防御:%.2f",actualATK,defDEF];
    
    //5.get the current HP
    float curHP=[defHP.text floatValue] - deltaHP;
    if (curHP<=0) {
        resultString = [resultString stringByAppendingFormat:@"\n守方翘辫子" ];
        result.text = resultString;
        defHP.text = [NSString stringWithFormat:@"0" ];
        return;
    }
    defHP.text = [NSString stringWithFormat:@"%f",curHP ];
    resultString = [resultString stringByAppendingFormat:@"\n守方减血：%.2f",deltaHP ];
    result.text = resultString;
}
-(void) strikeback
{
    resultString=[resultString stringByAppendingFormat:@"\n守方反击！"];
    //1.judge the defender evsion
    float offAGI = [offAgility.text floatValue];
    float offEv = [conventionFormula EvFromAgility:offAGI];
    float random = arc4random()%100/100.0;
    
    if (random <=offEv) {
        
        resultString=[resultString stringByAppendingFormat:@"\n攻方闪避了攻方的普通攻击"];
        result.text = resultString;
        return;
    }
    
    //2.get attack value
    float defSTR = [defStrength.text floatValue];
    float defATK = [conventionFormula ATKFromStrength:defSTR];
    float actualATK = defATK;
    //3.judge the crical attack
    random = arc4random()%100/100.0;
    float defAGI = [defAgility.text floatValue];
    float defCRI_R = [conventionFormula CRI_RFromAgility:defAGI];

    if (random<=defCRI_R) {
        float defCRI = [conventionFormula CRIFromStrength:defSTR];
        actualATK = actualATK*defCRI;
        resultString=[resultString stringByAppendingFormat:@"\n守方暴击：%.2f",actualATK];
    }
    else
    {
        resultString=[resultString stringByAppendingFormat:@"\n守方普通攻击：%.2f",actualATK ];
        
    }
    
    //4.the value minus defend to get the delta HP
    float offDEF=[conventionFormula DEFFromAgility:offAGI];
    float deltaHP = actualATK*decayRatio - offDEF;
    if (deltaHP<0) {
        deltaHP=0;
    }
    resultString=[resultString stringByAppendingFormat:@"\n守方反击伤害：%.2f,攻方防御:%.2f",actualATK*decayRatio,offDEF];
    
    //5.get the current HP
    float curHP=[offHP.text floatValue] - deltaHP;
    if (curHP<=0) {
        resultString = [resultString stringByAppendingFormat:@"\n攻方翘辫子" ];
        result.text = resultString;
        offHP.text = [NSString stringWithFormat:@"0" ];
        return;
    }
    offHP.text = [NSString stringWithFormat:@"%f",curHP ];
    resultString = [resultString stringByAppendingFormat:@"\n攻方减血：%.2f",deltaHP ];
    result.text = resultString;

}
-(IBAction)magicalAttack:(id)sender
{

    //1.determine whether you have a magic
    float offMAG=[offMagicalAttack.text floatValue];
    if (offMAG<=0) {
        resultString=[resultString stringByAppendingFormat:@"\n魔法攻击，总要给个魔法吧~~亲~"];
        result.text = resultString;
        return;
    }
    //2.Determine whether MP remaining quantity release the magic（20 pre）
    if ([offMP.text floatValue]<=0) {
        resultString=[resultString stringByAppendingFormat:@"\n没魔了，你看着办"];
        result.text = resultString;
        return;
    }
        resultString = [resultString stringByAppendingFormat:@"\n第%d回合",round++];
    //3.get the MATK value and composite
    float offWIL = [offWillpower.text floatValue];
    float offMATK = [conventionFormula MATKFromWillpower:offWIL];
    
    float actualATK = offMAG*offMATK;

    //4.the value minus magical defend to get the delta HP
    float defWIL = [defWillpower.text floatValue];
    float defMDEF=[conventionFormula MDEFFromWillpower:defWIL];
    float deltaHP = actualATK - defMDEF;
    if (deltaHP<0) {
        deltaHP=0;
    }
    resultString=[resultString stringByAppendingFormat:@"\n攻方魔法伤害：%.2f,守方魔法防御:%.2f",actualATK,defMDEF];
    
    //5.get the current HP
    float curHP=[defHP.text floatValue] - deltaHP;
    if (curHP<=0) {
        resultString = [resultString stringByAppendingFormat:@"\n守方翘辫子" ];
        result.text = resultString;
        defHP.text = [NSString stringWithFormat:@"0" ];
        return;
    }
    defHP.text = [NSString stringWithFormat:@"%f",curHP ];
    resultString = [resultString stringByAppendingFormat:@"\n守方减血：%.2f",deltaHP ];
    result.text = resultString;

    
}

-(IBAction)resetBattle:(id)sender
{
    resultString=@"奇奇怪怪的东西又要来了哟~";
    result.text = resultString;
    float offStr = [offStrength.text floatValue];
    float offWIL= [offWillpower.text floatValue];
    float defStr = [defStrength.text floatValue];
    float defWIL=[defWillpower.text floatValue];
    offHP.text= [NSString stringWithFormat:@"%.1f",[conventionFormula HPFromStength:offStr]];
    defHP.text= [NSString stringWithFormat:@"%.1f",[conventionFormula HPFromStength:defStr]];
    offMP.text= [NSString stringWithFormat:@"%.1f",[conventionFormula HPFromStength:offWIL]];
    defMP.text= [NSString stringWithFormat:@"%.1f",[conventionFormula HPFromStength:defWIL]];
    round=1;
}
// 触摸背景，关闭键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    UIView *view = (UIView *)[touch view];
    if (view == self.view) {
        [offStrength resignFirstResponder];
        [offWillpower resignFirstResponder];
        [offAgility resignFirstResponder];
        [offLuck resignFirstResponder];
        [offMagicalAttack resignFirstResponder];
        
        [defStrength resignFirstResponder];
        [defWillpower resignFirstResponder];
        [defAgility resignFirstResponder];
        [defLuck resignFirstResponder];
        [defMagicalAttack resignFirstResponder];
    }
}

@end
