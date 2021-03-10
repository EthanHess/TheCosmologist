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

@property UIView *loadingAnimationContainer;
@property UILabel *loadingLabel;
@property NSMutableArray *animationDotArray;

@end

@implementation LoadingAnimationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        [self performSelector:@selector(containerAndSceneSetup) withObject:nil afterDelay:0.25];
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
        
        //Crashes
        //SCNView *sceneView = (SCNView *)self.sceneContainer;
        SCNView *sceneView = [[SCNView alloc]initWithFrame:self.sceneContainer.bounds];
        [self.sceneContainer addSubview:sceneView];
        
        sceneView.scene = self.mainScene;
        sceneView.allowsCameraControl = YES;
        sceneView.showsStatistics = YES;
        sceneView.backgroundColor = [UIColor blackColor];

        //Earth + Moon
        CGFloat size = 0.5;
       // CGFloat orbit = 0;
        
        SCNSphere *earthGeo = [SCNSphere sphereWithRadius:size];
        SCNNode *earthNode = [SCNNode nodeWithGeometry:earthGeo];
        earthNode.geometry.firstMaterial.diffuse.contents = [self shadowColorsForLabel][3];
        
        [self.mainScene.rootNode addChildNode:earthNode];
        
        SCNTorus *geo = [SCNTorus torusWithRingRadius:0.7 pipeRadius:0.01];
        SCNNode *moonOrbitNode = [SCNNode nodeWithGeometry:geo];
        
        [earthNode addChildNode:moonOrbitNode];
        
        [moonOrbitNode runAction:[SCNAction repeatActionForever:[SCNAction rotateByX:0 y:3.2 z:0 duration:1]]];

        SCNSphere *moonGeo = [SCNSphere sphereWithRadius:0.2];
        moonGeo.firstMaterial.diffuse.contents = [self shadowColorsForLabel][4];

        SCNNode *moonNode = [SCNNode nodeWithGeometry:moonGeo];
        [moonOrbitNode addChildNode:moonNode];
        moonNode.position = SCNVector3Make(0.7, 0, 0);

        [self addSubview:self.sceneContainer]; 
        [self labelSetupWithAnimationDots];
    }
}

- (void)labelSetupWithAnimationDots {
    self.animationDotArray = [[NSMutableArray alloc]init];
    
    CGFloat yCoord = self.loadingAnimationContainer.frame.size.height + 40;
    CGFloat width = self.frame.size.width;
    self.loadingAnimationContainer = [[UIView alloc]initWithFrame:CGRectMake(20, yCoord, width - 40, 60)];
    
    //Subviews
    self.loadingLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, self.loadingAnimationContainer.frame.size.width, 30)];
    self.loadingLabel.text = @"LOADING"; //typewriter style?
    self.loadingLabel.textAlignment = NSTextAlignmentCenter;
    self.loadingLabel.textColor = [self shadowColorsForLabel][0];
    [self.loadingAnimationContainer addSubview:self.loadingLabel];
    [self.sceneContainer addSubview:self.loadingAnimationContainer];
    
    for (int i = 0; i < [self shadowColorsForLabel].count; i++) {
        //TODO animate views onscreen
    }
}

//MARK: Is being used around app, make global, D.R.Y.
//Can use category / extension

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
    return CGRectMake(20, 20, width - 40, height - 100);
}

//TODO use layout anchor extension from grammin etc. app

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
