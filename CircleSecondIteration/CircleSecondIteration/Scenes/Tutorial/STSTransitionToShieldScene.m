//
//  STSTransitionToShieldScene.m
//  Ozone!
//
//  Created by Yujun Cho on 6/2/14.
//  Copyright (c) 2014 SummaTime Studio. All rights reserved.
//

#import "STSTransitionToShieldScene.h"
#import "STSObtainShieldScene.h"

@implementation STSTransitionToShieldScene

- (id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.scene.scaleMode = SKSceneScaleModeAspectFill;
        self.backgroundColor = [SKColor colorWithRed:240.0 / 255.0
                                               green:241.0 / 255.0
                                                blue:238.0 / 255.0
                                               alpha:1.0];
        [self addText];
        [self addObtainShieldButton];
    }

    return self;
}

- (void)addText{
    //initialize first line of message
    SKLabelNode *messageOuch = [SKLabelNode labelNodeWithFontNamed:@"HelveticaNeue-Light"];
    messageOuch.fontColor = [SKColor blackColor];
    messageOuch.fontSize = 16.0;
    messageOuch.text = @"Red dots hurt Ozone.";
    messageOuch.position = CGPointMake(self.size.width / 2, self.size.height / 2 + 50);
    
    //initialize second line of message
    SKLabelNode *messageNeedShields = [SKLabelNode labelNodeWithFontNamed:@"HelveticaNeue-Light"];
    messageNeedShields.fontColor = [SKColor blackColor];
    messageNeedShields.fontSize = 16.0;
    messageNeedShields.text = @"We'll need some shields.";
    messageNeedShields.position = CGPointMake(messageOuch.position.x, messageOuch.position.y - 20);
    
    //add the message to the scene
    [self addChild:messageOuch];
    [self addChild:messageNeedShields];
}

- (void)addObtainShieldButton {
    //pretend the message says "Obtain Shield"
    SKSpriteNode *obtainShields = [SKSpriteNode spriteNodeWithImageNamed:@"Resume.png"];
    obtainShields.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    obtainShields.name = @"obtainShield";
    [self addChild:obtainShields];
}

#pragma mark - transitions

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    //logic to change scenes when button is pressed
    if ([node.name isEqualToString:@"obtainShield"]) {
        SKColor *obtainShieldSceneBackgroundColor = [SKColor colorWithRed:245.0 / 255.0
                                                                    green:144.0 / 255.0
                                                                     blue:68.0 / 255.0
                                                                    alpha:1.0];
        SKSpriteNode *background = [[SKSpriteNode alloc] initWithColor:obtainShieldSceneBackgroundColor
                                                                  size:self.size];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        background.alpha = 0.0;
        [self addChild:background];
        SKAction *fadeBackgroundIn = [SKAction fadeAlphaTo:1.0 duration:1.0];
        [background runAction:fadeBackgroundIn completion:^{
            SKTransition *fade = [SKTransition fadeWithColor:obtainShieldSceneBackgroundColor
                                                    duration:0.5];
            STSObtainShieldScene *newObtainShieldScene = [[STSObtainShieldScene alloc]
                                                                      initWithSize:self.size];
            [self.view presentScene:newObtainShieldScene transition:fade];
        }];
    }
}

@end
