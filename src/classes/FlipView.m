// Hive Pingu Service
// Copyright (C) 2008-2012 Hive Solutions Lda.
//
// This file is part of Hive Pingu Service.
//
// Hive Pingu Service is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Hive Pingu Service is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Hive Pingu Service. If not, see <http://www.gnu.org/licenses/>.

// __author__    = João Magalhães <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision$
// __date__      = $LastChangedDate$
// __copyright__ = Copyright (c) 2008-2012 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "FlipView.h"




#import "StatusViewController.h"

@implementation FlipView

static int frontViewWidth = 640;
static int frontViewHeight = 640;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.up = NO;
        self.enabled = NO;
        self.currentView = nil;
        
        self.frontView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tobias.jpg"]];
//        self.backView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tobias2.jpg"]];
        
        StatusViewController *statusViewController = [[StatusViewController alloc] initWithNibName:@"StatusViewControllerIpad" bundle:nil];
        self.backView = statusViewController.view;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        self.up = NO;
        self.enabled = NO;
        self.currentView = nil;
    }
    return self;
}

- (void)enable {
    if(self.enabled) { return; }

    self.frontView.hidden = YES;
    self.backView.hidden = YES;
    [self addSubview:self.frontView];
    //[self addSubview:self.backView];
    self.currentView = self.frontView;
    self.currentView.hidden = NO;

    self.enabled = YES;
}

- (void)disable {
    if(!self.enabled) { return; }
    
    [self.frontView removeFromSuperview];
    [self.backView removeFromSuperview];
    self.enabled = NO;
}

- (void)toggle {
    if(self.up) { [self bringDown]; }
    else { [self bringUp]; }
}



- (void)myAnimationStopped:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    self.backView.layer.masksToBounds = NO;
    self.backView.layer.shouldRasterize = YES;
    self.backView.layer.shadowOffset = CGSizeMake(0, 0);
    self.backView.layer.shadowRadius = 8.0;
    self.backView.layer.shadowOpacity = 0.8;
    self.backView.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)bringUp {
    if(self.up) { return; }
    
    self.currentView.hidden = YES;
    self.currentView = self.backView;
    [self addSubview:self.currentView];

    float offsetX = 0.0f;
    float offsetY = 0.0f;
    
    bool isScrollable = [self.superview isKindOfClass:[UIScrollView class]];
    if(isScrollable) {
        offsetX += ((UIScrollView *) self.superview).contentOffset.x;
        offsetY += ((UIScrollView *) self.superview).contentOffset.y;
    }
    
    float width = frontViewWidth;
    float height = frontViewHeight;
    float x = self.superview.frame.size.width / 2.0f - width / 2.0f + offsetX;
    float y = self.superview.frame.size.height / 2.0f - height / 2.0f + offsetY;
    CGRect frame = CGRectMake(x, y, width, height);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(myAnimationStopped:finished:context:)];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    [self setFrame:frame withRatio:0.15];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft
                           forView:self
                             cache:YES];
    
    [UIView commitAnimations];
    
    self.currentView.hidden = NO;
    self.up = YES;
}

- (void)bringDown {
    if(!self.up) { return; }

    self.currentView.hidden = YES;
    self.currentView = self.frontView;

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    
    [self setFrame:self.baseFrame withRatio:0.75];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight
                           forView:self
                             cache:YES];
    
    [UIView commitAnimations];

    self.currentView.hidden = NO;
    self.up = NO;
    
    
    self.backView.layer.masksToBounds = NO;
    self.backView.layer.shouldRasterize = NO;
    self.backView.layer.shadowOffset = CGSizeMake(0, 0);
    self.backView.layer.shadowRadius = 0.0;
    self.backView.layer.shadowOpacity = 0.0;
    self.backView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    [self.backView removeFromSuperview];
}

- (void)doLayout {
    if(!self.up) { return; }

    float offsetX = 0.0f;
    float offsetY = 0.0f;
    
    bool isScrollable = [self.superview isKindOfClass:[UIScrollView class]];
    if(isScrollable) {
        offsetX += ((UIScrollView *) self.superview).contentOffset.x;
        offsetY += ((UIScrollView *) self.superview).contentOffset.y;
    }
    
    float width = frontViewWidth;
    float height = frontViewHeight;
    float x = self.superview.frame.size.width / 2.0f - width / 2.0f + offsetX;
    float y = self.superview.frame.size.height / 2.0f - height / 2.0f + offsetY;
    CGRect frame = CGRectMake(x, y, width, height);
    
    [self setFrame:frame withRatio:0.15];
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

- (void)setFrame:(CGRect)frame withRatio:(float)ratio {
    float width = frame.size.width * (ratio + 1.0);
    float height = frame.size.height * (ratio + 1.0);
    float xOffset = frame.size.width * (ratio / 2.0);
    float yOffset = frame.size.height * (ratio / 2.0);
    
    [super setFrame:CGRectMake(
        frame.origin.x - xOffset, frame.origin.y - yOffset, width, height
    )];
}

- (void)setInnerFrame:(CGRect)frame withRatio:(float)ratio {
    float xOffset = frame.size.width * (ratio / 2.0);
    float yOffset = frame.size.height * (ratio / 2.0);
    
    self.frontView.frame = CGRectMake(
        xOffset, yOffset, frame.size.width, frame.size.height
    );
    self.backView.frame = CGRectMake(
        xOffset, yOffset, frame.size.width, frame.size.height
    );
}

- (void)setBaseFrame:(CGRect)baseFrame {
    _baseFrame = baseFrame;
    [self setFrame:baseFrame withRatio:0.75];
    [self setInnerFrame:baseFrame withRatio:0.75];
}

- (void)setFrontView:(UIView *)frontView {
    _frontView = frontView;
    _frontView.userInteractionEnabled = YES;
    _frontView.autoresizingMask |= UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _frontView.layer.masksToBounds = NO;
    _frontView.layer.shouldRasterize = YES;
    _frontView.layer.shadowOffset = CGSizeMake(0, 2);
    _frontView.layer.shadowRadius = 2.0;
    _frontView.layer.shadowOpacity = 0.4;
    _frontView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(frontViewClick:)];
    [_frontView addGestureRecognizer:recognizer];
    if(self.currentView == nil) { self.currentView = frontView; }
}

- (void)setBackView:(UIView *)backView {
    _backView = backView;
    _backView.userInteractionEnabled = YES;
    _backView.autoresizingMask |= UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(backViewClick:)];
    [_backView addGestureRecognizer:recognizer];
}

@end
