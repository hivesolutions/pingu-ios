// Hive Pingu Service
// Copyright (c) 2008-2017 Hive Solutions Lda.
//
// This file is part of Hive Pingu Service.
//
// Hive Pingu Service is free software: you can redistribute it and/or modify
// it under the terms of the Apache License as published by the Apache
// Foundation, either version 2.0 of the License, or (at your option) any
// later version.
//
// Hive Pingu Service is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// Apache License for more details.
//
// You should have received a copy of the Apache License along with
// Hive Pingu Service. If not, see <http://www.apache.org/licenses/>.

// __author__    = João Magalhães <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision$
// __date__      = $LastChangedDate$
// __copyright__ = Copyright (c) 2008-2017 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

#import "FlipView.h"

#import "StatusViewController.h"

@implementation FlipView

static int backViewWidth = 640;
static int backViewHeight = 640;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.up = NO;
        self.pending = NO;

        self.frontView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tobias.jpg"]];
        StatusViewController *statusViewController = [[StatusViewController alloc] initWithNibName:@"StatusViewControllerIpad" bundle:nil];
        self.backView = statusViewController.view;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        self.up = NO;
        self.pending = NO;
    }
    return self;
}

- (void)didMoveToSuperview {
    [self.superview addSubview:self.backView];
    [self.superview addSubview:self.frontView];
}

- (void)toggle {
    if(self.up) { [self bringDown]; }
    else { [self bringUp]; }
}

- (void)bringUp {
    if(self.pending) { return; }
    if(self.up) { return; }

    // sets both the front and back views as visible (enforces
    // the correct rendering of the animation)
    self.frontView.hidden = NO;
    self.backView.hidden = NO;

    // retrieves the references for both the top and the bottom layers
    // ir order to correctly manipulate them
    CALayer *topLayer = self.frontView.layer;
    CALayer *bottomLayer = self.backView.layer;

    // brings both views to the front so that they stay on
    // on top of the other views contained in the super view
    [self.frontView.superview bringSubviewToFront:self.frontView];
    [self.backView.superview bringSubviewToFront:self.backView];

    // sets the z position for both layers to a high value so
    // that the layer itself remains on top
    topLayer.zPosition = 1000.0;
    bottomLayer.zPosition = 1000.0;

    // creates and sets the perspective in both the top
    // and the bottom layer to provide a sence of depth
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = 1.0f / 1250.f;
    topLayer.transform = perspective;
    bottomLayer.transform = perspective;

    // creates both the animation for the top layer and the animation
    // for the bottom layer, in order to be able to create the flip effect
    // then sets the delegate for the animation as the current instances
    CAAnimation *topAnimation = [self upAnimation:0.5 forTopLayer:YES];
    CAAnimation *bottomAnimation = [self upAnimation:0.5 forTopLayer:NO];
    topAnimation.delegate = self;

    // creates the transaction for the anumation and pushes both animations
    // to the core animation stack of animations (to be processed)
    [CATransaction begin];
    [topLayer addAnimation:topAnimation forKey:@"flip"];
    [bottomLayer addAnimation:bottomAnimation forKey:@"flip"];
    [CATransaction commit];

    // sets the up flag indicating that the current state of the view
    // is (centered in the front of the panel)
    self.up = YES;
    self.pending = YES;
    self.userInteractionEnabled = NO;

    // calls the appropriate delegate methods to indicate that the up
    // operation has already started
    if(self.delegate && [self.delegate respondsToSelector:@selector(didStart:)]) {
        [self.delegate didStart:self];
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(didStartUp:)]) {
        [self.delegate didStartUp:self];
    }
}

