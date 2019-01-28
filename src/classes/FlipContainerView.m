// Hive Pingu Service
// Copyright (c) 2008-2019 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2019 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

#import "FlipContainerView.h"

@implementation FlipContainerView

static int itemWidth = 128;
static int itemHeight = 128;
static int itemHPMargin = 22;
static int itemHLMargin = 42;
static int itemVPMargin = 32;
static int itemVLMargin = 32;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.up = NO;

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
        self.up = NO;

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
    // retrieves the current device orientation and checks if its of type
    // landscape in order to correctly retrieve the correct measures
    UIInterfaceOrientation orientation = [UIDevice currentDevice].orientation;
    bool isLandscape = UIDeviceOrientationIsLandscape(orientation);

    // retrieves the scroll view with as the with to be used
    // in a per page basis
    CGFloat pageWidth = _scrollView.frame.size.width;

    CGFloat itemHMargin = isLandscape ? itemHLMargin : itemHPMargin;
    CGFloat itemVMargin = isLandscape ? itemVLMargin : itemVPMargin;

    // calculates the total width and height for the items
    // to be drawn in the target area
    CGFloat itemTWidth = itemWidth + itemHMargin;
    CGFloat itemTHeight = itemHeight + itemVMargin;

    // calculates the various intermediate values to be used
    // in the render operation of each of the items
    int items = [self.flipViews count];
    int itemsLine = (int) floor(pageWidth / itemTWidth);
    int extraWidth = pageWidth - (itemsLine * itemTWidth - itemHMargin);
    int extraPadding = (int) round((float) extraWidth / 2.0f);
    int numberRows = (int) ceil((float) items / (float) itemsLine);

    // updates the content size of the scroll view with the current width
    // (not changing it) and the heigth with enough room for the complete
    // set of element in the mosaic, then updates the overlay size to reflect
    // this change and cover the complete screen
    _scrollView.contentSize = CGSizeMake(
        _scrollView.frame.size.width, numberRows * itemTHeight + itemVMargin
    );
    _overlay.frame = CGRectMake(
        0,
        0,
        _scrollView.contentSize.width > self.frame.size.width ?
            _scrollView.contentSize.width : self.frame.size.width,
        _scrollView.contentSize.height > self.frame.size.height ?
            _scrollView.contentSize.height : self.frame.size.height
    );

    // starts the line counter in minus one so that the
    // initial modulus opertion puts it in zero
    int line = -1;

    // iterates over all the current flip views in order to
    // correctly position them in the current panel
    for(int index = 0; index < items; index++) {
        // calculates the horizontal offset index of the current
        // item by using the current index and the items (per)
        // line value in a modulus operation
        int offset = index % itemsLine;

        // in case the current offset is zero (start of a line)
        // the line counter must be incremented
        if(offset == 0) { line++; }

        FlipView *flipView = self.flipViews[index];
        flipView.frame = CGRectMake(
            extraPadding + itemTWidth * offset,
            itemVMargin + itemTHeight * line - 12,
            itemWidth,
            itemHeight
        );
    }
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];

    // does the layout of the view
    // in order to expand the option items
    [self doLayout];
}

- (void)didTap:(id)sender {
    FlipView *flipView = (FlipView *) sender;

    if(flipView.pending) { return; }
    if(self.up && !flipView.up) { return; }

    if(flipView.up) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.5];
        _overlay.alpha = 0.0;
        [UIView commitAnimations];
        [flipView bringDown];
        _scrollView.scrollEnabled = YES;
    } else {
        [_scrollView bringSubviewToFront:_overlay];
        [_scrollView bringSubviewToFront:flipView];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.5];
        _overlay.alpha = 0.6;
        [UIView commitAnimations];
        [flipView bringUp];
        _scrollView.scrollEnabled = NO;
    }
}

- (void)didStartUp:(FlipView *)flipView {
    self.up = YES;
}

- (void)didEndDown:(FlipView *)flipView {
    self.up = NO;
}

@end
