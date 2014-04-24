// Hive Pingu Service
// Copyright (C) 2008-2014 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2014 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

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
