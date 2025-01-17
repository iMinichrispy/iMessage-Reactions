//
//  _UIContextMenuAccessoryViewBuilder.m
//
//  Created by Alex Perez on 7/31/24.
//  Copyright © 2024 Alex Perez. All rights reserved.
//

#import "_UIContextMenuAccessoryViewBuilder.h"

typedef struct _UIContextMenuAccessoryViewAnchor {
    NSUInteger attachment;
    NSUInteger alignment;
    CGFloat attachmentOffset;
    CGFloat alignmentOffset;
    NSInteger gravity;
} _UIContextMenuAccessoryViewAnchor;

// Magic numbers
static NSInteger const UIContextMenuAccessoryAttachmentValue = 1;
static NSInteger const UIContextMenuAccessoryLocationValue = 1;
static NSInteger const UIContextMenuAccessoryAlignmentLeftValue = 2;
static NSInteger const UIContextMenuAccessoryAlignmentRightValue = 8;

@implementation _UIContextMenuAccessoryViewBuilder

#pragma mark - Public

+ (UIView *)buildWithAlignment:(UIContextMenuAccessoryAlignment)alignment offset:(CGPoint)offset {
    Class _UIContextMenuAccessoryView = NSClassFromString(@"_UIContextMenuAccessoryView");
    if (!_UIContextMenuAccessoryView) {
        return nil;
    }

    UIView *accessoryView = [[_UIContextMenuAccessoryView alloc] init];

    NSInteger alignmentValue = [self _valueForAlignment:alignment];

    _UIContextMenuAccessoryViewAnchor anchor = (_UIContextMenuAccessoryViewAnchor) {
        .attachment = UIContextMenuAccessoryAttachmentValue,
        .alignment = alignmentValue,
        .attachmentOffset = 0,
        .alignmentOffset = 0,
        .gravity = 0,
    };
    NSValue *anchorValue = [NSValue value:&anchor withObjCType:@encode(_UIContextMenuAccessoryViewAnchor)];
    [accessoryView setValue:anchorValue forKey:@"anchor"];

    NSValue *offsetValue = [NSValue value:&offset withObjCType:@encode(CGPoint)];
    [accessoryView setValue:offsetValue forKey:@"offset"];

    NSNumber *locationValue = @(UIContextMenuAccessoryLocationValue);
    [accessoryView setValue:locationValue forKey:@"location"];

    return accessoryView;
}

#pragma mark - Private

+ (NSInteger)_valueForAlignment:(UIContextMenuAccessoryAlignment)alignment {
    BOOL rtl = [UIApplication sharedApplication].userInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft;
    switch (alignment) {
        case UIContextMenuAccessoryAlignmentLeading:
            return rtl ? UIContextMenuAccessoryAlignmentRightValue: UIContextMenuAccessoryAlignmentLeftValue;
        case UIContextMenuAccessoryAlignmentTrailing:
            return rtl ? UIContextMenuAccessoryAlignmentLeftValue : UIContextMenuAccessoryAlignmentRightValue;
    }
}

@end
