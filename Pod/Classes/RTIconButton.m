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

static inline NSString * NSStringFromIconPosition(RTIconPosition position) {
    switch (position) {
        case RTIconPositionTop:
            return @"Top";
            break;
        case RTIconPositionLeft:
            return @"Left";
            break;
        case RTIconPositionRight:
            return @"Right";
            break;
        case RTIconPositionBottom:
            return @"Bottom";
            break;
        default:
            break;
    }
    return @"Unknown";
}

@implementation RTIconButton
@synthesize iconSize = _iconSize;

- (void)commonInit
{
    self.autoresizesSubviews = NO;
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
        return [super imageRectForContentRect:CGRectMake(0, 0, CGFLOAT_MAX, CGFLOAT_MAX)].size;
    }
    if (self.currentImage)
        return _iconSize;
    return CGSizeZero;
}

- (CGSize)titleSize
{
    CGSize size = CGSizeZero;
    if (self.currentAttributedTitle) {
        size = [self.currentAttributedTitle size];
    }
    else if (self.currentTitle) {
        size = [self.currentTitle sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}];
    }
    return size;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGSize size = [super titleRectForContentRect:CGRectMake(0, 0, CGFLOAT_MAX, CGFLOAT_MAX)].size;
    if (self.contentVerticalAlignment == UIControlContentVerticalAlignmentFill) {
        size.height = MIN(size.height, CGRectGetHeight(contentRect));
    }
    if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentFill) {
        size.width = MIN(size.width, CGRectGetWidth(contentRect));
    };
    
    CGSize iconSize = self.iconSize;
    CGFloat margin = self.iconMargin;
    if (CGSizeEqualToSize(iconSize, CGSizeZero)) {
        margin = 0;
    }
    CGFloat totalWidth = size.width + iconSize.width + margin;
    CGFloat totalHeight = size.height + iconSize.height + margin;
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
    return CGRectIntegral(rect);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGSize size = self.iconSize;
    if (self.contentVerticalAlignment == UIControlContentVerticalAlignmentFill) {
        size.height = MIN(size.height, CGRectGetHeight(contentRect));
    }
    if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentFill) {
        size.width = MIN(size.width, CGRectGetWidth(contentRect));
    };
    
    CGSize titleSize = [self titleSize];
    CGFloat margin = self.iconMargin;
    if (CGSizeEqualToSize(titleSize, CGSizeZero)) {
        margin = 0;
    }
    
    switch (_iconPosition) {
        case RTIconPositionTop:
        case RTIconPositionBottom:
            size.height = MAX(MIN(CGRectGetHeight(contentRect) - margin - titleSize.height, size.height), size.height);
            break;
        default:
            size.width = MAX(MIN(CGRectGetWidth(contentRect) - margin - titleSize.width, size.width), size.width);
            break;
    }
    
    CGFloat totalWidth = size.width + titleSize.width + margin;
    CGFloat totalHeight = size.height + titleSize.height + margin;
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

- (void)setIconSize:(CGSize)iconSize
{
    if (!CGSizeEqualToSize(_iconSize, iconSize)) {
        _iconSize = iconSize;
        [self invalidateIntrinsicContentSize];
        [self setNeedsLayout];
    }
}

- (void)setIconMargin:(CGFloat)iconMargin
{
    if (_iconMargin != iconMargin) {
        _iconMargin = iconMargin;
        [self invalidateIntrinsicContentSize];
        [self setNeedsLayout];
    }
}

- (void)setIconPosition:(NSInteger)iconPosition
{
    if (_iconPosition != iconPosition) {
        _iconPosition = iconPosition;
        [self invalidateIntrinsicContentSize];
        [self setNeedsLayout];
    }
}

- (void)setEnabled:(BOOL)enabled
{
    super.enabled = enabled;
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}

- (void)setSelected:(BOOL)selected
{
    super.selected = selected;
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}

- (void)setHighlighted:(BOOL)highlighted
{
    super.highlighted = highlighted;
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}

- (void)setContentVerticalAlignment:(UIControlContentVerticalAlignment)contentVerticalAlignment
{
    super.contentVerticalAlignment = contentVerticalAlignment;
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}

- (void)setContentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment
{
    super.contentHorizontalAlignment = contentHorizontalAlignment;
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}

- (void)setAttributedTitle:(NSAttributedString *)title forState:(UIControlState)state
{
    [super setAttributedTitle:title forState:state];
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}

- (void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets
{
    [super setContentEdgeInsets:contentEdgeInsets];
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}

- (CGSize)intrinsicContentSize
{
    UIEdgeInsets contentInsets = self.contentEdgeInsets;
    
    CGSize titleSize = [self titleSize];
    CGSize imageSize = self.iconSize;
    CGFloat margin = self.iconMargin;
    if (CGSizeEqualToSize(imageSize, CGSizeZero) || CGSizeEqualToSize(titleSize, CGSizeZero)) {
        margin = 0;
    }
    CGSize size = {0, 0};
    switch (_iconPosition) {
        case RTIconPositionTop:
        case RTIconPositionBottom:
            size = CGSizeMake(MAX(titleSize.width, imageSize.width) + contentInsets.left + contentInsets.right,
                              titleSize.height + imageSize.height + margin + contentInsets.top + contentInsets.bottom);
            
            break;
        default:
            size = CGSizeMake(titleSize.width + imageSize.width + margin + contentInsets.left + contentInsets.right,
                              MAX(titleSize.height, imageSize.height) + contentInsets.top + contentInsets.bottom);
            break;
    }
    return CGRectIntegral((CGRect){{0, 0}, size}).size;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    return [self intrinsicContentSize];
}

- (NSString *)debugDescription
{
    return [NSString stringWithFormat:@"<%@: %p; frame = %@; icon margin = %.6f; icon position = %@; icon size = %@>", NSStringFromClass(self.class), self, NSStringFromCGRect(self.frame), self.iconMargin, NSStringFromIconPosition(self.iconPosition), NSStringFromCGSize(self.iconSize)];
}

@end
