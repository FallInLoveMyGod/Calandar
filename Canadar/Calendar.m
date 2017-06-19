//
//  Calendar.m
//  Canadar
//
//  Created by 田耀琦 on 2017/6/6.
//  Copyright © 2017年 田耀琦. All rights reserved.
//

#import "Calendar.h"

#define ScrollView_Width self.frame.size.width
#define ScrollView_Height self.frame.size.height

@implementation Calendar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.scrollV = [[UIScrollView alloc] initWithFrame:self.frame];
    
    self.scrollV.contentSize = CGSizeMake(ScrollView_Width, ScrollView_Height * 3);
    self.scrollV.contentOffset = CGPointMake(0, ScrollView_Height);
    self.scrollV.pagingEnabled = YES;
    self.scrollV.delegate = self;
    [self addSubview:self.scrollV];
    
    self.nowDate = [NSDate date];
    
    [self.scrollV addSubview:self.currentView];
    [self.scrollV addSubview:self.preView];
    [self.scrollV addSubview:self.nextView];
}

- (CalendarView *)currentView {
    if (!_currentView) {
        _currentView = [[CalendarView alloc] initWithFrame:CGRectMake(0, ScrollView_Height, ScrollView_Width, ScrollView_Height) date:self.nowDate];
    }
    return _currentView;
}

- (CalendarView *)preView {
    if (!_preView) {
        _preView = [[CalendarView alloc] initWithFrame:CGRectMake(0, 0, ScrollView_Width, ScrollView_Height) date:[self creatLastMonthWithInterval:-1 date:self.nowDate]];
    }
    return _preView;
}

- (CalendarView *)nextView {
    if (!_nextView) {
        _nextView = [[CalendarView alloc] initWithFrame:CGRectMake(0, ScrollView_Height * 2, ScrollView_Width, ScrollView_Height) date:[self creatLastMonthWithInterval:1 date:self.nowDate]];
    }
    return _nextView;
}

// 获取该月的前后几个月
- (NSDate *)creatLastMonthWithInterval:(NSInteger)interval date:(NSDate *)date{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *lastMonth = [[NSDateComponents alloc] init];
    [lastMonth setMonth:interval];
    
    NSDate *newDate = [calendar dateByAddingComponents:lastMonth toDate:date options:0];
    NSString *dateStr = [formatter stringFromDate:newDate];
    NSLog(@"date:%@",dateStr);
    return newDate;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y == 0) {
        self.nowDate = self.preView.myDate;
        
        [_nextView removeFromSuperview];
        _nextView = nil;
        [scrollView addSubview:self.nextView];
        
        [_currentView removeFromSuperview];
        _currentView = nil;
        [scrollView addSubview:self.currentView];
        
        [_preView removeFromSuperview];
        _preView = nil;
        [scrollView addSubview:self.preView];
        
        [scrollView setContentOffset:CGPointMake(0, ScrollView_Height)];
    }
    if (scrollView.contentOffset.y == ScrollView_Height * 2) {
        self.nowDate = self.nextView.myDate;
        [_preView removeFromSuperview];
        _preView = nil;
        [scrollView addSubview:self.preView];
        
        [_currentView removeFromSuperview];
        _currentView = nil;
        [scrollView addSubview:self.currentView];
        
        [_nextView removeFromSuperview];
        _nextView = nil;
        [scrollView addSubview:self.nextView];
        
        [scrollView setContentOffset:CGPointMake(0, ScrollView_Height)];
    }
    
}

@end