- (void)bringDown {
    if(self.pending) { return; }
    if(!self.up) { return; }

    // sets both the front and back views as visible (enforces
    // the correct rendering of the animation)
    self.frontView.hidden = NO;
    self.backView.hidden = NO;

    // retrieves the references for both the top and the bottom layers
    // ir order to correctly manipulate them
    CALayer *topLayer = self.backView.layer;
    CALayer *bottomLayer = self.frontView.layer;

    // creates and sets the perspective in both the top
    // and the bottom layer to provide a sence of depth
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = 1.0f / 1250.f;
    topLayer.transform = perspective;
    bottomLayer.transform = perspective;

    // creates both the animation for the top layer and the animation
    // for the bottom layer, in order to be able to create the flip effect
    // then sets the delegate for the animation as the current instances
    CAAnimation *topAnimation = [self downAnimation:0.5 forTopLayer:YES];
    CAAnimation *bottomAnimation = [self downAnimation:0.5 forTopLayer:NO];
    topAnimation.delegate = self;

    // creates the transaction for the anumation and pushes both animations
    // to the core animation stack of animations (to be processed)
    [CATransaction begin];
    [topLayer addAnimation:topAnimation forKey:@"flip"];
    [bottomLayer addAnimation:bottomAnimation forKey:@"flip"];
    [CATransaction commit];

    // unsets the up flag indicating that the current state of the view
    // is thumbnailed down in the panel
    self.up = NO;
    self.pending = YES;
    self.userInteractionEnabled = NO;

    // calls the appropriate delegate methods to indicate that the down
    // operation has already started
    if(self.delegate && [self.delegate respondsToSelector:@selector(didStart:)]) {
        [self.delegate didStart:self];
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(didStartDown:)]) {
        [self.delegate didStartDown:self];
    }
}

- (void)doLayout {
    float x;
    float y;

    _ratio = backViewWidth / self.frame.size.width;
    _ratioI = 1.0 / _ratio;

    if(self.up) {
        x = (self.backView.superview.frame.size.width / 2.0) - (backViewWidth / 2.0);
        y = (self.backView.superview.frame.size.height / 2.0) - (backViewHeight / 2.0);
    } else {
        x = self.frame.origin.x - (backViewWidth / 2.0 - self.frame.size.width / 2.0);
        y = self.frame.origin.y - (backViewHeight / 2.0 - self.frame.size.height / 2.0);

        CATransform3D scale = CATransform3DMakeScale(_ratioI, _ratioI, _ratioI);
        self.frontView.layer.transform = scale;
    }

    self.frontView.frame = CGRectMake(x, y, backViewWidth, backViewHeight);
    self.backView.frame = CGRectMake(x, y, backViewWidth, backViewHeight);
}

- (CAAnimation *)upAnimation:(NSTimeInterval)duration
                 forTopLayer:(bool)isTop {
    // initializes the various animations that are going to
    // be used to perform the flip operation in a layer
    CABasicAnimation *rotationAnimation = nil;
    CABasicAnimation *scaleAnimation = nil;
    CABasicAnimation *translateXAnimation = nil;
    CABasicAnimation *translateYAnimation = nil;

    // creates the rotation animation arround the y axis, this
    // is considered the main animation, note that the way of
    // the roation varies in conformance with the begins on top
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    CGFloat startValue = isTop ? 0.0f : M_PI;
    CGFloat endValue = isTop ? -M_PI : 0.0f;
    rotationAnimation.fromValue = [NSNumber numberWithDouble:startValue];
    rotationAnimation.toValue = [NSNumber numberWithDouble:endValue];

    // checks if the scale factor is diferent from the "normal" on
    // in such case performs a scale operation that is reversed
    scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:_ratioI];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.duration = duration;
    scaleAnimation.autoreverses = NO;

    // creates the animation that will be used to correctly position the layers
    // on top of the current panel (centered on screen)
    translateXAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    translateXAnimation.toValue = [NSNumber numberWithFloat:self.superview.center.x];
    translateXAnimation.duration = duration;
    translateYAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    translateYAnimation.toValue = [NSNumber numberWithFloat:self.superview.center.y];
    translateYAnimation.duration = duration;

    // combines the complete set of animations into a single
    // sets so that all of them are performed at once
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = [NSArray arrayWithObjects:
                                 rotationAnimation,
                                 scaleAnimation,
                                 translateXAnimation,
                                 translateYAnimation,
                                 nil];

    // sets the easy in and out timing function for the animation and sets
    // the duration of the complete combines animation
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animationGroup.duration = duration;

    // avoids the removal of the layer on the completion, this avoids an
    // unnecessary flickering effect, then returns the animation group
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    return animationGroup;
}

