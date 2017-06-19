//
//  CalendarView.m
//  Canadar
//
//  Created by 田耀琦 on 2017/6/6.
//  Copyright © 2017年 田耀琦. All rights reserved.
//

#import "CalendarView.h"

@implementation CalendarView



- (id)initWithFrame:(CGRect)frame date:(NSDate *)date {
    self = [super initWithFrame:frame];
    if (self) {
        self.myDate = date;
        [self creatCalendarWithDate:date];
    }
    return self;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, self.frame.size.width, 35)];
        _titleLab.font = [UIFont systemFontOfSize:18];
        _titleLab.textColor = [UIColor greenColor];
    }
    return _titleLab;
}

- (void)creatCalendarWithDate:(NSDate *)date {
    self.titleLab.text = [self stringFromDate:date];
    [self addSubview:self.titleLab];
    
    NSInteger firstDay = [self firstDayInThisMonth:date];
    NSInteger totalDay = [self totalDaysInThisMonth:date];
    
    for (int i = 0; i < 42; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        int x = self.frame.size.width / 7.0 * (i % 7);
        int y = 25 * (i / 7) + 40;
        [btn setFrame:CGRectMake(x, y, 45, 25)];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(calendarChoosed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        if (i < firstDay) {
            
        }
        else if (i > firstDay - 1 + totalDay) {
            
        }
        else {
            [btn setTitle:[NSString stringWithFormat:@"%ld",i - firstDay + 1] forState:UIControlStateNormal];
        }
        
    }
}

// 获取这个月第一天在周几
- (NSInteger)firstDayInThisMonth:(NSDate *)date {
    NSLog(@"%@",date);
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSLog(@"%@",firstDayOfMonthDate);
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [firstDayOfMonthDate  dateByAddingTimeInterval: interval];
    NSLog(@"enddate=%@",localeDate);
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:localeDate]; // 这个月第一天在当前日历的顺序
    // 返回某个特定时间(date)其对应的小的时间单元(smaller)在大的时间单元(larger)中的顺序
    return firstWeekday - 1;
}

//  算出给定时间的所在月的天数
- (NSInteger )totalDaysInThisMonth:(NSDate *)date {
    NSRange range = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}

- (NSString *)stringFromDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}
@end
