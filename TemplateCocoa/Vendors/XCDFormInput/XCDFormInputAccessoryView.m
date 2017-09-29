//
//  XCDFormInputAccessoryView.m
//
//  Created by Cédric Luthi on 2012-11-10
//  Copyright (c) 2012 Cédric Luthi. All rights reserved.
//

#import "XCDFormInputAccessoryView.h"
#import "TPKeyboardAvoidingCollectionView.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "TPKeyboardAvoidingTableView.h"

#import "AppMacro.h"

@interface XCDFormInputAccessoryView ()
{
    
}
@property (strong, nonatomic)  NSMutableArray *viewsArray;
@end
/*
static NSString * UIKitLocalizedString(NSString *string)
{
	NSBundle *UIKitBundle = [NSBundle bundleForClass:[UIApplication class]];
	return UIKitBundle ? [UIKitBundle localizedStringForKey:string value:string table:nil] : string;
}
*/
static NSArray * EditableTextInputsInView(UIView *view)
{
	NSMutableArray *textInputs = [NSMutableArray new];
	for (UIView *subview in view.subviews)
	{
		BOOL isTextField = [subview isKindOfClass:[UITextField class]];
		BOOL isEditableTextView = [subview isKindOfClass:[UITextView class]] && [(UITextView *)subview isEditable];
		if (isTextField || isEditableTextView)
			[textInputs addObject:subview];
		else
			[textInputs addObjectsFromArray:EditableTextInputsInView(subview)];
	}
	return textInputs;
}

static NSArray * ViewsOfEditableTextInputs(UIView *view)
{
    NSMutableArray *TPKeyboardArray = [NSMutableArray new];
    for (UIView *subview in view.subviews)
    {
        BOOL isTPKeyboardView = [subview isKindOfClass:[UIScrollView class]];//[subview isKindOfClass:[TPKeyboardAvoidingCollectionView class]] || [subview isKindOfClass:[TPKeyboardAvoidingScrollView class]] || [subview isKindOfClass:[TPKeyboardAvoidingTableView class]];
        if (isTPKeyboardView)
            [TPKeyboardArray addObject:subview];
        else
            [TPKeyboardArray addObjectsFromArray:ViewsOfEditableTextInputs(subview)];
    }
    return TPKeyboardArray;
}


@implementation XCDFormInputAccessoryView
{
	UIToolbar *_toolbar;
    UIResponder *adjacentResponder;
}

- (id) initWithFrame:(CGRect)frame
{
	return [self initWithResponders:nil];
}

- (id) initWithResponders:(NSArray *)responders
{
	if (!(self = [super initWithFrame:CGRectZero]))
		return nil;
	
	_responders = responders;
	
	_toolbar = [[UIToolbar alloc] init];
    if (IOS7_OR_LATER)
    {
        [_toolbar setTintColor:[UIColor blackColor]];
    }
    else
    {
//        [_toolbar setBarStyle:UIBarStyleBlackTranslucent];
    }
    
	_toolbar.translucent = YES;
	_toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    /*
	UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[ UIKitLocalizedString(@"Previous"), UIKitLocalizedString(@"Next") ]];
	[segmentedControl addTarget:self action:@selector(selectAdjacentResponder:) forControlEvents:UIControlEventValueChanged];
	segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
	segmentedControl.momentary = YES;
	UIBarButtonItem *segmentedControlBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];
	UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
     _toolbar.items = @[ segmentedControlBarButtonItem, flexibleSpace ];
     */
//    @"app_keyboardLeft"
    UIBarButtonItem *prev = [[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStylePlain target:self action:@selector(selectAdjacentResponder:)];
    prev.tag = 0;
    UIBarButtonItem *fixed =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [fixed setWidth:23];
    
//    @"app_keyboardRight"
    UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStylePlain target:self action:@selector(selectAdjacentResponder:)];
    next.tag = 1;
     UIBarButtonItem *nilButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    _toolbar.items = @[prev,fixed,next,nilButton];
	
	self.hasDoneButton = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
//	
	[self addSubview:_toolbar];
    
	self.frame = _toolbar.frame = (CGRect){CGPointZero, [_toolbar sizeThatFits:CGSizeZero]};
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textInputDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textInputDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:nil];
	
	return self;
}

- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) updateSegmentedControl
{
	NSArray *responders = self.responders;
	if ([responders count] == 0)
		return;
	
	UIBarButtonItem *pre = (UIBarButtonItem *)_toolbar.items[0];
    UIBarButtonItem *next = (UIBarButtonItem *)_toolbar.items[2];
	BOOL isFirst = [[responders objectAtIndex:0] isFirstResponder];
	BOOL isLast = [[responders lastObject] isFirstResponder];
    pre.enabled = !isFirst;
    next.enabled = !isLast;
    //Setting toolbar tintColor
    UIView *textField = [responders objectAtIndex:0];
    if ( [textField respondsToSelector:@selector(tintColor)])
        [textField.inputAccessoryView setTintColor:[textField tintColor]];
}

- (void) willMoveToWindow:(UIWindow *)window
{
	if (!window)
		return;
	
	[self updateSegmentedControl];
}

- (void) textInputDidBeginEditing:(NSNotification *)notification
{
	[self updateSegmentedControl];
}

- (NSArray *) responders
{
	if (_responders)
		return _responders;
	
	NSArray *textInputs = EditableTextInputsInView([[UIApplication sharedApplication] keyWindow]);
	return [textInputs sortedArrayUsingComparator:^NSComparisonResult(UIView *textInput1, UIView *textInput2) {
		UIView *commonAncestorView = textInput1.superview;
		while (commonAncestorView && ![textInput2 isDescendantOfView:commonAncestorView])
			commonAncestorView = commonAncestorView.superview;
		
		CGRect frame1 = [textInput1 convertRect:textInput1.bounds toView:commonAncestorView];
		CGRect frame2 = [textInput2 convertRect:textInput2.bounds toView:commonAncestorView];
		return [@(CGRectGetMinY(frame1)) compare:@(CGRectGetMinY(frame2))];
	}];
}

- (NSMutableArray *)viewsArray
{
    if (_viewsArray) {
        return _viewsArray;
    }
    NSArray *views = ViewsOfEditableTextInputs([[UIApplication sharedApplication] keyWindow]);
    return [NSMutableArray arrayWithArray:views];
}

- (void) setHasDoneButton:(BOOL)hasDoneButton
{
	[self setHasDoneButton:hasDoneButton animated:NO];
}

- (void) setHasDoneButton:(BOOL)hasDoneButton animated:(BOOL)animated
{
	if (_hasDoneButton == hasDoneButton)
		return;
	
	[self willChangeValueForKey:@"hasDoneButton"];
	_hasDoneButton = hasDoneButton;
	[self didChangeValueForKey:@"hasDoneButton"];
	
	NSArray *items;
	if (hasDoneButton)
		items = [_toolbar.items arrayByAddingObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)]];
	else
		items = [_toolbar.items subarrayWithRange:NSMakeRange(0, 2)];
	
	[_toolbar setItems:items animated:animated];
}

#pragma mark - Actions

- (void) selectAdjacentResponder:(UIBarButtonItem *)sender
{
	NSArray *firstResponders = [self.responders filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UIResponder *responder, NSDictionary *bindings) {
		return [responder isFirstResponder];
	}]];
	UIResponder *firstResponder = [firstResponders lastObject];
	NSInteger offset = sender.tag  == 0 ? -1 : +1;
	NSInteger firstResponderIndex = [self.responders indexOfObject:firstResponder];
	NSInteger adjacentResponderIndex = firstResponderIndex != NSNotFound ? firstResponderIndex + offset : NSNotFound;
	//UIResponder *adjacentResponder = nil;
    sender.enabled = YES;
	if (adjacentResponderIndex >= 0 && adjacentResponderIndex < (NSInteger)[self.responders count])
    {
		adjacentResponder = [self.responders objectAtIndex:adjacentResponderIndex];
    }
    
    [self scrollToView:(UIView*)adjacentResponder];
}

- (void)scrollToView:(UIView *)view
{
    for (UIView *superview = view.superview; superview; superview = superview.superview) {
        for (UIView *object in self.viewsArray) {
            if (superview == object)
            {
                if ([object isKindOfClass:TPKeyboardAvoidingCollectionView.class] ||
                    [object isKindOfClass:TPKeyboardAvoidingScrollView.class] ||
                    [object isKindOfClass:TPKeyboardAvoidingTableView.class]) {
//                    [object performSelector:@selector(scrollToTextField:) withObject:view];
                    return;
                }
            }
        }
    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}
- (BOOL)becomeFirstResponder
{
    [super becomeFirstResponder];
    return [adjacentResponder becomeFirstResponder];
}
- (void) done
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

@end
