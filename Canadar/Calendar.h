//
//  Calendar.h
//  Canadar
//
//  Created by 田耀琦 on 2017/6/6.
//  Copyright © 2017年 田耀琦. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CalendarView.h"

@interface Calendar : UIView <UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView *scrollV;

@property (nonatomic,strong)CalendarView *currentView;

@property (nonatomic,strong)CalendarView *preView;

@property (nonatomic,strong)CalendarView *nextView;

@property (nonatomic,strong)NSDate *nowDate;

@end
