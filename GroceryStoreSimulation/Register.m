//
//  Register.m
//  GroceryStoreSimulation
//
//  Created by Dan Brajkovic on 2/21/14.
//  Copyright (c) 2014 Dan Brajkovic. All rights reserved.
//

#import "Register.h"
#import "Customer.h"

@interface Register ()

@property (strong, nonatomic) NSMutableArray *mutableQueue;
@property (assign, nonatomic) NSInteger itemProcessTime;

@end

@implementation Register

- (id)init
{
    self = [super init];
    if (self) {
        _mutableQueue = [NSMutableArray array];
        _itemProcessTime = 0;
    }
    return self;
}

- (NSArray *)customerQueue
{
    return [self.mutableQueue copy];
}

- (void)customerArrived:(Customer *)customer
{
    [self.mutableQueue addObject:customer];
}

- (void)serviceCustomer {
    Customer *currentCustomer = [self.mutableQueue firstObject];
    if (currentCustomer) {
        self.itemProcessTime ++;
        if (self.itemProcessTime == 1 && self.isTrainee) {
            return;
        }
        
        currentCustomer.numberOfUncheckedItems --;
        self.itemProcessTime = 0;
        if (currentCustomer.numberOfUncheckedItems < 1) {
            [self.mutableQueue removeObject:currentCustomer];
        }
    }
}

@end
