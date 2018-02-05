//
//  BSTCellInput.m
//  HealthCloud
//
//  Created by yuwenhua on 2017/10/31.
//  Copyright © 2017年 www.bsoft.com. All rights reserved.
//

#import "TCell_Input.h"

#import "NSString+JudgeString.h"

@interface TCell_Input () <UITextFieldDelegate>


@property (nonatomic, strong) UIImageView *cIconView;
@property (nonatomic, strong) UILabel *cTitleLabel;

@property (nonatomic, strong) UITextField *cInputTextFiled;


@end

@implementation TCell_Input

+ (CGFloat)classCellHeight {
    return 50.0;
}

- (void)setupUI {
    [super setupUI];
    
    _limitMaxLength = 12;
}

#pragma mark - 类方法
+ (instancetype)stringInputCell {
    TCell_Input *inputCell = [[TCell_Input alloc] init];
    inputCell.cInputTextFiled.keyboardType = UIKeyboardTypeDefault;
    return inputCell;
}
+ (instancetype)numberInputCell {
    TCell_Input *inputCell = [[TCell_Input alloc] init];
    inputCell.cInputTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    return inputCell;
}
+ (instancetype)passwordInputCell {
    TCell_Input *inputCell = [[TCell_Input alloc] init];
    inputCell.cInputTextFiled.keyboardType = UIKeyboardTypeASCIICapable;
    inputCell.cInputTextFiled.secureTextEntry = YES;
    return inputCell;
}

- (void)setupSubViews {
    [super setupSubViews];
    
    [self addSubview:self.cIconView];
    [self addSubview:self.cTitleLabel];
    [self addSubview:self.cInputTextFiled];
    
    [self setupLayout];
}

#pragma mark - 界面
// Icon
- (UIImageView *)cIconView {
    if (!_cIconView) {
        _cIconView = ({
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
            imgView;
        });
    }
    return _cIconView;
}
// Title
- (UILabel *)cTitleLabel {
    if (!_cTitleLabel) {
        _cTitleLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.text = _title;
            label.textAlignment = NSTextAlignmentLeft;
            label.font = FONT(16);
            label.textColor = RGB(33, 33, 33);
            label;
        });
    }
    return _cTitleLabel;
}
// TextFiled
- (UITextField *)cInputTextFiled {
    if (!_cInputTextFiled) {
        _cInputTextFiled = ({
            UITextField *textField = [[UITextField alloc] init];
            textField.backgroundColor = [UIColor clearColor];
            textField.font = FONT(15);
            textField.textColor = RGB(99, 99, 99);
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            textField;
        });
    }
    return _cInputTextFiled;
}

- (void)setupLayout {
    [super setupLayout];
    
    [_cIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(30);
        make.left.offset(10);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    [_cTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(5);
        make.bottom.offset(-5);
        make.left.mas_equalTo(_cIconView.mas_right).offset(10);
        make.width.offset(50);
    }];
    [_cInputTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(5);
        make.bottom.offset(-5);
        make.left.mas_equalTo(_cTitleLabel.mas_right).offset(10);
        make.right.offset(-40);
    }];
}

#pragma mark - 更新
- (void)setLimitMaxLength:(NSInteger)limitMaxLength {
    _limitMaxLength = limitMaxLength;
    
    self.cInputTextFiled.delegate = self;
}
- (void)setIcon:(UIImage *)icon {
    _icon = icon;
    self.cIconView.image = icon;
}
- (void)setTitle:(NSString *)title {
    _title = title;
    self.cTitleLabel.text = title;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.cInputTextFiled.placeholder = placeholder;
}
- (void)setText:(NSString *)text {
    self.cInputTextFiled.text = text;
}
- (NSString *)text {
    return _cInputTextFiled.text;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    [self scrollToActiveTextField];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    UITextRange *selectRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectRange.start offset:0];
    
    NSString *text = textField.text;
    text = [text stringByReplacingCharactersInRange:range withString:string];
    
    // 数字
    if (textField.keyboardType == UIKeyboardTypeNumberPad && ![string isValidNumber]) {
        
        return NO;
    }
    // 数字和字母
    if (textField.keyboardType == UIKeyboardTypeASCIICapable) {
        if (string.length) {
            for (int i=0; i<string.length; i++) {
                NSString *s = [string substringWithRange:NSMakeRange(i, 1)];
                if (![s isValidateAscII]) {
                    return NO;
                }
            }
        }
    }
    //
    if (position) {
        return YES;
    }
    else {
        
        if (string.length > 1) {
            return YES;
        }
        
        if (_limitMaxLength < text.length) {
            return NO;
        }
    }
    return YES;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
