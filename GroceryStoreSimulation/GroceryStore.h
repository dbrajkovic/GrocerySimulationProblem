//
//  GroceryStore.h
//  GroceryStoreSimulation
//
//  Created by Dan Brajkovic on 2/21/14.
//  Copyright (c) 2014 Dan Brajkovic. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Customer, Register;

@interface GroceryStore : NSObject

@property (copy, nonatomic) NSArray *customers;
@property (copy, nonatomic) NSArray *registers;
@property (assign, nonatomic) NSInteger minuteCounter;

- (id)initWithInputString:(NSString *)inputString;
- (void)customerDidLeave:(Customer *)customer;
- (void)incrementMinuteCounter;

@end
