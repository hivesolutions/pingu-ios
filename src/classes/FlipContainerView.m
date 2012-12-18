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

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [[UIScrollView alloc] initWithFrame:frame];
        _scrollView.scrollEnabled = YES;
        _overlay = [[UIScrollView alloc] initWithFrame:frame];
        _overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        self.flipViews = [[NSMutableArray alloc] init];
        
        [self addSubview:_scrollView];
        [self addSubview:_overlay];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        _scrollView = [[UIScrollView alloc] initWithCoder:aDecoder];
        _scrollView.scrollEnabled = YES;
        _overlay = [[UIScrollView alloc] initWithCoder:aDecoder];
        _overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        self.flipViews = [[NSMutableArray alloc] init];
        
        [self addSubview:_scrollView];
        [self addSubview:_overlay];
    }
    return self;
}

- (void)addFlipView:(FlipView *)flipView {
    [self.flipViews addObject:flipView];
    [_scrollView addSubview:flipView];
    
    [self doLayout];
}

- (void)doLayout {
    for(int index  = 0; index < [self.flipViews count]; index++) {
        NSLog(@"flip view");
    }
}

@end
