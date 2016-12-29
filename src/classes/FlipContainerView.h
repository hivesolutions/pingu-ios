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

#import "Dependencies.h"

#import "FlipView.h"
#import "FlipViewDelegate.h"

@interface FlipContainerView : UIView<FlipViewDelegate> {
    @private
    UIScrollView *_scrollView;
    UIView *_overlay;
}

@property (nonatomic) bool up;
@property (nonatomic) NSMutableArray *flipViews;

- (void)addFlipView:(FlipView *)flipView;

@end
