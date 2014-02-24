//
//  Register.h
//  GroceryStoreSimulation
//
//  Created by Dan Brajkovic on 2/21/14.
//  Copyright (c) 2014 Dan Brajkovic. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Customer;

@interface Register : NSObject

@property (assign, nonatomic, getter = isTrainee) BOOL trainee;
@property (assign, nonatomic) NSInteger registerNumber;
@property (nonatomic, readonly) NSArray *customerQueue;

- (void)serviceCustomer;
- (void)customerArrived:(Customer *)customer;

@end
