//
//  Customer.m
//  GroceryStoreSimulation
//
//  Created by Dan Brajkovic on 2/21/14.
//  Copyright (c) 2014 Dan Brajkovic. All rights reserved.
//

#import "Customer.h"
#import "Register.h"

@interface Customer ()

@end

@implementation Customer

- (void)setNumberOfUncheckedItems:(NSInteger)itemCount
{
    _numberOfUncheckedItems = itemCount;
    if (_numberOfUncheckedItems < 1) {
        [self.store customerDidLeave:self];
    }
}

- (void)chooseRegister
{
    Register *cashRegister;
    switch (self.customerType) {
        case CustomerTypeA:
            cashRegister = [self registerWithShortestLine];
            break;
            
        case CustomerTypeB:
            cashRegister = [self registerWithLastCustomerWithFewestUncheckedItems];
            break;
            
        default:
            break;
    }
    [cashRegister customerArrived:self];
}

- (Register *)registerWithShortestLine
{
    Register *reg;
    for (Register *cashRegister in self.store.registers) {
        if (!reg || cashRegister.customerQueue.count < reg.customerQueue.count) {
            reg = cashRegister;
        }
    }
    return reg;
}

- (Register *)registerWithLastCustomerWithFewestUncheckedItems
{
    Register *reg;
    for (Register *cashRegister in self.store.registers) {
        if (!reg ||
            [cashRegister.customerQueue.lastObject numberOfUncheckedItems] < [reg.customerQueue.lastObject numberOfUncheckedItems] ||
            (cashRegister.customerQueue.count == 0 && reg.customerQueue.count > 0)) {
            reg = cashRegister;
        }
    }
    return reg;
}

@end
