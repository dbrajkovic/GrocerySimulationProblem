//
//  CustomerTests.m
//  GroceryStoreSimulation
//
//  Created by Dan Brajkovic on 2/23/14.
//  Copyright (c) 2014 Dan Brajkovic. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Customer.h"
#import "GroceryStore.h"
#import "Register.h"


@interface CustomerTests : XCTestCase
{
    GroceryStore *store;
    
    Register *register1;
    Register *register2;
    
    Customer *customer1;
    Customer *customer2;
    Customer *customer3;
    Customer *customer4;
    Customer *customer5;
    
}
@end

@implementation CustomerTests

- (void)setUp
{
    [super setUp];
    store = [[GroceryStore alloc] init];
    
    register1 = [[Register alloc] init];
    register2 = [[Register alloc] init];
    NSArray *registers = @[register1, register2];
    store.registers = registers;
    
    customer1 = [[Customer alloc] init];
    customer1.store = store;
    customer1.customerType = CustomerTypeA;
    customer1.numberOfUncheckedItems = 1;
    customer1.arrivalTime = 1;
    
    customer2 = [[Customer alloc] init];
    customer2.store = store;
    customer2.customerType = CustomerTypeB;
    customer2.numberOfUncheckedItems = 1;
    customer2.arrivalTime = 1;
    
    customer3 = [[Customer alloc] init];
    customer3.store = store;
    customer3.numberOfUncheckedItems = 3;
    
    customer4 = [[Customer alloc] init];
    customer4.store = store;
    customer4.numberOfUncheckedItems = 4;
    
    customer5 = [[Customer alloc] init];
    customer5.store = store;
    customer5.numberOfUncheckedItems = 5;
    
    store.customers = @[customer1, customer2, customer3, customer4, customer5];
}

- (void)tearDown
{
    customer1 = nil;
    customer2 = nil;
    customer3= nil;
    customer4 = nil;
    customer5 = nil;
    [super tearDown];
}

- (void)testSetNumberOfUncheckedItems;
{
    customer1.numberOfUncheckedItems = 1;
    XCTAssertTrue([store.customers containsObject:customer1], @"Customer should still be a store customer");
    customer1.numberOfUncheckedItems --;
    XCTAssertFalse([store.customers containsObject:customer1], @"Customer should not be a store customer");
}

- (void)testChooseRegister
{
    
    [register1 customerArrived:customer5];
    [register1 customerArrived:customer3];
    [register2 customerArrived:customer4];
    
    [customer1 chooseRegister];
    XCTAssertTrue([register2.customerQueue containsObject:customer1], @"Customer Type A chose the wrong register.");
    [customer2 chooseRegister];
    XCTAssertTrue([register2.customerQueue containsObject:customer2], @"Customer Type B chose the wrong register.");
}

- (void)testChooseRegister_bothRegistersInitiallyEmpty
{
    [customer1 chooseRegister];
    XCTAssertTrue([register1.customerQueue containsObject:customer1], @"Customer Type A chose the wrong register.");
    [customer2 chooseRegister];
    XCTAssertTrue([register2.customerQueue containsObject:customer2], @"Customer Type B chose the wrong register.");
}

- (void)testCustomerTypeAChoosesBeforeCustomerTypeBWithSameNumberOfItems
{
    customer1.numberOfUncheckedItems = 5;
    customer2.numberOfUncheckedItems = 5;
    [store incrementMinuteCounter];
    XCTAssertTrue([register1.customerQueue containsObject:customer1], @"Customer Type A chose the wrong register.");
    XCTAssertTrue([register2.customerQueue containsObject:customer2], @"Customer Type B chose the wrong register.");
}

- (void)testCustomerWithFewerItemsChoosesFirst
{
    customer1.numberOfUncheckedItems = 5;
    customer2.numberOfUncheckedItems = 3;
    [store incrementMinuteCounter];
    XCTAssertTrue([register1.customerQueue containsObject:customer2], @"Customer Type A chose the wrong register.");
    XCTAssertTrue([register2.customerQueue containsObject:customer1], @"Customer Type B chose the wrong register.");
}

@end
