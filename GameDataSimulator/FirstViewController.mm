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
@synthesize offLevel,offAgility,offHP,offLuck,offMagicalAttack,offMP,offState,offStrength,offWillpower;
@synthesize defLevel,defAgility,defHP,defLuck,defMagicalAttack,defMP,defState,defStrength,defWillpower;
@synthesize result;

- (void)viewDidLoad
{
    [super viewDidLoad];
    offRole=[[Role alloc] init] ;
    defRole = [[Role alloc] init];
    resultString = @"战斗开始！\n";
    isStrikeback=YES;
    round=1;
	// Do ny additional setup after loading the view, typically from a nib.

    
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

    float offMSTR =offRole.MSTR;
    
    float actualATK = offMAG*offMSTR;

    //4.the value minus magical defend to get the delta HP

    float defMDEF=defRole.MDEF;
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
    [offRole resetHPMP];
    [defRole resetHPMP];
    offHP.text=[NSString stringWithFormat:@"%d",offRole.HP];
    defHP.text= [NSString stringWithFormat:@"%d",defRole.HP];
    offMP.text= [NSString stringWithFormat:@"%d",offRole.MP];
    defMP.text= [NSString stringWithFormat:@"%d",defRole.MP];
    round=1;
}
-(IBAction)setAttribute:(id)sender
{
    float offInitLv = [offLevel.text floatValue];
    float offInitSTR = [offStrength.text floatValue];
    float offInitAGI =[offAgility.text floatValue];
    float offInitWIL= [offWillpower.text floatValue];
    float offInitLuc = [offLuck.text floatValue];
    [offRole setInitDataWithLevel:offInitLv str:offInitSTR agi:offInitAGI wil:offInitWIL luc:offInitLuc];
    
    float defInitLv = [defLevel.text floatValue];
    float defInitSTR = [defStrength.text floatValue];
    float defInitAGI =[defAgility.text floatValue];
    float defInitWIL=[defWillpower.text floatValue];
    float defInitLuc = [defLuck.text floatValue];
    [defRole setInitDataWithLevel:defInitLv str:defInitSTR agi:defInitAGI wil:defInitWIL luc:defInitLuc];
    
    [self updateAttribute];
    
    
}
-(IBAction)displayOff:(id)sender
{

    
    NSString* string = [NSString stringWithFormat:@"ATK:%d   CRI:%f   HPR:%d \nDEF:%d   Ev:%f   CRIR:%f\nMDEF:%d   MSTR:%d",offRole.ATK,offRole.CRI,offRole.HPR,offRole.DEF,offRole.Ev,offRole.CRIR,offRole.MDEF,offRole.MSTR];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Offensive" message:string delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
}
-(IBAction)displayDef:(id)sender
{
    NSString* string = [NSString stringWithFormat:@"ATK:%d   CRI:%f   HPR:%d \nDEF:%d   Ev:%f   CRIR:%f\nMDEF:%d   MSTR:%d",defRole.ATK,defRole.CRI,defRole.HPR,defRole.DEF,defRole.Ev,defRole.CRIR,defRole.MDEF,defRole.MSTR];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Defensive" message:string delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
#pragma Helper
-(void) updateAttribute
{
    offHP.text=[NSString stringWithFormat:@"%d",offRole.HP];
    defHP.text= [NSString stringWithFormat:@"%d",defRole.HP];
    offMP.text= [NSString stringWithFormat:@"%d",offRole.MP];
    defMP.text= [NSString stringWithFormat:@"%d",defRole.MP];
    
    offLevel.text = [NSString stringWithFormat:@"%d",offRole.LV];
    offStrength.text = [NSString stringWithFormat:@"%d",offRole.STR];
    offAgility.text = [NSString stringWithFormat:@"%d",offRole.AGI];
    offWillpower.text = [NSString stringWithFormat:@"%d",offRole.WIL];
    offLuck.text = [NSString stringWithFormat:@"%d",offRole.LUCK];
    
    defLevel.text = [NSString stringWithFormat:@"%d",defRole.LV];
    defStrength.text = [NSString stringWithFormat:@"%d",defRole.STR];
   defAgility.text = [NSString stringWithFormat:@"%d",defRole.AGI];
    defWillpower.text = [NSString stringWithFormat:@"%d",defRole.WIL];
    defLuck.text = [NSString stringWithFormat:@"%d",defRole.LUCK];
}
-(void) strike
{
    //1.judge the evsion
    
    float defEv = defRole.Ev/100.0;
    
    float random = arc4random()%100/100.0;
    
    if (random <=defEv) {
        
        resultString=[resultString stringByAppendingFormat:@"\n守方闪避了攻方的普通攻击"];
        result.text = resultString;
        return;
    }
    
    //2.get attack value
    
    float offATK = offRole.ATK;
    float actualATK = offATK;
    //3.judge the crical attack
    random = arc4random()%100/100.0;
    float offCRI_R = offRole.CRIR/100.0;
    NSLog(@"offCir_r:%.2f",offCRI_R);
    NSLog(@"%.2f",random);
    if (random<=offCRI_R) {
        float offCRI = offRole.CRI;
        actualATK = actualATK*offCRI/100.0;
        resultString=[resultString stringByAppendingFormat:@"\n攻方暴击：%.2f",actualATK];
    }
    else
    {
        resultString=[resultString stringByAppendingFormat:@"\n攻方普通攻击：%.2f",actualATK ];
        
    }
    
    //4.the value minus defend to get the delta HP
    float defDEF=defRole.DEF;
    //require a float value judged by weapon or kit
    float deltaHP =( actualATK - defDEF*10)*2;
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
    
    float offEv = offRole.Ev/100.0;
    float random = arc4random()%100/100.0;
    
    if (random <=offEv) {
        
        resultString=[resultString stringByAppendingFormat:@"\n攻方闪避了攻方的普通攻击"];
        result.text = resultString;
        return;
    }
    
    //2.get attack value
    
    float defATK = defRole.ATK;
    float actualATK = defATK;
    //3.judge the crical attack
    random = arc4random()%100/100.0;
    
    float defCRI_R = defRole.CRIR/100.0;
    
    if (random<=defCRI_R) {
        float defCRI = defRole.CRI;
        actualATK = actualATK*defCRI/100.0;
        resultString=[resultString stringByAppendingFormat:@"\n守方暴击：%.2f",actualATK];
    }
    else
    {
        resultString=[resultString stringByAppendingFormat:@"\n守方普通攻击：%.2f",actualATK ];
        
    }
    
    //4.the value minus defend to get the delta HP
    float offDEF=offRole.DEF;
    float deltaHP = (actualATK*decayRatio - offDEF*10)*2;
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
