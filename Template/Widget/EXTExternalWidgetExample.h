#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// please see README for explanation
@protocol MPAWidgetProtocol
@required
- (void)updateWidget;
@optional
- (void)widgetBecameFocused;
- (void)widgetLostFocus;
@end

@interface EXTExternalWidgetExample : UIView <MPAWidgetProtocol>
- (instancetype)initWithFrame:(CGRect)arg1;
- (void)updateWidget;
@end