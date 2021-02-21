#import "EXTExternalWidgetExample.h"

@implementation EXTExternalWidgetExample

- (instancetype)initWithFrame:(CGRect)arg1 {
    self = [super initWithFrame:arg1];
    if(self) {
        // add a label
        UILabel *label = [[UILabel alloc] init];
        [label setFont:[UIFont systemFontOfSize:15]];
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        [label setText:@"This is a widget"];

        [self addSubview:label];
        label.translatesAutoresizingMaskIntoConstraints = NO;

        // add layout constraints
        [NSLayoutConstraint activateConstraints:@[
            [label.widthAnchor constraintEqualToAnchor:self.widthAnchor],
            [label.heightAnchor constraintEqualToAnchor:self.heightAnchor],
            [label.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
            [label.centerYAnchor constraintEqualToAnchor:self.centerYAnchor]
        ]];
    }
    return self;
}

- (void)updateWidget {
    // called when scrolling ends and the widget needs an update.
    // will be called even if your widget was the one that was
    // showing already. if the user cancels their scroll, your
    // widget will be called to update again.
}

- (void)widgetBecameFocused {
    // called when the widget is set as the currently displaying widget
    // and it wasn't before
}

- (void)widgetLostFocus {
    // widget is completely hidden and scrolling has stopped
    // feel free to reset your views here if you need to,
    // the user should not be able to see any changes you make,
    // so you don't even need animations.
}

@end
