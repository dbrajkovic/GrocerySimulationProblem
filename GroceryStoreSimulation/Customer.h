//
//  Customer.h
//  GroceryStoreSimulation
//
//  Created by Dan Brajkovic on 2/21/14.
//  Copyright (c) 2014 Dan Brajkovic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GroceryStore.h"

typedef NS_ENUM(NSUInteger, CustomerType) {
    CustomerTypeA   = 966,
    CustomerTypeB   = 969
};

@interface Customer : NSObject

@property (weak, nonatomic) GroceryStore *store;
@property (assign, nonatomic) NSUInteger customerType;
@property (assign, nonatomic) NSInteger arrivalTime;
@property (assign, nonatomic) NSInteger numberOfUncheckedItems;

- (void)chooseRegister;

@end
