//
//  LoadingAnimationView.m
//  Cosmologist
//
//  Created by Ethan Hess on 3/3/21.
//  Copyright © 2021 Ethan Hess. All rights reserved.
//

#import "LoadingAnimationView.h"
#import <SceneKit/SceneKit.h>

//MARK: Private properties
@interface LoadingAnimationView()

@property SCNScene *mainScene;

//Scene container
@property UIView *sceneContainer;

@end

@implementation LoadingAnimationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        [self containerAndSceneSetup];
    }
    return self;
}

- (void)shimmerAnimation {
    
}

- (void)containerAndSceneSetup {
    if (self.sceneContainer == nil) {
        self.sceneContainer = [[UIView alloc]initWithFrame:[self sceneContainerFrame]];
        
        //NOTE: May be no reason to make global
        self.mainScene = [SCNScene scene];
        
        //Camera node
        SCNNode *cameraNode = [SCNNode node];
        SCNCamera *camera = [SCNCamera camera];
        cameraNode.camera = camera;
        [self.mainScene.rootNode addChildNode:cameraNode];
        
        //Camera position
        cameraNode.position = SCNVector3Make(0, 0, 15);
        
        SCNNode *lightNode = [SCNNode node];
        lightNode.light = [SCNLight light];
        lightNode.light.type = SCNLightTypeOmni;
        lightNode.position = SCNVector3Make(0, 10, 10);
        [self.mainScene.rootNode addChildNode:lightNode];
                
        SCNNode *ambientNode = [SCNNode node];
        ambientNode.light = [SCNLight light];
        ambientNode.light.type = SCNLightTypeAmbient;
        ambientNode.light.color = [UIColor whiteColor]; //Change? Custom
        [self.mainScene.rootNode addChildNode:ambientNode];
        
        SCNView *sceneView = (SCNView *)self.sceneContainer;
        
        sceneView.scene = self.mainScene;
        sceneView.allowsCameraControl = YES;
        sceneView.showsStatistics = YES;
        sceneView.backgroundColor = [self shadowColorsForLabel][0];

        //TODO add earth / moon rotation animation
    }
}

//MARK: Is being used around app, make global, D.R.Y.
- (NSArray *)shadowColorsForLabel {
    UIColor *colorOne = [UIColor colorWithRed:124.0f/255.0f green:247.0f/255.0f blue:252.0f/255.0f alpha:1.0];
    UIColor *colorTwo = [UIColor colorWithRed:124.0f/255.0f green:252.0f/255.0f blue:230.0f/255.0f alpha:1.0];
    UIColor *colorThree = [UIColor colorWithRed:124.0f/255.0f green:199.0f/255.0f blue:252.0f/255.0f alpha:1.0];
    UIColor *colorFour = [UIColor colorWithRed:13.0f/255.0f green:236.0f/255.0f blue:194.0f/255.0f alpha:1.0];
    UIColor *colorFive = [UIColor colorWithRed:13.0f/255.0f green:126.0f/255.0f blue:236.0f/255.0f alpha:1.0];
    UIColor *colorSix = [UIColor colorWithRed:176.0f/255.0f green:175.0f/255.0f blue:248.0f/255.0f alpha:1.0];
    UIColor *colorSeven = [UIColor colorWithRed:227.0f/255.0f green:175.0f/255.0f blue:248.0f/255.0f alpha:1.0];
    UIColor *colorEight = [UIColor colorWithRed:246.0f/255.0f green:101.0f/255.0f blue:159.0f/255.0f alpha:1.0];
    return @[colorOne, colorTwo, colorThree, colorFour, colorFive, colorSix, colorSeven, colorEight];
}

- (CGRect)sceneContainerFrame {
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    return CGRectMake(20, 20, width - 40, height - 40);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
