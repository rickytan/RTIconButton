// RTIconButton.m
//
// Copyright (c) 2016 Ricky Tan
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "RTIconButton.h"

@implementation RTIconButton

- (void)commonInit
{
    self.iconSize = CGSizeZero;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (CGSize)iconSize
{
    if (CGSizeEqualToSize(_iconSize, CGSizeZero)) {
        _iconSize = [super imageRectForContentRect:CGRectMake(0, 0, CGFLOAT_MAX, CGFLOAT_MAX)].size;
    }
    return _iconSize;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
    CGSize size = [[self titleForState:self.state] sizeWithFont:self.font
                                              constrainedToSize:contentRect.size];
#pragma clang diagnostic pop
    CGSize iconSize = self.iconSize;
    CGFloat totalWidth = size.width + iconSize.width + self.iconMargin;
    CGFloat totalHeight = size.height + iconSize.height + self.iconMargin;
    CGRect rect = {{0, 0}, size};
    switch (self.contentHorizontalAlignment) {
        case UIControlContentHorizontalAlignmentLeft:
            switch (_iconPosition) {
                case RTIconPositionRight:
                    rect.origin.x = CGRectGetMinX(contentRect);
                    break;
                case RTIconPositionLeft:
                    rect.origin.x = CGRectGetMinX(contentRect) + totalWidth - size.width;
                    break;
                default:
                    rect.origin.x = CGRectGetMinX(contentRect);
                    break;
            }
            break;
        case UIControlContentHorizontalAlignmentRight:
            switch (_iconPosition) {
                case RTIconPositionRight:
                    rect.origin.x = CGRectGetMaxX(contentRect) - totalWidth;
                    break;
                case RTIconPositionLeft:
                    rect.origin.x = CGRectGetMaxX(contentRect) - size.width;
                    break;
                default:
                    rect.origin.x = CGRectGetMaxX(contentRect) - size.width;
                    break;
            }
            break;
        case UIControlContentHorizontalAlignmentFill:
            switch (_iconPosition) {
                case RTIconPositionRight:
                    rect.origin.x = CGRectGetMinX(contentRect);
                    break;
                case RTIconPositionLeft:
                    rect.origin.x = CGRectGetMaxX(contentRect) - size.width;
                    break;
                default:
                    rect.origin.x = CGRectGetMinX(contentRect) + (CGRectGetWidth(contentRect) - size.width) / 2;
                    break;
            }
            break;
        default:
            switch (_iconPosition) {
                case RTIconPositionRight:
                    rect.origin.x = CGRectGetMinX(contentRect) + (CGRectGetWidth(contentRect) - totalWidth) / 2;
                    break;
                case RTIconPositionLeft:
                    rect.origin.x = CGRectGetMinX(contentRect) + CGRectGetWidth(contentRect) - (CGRectGetWidth(contentRect) - totalWidth) / 2 - size.width;
                    break;
                default:
                    rect.origin.x = CGRectGetMinX(contentRect) + (CGRectGetWidth(contentRect) - size.width) / 2;
                    break;
            }
            break;
    }

    switch (self.contentVerticalAlignment) {
        case UIControlContentVerticalAlignmentTop:
            switch (_iconPosition) {
                case RTIconPositionTop:
                    rect.origin.y = CGRectGetMinY(contentRect) + totalHeight - size.height;
                    break;
                case RTIconPositionBottom:
                    rect.origin.y = CGRectGetMinY(contentRect);
                    break;
                default:
                    rect.origin.y = CGRectGetMinY(contentRect);
                    break;
            }
            break;
        case UIControlContentVerticalAlignmentBottom:
            switch (_iconPosition) {
                case RTIconPositionTop:
                    rect.origin.y = CGRectGetMaxY(contentRect) - size.height;
                    break;
                case RTIconPositionBottom:
                    rect.origin.y = CGRectGetMaxY(contentRect) - totalHeight;
                    break;
                default:
                    rect.origin.y = CGRectGetMaxY(contentRect) - size.height;
                    break;
            }
            break;
        case UIControlContentVerticalAlignmentFill:
            switch (_iconPosition) {
                case RTIconPositionTop:
                    rect.origin.y = CGRectGetMaxY(contentRect) - size.height;
                    break;
                case RTIconPositionBottom:
                    rect.origin.y = CGRectGetMinY(contentRect);
                    break;
                default:
                    rect.origin.y = CGRectGetMinY(contentRect) + (CGRectGetHeight(contentRect) - size.height) / 2;
                    break;
            }
            break;
        default:
            switch (_iconPosition) {
                case RTIconPositionTop:
                    rect.origin.y = CGRectGetMaxY(contentRect) - (CGRectGetHeight(contentRect) - totalHeight) / 2 - size.height;
                    break;
                case RTIconPositionBottom:
                    rect.origin.y = CGRectGetMinY(contentRect) + (CGRectGetHeight(contentRect) - totalHeight) / 2;
                    break;
                default:
                    rect.origin.y = CGRectGetMinY(contentRect) + (CGRectGetHeight(contentRect) - size.height) / 2;
                    break;
            }
            break;
    }
    return rect;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGSize size = self.iconSize;
    CGSize titleSize = [self titleRectForContentRect:contentRect].size;

    switch (_iconPosition) {
        case RTIconPositionTop:
        case RTIconPositionBottom:
            size.height = MAX(MIN(CGRectGetHeight(contentRect) - self.iconMargin - titleSize.height, size.height), self.iconSize.height);
            break;
        default:
            size.width = MAX(MIN(CGRectGetWidth(contentRect) - self.iconMargin - titleSize.width, size.width), self.iconSize.width);
            break;
    }

    CGFloat totalWidth = size.width + titleSize.width + self.iconMargin;
    CGFloat totalHeight = size.height + titleSize.height + self.iconMargin;
    CGRect rect = {{0, 0}, size};
    switch (self.contentHorizontalAlignment) {
        case UIControlContentHorizontalAlignmentLeft:
            switch (_iconPosition) {
                case RTIconPositionRight:
                    rect.origin.x = CGRectGetMinX(contentRect) + totalWidth - size.width;
                    break;
                case RTIconPositionLeft:
                    rect.origin.x = CGRectGetMinX(contentRect);
                    break;
                default:
                    rect.origin.x = CGRectGetMinX(contentRect);
                    break;
            }
            break;
        case UIControlContentHorizontalAlignmentRight:
            switch (_iconPosition) {
                case RTIconPositionRight:
                    rect.origin.x = CGRectGetMaxX(contentRect) - size.width;
                    break;
                case RTIconPositionLeft:
                    rect.origin.x = CGRectGetMaxX(contentRect) - totalWidth;
                    break;
                default:
                    rect.origin.x = CGRectGetMaxX(contentRect) - size.width;
                    break;
            }
            break;
        case UIControlContentHorizontalAlignmentFill:
            switch (_iconPosition) {
                case RTIconPositionRight:
                    rect.origin.x = CGRectGetMaxX(contentRect) - size.width;
                    break;
                case RTIconPositionLeft:
                    rect.origin.x = CGRectGetMinX(contentRect);
                    break;
                default:
                    rect.origin.x = CGRectGetMinX(contentRect) + (CGRectGetWidth(contentRect) - size.width) / 2;
                    break;
            }
            break;
        default:
            switch (_iconPosition) {
                case RTIconPositionRight:
                    rect.origin.x = CGRectGetMinX(contentRect) + CGRectGetWidth(contentRect) - (CGRectGetWidth(contentRect) - totalWidth) / 2 - size.width;
                    break;
                case RTIconPositionLeft:
                    rect.origin.x = CGRectGetMinX(contentRect) + (CGRectGetWidth(contentRect) - totalWidth) / 2;
                    break;
                default:
                    rect.origin.x = CGRectGetMinX(contentRect) + (CGRectGetWidth(contentRect) - size.width) / 2;
                    break;
            }
            break;
    }

    switch (self.contentVerticalAlignment) {
        case UIControlContentVerticalAlignmentTop:
            switch (_iconPosition) {
                case RTIconPositionTop:
                    rect.origin.y = CGRectGetMinY(contentRect);
                    break;
                case RTIconPositionBottom:
                    rect.origin.y = CGRectGetMinY(contentRect) + totalHeight - size.height;
                    break;
                default:
                    rect.origin.y = CGRectGetMinY(contentRect);
                    break;
            }
            break;
        case UIControlContentVerticalAlignmentBottom:
            switch (_iconPosition) {
                case RTIconPositionTop:
                    rect.origin.y = CGRectGetMaxY(contentRect) - totalHeight;
                    break;
                case RTIconPositionBottom:
                    rect.origin.y = CGRectGetMaxY(contentRect) - size.height;
                    break;
                default:
                    rect.origin.y = CGRectGetMaxY(contentRect) - size.height;
                    break;
            }
            break;
        case UIControlContentVerticalAlignmentFill:
            switch (_iconPosition) {
                case RTIconPositionTop:
                    rect.origin.y = CGRectGetMinY(contentRect);
                    break;
                case RTIconPositionBottom:
                    rect.origin.y = CGRectGetMaxY(contentRect) - size.height;
                    break;
                default:
                    rect.origin.y = CGRectGetMinY(contentRect) + (CGRectGetHeight(contentRect) - size.height) / 2;
                    break;
            }
            break;
        default:
            switch (_iconPosition) {
                case RTIconPositionTop:
                    rect.origin.y = CGRectGetMinY(contentRect) + (CGRectGetHeight(contentRect) - totalHeight) / 2;
                    break;
                case RTIconPositionBottom:
                    rect.origin.y = CGRectGetMaxY(contentRect) - (CGRectGetHeight(contentRect) - totalHeight) / 2 - size.height;
                    break;
                default:
                    rect.origin.y = CGRectGetMinY(contentRect) + (CGRectGetHeight(contentRect) - size.height) / 2;
                    break;
            }
            break;
    }

    return rect;
}

- (CGSize)intrinsicContentSize
{
    UIEdgeInsets contentInsets = self.contentEdgeInsets;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
    CGSize titleSize = [[self titleForState:self.state] sizeWithFont:self.font];
#pragma clang diagnostic pop
    CGSize imageSize = self.iconSize;

    switch (_iconPosition) {
        case RTIconPositionTop:
        case RTIconPositionBottom:
            return CGSizeMake(MAX(titleSize.width, imageSize.width) + contentInsets.left + contentInsets.right,
                              titleSize.height + imageSize.height + self.iconMargin + contentInsets.top + contentInsets.bottom);

            break;
        default:
            return CGSizeMake(titleSize.width + imageSize.width + self.iconMargin + contentInsets.left + contentInsets.right,
                              MAX(titleSize.height, imageSize.height) + contentInsets.top + contentInsets.bottom);
            break;
    }
}

- (CGSize)sizeThatFits:(CGSize)size
{
    return [self intrinsicContentSize];
}

@end
