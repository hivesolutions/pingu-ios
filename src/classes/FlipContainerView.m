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

#import "FlipContainerView.h"

@implementation FlipContainerView

static int itemWidth = 128;
static int itemHeight = 128;
static int itemMargin = 10;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        _scrollView = [[UIScrollView alloc] initWithFrame:frame];
        _scrollView.scrollEnabled = YES;
        _overlay = [[UIScrollView alloc] initWithFrame:frame];
        _overlay.alpha = 0.0;
        _overlay.backgroundColor = [UIColor blackColor];
        _overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        self.flipViews = [[NSMutableArray alloc] init];
        
        [self addSubview:_scrollView];
        [_scrollView addSubview:_overlay];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        _scrollView = [[UIScrollView alloc] initWithCoder:aDecoder];
        _scrollView.scrollEnabled = YES;
        _overlay = [[UIScrollView alloc] initWithCoder:aDecoder];
        _overlay.alpha = 0.0;
        _overlay.backgroundColor = [UIColor blackColor];
        _overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        self.flipViews = [[NSMutableArray alloc] init];

        [self addSubview:_scrollView];
        [_scrollView addSubview:_overlay];
    }
    return self;
}

- (void)addFlipView:(FlipView *)flipView {
    [self.flipViews addObject:flipView];
    [_scrollView addSubview:flipView];

    flipView.delegate = self;
    
    [self doLayout];
}

- (void)doLayout {
    int items = [self.flipViews count];
    
    for(int index  = 0; index < items; index++) {
        FlipView *flipView = [self.flipViews objectAtIndex:index];
        flipView.baseFrame = CGRectMake(index * (itemWidth + itemMargin), 0, itemWidth, itemHeight);
        [flipView enable];
    }
}

- (void)didTap:(id)sender {
    FlipView *flipView = (FlipView *) sender;
    
    if(flipView.up) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.5];
        _overlay.alpha = 0.0;
        [UIView commitAnimations];
        [flipView bringDown];
    } else {
        [_scrollView bringSubviewToFront:_overlay];
        [_scrollView bringSubviewToFront:flipView];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.5];
        _overlay.alpha = 0.6;
        [UIView commitAnimations];
        [flipView bringUp];
    }
}

@end
