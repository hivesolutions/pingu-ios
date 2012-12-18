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

@implementation FlipView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.up = NO;
        self.enabled = NO;
        
        self.frontView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tobias.jpg"]];
        self.backView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tobias2.jpg"]];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        self.up = NO;
        self.enabled = NO;
    }
    return self;
}

- (void)enable {
    if(self.enabled) { return; }
    
    [self addSubview:self.frontView];
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

- (void)bringUp {
    if(self.up) { return; }
    
    [self.frontView removeFromSuperview];
    [UIView beginAnimations:nil context:NULL];
    
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self cache:YES];
    
    [UIView setAnimationDuration:1.0];
    CGAffineTransform transform = CGAffineTransformMakeScale(1.2, 1.2);
    self.transform = transform;
    
    [UIView commitAnimations];
    [self addSubview:self.backView];
    
    self.up = YES;
}

- (void)bringDown {
    if(!self.up) { return; }
    
    [self.backView removeFromSuperview];
    [UIView beginAnimations:nil context:NULL];
    
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self cache:YES];
    
    [UIView setAnimationDuration:1.0];
    CGAffineTransform transform = CGAffineTransformMakeScale(1, 1);
    self.transform = transform;
    
    [UIView commitAnimations];
    [self addSubview:self.frontView];
    
    self.up = NO;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.frontView.frame = CGRectMake(
        0, 0, frame.size.width, frame.size.height
    );
}

@end
