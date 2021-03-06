//
//  CustomLevelOnePickerView.m
//  DK_CustomPickerView
//
//  Created by apple on 17/4/18.
//  Copyright © 2017年 DeamonKing. All rights reserved.
//

#import "CustomLevelOnePickerView.h"

@interface CustomLevelOnePickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>

{
    UIView *view;
    UIView *btnView;
    UIPickerView *picker;
    UIButton *rightButton;
    UIButton *leftButton;
    
    NSString *selectedData;
    
}

@end

@implementation CustomLevelOnePickerView

const CGFloat CustomLevelOnePVRowHeight = 35.0f;
const CGFloat CustomLevelOnePVHeight = 250.0f;
const CGFloat CustomLevelOnePVBtnViewWidth = 40.0f;
const CGFloat CustomLevelOnePVBtnViewHeight = 40.0f;

- (NSMutableArray *)dataArrM {
    if (!_dataArrM) {
        _dataArrM = [NSMutableArray array];
    }
    return _dataArrM;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self creatPickerView];
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    }
    return self;
}

- (void)creatPickerView {
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT, WIDTH, CustomLevelOnePVHeight)];
    view.backgroundColor = [UIColor whiteColor];
    
    picker = [[UIPickerView alloc] initWithFrame: CGRectMake(0, 0, WIDTH, CustomLevelOnePVHeight)];
    picker.dataSource = self;
    picker.delegate = self;
    picker.showsSelectionIndicator = YES;
    [picker selectRow: 0 inComponent: 0 animated: YES];
    [view addSubview: picker];
    
    btnView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT, WIDTH, 40)];
    btnView.backgroundColor = [UIColor whiteColor];
    btnView.layer.borderWidth = 0.5;
    btnView.layer.borderColor = [[[UIColor blackColor] colorWithAlphaComponent:0.3] CGColor];
    
    rightButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH - CustomLevelOnePVBtnViewWidth - 10, 0, CustomLevelOnePVBtnViewWidth, CustomLevelOnePVBtnViewHeight)];
    [rightButton setTitle: @"完成" forState: UIControlStateNormal];
    [rightButton setTitleColor:[UIColor colorWithRed:58/255.0 green:112/255.0 blue:234/255.0 alpha:1] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightButton addTarget: self action: @selector(rightButtonClicked:) forControlEvents: UIControlEventTouchUpInside];
    [btnView addSubview:rightButton];
    
    leftButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, CustomLevelOnePVBtnViewWidth, CustomLevelOnePVBtnViewHeight)];
    [leftButton setTitle: @"取消" forState: UIControlStateNormal];
    [leftButton setTitleColor:[UIColor colorWithRed:58/255.0 green:112/255.0 blue:234/255.0 alpha:1] forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [leftButton addTarget: self action: @selector(leftButtonClicked:) forControlEvents: UIControlEventTouchUpInside];
    [btnView addSubview:leftButton];
    
    [self addSubview:view];
    [self addSubview:btnView];
    
}

#pragma mark- button clicked

- (void)addButtonAction:(buttonBlock)buttonBlock {
    self.buttonBlock = buttonBlock;
}

- (void)rightButtonClicked:(UIButton *)sender {
    NSInteger dataIndex = [picker selectedRowInComponent:0];
    
    NSString *dataStr = [self.dataArrM objectAtIndex:dataIndex];
    
    if (self.buttonBlock) {
        self.buttonBlock(dataStr);
    }
    [self remove];
    
}

- (void)leftButtonClicked:(UIButton *)sender {
    [self remove];
}


#pragma mark- Picker Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.dataArrM count];
}


#pragma mark- Picker Delegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.dataArrM objectAtIndex:row];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return WIDTH;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return CustomLevelOnePVRowHeight;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* pickerLabel = nil;
    if (!pickerLabel) {
        pickerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, CustomLevelOnePVRowHeight)];
        pickerLabel.numberOfLines = 0;
        pickerLabel.lineBreakMode = NSLineBreakByWordWrapping;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        pickerLabel.backgroundColor = [UIColor clearColor];
        [pickerLabel setFont:[UIFont systemFontOfSize:13]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];//调用上一个委托方法，获得要展示的title
    
    
    return pickerLabel;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self remove];
}

- (void)show {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect viewFrame = view.frame;
        viewFrame.origin.y = HEIGHT - CustomLevelOnePVHeight;
        view.frame = viewFrame;
        CGRect btnViewFrame = btnView.frame;
        btnViewFrame.origin.y = HEIGHT - CustomLevelOnePVHeight - CustomLevelOnePVRowHeight;
        btnView.frame = btnViewFrame;
    }];
}

- (void)remove {
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        
        CGRect viewFrame = view.frame;
        viewFrame.origin.y = HEIGHT;
        view.frame = viewFrame;
        CGRect btnViewFrame = btnView.frame;
        btnViewFrame.origin.y = HEIGHT;
        btnView.frame = btnViewFrame;
        
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

@end