- (CAAnimation *)downAnimation:(NSTimeInterval)duration
                   forTopLayer:(bool)isTop {
    // initializes the various animations that are going to
    // be used to perform the flip operation in a layer
    CABasicAnimation *rotationAnimation = nil;
    CABasicAnimation *scaleAnimation = nil;
    CABasicAnimation *translateXAnimation = nil;
    CABasicAnimation *translateYAnimation = nil;

    // creates the rotation animation arround the y axis, this
    // is considered the main animation, note that the way of
    // the roation varies in conformance with the begins on top
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    CGFloat startValue = isTop ? 0.0f : -M_PI;
    CGFloat endValue = isTop ? M_PI : 0.0f;
    rotationAnimation.fromValue = [NSNumber numberWithDouble:startValue];
    rotationAnimation.toValue = [NSNumber numberWithDouble:endValue];

    // checks if the scale factor is diferent from the "normal" on
    // in such case performs a scale operation that is reversed
    scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:_ratioI];
    scaleAnimation.duration = duration;
    scaleAnimation.autoreverses = NO;

    // calculçates the returning position for the frame taking
    // into account the raio between the top and the bottom sizes
    float x = self.frame.origin.x + backViewWidth / (_ratio * 2.0);
    float y = self.frame.origin.y + backViewHeight / (_ratio * 2.0);

    // creates the animation that will be used to correctly position the layers
    // back on their original position (rollback position)
    translateXAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    translateXAnimation.toValue = [NSNumber numberWithFloat:x];
    translateXAnimation.duration = duration;
    translateYAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    translateYAnimation.toValue = [NSNumber numberWithFloat:y];
    translateYAnimation.duration = duration;

    // combines the complete set of animations into a single
    // sets so that all of them are performed at once
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = [NSArray arrayWithObjects:
                                 rotationAnimation,
                                 scaleAnimation,
                                 translateXAnimation,
                                 translateYAnimation,
                                 nil];

    // sets the easy in and out timing function for the animation and sets
    // the duration of the complete combines animation
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animationGroup.duration = duration;

    // avoids the removal of the layer on the completion, thi avoids an
    // unnecessary flickering effect, then returns the animation group
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    return animationGroup;
}

- (void)animationDidStop:(CAAnimation *)animation finished:(bool)flag {
    if(!flag) { return; }

    if(self.up) {
        self.frontView.hidden = YES;

        [self.backView.layer removeAllAnimations];
        [self.frontView.layer removeAllAnimations];
        [self doLayout];

        if(self.delegate && [self.delegate respondsToSelector:@selector(didEndUp:)]) {
            [self.delegate didEndUp:self];
        }
    }
    else {
        self.backView.layer.zPosition = -1.0;
        self.frontView.layer.zPosition = -1.0;

        self.backView.hidden = YES;

        [self.backView.layer removeAllAnimations];
        [self.frontView.layer removeAllAnimations];
        [self doLayout];

        if(self.delegate && [self.delegate respondsToSelector:@selector(didEndDown:)]) {
            [self.delegate didEndDown:self];
        }
    }

    self.pending = NO;
    self.userInteractionEnabled = YES;

    if(self.delegate && [self.delegate respondsToSelector:@selector(didEnd:)]) {
        [self.delegate didEnd:self];
    }
}

- (void)frontViewClick:(id)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(didTap:)]) {
        [self.delegate didTap:self];
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(didTapFront:)]) {
        [self.delegate didTapFront:self];
    }
}

- (void)backViewClick:(id)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(didTap:)]) {
        [self.delegate didTap:self];
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(didTapBack:)]) {
        [self.delegate didTapBack:self];
    }
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self doLayout];
}

- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled {
    [super setUserInteractionEnabled:userInteractionEnabled];
    self.frontView.userInteractionEnabled = userInteractionEnabled;
    self.backView.userInteractionEnabled = userInteractionEnabled;
}

- (void)setFrontView:(UIView *)frontView {
    _frontView = frontView;
    _frontView.userInteractionEnabled = YES;
    _frontView.layer.doubleSided = NO;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(frontViewClick:)];
    [_frontView addGestureRecognizer:recognizer];
}

- (void)setBackView:(UIView *)backView {
    _backView = backView;
    _backView.hidden = YES;
    _backView.userInteractionEnabled = YES;
    _backView.layer.doubleSided = NO;
    _backView.layer.masksToBounds = NO;
    _backView.layer.shouldRasterize = YES;
    _backView.layer.cornerRadius = 8.0;
    _backView.layer.shadowOffset = CGSizeMake(0, 0);
    _backView.layer.shadowRadius = 6.0;
    _backView.layer.shadowOpacity = 0.6;
    _backView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(backViewClick:)];
    [_backView addGestureRecognizer:recognizer];
}

@end
