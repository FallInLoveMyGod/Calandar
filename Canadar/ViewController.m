//
//  ViewController.m
//  Canadar
//
//  Created by 田耀琦 on 2017/6/5.
//  Copyright © 2017年 田耀琦. All rights reserved.
//

#import "ViewController.h"

#import "CalendarView.h"
#import "Calendar.h"

@interface ViewController () <UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView *scrollV;

@property (nonatomic,strong)CalendarView *currentView;

@property (nonatomic,strong)CalendarView *preView;

@property (nonatomic,strong)CalendarView *nextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self creatUI];
    [self testCalendar];
    
//    CalendarView *calendar = [[CalendarView alloc] initWithFrame:CGRectMake(10, 10, 320, 160) date:[NSDate date]];
//    [self.view addSubview:calendar];
}
- (void)testCalendar {
    Calendar *calendar = [[Calendar alloc] initWithFrame:CGRectMake(10, 50, 300, 200)];
    [self.view addSubview:calendar];
}

#pragma mark - UI

- (void)creatUI {
    self.scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 40, 320, 160)];
    self.scrollV.delegate = self;
    self.scrollV.contentSize = CGSizeMake(320,160 * 3);
    self.scrollV.pagingEnabled = YES;
    [self.view addSubview:self.scrollV];
    
    self.currentView = [[CalendarView alloc] initWithFrame:CGRectMake(0, 160, 320, 160) date:[NSDate date]];
    //[self.currentView creatCalendarWithDate:[NSDate date]];
    self.currentView.backgroundColor = [UIColor cyanColor];
    [self.scrollV addSubview:self.currentView];
    
    self.preView = [[CalendarView alloc] initWithFrame:CGRectMake(0, 0, 320, 160) date:[self creatLastMonthWithInterval:-1 date:[NSDate date]]];
    //[self.preView creatCalendarWithDate:[self creatLastMonthWithInterval:-1 date:[NSDate date]]];
    self.preView.backgroundColor = [UIColor blueColor];
    [self.scrollV addSubview:self.preView];
    
    self.nextView = [[CalendarView alloc] initWithFrame:CGRectMake(0, 160 * 2, 320, 160) date:[self creatLastMonthWithInterval:1 date:[NSDate date]]];
   // [self.nextView creatCalendarWithDate:[self creatLastMonthWithInterval:1 date:[NSDate date]]];
    self.nextView.backgroundColor = [UIColor magentaColor];
    [self.scrollV addSubview:self.nextView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y == 0) {
        
        [self.nextView removeFromSuperview];
        self.nextView = nil;
        self.nextView = [[CalendarView alloc] initWithFrame:CGRectMake(0, 320, 320, 160) date:self.currentView.myDate];
        [scrollView addSubview:self.nextView];
        
        [self.currentView removeFromSuperview];
        self.currentView = nil;
        self.currentView = [[CalendarView alloc] initWithFrame:CGRectMake(0, 160, 320, 160) date:self.preView.myDate];
        [scrollView addSubview:self.currentView];
        
        NSDate *preDate = [self creatLastMonthWithInterval:-1 date:self.preView.myDate];
        [self.preView removeFromSuperview];
        self.preView = nil;
        self.preView = [[CalendarView alloc] initWithFrame:CGRectMake(0, 0, 320, 160) date:preDate];
        [scrollView addSubview:self.preView];
        
        [scrollView setContentOffset:CGPointMake(0, 160)];
    }
    if (scrollView.contentOffset.y == 160 * 2) {
        
        [self.preView removeFromSuperview];
        self.preView = nil;
        self.preView = [[CalendarView alloc] initWithFrame:CGRectMake(0, 0, 320, 160) date:self.currentView.myDate];
        [scrollView addSubview:self.preView];
        
        [self.currentView removeFromSuperview];
        self.currentView = nil;
        self.currentView = [[CalendarView alloc] initWithFrame:CGRectMake(0, 160, 320, 160) date:self.nextView.myDate];
        [scrollView addSubview:self.currentView];
        
        [self.nextView removeFromSuperview];
        self.nextView = nil;
        self.nextView = [[CalendarView alloc] initWithFrame:CGRectMake(0, 320, 320, 160) date:[self creatLastMonthWithInterval:1 date:self.currentView.myDate]];
        [scrollView addSubview:self.nextView];
        
        [scrollView setContentOffset:CGPointMake(0, 160)];
    }
    
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


@end
