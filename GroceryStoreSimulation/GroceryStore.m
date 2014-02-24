//
//  GroceryStore.m
//  GroceryStoreSimulation
//
//  Created by Dan Brajkovic on 2/21/14.
//  Copyright (c) 2014 Dan Brajkovic. All rights reserved.
//

#import "GroceryStore.h"
#import "Customer.h"
#import "Register.h"

@interface GroceryStore ()

@property (strong, nonatomic) NSMutableArray *mutableCustomers;

@end

@implementation GroceryStore

- (id)initWithInputString:(NSString *)inputString
{
    self = [super init];
    if (self) {
        NSCharacterSet *whiteSpaceSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSInteger numberOfRegisters;
        
        NSScanner *theScanner = [NSScanner scannerWithString:inputString];
        [theScanner scanInteger:&numberOfRegisters];
        NSMutableArray *registers = [NSMutableArray array];
        for (NSInteger registerNumber = 1; registerNumber <= numberOfRegisters; registerNumber ++) {
            Register *cashRegister = [[Register alloc] init];
            cashRegister.registerNumber = registerNumber;
            [registers addObject:cashRegister];
        }
        [[registers lastObject] setTrainee:YES];
        _registers = [registers copy];
        
        NSMutableArray *customers = [NSMutableArray array];
        while ([theScanner isAtEnd] == NO) {
            NSString *customerType;
            NSInteger arrivalTime;
            NSInteger numberOfItems;
            [theScanner scanUpToCharactersFromSet:whiteSpaceSet intoString:&customerType];
            [theScanner scanInteger:&arrivalTime];
            [theScanner scanInteger:&numberOfItems];
            Customer *customer = [[Customer alloc] init];
            customer.customerType = [[customerType uppercaseString] hash];
            customer.arrivalTime = arrivalTime;
            customer.numberOfUncheckedItems = numberOfItems;
            customer.store = self;
            [customers addObject:customer];
        }
        _mutableCustomers = [customers mutableCopy];
    }
    return self;
}

- (void)setCustomers:(NSArray *)customers
{
    self.mutableCustomers = [customers mutableCopy];
}

- (NSArray *)customers
{
    return [self.mutableCustomers copy];
}

- (void)setRegisters:(NSArray *)registers
{
    _registers = [NSArray arrayWithArray:registers];
    [[_registers lastObject] setTrainee:YES];
}

- (void)incrementMinuteCounter
{
    self.minuteCounter ++;
    for (Register *cashRegister in self.registers) {
        [cashRegister serviceCustomer];
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"arrivalTime = %d", self.minuteCounter];
    NSSortDescriptor *itemCountSort = [NSSortDescriptor sortDescriptorWithKey:@"numberOfUncheckedItems" ascending:YES];
    NSSortDescriptor *typeSort = [NSSortDescriptor sortDescriptorWithKey:@"customerType" ascending:YES];
    NSArray *arrivingCustomers = [[self.customers filteredArrayUsingPredicate:predicate] sortedArrayUsingDescriptors:@[itemCountSort, typeSort]];
    for (Customer *customer in arrivingCustomers) {
        [customer chooseRegister];
    }
}

- (void)customerDidLeave:(Customer *)customer
{
    [self.mutableCustomers removeObject:customer];
}

@end
